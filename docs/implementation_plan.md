# 📅 Implementation Plan – ULMP

## 🧩 Project Stack
- **Frontend Web (Admin):** Next.js + TailwindCSS
- **Mobile Apps:** React Native (Expo)
- **Backend & DB:** Supabase (PostgreSQL, Auth, Storage)
- **AI Engines:** OpenAI Whisper + GPT-4 via MCP
- **Environment Config:** `.env` securely stores keys
- **CI/CD:** GitHub Actions

---

## 🗂 Milestone Structure
| Sprint | Duration | Goals |
|--------|----------|-------|
| Sprint 1 | 2 weeks | Setup Supabase DB, RLS, schema, roles |
| Sprint 2 | 3 weeks | Build MVP UI for Admin Panel (CRUD + Roles) |
| Sprint 3 | 3 weeks | Build MVP Student/Parent App + Auth + Homework |
| Sprint 4 | 2 weeks | Add Teacher App with AI override support |
| Sprint 5 | 2 weeks | AI pipeline integration (Whisper → GPT) |
| Sprint 6 | 2 weeks | Leaderboards, Attendance, Ranking logic |
| Sprint 7 | 1 week  | Final QA + bug patching |
| Sprint 8 | 1 week  | Deploy stable v1 release + documentation |

---

## ⚙️ Key Tasks per Sprint
### Sprint 1
- Setup Supabase project
- Configure DB schema
- Implement auth roles: student, parent, teacher, admin
- Define RLS per table
- Create Edge Functions scaffold

### Sprint 2
- Admin UI scaffolding with Next.js
- Dashboards, tables, alerts
- CRUD operations on users, groups
- Manual payment update tools

### Sprint 3
- Student/Parent login flows
- Vocabulary system UI + storage
- Homework submission to Edge Function
- Upload .mp3, submit answers, trigger AI

### Sprint 4
- Teacher login/authentication
- Class selector, attendance marking
- Homework review page + override
- Ranking + faults logging UI

### Sprint 5
- Whisper AI STT setup
- GPT-4 grading logic
- Connect MCP agents:
  - `sequential-thinking`, `context7`, `supabase MCP`

### Sprint 6
- Leaderboard aggregation via Edge
- Graphs, metrics for Admin & Students
- Realtime views with Supabase subscriptions

### Sprint 7
- Cross-device testing
- Role-based flow validation
- Optimize API response + sync

### Sprint 8
- Documentation
- GitHub release tagging
- Deploy to production

---

## 🔐 API Keys Placement
`.env` config per service:
```
OPENAI_API_KEY=
SUPABASE_URL=
SUPABASE_ANON_KEY=
SUPABASE_SECRET_KEY=
```
- Only backend uses `SUPABASE_SECRET_KEY`
- Clients use `SUPABASE_ANON_KEY` (limited)

---

## 📋 QA & Version Control
- All releases tracked in GitHub with CI tests
- Bug tracking via dedicated document
- Lint, build, test checks enforced per push

---

## ✅ Summary
This implementation plan defines 8 clear Sprints for a full stack education platform, including Supabase backend, mobile/web clients, and Whisper + GPT AI pipeline. It ensures secure environment management and follows modular CI/CD deployment principles.

