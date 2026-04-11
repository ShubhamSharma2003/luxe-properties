-- Run this in Supabase SQL Editor (https://supabase.com/dashboard → SQL Editor)

-- 1. Create the luxe_property_leads table
CREATE TABLE luxe_property_leads (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  project TEXT NOT NULL DEFAULT 'Oberoi Realty — Sector 58, Gurugram',
  first_name TEXT NOT NULL,
  last_name TEXT,
  email TEXT,
  phone_code TEXT DEFAULT '+91',
  phone TEXT NOT NULL,
  buyer_type TEXT,
  budget TEXT,
  visit_timing TEXT,
  source TEXT NOT NULL CHECK (source IN ('main_form', 'visit_form')),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Enable Row Level Security
ALTER TABLE luxe_property_leads ENABLE ROW LEVEL SECURITY;

-- 3. Allow anonymous inserts (from the website) but NOT reads
CREATE POLICY "Allow anonymous inserts"
  ON luxe_property_leads
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- 4. Allow authenticated users (you in the dashboard) to read all leads
CREATE POLICY "Allow authenticated reads"
  ON luxe_property_leads
  FOR SELECT
  TO authenticated
  USING (true);

-- 5. Create an index on created_at for fast sorting
CREATE INDEX idx_luxe_leads_created_at ON luxe_property_leads (created_at DESC);

-- 6. Create an index on source for filtering
CREATE INDEX idx_luxe_leads_source ON luxe_property_leads (source);

-- 7. Create an index on project for filtering across projects
CREATE INDEX idx_luxe_leads_project ON luxe_property_leads (project);
