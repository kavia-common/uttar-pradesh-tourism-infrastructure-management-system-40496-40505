# uttar-pradesh-tourism-infrastructure-management-system-40496-40505

Database setup:
- PostgreSQL runs on port 5000 with DB myapp and user appuser.
- On first startup, postgresql_database/startup.sh will auto-run sql/001_init.sql and sql/002_seed.sql if the database is empty.
- Connection helper: see postgresql_database/db_connection.txt or postgresql_database/db_visualizer/postgres.env.

Folders:
- postgresql_database/sql/001_init.sql: Core schema DDL (users/roles/projects/tenders/contractors/funds/milestones/progress/inspections/handover/payments/documents/audit_logs) with constraints and indexes.
- postgresql_database/sql/002_seed.sql: Seed roles and default admin user (assigns ADMIN role).
- postgresql_database/startup.sh: Boots PostgreSQL on port 5000, creates user/db, and runs schema/seed when empty.

Note:
- Replace the placeholder bcrypt hash in 002_seed.sql with a production-grade password hash before deployment.
