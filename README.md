# 📚 Library Database Schema

This repository contains a **MySQL relational database schema** for a simple library management system.  
It covers members, addresses, authors, books, and loans, with full referential integrity.

---

## 🚀 Features
- Manage **members** and their personal information
- Store **addresses** for members (1:1 relationship)
- Track **authors** and their books (many-to-many)
- Keep inventory of **books and copies**
- Handle **loans**, due dates, returns, and statuses

---

## 🛠️ Setup

1. Clone this repository or copy the SQL file.
2. Open MySQL and run:

```sql
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;
