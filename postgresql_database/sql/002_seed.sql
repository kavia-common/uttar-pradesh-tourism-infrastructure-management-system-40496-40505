-- 002_seed.sql
-- Seed base roles and default admin user

-- Insert roles
INSERT INTO roles (code, name, description)
VALUES 
  ('ADMIN', 'Administrator', 'Full access to all modules'),
  ('PM', 'Project Manager', 'Manage projects, tenders, milestones, progress'),
  ('INSPECTOR', 'Inspector', 'Perform inspections and approvals'),
  ('FINANCE', 'Finance', 'Manage funds and payments'),
  ('VIEWER', 'Viewer', 'Read-only access')
ON CONFLICT (code) DO NOTHING;

-- Create admin user if not exists
WITH existing AS (
  SELECT id FROM users WHERE email = 'admin@upstdc.in'
), ins AS (
  INSERT INTO users (email, password_hash, full_name, phone, is_active)
  SELECT 'admin@upstdc.in',
         -- NOTE: Replace this placeholder hash in production with secure hash management
         '$2a$10$Vx6uKq6qQ8bYv0Hh2qY6U.1f4Yb1E9JzZgKkJ2VYf7QyYwzq0jO3K', -- bcrypt for 'Admin@123' example
         'System Administrator',
         '+91-0000000000',
         TRUE
  WHERE NOT EXISTS (SELECT 1 FROM existing)
  RETURNING id
)
INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id
FROM (
  SELECT id FROM existing
  UNION ALL
  SELECT id FROM ins
) u
CROSS JOIN LATERAL (SELECT id FROM roles WHERE code = 'ADMIN') r
ON CONFLICT DO NOTHING;
