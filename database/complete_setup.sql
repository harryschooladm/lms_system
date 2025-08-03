-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- USER ROLES
CREATE TYPE user_role AS ENUM ('admin', 'teacher', 'student', 'parent');

-- USERS
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    full_name TEXT,
    role user_role NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- PARENT-STUDENT RELATIONSHIP
CREATE TABLE parent_student_relations (
    parent_id UUID REFERENCES users(id) ON DELETE CASCADE,
    student_id UUID REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (parent_id, student_id)
);

-- GROUPS (CLASSES)
CREATE TABLE groups (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    teacher_id UUID REFERENCES users(id) ON DELETE SET NULL, -- A group must have a teacher
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- STUDENTS_GROUPS (many-to-many)
CREATE TABLE students_groups (
    student_id UUID REFERENCES users(id) ON DELETE CASCADE,
    group_id UUID REFERENCES groups(id) ON DELETE CASCADE,
    PRIMARY KEY (student_id, group_id)
);

-- ATTENDANCE
CREATE TABLE attendance (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id UUID REFERENCES users(id) ON DELETE CASCADE,
    group_id UUID REFERENCES groups(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    is_present BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(student_id, group_id, date)
);

-- HOMEWORK/ASSIGNMENTS
CREATE TABLE assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    group_id UUID REFERENCES groups(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    due_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- HOMEWORK SUBMISSIONS
CREATE TABLE submissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    assignment_id UUID REFERENCES assignments(id) ON DELETE CASCADE,
    student_id UUID REFERENCES users(id) ON DELETE CASCADE,
    text_submission TEXT,
    voice_submission_url TEXT,
    submitted_at TIMESTAMPTZ DEFAULT NOW()
);

-- SCORES
CREATE TABLE scores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    submission_id UUID REFERENCES submissions(id) ON DELETE CASCADE,
    score INTEGER NOT NULL,
    feedback TEXT, -- AI generated or teacher override
    is_override BOOLEAN DEFAULT false,
    graded_at TIMESTAMPTZ DEFAULT NOW()
);

-- PAYMENTS
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id UUID REFERENCES users(id) ON DELETE CASCADE,
    amount DECIMAL(10, 2) NOT NULL,
    status TEXT NOT NULL DEFAULT 'unpaid', -- unpaid, paid, overdue
    due_date DATE,
    paid_at DATE
);

-- ALERTS
CREATE TABLE alerts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    recipient_id UUID REFERENCES users(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW()
);


-- RLS POLICIES

-- USERS TABLE
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow admin full access" ON users FOR ALL USING (true);
CREATE POLICY "Allow users to view their own info" ON users FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Allow teachers to see their students" ON users FOR SELECT USING (
    id IN (
        SELECT student_id FROM students_groups WHERE group_id IN (
            SELECT id FROM groups WHERE teacher_id = auth.uid()
        )
    )
);
CREATE POLICY "Allow parents to see their children's info" ON users FOR SELECT USING (
    id IN (
        SELECT student_id FROM parent_student_relations WHERE parent_id = auth.uid()
    )
);

-- GROUPS TABLE
ALTER TABLE groups ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow admin full access on groups" ON groups FOR ALL USING (true);
CREATE POLICY "Allow teachers to manage their own groups" ON groups FOR SELECT, INSERT, UPDATE, DELETE USING (
    teacher_id = auth.uid()
);
CREATE POLICY "Allow students to view their assigned groups" ON groups FOR SELECT USING (
    id IN (
        SELECT group_id FROM students_groups WHERE student_id = auth.uid()
    )
);

-- ASSIGNMENTS TABLE
ALTER TABLE assignments ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow admin full access on assignments" ON assignments FOR ALL USING (true);
CREATE POLICY "Allow teachers to manage assignments of their groups" ON assignments FOR SELECT, INSERT, UPDATE, DELETE USING (
    group_id IN (
        SELECT id FROM groups WHERE teacher_id = auth.uid()
    )
);
CREATE POLICY "Allow students to view assignments of their groups" ON assignments FOR SELECT USING (
    group_id IN (
        SELECT group_id FROM students_groups WHERE student_id = auth.uid()
    )
);

-- SUBMISSIONS TABLE
ALTER TABLE submissions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow admin full access on submissions" ON submissions FOR ALL USING (true);
CREATE POLICY "Allow students to manage their own submissions" ON submissions FOR SELECT, INSERT, UPDATE, DELETE USING (
    student_id = auth.uid()
);
CREATE POLICY "Allow teachers to view submissions for their assignments" ON submissions FOR SELECT USING (
    assignment_id IN (
        SELECT id FROM assignments WHERE group_id IN (
            SELECT id FROM groups WHERE teacher_id = auth.uid()
        )
    )
);

-- SCORES TABLE
ALTER TABLE scores ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow admin full access on scores" ON scores FOR ALL USING (true);
CREATE POLICY "Allow students to view their own scores" ON scores FOR SELECT USING (
    submission_id IN (
        SELECT id FROM submissions WHERE student_id = auth.uid()
    )
);
CREATE POLICY "Allow teachers to manage scores for their assignments" ON scores FOR SELECT, INSERT, UPDATE USING (
    submission_id IN (
        SELECT id FROM submissions WHERE assignment_id IN (
            SELECT id FROM assignments WHERE group_id IN (
                SELECT id FROM groups WHERE teacher_id = auth.uid()
            )
        )
    )
);

-- PAYMENTS TABLE
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow admin full access on payments" ON payments FOR ALL USING (true);
CREATE POLICY "Allow students to view their own payments" ON payments FOR SELECT USING (
    student_id = auth.uid()
);
CREATE POLICY "Allow parents to view payments of their children" ON payments FOR SELECT USING (
    student_id IN (
        SELECT student_id FROM parent_student_relations WHERE parent_id = auth.uid()
    )
);

-- ALERTS TABLE
ALTER TABLE alerts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow admin full access on alerts" ON alerts FOR ALL USING (true);
CREATE POLICY "Allow users to view their own alerts" ON alerts FOR SELECT USING (
    recipient_id = auth.uid()
);

"
-- VOCABULARY
CREATE TABLE vocabulary (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    word TEXT NOT NULL UNIQUE,
    definition TEXT,
    example_sentence TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- LEADERBOARD
CREATE TABLE leaderboard (
    student_id UUID REFERENCES users(id) ON DELETE CASCADE,
    total_score INT NOT NULL,
    ranking INT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE leaderboard ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow users to view leaderboard positions" ON leaderboard FOR SELECT USING ( true );

ALTER TABLE vocabulary ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all users to view vocabularies" ON vocabulary FOR SELECT USING ( true );

