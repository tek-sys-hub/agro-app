-- ========================================================
-- AGROSMART SUPABASE DATABASE SCHEMA & UTILITIES
-- Run these queries in the Supabase SQL Editor (Dashboard > SQL Editor)
-- ========================================================

-- 1. Create 'profiles' table linked to Supabase Auth users
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    role TEXT DEFAULT 'Farmer',
    location TEXT DEFAULT 'Kanchanpur, Nepal',
    language TEXT DEFAULT 'Nepali',
    is_pro BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security (RLS) on profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- RLS Policies for Profiles
CREATE POLICY "Users can view their own profile"
ON public.profiles FOR SELECT
USING (auth.uid() = id);

CREATE POLICY "Users can insert their own profile"
ON public.profiles FOR INSERT
WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update their own profile"
ON public.profiles FOR UPDATE
USING (auth.uid() = id);


-- 2. Create 'sensor_readings' table for IoT Telemetry
CREATE TABLE IF NOT EXISTS public.sensor_readings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    device_name TEXT NOT NULL DEFAULT 'Kanchanpur North Field 1',
    soil_moisture NUMERIC NOT NULL,
    soil_ph NUMERIC NOT NULL,
    temperature NUMERIC NOT NULL,
    humidity INT NOT NULL,
    nitrogen INT,
    phosphorus INT,
    potassium INT,
    recorded_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.sensor_readings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own sensor readings"
ON public.sensor_readings FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own sensor readings"
ON public.sensor_readings FOR INSERT
WITH CHECK (auth.uid() = user_id);


-- 3. Create 'crop_market_prices' table
CREATE TABLE IF NOT EXISTS public.crop_market_prices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    crop_name TEXT NOT NULL,
    category TEXT NOT NULL DEFAULT 'Crops',
    unit TEXT NOT NULL DEFAULT 'per Kg',
    price_npr NUMERIC NOT NULL,
    change_percent TEXT,
    is_up BOOLEAN DEFAULT true,
    location TEXT DEFAULT 'Kanchanpur, Nepal',
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.crop_market_prices ENABLE ROW LEVEL SECURITY;

-- Allow public read access to commodity prices
CREATE POLICY "Public read access to market prices"
ON public.crop_market_prices FOR SELECT
USING (true);


-- 4. Create 'ai_scan_history' table
CREATE TABLE IF NOT EXISTS public.ai_scan_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    crop_name TEXT NOT NULL,
    diagnosis_title TEXT NOT NULL,
    status TEXT NOT NULL,
    severity TEXT,
    remedy_notes TEXT,
    scanned_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.ai_scan_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own scan history"
ON public.ai_scan_history FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own scan history"
ON public.ai_scan_history FOR INSERT
WITH CHECK (auth.uid() = user_id);


-- 5. Seed Initial Sample Commodity Prices Data
INSERT INTO public.crop_market_prices (crop_name, category, unit, price_npr, change_percent, is_up, location)
VALUES
    ('Rice', 'Crops', 'per Kg', 64.0, '↑ 0.8%', true, 'Kanchanpur, Nepal'),
    ('Tomato', 'Crops', 'per Kg', 48.0, '↑ 2.3%', true, 'Kanchanpur, Nepal'),
    ('Potato', 'Crops', 'per Kg', 32.0, '↓ 1.1%', false, 'Kanchanpur, Nepal'),
    ('Maize', 'Crops', 'per Kg', 30.0, '↑ 1.5%', true, 'Kanchanpur, Nepal'),
    ('Chili', 'Crops', 'per Kg', 120.0, '↓ 0.5%', false, 'Kanchanpur, Nepal')
ON CONFLICT DO NOTHING;


-- ========================================================
-- 6. UTILITY: AUTO-CONFIRM UNCONFIRMED EMAIL USERS
-- Run this if any user gets 'Email not confirmed' error
-- ========================================================
UPDATE auth.users
SET email_confirmed_at = NOW()
WHERE email_confirmed_at IS NULL;
