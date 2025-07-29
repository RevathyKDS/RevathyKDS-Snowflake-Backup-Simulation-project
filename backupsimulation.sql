-- Step 1: Create Database and Schema
CREATE OR REPLACE DATABASE employee_db;
CREATE OR REPLACE SCHEMA employee_db.hr;
USE SCHEMA employee_db.hr;

-- Step 2: Create Employee Table and Insert Sample Data
CREATE OR REPLACE TABLE employees (
  id INT,
  name STRING,
  department STRING,
  salary NUMBER
);

INSERT INTO employees (id, name, department, salary) VALUES
(1, 'Revathy', 'IT', 70000),
(2, 'John', 'HR', 60000),
(3, 'Meena', 'Sales', 50000);

-- Step 3: Enable Change Tracking (Stream for Incremental)
CREATE OR REPLACE STREAM emp_stream ON TABLE employees;

-- Step 4: Create Log Table to Track Backups
CREATE OR REPLACE TABLE backup_log (
  backup_name STRING,
  timestamp TIMESTAMP,
  status STRING
);

-- Step 5: Create Task to Perform Daily Clone (Simulating Full Backup)
CREATE OR REPLACE TASK daily_employee_backup
  WAREHOUSE = compute_wh
  SCHEDULE = 'USING CRON 0 2 * * * UTC'
AS
BEGIN
  CREATE OR REPLACE TABLE employee_db.hr.employees_backup CLONE employee_db.hr.employees;
  INSERT INTO employee_db.hr.backup_log
    VALUES ('employees_backup', CURRENT_TIMESTAMP(), 'SUCCESS');
END;

-- Step 6: Resume the Scheduled Task
ALTER TASK daily_employee_backup RESUME;

-- Step 7: (Optional) Simulate Updates for Testing Stream
UPDATE employees SET salary = salary + 5000 WHERE id = 2;

-- Step 8: View Changes Captured by Stream
SELECT * FROM emp_stream;

-- Step 9: View Backup Log
SELECT * FROM backup_log;

-- Step 10: Restore from Backup (Manual)
-- Use if you need to simulate a restore scenario
-- CREATE OR REPLACE TABLE employees RESTORE FROM employees_backup;
