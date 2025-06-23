# Subject Change Request Problem

This repository contains an SQL Server-based solution for managing **subject change requests** in a college environment. It allows administrators to track and update students' Open Elective subjects while maintaining a complete history of subject changes.

---

## Problem Statement

A college requires a system to manage and track **Open Elective Subject** allotments for students. The system must:

- Store the **current and previous** subject choices.
- Record **student requests** for subject changes.
- Ensure historical visibility of **subject allotment updates**.

---

## Solution Overview

This solution is built using **SQL Server** and involves:

### Database Tables

1. **`SubjectAllotments`**
   - Stores all subject allotments for students, including current and previous records.
   - Contains fields like `StudentID`, `SubjectCode`, `IsCurrent`, and `Timestamp`.

2. **`SubjectRequest`**
   - Stores subject change requests raised by students.
   - Contains fields like `RequestID`, `StudentID`, `RequestedSubject`, `RequestDate`.

### Stored Procedure

**`UpdateSubjectAllotments`**

- Checks for valid subject change requests.
- Updates the `SubjectAllotments` table accordingly.
- Marks previous subjects as inactive (`IsCurrent = 0`) and inserts new ones (`IsCurrent = 1`).

---

## Example Usage

### Sample Scripts Include:

- **Creation of Tables**
  - `SubjectAllotments`
  - `SubjectRequest`

- **Insertion of Sample Data**
  - Sample students, subjects, and requests.

- **Execution of Stored Procedure**
  - Running `UpdateSubjectAllotments` to process pending change requests.
