-- Create the SCD database
CREATE DATABASE SCD;
GO

-- Use the SCD database
USE SCD;
GO

-- Step 1: Create Main Dimension Table
CREATE TABLE DimCustomer (
    CustomerID INT,
    Name NVARCHAR(100),
    City NVARCHAR(100),
    PreviousCity NVARCHAR(100),     -- For SCD Type 3 & 6
    EffectiveDate DATETIME,         -- For SCD Type 2 & 6
    ExpiryDate DATETIME,            -- For SCD Type 2 & 6
    IsCurrent BIT                   -- For SCD Type 2 & 6
);
GO

-- Step 2: Create History Table for SCD Type 4
CREATE TABLE DimCustomer_History (
    CustomerID INT,
    Name NVARCHAR(100),
    City NVARCHAR(100),
    ChangeDate DATETIME
);
GO

-- Step 3: Insert Sample Data
INSERT INTO DimCustomer (CustomerID, Name, City, PreviousCity, EffectiveDate, ExpiryDate, IsCurrent)
VALUES
(101, 'Alice', 'Delhi', NULL, GETDATE(), NULL, 1),
(102, 'Bob', 'Mumbai', NULL, GETDATE(), NULL, 1),
(103, 'Zon', 'Gujrat', NULL, GETDATE(), NULL, 1),
(104, 'Mage', 'Goa', NULL, GETDATE(), NULL, 1),
(105, 'Allen', 'Kerala', NULL, GETDATE(), NULL, 1),
(106, 'Sam', 'Pune', NULL, GETDATE(), NULL, 1);
GO

-- Step 4: Create SCD Type 0 Procedure
CREATE PROCEDURE SCD_Type0_Update
    @CustomerID INT,
    @NewCity NVARCHAR(100)
AS
BEGIN
    PRINT 'SCD Type 0: No changes allowed.';
END;
GO

-- Step 5: Create SCD Type 1 Procedure
CREATE PROCEDURE SCD_Type1_Update
    @CustomerID INT,
    @NewCity NVARCHAR(100)
AS
BEGIN
    UPDATE DimCustomer
    SET City = @NewCity
    WHERE CustomerID = @CustomerID;
END;
GO

-- Step 6: Create SCD Type 2 Procedure
CREATE PROCEDURE SCD_Type2_Update
    @CustomerID INT,
    @NewCity NVARCHAR(100)
AS
BEGIN
    DECLARE @Now DATETIME = GETDATE();

    UPDATE DimCustomer
    SET ExpiryDate = @Now, IsCurrent = 0
    WHERE CustomerID = @CustomerID AND IsCurrent = 1;

    INSERT INTO DimCustomer (CustomerID, Name, City, PreviousCity, EffectiveDate, ExpiryDate, IsCurrent)
    SELECT CustomerID, Name, @NewCity, NULL, @Now, NULL, 1
    FROM DimCustomer
    WHERE CustomerID = @CustomerID
    ORDER BY ExpiryDate DESC;
END;
GO

-- Step 7: Create SCD Type 3 Procedure
CREATE PROCEDURE SCD_Type3_Update
    @CustomerID INT,
    @NewCity NVARCHAR(100)
AS
BEGIN
    UPDATE DimCustomer
    SET PreviousCity = City,
        City = @NewCity
    WHERE CustomerID = @CustomerID;
END;
GO

-- Step 8: Create SCD Type 4 Procedure
CREATE PROCEDURE SCD_Type4_Update
    @CustomerID INT,
    @NewCity NVARCHAR(100)
AS
BEGIN
    INSERT INTO DimCustomer_History (CustomerID, Name, City, ChangeDate)
    SELECT CustomerID, Name, City, GETDATE()
    FROM DimCustomer
    WHERE CustomerID = @CustomerID;

    UPDATE DimCustomer
    SET City = @NewCity
    WHERE CustomerID = @CustomerID;
END;
GO

-- Step 9: Create SCD Type 6 Procedure
CREATE PROCEDURE SCD_Type6_Update
    @CustomerID INT,
    @NewCity NVARCHAR(100)
AS
BEGIN
    DECLARE @Now DATETIME = GETDATE();

    UPDATE DimCustomer
    SET ExpiryDate = @Now, IsCurrent = 0
    WHERE CustomerID = @CustomerID AND IsCurrent = 1;

    INSERT INTO DimCustomer (CustomerID, Name, City, PreviousCity, EffectiveDate, ExpiryDate, IsCurrent)
    SELECT CustomerID, Name, @NewCity, City, @Now, NULL, 1
    FROM DimCustomer
    WHERE CustomerID = @CustomerID
    ORDER BY ExpiryDate DESC;
END;
GO

-- Type 0
EXEC SCD_Type0_Update @CustomerID = 101, @NewCity = 'Agra';

-- Type 1
EXEC SCD_Type1_Update @CustomerID = 101, @NewCity = 'Agra';

-- Type 2
EXEC SCD_Type2_Update @CustomerID = 102, @NewCity = 'Pune';

-- Type 3
EXEC SCD_Type3_Update @CustomerID = 101, @NewCity = 'Lucknow';

-- Type 4
EXEC SCD_Type4_Update @CustomerID = 102, @NewCity = 'Kolkata';

-- Type 6
EXEC SCD_Type6_Update @CustomerID = 101, @NewCity = 'Chennai';
GO

-- View current data
SELECT * FROM DimCustomer;

-- View history table (for Type 4)
SELECT * FROM DimCustomer_History;
