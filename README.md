# Universal Learning Management Platform (ULMP)

A comprehensive educational platform for Harry School with separate interfaces for admins, teachers, students, and parents.

## 🚀 Project Overview

ULMP is a modern learning management system built with:
- **Admin Panel**: Next.js + Tailwind CSS web application
- **Mobile Apps**: React Native (Expo) for students, parents, and teachers
- **Backend**: Supabase (PostgreSQL, Auth, Storage, Edge Functions)
- **AI Integration**: OpenAI Whisper + GPT-4 for homework grading

## 📁 Project Structure

```
ulmp-platform/
├── apps/
│   ├── admin-web/              # Admin Panel (Next.js)
│   ├── student-parent-app/     # Student/Parent Mobile App (React Native)
│   └── teacher-app/            # Teacher Mobile App (React Native)
├── backend/                    # Supabase Edge Functions & Services
├── database/                   # Database schemas
├── docs/                       # Project documentation
├── scripts/                    # DevOps automation
└── tests/                      # Test suites
```

## 🛠️ Tech Stack

- **Frontend Web**: Next.js 14, Tailwind CSS, TypeScript
- **Mobile Apps**: React Native (Expo), TypeScript
- **Backend**: Supabase (PostgreSQL, Auth, Storage)
- **AI Services**: OpenAI API (Whisper + GPT-4)
- **Authentication**: Supabase Auth with role-based access
- **Real-time**: Supabase Realtime subscriptions

## 🔑 Features

### Admin Web Platform
- User management (students, teachers, parents)
- Class and group creation
- Payment tracking
- Attendance control
- Global leaderboard
- Alert system

### Student/Parent App
- Interactive vocabulary with audio
- Homework submission (text + voice)
- AI-powered grading feedback
- Progress tracking
- Payment status viewing

### Teacher App
- Attendance marking
- Homework review with AI assistance
- Student performance tracking
- Class management

## 🚦 Getting Started

### Prerequisites
- Node.js 18+
- npm or yarn
- Supabase account
- OpenAI API key

### Installation

1. Clone the repository
```bash
git clone [repository-url]
cd ulmp-platform
```

2. Install dependencies
```bash
npm install
```

3. Set up environment variables
```bash
cp .env.example .env.local
```

4. Configure your `.env.local` file with:
```
OPENAI_API_KEY=your_openai_key
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SECRET_KEY=your_secret_key
```

## 📅 Development Roadmap

| Sprint | Duration | Goals |
|--------|----------|-------|
| Sprint 1 | 2 weeks | Database setup, auth, schema |
| Sprint 2 | 3 weeks | Admin Panel MVP |
| Sprint 3 | 3 weeks | Student/Parent App MVP |
| Sprint 4 | 2 weeks | Teacher App |
| Sprint 5 | 2 weeks | AI Integration |
| Sprint 6 | 2 weeks | Leaderboards & Rankings |
| Sprint 7 | 1 week  | QA & Bug fixes |
| Sprint 8 | 1 week  | Deployment |

## 🎨 Design System

- **Primary Color**: #1D7452
- **Typography**: Inter (primary), Roboto (fallback)
- **UI Libraries**: Tailwind CSS (web), NativeBase (mobile)

## 📝 License

This project is proprietary software for Harry School.

## 👥 Team

- Project Lead: [Name]
- Backend Developer: [Name]
- Frontend Developer: [Name]
- Mobile Developer: [Name]
- UI/UX Designer: [Name]
