# 🎯 Client Overview – ULMP

## 🖥️ Admin Web Platform

- **Access:** Web browser
- **Tech Stack:** Next.js + Tailwind CSS + Supabase
- **Role:** Admin
- **Data Source:** Securely connects to Supabase backend

### Features

- Dashboard view of global activity (students, teachers, classes)
- Attendance control (editable by Admin)
- Manual payment status updates
- Group and class creation tools
- User (teacher, student, parent) creation
- Manual score entry from offline exams
- Leaderboard and ranking view
- Alert dispatcher to teachers, students, or parents

### Auth & Security

- Supabase Auth with `role=admin`
- RLS fully bypassed via service role key on restricted routes

---

## 📱 Student/Parent Mobile App

- **Access:** Mobile App (Expo)
- **Tech Stack:** React Native + Supabase
- **Role:** Student / Parent (role detected at login)
- **Data Source:** Reads only own/student-linked data from backend

### Student Features

- View assigned homework per unit
- Submit homework (text + voice)
- Review AI-generated grading
- Access interactive vocabulary with audio + image
- Track attendance, alerts, ranking position
- View read-only payment status

### Parent Features

- Read-only student mirror
- Extra: tuition reminders, performance tracking

### Auth & Security

- JWT issued by Supabase identifies `role=student` or `role=parent`
- RLS filters all views to current user/student only

---

## 📱 Teacher Mobile App

- **Access:** Mobile App (Expo)
- **Tech Stack:** React Native + Supabase
- **Role:** Teacher
- **Data Source:** Supabase backend with RLS per teacher's group assignments

### Features

- Attendance marking (per group)
- Homework review (AI result + override)
- Add extra homework (optional)
- Track student ranking & improvement
- View own ranking vs other teachers
- Log student faults or misconduct

### Auth & Security

- JWT confirms teacher identity and group rights
- RLS restricts access to teacher’s students only

---

## 🔁 Unified System Logic

- All apps are isolated clients, connect via API to Supabase
- All logic sync and AI evaluation occurs in backend only
- No client ever reads or writes data to other client’s space
- All tokens validated server-side before DB access

---

## 🔐 .env Configuration Per Client

Each app includes its own `.env.local` file with scoped keys:

```
OPENAI_API_KEY=sk-...
SUPABASE_URL=https://xyz.supabase.co
SUPABASE_ANON_KEY=anon-key
SUPABASE_SECRET_KEY=service-role-key (backend only)
```

---

## ✅ Summary

This structure guarantees a clean separation between each client and ensures users access only what they’re authorized to see. All syncing happens via Supabase backend enforced with secure keys, JWTs, and RLS rules.

