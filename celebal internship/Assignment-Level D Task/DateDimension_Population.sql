-- Step 1: Create the database
CREATE DATABASE DateDimensionDB;
GO

-- Step 2: Use the newly created database
USE DateDimensionDB;
GO

-- Step 3: Create the DateDimension table
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

-- Step 4: Create the stored procedure
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
    INSERT INTO DateDimension (
        SKDate, KeyDate, [Date], CalendarDay, CalendarMonth, CalendarQuarter,
        CalendarYear, DayNameLong, DayNameShort, DayNumberOfWeek,
        DayNumberOfYear, DaySuffix, FiscalWeek, FiscalPeriod,
        FiscalQuarter, FiscalYear, FiscalYearPeriod
    )
    SELECT
        CONVERT(INT, FORMAT(DateValue, 'yyyyMMdd')) AS SKDate,
        DateValue AS KeyDate,
        DateValue AS [Date],
        DAY(DateValue) AS CalendarDay,
        MONTH(DateValue) AS CalendarMonth,
        DATEPART(QUARTER, DateValue) AS CalendarQuarter,
        YEAR(DateValue) AS CalendarYear,
        DATENAME(WEEKDAY, DateValue) AS DayNameLong,
        LEFT(DATENAME(WEEKDAY, DateValue), 3) AS DayNameShort,
        DATEPART(WEEKDAY, DateValue) AS DayNumberOfWeek,
        DATEPART(DAYOFYEAR, DateValue) AS DayNumberOfYear,
        CAST(DAY(DateValue) AS VARCHAR) +
            CASE 
                WHEN DAY(DateValue) IN (11, 12, 13) THEN 'th'
                WHEN DAY(DateValue) % 10 = 1 THEN 'st'
                WHEN DAY(DateValue) % 10 = 2 THEN 'nd'
                WHEN DAY(DateValue) % 10 = 3 THEN 'rd'
                ELSE 'th'
            END AS DaySuffix,
        DATEPART(WEEK, DateValue) AS FiscalWeek,
        MONTH(DateValue) AS FiscalPeriod,
        DATEPART(QUARTER, DateValue) AS FiscalQuarter,
        YEAR(DateValue) AS FiscalYear,
        CAST(YEAR(DateValue) AS VARCHAR) + RIGHT('0' + CAST(MONTH(DateValue) AS VARCHAR), 2) AS FiscalYearPeriod
    FROM DateRange
    OPTION (MAXRECURSION 366);
END;
GO

-- Step 5: Execute the stored procedure for a specific year
EXEC PopulateDateDimension '2003-07-14';
GO

EXEC PopulateDateDimension '2003-07-14';
GO

--Step 6: To view the inserted data
SELECT * FROM DateDimension;
GO

-- To Row count check (how many days inserted)
SELECT COUNT(*) FROM DateDimension;
GO

-- To Filter specific dates
SELECT * FROM DateDimension WHERE CalendarMonth = 7 AND CalendarDay = 14;
GO

-- Step 7: If you want to clear the table and run again

TRUNCATE TABLE DateDimension;
EXEC PopulateDateDimension '2021-03-05';  -- Different year
GO