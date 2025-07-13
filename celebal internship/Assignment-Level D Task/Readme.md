# Date Dimension Stored Procedure (SQL Server)

This project demonstrates the creation of a comprehensive **Date Dimension** in SQL Server using a stored procedure. The solution dynamically populates detailed calendar and fiscal date attributes for an entire year, based on an input date.

---

## Objective

To design a stored procedure that:
- Accepts a date (e.g., `'2003-07-14'`) as input
- Populates one full year of records into a `DateDimension` table
- Computes calendar, fiscal, and weekday metadata
- Uses only **one `INSERT` statement** via **recursive CTE**
- Stores up to 366 rows (for leap years)

---

## Step-by-Step Implementation

### Step 1: Create the Database
```sql
CREATE DATABASE DateDimensionDB;
GO
```

### Step 2: Use the Database
```sql
USE DateDimensionDB;
GO
```

### Step 3: Create the Date Dimension Table
A well-structured table with primary key `SKDate` and various calendar & fiscal attributes.

```sql
CREATE TABLE DateDimension (
    SKDate INT PRIMARY KEY,
    KeyDate DATE,
    [Date] DATE,
    CalendarDay INT,
    CalendarMonth INT,
    CalendarQuarter INT,
    CalendarYear INT,
    DayNameLong VARCHAR(20),
    DayNameShort VARCHAR(10),
    DayNumberOfWeek INT,
    DayNumberOfYear INT,
    DaySuffix VARCHAR(5),
    FiscalWeek INT,
    FiscalPeriod INT,
    FiscalQuarter INT,
    FiscalYear INT,
    FiscalYearPeriod VARCHAR(10)
);
GO
```

### Step 4: Create the Stored Procedure
Efficient population using recursive CTE (no loops, no multiple inserts).

```sql
CREATE PROCEDURE PopulateDateDimension
    @InputDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATE = DATEFROMPARTS(YEAR(@InputDate), 1, 1);
    DECLARE @EndDate DATE = DATEFROMPARTS(YEAR(@InputDate), 12, 31);

    ;WITH DateRange AS (
        SELECT @StartDate AS DateValue
        UNION ALL
        SELECT DATEADD(DAY, 1, DateValue)
        FROM DateRange
        WHERE DATEADD(DAY, 1, DateValue) <= @EndDate
    )
    INSERT INTO DateDimension (...columns...)
    SELECT (...values...) FROM DateRange
    OPTION (MAXRECURSION 366);
END;
GO
```

### Step 5: Execute the Procedure
```sql
EXEC PopulateDateDimension '2003-07-14';
GO
```

### Step 6: Query the Output
```sql
-- View inserted rows
SELECT * FROM DateDimension;

-- Row count
SELECT COUNT(*) FROM DateDimension;

-- Filter specific date
SELECT * FROM DateDimension WHERE CalendarMonth = 7 AND CalendarDay = 14;
```

### Step 7: Re-run After Truncating
```sql
TRUNCATE TABLE DateDimension;
EXEC PopulateDateDimension '2021-03-05';
```

---

## Sample Output

| SKDate   | Date       | DayNameLong | FiscalWeek | FiscalYearPeriod |
|----------|------------|-------------|-------------|------------------|
| 20030101 | 2003-01-01 | Wednesday   | 1           | 200301           |
| 20030102 | 2003-01-02 | Thursday    | 1           | 200301           |
| ...      | ...        | ...         | ...         | ...              |

| SKDate   | KeyDate   | DayNameLong | CalendarMonth | FiscalWeek |
|----------|-----------|-------------|----------------|-------------|
| 20200101 | 2020-01-01| Wednesday   | 1              | 1           |
| 20200102 | 2020-01-02| Thursday    | 1              | 1           |
| ...      | ...       | ...         | ...            | ...         |

---

## Files Included

- `DateDimension_Population.sql` – Complete SQL script with table creation, stored procedure, execution, and testing queries.

---

## Technologies Used

- Microsoft SQL Server Management Studio (SSMS)
- T-SQL

---
