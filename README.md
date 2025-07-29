# Snowflake-Backup-Simulation-project
# ❄️ Snowflake Backup Simulation & Recovery Workflow

## 🚀 Project Overview
This project simulates backup, restore, and change tracking functionality in **Snowflake** using built-in features like **Time Travel**, **Zero-Copy Cloning**, **Streams**, and **Tasks**. It mimics traditional MySQL backup workflows but uses Snowflake-native cloud capabilities to build a modern and automated solution.

---

## 📌 Key Features

- ✅ Full backups via **zero-copy cloning**
- 🔁 Incremental change tracking via **streams**
- 📅 Daily automated backups using **Snowflake Tasks (CRON)**
- 🛠️ Backup activity logging for **monitoring**
- 💾 Ready for integration with BI dashboards or alerts

---

## 🗃️ Project Structure

| Component        | Description                                          |
|------------------|------------------------------------------------------|
| `employees`      | Main transactional table                             |
| `employees_backup` | Cloned backup copy (full backup simulation)       |
| `emp_stream`     | Change Data Capture stream (incremental backup)      |
| `backup_log`     | Tracks backup activity with timestamps               |
| `daily_employee_backup` | Snowflake task for daily scheduled cloning |

---

## 🛠️ Setup Steps

### 1. Create Database & Tables
```sql
CREATE DATABASE employee_db;
CREATE SCHEMA hr;
CREATE TABLE employees (...);
INSERT INTO employees VALUES (...);
