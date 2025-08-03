# Supabase Setup Guide

## Required Configurations

### Step 1: Tables and Schema

1. **Users Table**
   `sql
   CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";
   
   CREATE TYPE user_role AS ENUM ('admin', 'teacher', 'student', 'parent');
   
   CREATE TABLE users (
       id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
       email TEXT UNIQUE NOT NULL,
       full_name TEXT,
       role user_role NOT NULL,
       created_at TIMESTAMPTZ DEFAULT NOW()
   );
   `

   ... (Include other tables)

### Step 2: Enable Row Level Security (RLS)

1. **For Users Table**
   `sql
   ALTER TABLE users ENABLE ROW LEVEL SECURITY;
   CREATE POLICY \"Allow admin full access\" ON users FOR ALL USING (true);
   ...
   `

### Step 3: Edge Functions

1. Create a function for submitting homework (use functions like submitHomework in your server)

### Step 4: Environment Variables

Set the following variables in your server:
   `env
   SUPABASE_URL=[Your Supabase URL]
   SUPABASE_ANON_KEY=[Your Supabase Anon Key]
   SUPABASE_SERVICE_KEY=[Your Supabase Service Key]
   `

### Step 5: Test your setup

Ensure that all users can only access the intended data and functions.

