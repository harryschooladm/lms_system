# 🎨 UI/UX Design Specifications – ULMP

## 🎯 Global Branding
- **Accent Color:** #1D7452 (deep green)
- **Typography:** Inter (primary), fallback Roboto
- **Theme:** Light with soft contrast, green accent highlights
- **UI Kit:** Tailwind CSS for web, NativeBase/React Native Paper for mobile

---

## 📱 Student/Parent App
### Navigation
- Role-based tabbed navigation (auto-detects if student or parent)
- Tabs: Home, Homework, Vocabulary, Leaderboard, Payments

### Key UI Elements
- **Vocabulary Trainer:**
  - Flashcard carousel
  - Audio playback + image
  - Word definition, context, translation
- **Homework Submission:**
  - Voice recorder for STT
  - Text input with AI feedback panel
  - Upload confirmation & AI processing indicator
- **Leaderboard:**
  - Global & class-level ranking
  - Rank, photo/avatar, level
- **Parent Portal:**
  - Mirrors child info
  - Tuition reminder banners (if unpaid)

### Animations
- Tab transitions: Fade or slide
- AI result display: Animated feedback (green/yellow/red)

---

## 📱 Teacher App
### Navigation
- Drawer-based layout (for class/group switching)
- Tabs: Dashboard, Attendance, Homework, Rankings

### Key UI Elements
- **Attendance:**
  - Class list with checkboxes
  - "All Present" and manual override
- **Homework Review:**
  - AI-generated scores preview
  - Option to override score or add comment
- **Fault Logging:**
  - Drop-down reason list
  - Optional admin visibility checkbox
- **Leaderboard:**
  - Class ranking of students
  - Teacher ranking widget (performance-based)

### Animations
- Homework transition: Card slide
- Performance gain: Pulse or glow for top teachers

---

## 🖥️ Admin Web Platform
### Navigation
- Sidebar layout with persistent top-level menu
- Pages: Dashboard, Users, Groups, Payments, Reports, Alerts

### Key UI Elements
- **User Management:**
  - Table view, filters by role
  - Create/edit modal dialogs
- **Payment Control:**
  - Manual entry of payments
  - Status badges (Paid, Partial, Overdue)
- **Group Builder:**
  - Drag-and-drop students into classes
- **Alert Dispatcher:**
  - Choose audience → Write message → Send

### Charts & Widgets
- Attendance heatmap per group
- Leaderboard pie charts
- Payment bar graph (by student/month)

---

## 🔐 Environment Integration
All UI elements using private data use real-time fetch from Supabase using only JWT-authenticated endpoints. No direct data writes without validation.

---

## ✅ Summary
This UI/UX system ensures delightful role-based experiences across mobile and web. It unifies performance tracking, homework flow, and payment transparency using modern native components and secure Supabase-backed data hooks.

