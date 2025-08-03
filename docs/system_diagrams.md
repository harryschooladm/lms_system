# 🧭 System Diagrams & Data Flow – ULMP

## 🔁 High-Level Architecture
```
[Student App]       [Parent App]       [Teacher App]         [Admin Web]
      |                  |                  |                      |
      |                  |                  |                      |
      |------------------|------------------|----------------------|
                            ↓ (API + Auth)
                    Supabase Backend (PostgreSQL)
                       |    |    |    |    |
                       |    |    |    |    +-- Auth / RLS
                       |    |    |    +------- Storage
                       |    |    +------------ Realtime Subscriptions
                       |    +----------------- Edge Functions (Homework, AI)
                       +---------------------- MCP Server Triggers
```

---

## 🔐 Authentication Flow
1. App initiates login (email/password or OTP)
2. Supabase Auth issues JWT
3. Role is decoded (student, parent, teacher, admin)
4. RLS applies restrictions automatically
5. Only backend Edge Functions can bypass for admin/sensitive ops

---

## 🎙 Homework Submission Flow
```
Student submits →
   → Audio (.mp3) → Supabase Storage
   → Text Answer → Supabase Function (/submitHomework)

Edge Function triggers:
  → Transcription via Whisper AI
  → GPT-4 analyzes transcription and text
  → Result saved to DB → Notify teacher

Teacher can:
  → View results
  → Override or approve
```

---

## 📈 Ranking & Score System
- Data stored in `scores`, `attendance`, `homework_results`
- Realtime aggregation into `leaderboards`
- Admin and students view it via read-only roles
- Teachers see own class ranking only

---

## 📦 Backend Edge Functions
| Name                | Role                        |
|---------------------|-----------------------------|
| /submitHomework     | Accepts file + text, returns task ID |
| /gradeHomework      | Internal only – triggered by Edge |
| /markAttendance     | Teacher only – logs class session |
| /getLeaderboard     | Read-only access to scores |
| /sendAlert          | Admin – writes alerts to recipients |

---

## ⚙️ MCP Servers Integration
| MCP Agent           | Description                          |
|---------------------|--------------------------------------|
| sequential-thinking | Orchestrates AI pipelines            |
| playwright          | Automated UI feedback (tests, UX)    |
| context7            | Processes complex student feedback   |
| supabase MCP        | Controls DB flow, invokes triggers   |

---

## 🔑 .env API Keys Location
```
.env
├── OPENAI_API_KEY
├── SUPABASE_URL
├── SUPABASE_ANON_KEY
└── SUPABASE_SECRET_KEY (used only on server)
```

---

## ✅ Summary
These diagrams represent core system logic and flow – where data comes in, how AI triggers run, and how Supabase enforces role security and client isolation.

