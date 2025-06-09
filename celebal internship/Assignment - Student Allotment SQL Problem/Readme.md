# Student Allotment SQL Problem

This project implements an **elective allocation system** using SQL. The system allocates elective subjects to students based on their **GPA** and **preferences**.

---

## Table of Contents
- [Database Schema](#database-schema)
- [Setup Instructions](#setup-instructions)
- [Running the Allocation Procedure](#running-the-allocation-procedure)
- [Verification](#verification)
- [Contact](#contact)

---

## Database Schema

The system uses the following tables:

- **StudentDetails**: Stores student information (e.g., ID, name, GPA).
- **SubjectDetails**: Stores subject information and available seats.
- **StudentPreference**: Stores student preferences for subjects (ranked).
- **Allotments**: Stores the allocated subjects for students.
- **UnallotedStudents**: Stores students who were not allocated any subjects.

---

## Setup Instructions

### 1. Create and Populate Required Tables

To create and populate the required tables, please refer to the SQL script provided:

**Student Allotment SQL Table**

---

### 2. Create the Stored Procedure

Define the logic for elective allocation based on GPA and preferences.

**Student Allotment SQL Solution**

---

## Running the Allocation Procedure

After the tables and procedure are created, execute the procedure using:

```sql
EXEC AllocateElectives;
```

This will automatically allocate subjects to students based on availability and priority.

---

## Verification

To verify the outcome of the procedure:

### Check Allotted Students:
```sql
SELECT * FROM Allotments;
```

### Check Unallotted Students:
```sql
SELECT * FROM UnallotedStudents;
```

---

## Contact

For any questions or feedback, please contact **Pranali Deshmukh**.

---
