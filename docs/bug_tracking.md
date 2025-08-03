# 🐞 Bug Tracking & QA Register – ULMP

## 🧪 QA Source
All bugs reported via:
- Manual QA Testing
- User feedback during beta
- GitHub Issues
- Internal TestFlight / Android testing

---

## 📋 Bug Log Format
| ID  | Date       | Reported By | Client         | Description                         | Priority | Status   | Assigned To |
|-----|------------|-------------|----------------|-------------------------------------|----------|----------|--------------|
| B01 | 2025-07-21 | QA Team     | Student App    | Audio upload fails intermittently   | High     | Open     | AI Backend   |
| B02 | 2025-07-21 | Dev Lead    | Admin Web      | Attendance form not saving properly | Medium   | Fixed    | Web Dev      |
| B03 | 2025-07-22 | Teacher     | Teacher App    | Homework list not loading for class | High     | Open     | App Dev      |
| B04 | 2025-07-22 | Parent User | Student App    | Parent can't switch between children| Medium   | In Review| Mobile UX    |

---

## 🛠 MCP Error Logging
- Each MCP server (e.g., `context7`, `sequential-thinking`) logs into central error tracking bucket
- Supabase functions emit status codes per task
- AI grading logs traced per student ID

---

## 🔐 Known Integration Conflicts
| Dependency     | Conflict Description                        | Solution                   |
|----------------|---------------------------------------------|----------------------------|
| Supabase RLS   | Teacher unable to view student homework     | Rework policy with class FK|
| React Native FS| MP3 playback flaky on Android 13+           | Patch module dependency    |

---

## ✅ QA Workflow
1. Bug detected → Create GitHub Issue (with label)
2. Assigned team confirms status
3. Fix submitted, tested, and closed

**Status Values:** `Open`, `In Review`, `Fixed`, `WontFix`

---

## ✅ Summary
Bug tracking ensures stability across clients and backend. All issues are version-controlled, prioritized, and managed per client type and sprint cycle.

