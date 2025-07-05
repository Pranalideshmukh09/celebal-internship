# 📦 Slowly Changing Dimensions (SCD) – SQL Server Stored Procedures

This repository provides a comprehensive solution for implementing **Slowly Changing Dimensions (SCD)** in a Data Warehouse using **Microsoft SQL Server (SSMS)**. It covers all major SCD types with real-world procedures, sample data, and testing methods.

---

## 🎯 Objective

In data warehousing, **SCDs are essential for tracking the evolution of dimensional attributes over time**. Businesses often need to retain, overwrite, or combine history for fields like customer address, employee role, or location.

This project simulates such requirements using a `DimCustomer` table and demonstrates each SCD type (0, 1, 2, 3, 4, 6) through **SQL Server stored procedures**.

---

## 🧠 What You'll Learn

- How each SCD type behaves in real business scenarios
- How to use T-SQL procedures to automate SCD logic
- Proper usage of columns like `EffectiveDate`, `IsCurrent`, and history tables
- Difference between overwrite (SCD 1), append (SCD 2), hybrid (SCD 6), etc.

---

## 🧱 Database Design

### 🔸 Table 1: `DimCustomer` (Main Dimension Table)
| Column         | Description                          |
|----------------|--------------------------------------|
| CustomerID     | Unique customer ID                   |
| Name           | Customer name                        |
| City           | Current city                         |
| PreviousCity   | Last known city (SCD Type 3, 6)      |
| EffectiveDate  | Start date of record (SCD Type 2, 6) |
| ExpiryDate     | End date of record (SCD Type 2, 6)   |
| IsCurrent      | Active/inactive record flag (Type 2) |

### 🔸 Table 2: `DimCustomer_History` (Used only for SCD Type 4)
| Column      | Description           |
|-------------|-----------------------|
| CustomerID  | Customer identifier   |
| Name        | Name at that point    |
| City        | City at that point    |
| ChangeDate  | When the change was made |

---

## 🧪 SCD Types Implemented

| SCD Type | Strategy                          | Description |
|----------|-----------------------------------|-------------|
| Type 0   | Fixed — No changes allowed        | Data is read-only once inserted. |
| Type 1   | Overwrite                         | Updates existing data without keeping history. |
| Type 2   | Add new row                       | Creates a new row with timestamps and version tracking. |
| Type 3   | Add column for previous value     | Stores previous value in another column. |
| Type 4   | Keep history in separate table    | Moves old data to a history table. |
| Type 6   | Hybrid (1+2+3)                    | Combines overwriting, versioning, and previous column. |

---

## 📂 Files Included

- `SCD_Types_SQLServer.sql`:  
  Full SQL script containing:
  - Table creation
  - Sample data
  - Stored procedures for all SCD types
  - Execution and test examples

- `README.md`:  
  Documentation and usage instructions.

---

## 🚀 How to Use

### Step 1: Create the Database in SSMS
```sql
CREATE DATABASE SCD;
USE SCD;
```

### Step 2: Execute the `.sql` Script
Run the `SCD_Types_SQLServer.sql` script in SQL Server Management Studio. This will:
- Create `DimCustomer` and `DimCustomer_History` tables
- Insert sample data
- Create all 6 stored procedures

### Step 3: Call Any Procedure to Test

```sql
-- Example: Apply SCD Type 2 change
EXEC SCD_Type2_Update @CustomerID = 102, @NewCity = 'Pune';

-- Example: SCD Type 6 hybrid change
EXEC SCD_Type6_Update @CustomerID = 101, @NewCity = 'Hyderabad';
```
## 💡 Example Use Case

> Suppose a customer moves from Delhi to Pune.  
> Depending on the SCD type:
- **Type 1**: Overwrites Delhi with Pune.
- **Type 2**: Ends Delhi row, starts new row for Pune.
- **Type 3**: Stores Delhi in `PreviousCity`, updates `City` to Pune.
- **Type 4**: Saves old Delhi record in history table.
- **Type 6**: All of the above (overwrites, logs version, and keeps previous).

---

## 👨‍💻 Author

- **Name**: Pranali Deshmukh
- **Tools Used**: Microsoft SQL Server Management Studio (SSMS)
- **GitHub**: Pranalideshmukh09


