# Project Structure for Universal Learning Management Platform (ULMP)

## Root Directory

```
ulmp-platform/
├── apps/
│   ├── admin-web/              # Admin Panel (isolated)
│   ├── student-parent-app/     # Student/Parent App (isolated)
│   └── teacher-app/            # Teacher App (isolated)
│
├── backend/                    # Central API and logic gateway
│   ├── functions/              # Supabase Edge Functions (auth, sync, grading)
│   ├── services/               # MCP Server connections, GPT grading, Whisper
│   └── common/                 # Shared logic/constants/types (only in backend)
│
├── database/
│   └── schema.sql              # PostgreSQL schema (via Supabase)
│
├── docs/
│   ├── Implementation.md       # PRD-based plan
│   ├── project_structure.md    # You are here
│   ├── UI_UX_doc.md            # Design reference
│   └── Bug_tracking.md         # Error tracking log
│
├── scripts/                    # DevOps automation (seed, migrate)
├── tests/                      # Unit + integration test suite
├── .github/                    # GitHub Actions workflows
├── .env.example                # Sample environment config
└── README.md                   # Project entry guide
```

---

## Breakdown by Client & Shared Backend

### 🖥️ Admin Web Platform (`/apps/admin-web/`)

- **Tech Stack:** Next.js + Tailwind + Supabase
- **Responsibilities:**
  - Create/manage groups, classes, users, and teachers
  - View and control payments (manual updates only)
  - Control attendance if needed
  - View global leaderboard and scores
  - Send targeted alerts
- **Structure:**
  - Pages: Dashboard, Classes, Users, Payments, Reports
  - Components: Tables, Alerts, Score Inputs
  - Auth: Supabase admin role-based

### 📱 Student & Parent App (`/apps/student-parent-app/`)

- **Tech Stack:** React Native (Expo) + Supabase
- **Student Responsibilities:**
  - Access interactive vocabulary
  - Submit homework (AI scored)
  - View ranking & progress
  - See alerts and attendance
  - View payment status (read-only)
- **Parent Responsibilities:**
  - Login and view child progress and payment
  - Get alerts regarding attendance/debt
- **Structure:**
  - Screens: Dashboard, Homework, Vocabulary, Leaderboard, Payments
  - Navigation: Role-identified Tab Stack
  - Auth: JWT session with RLS on tables

### 📱 Teacher App (`/apps/teacher-app/`)

- **Tech Stack:** React Native (Expo) + Supabase
- **Responsibilities:**
  - View their classes and students
  - Mark attendance
  - Review/override AI-graded homework
  - Assign extra homework
  - Track performance and leaderboard
- **Structure:**
  - Screens: Dashboard, Attendance, Homework Review, Ranking
  - Navigation: Drawer for multiple groups
  - Auth: JWT token confirms teacher role

### ⚙️ Shared Backend (`/backend/`)

- **Tech Stack:** Supabase (PostgreSQL + Auth + Storage + Edge Functions)
- **Responsibilities:**
  - All data shared between apps comes from this backend only
  - Edge Functions secure all mutations
  - RLS ensures user-specific access only
  - Triggers auto-generate AI feedback routing
  - Manual payment tracking via UI by admin
  - All MCP server communication happens here
- **Structure:**
  - `functions/`: auth, homework submission, AI logic
  - `services/`: grading bots, Whisper STT, GPT feedback
  - `common/`: roles, enums, shared logic

---

## Central Data Sync Model

All apps connect to one central backend:

```
Students, Parents, Teachers, Admins
           ↓          ↓          ↓
     Central Supabase (auth + DB + logic)
```

- Only backend has knowledge of all data
- Apps are isolated clients that display data scoped to their role
- Real-time sync and AI logic happen in backend, not client

---

## Environment & Config Separation

- Separate `.env.local` per client app
- Scoped keys using Supabase Auth roles
- `.env` entries used:

```
OPENAI_API_KEY=
SUPABASE_URL=
SUPABASE_ANON_KEY=
SUPABASE_SECRET_KEY=
```

- MCP AI is powered by:
  - `sequential-thinking`
  - `playwright`
  - `context7`
  - `supabase MCP`

---

## Color Scheme

- Accent Color: `#1d7452` (used in highlights, buttons, titles)
- Accessible with dark/light theme variants

---

## Summary

Each client is standalone, connects only to backend, and accesses scoped data through secure APIs. No app is aware of other clients' logic or access, enforcing modularity and long-term scalability. All communication is centralized and protected under strict backend control using Supabase, RLS, and MCP agents for intelligent logic.

