# Quick Start Guide - SuperRides STFMS

## Getting Started in 5 Minutes

This guide will help you quickly set up and test the SuperRides Transportation & Fleet Management System database.

---

## Prerequisites

- Oracle Database 11g or higher
- SQL*Plus or Oracle SQL Developer
- Database user with CREATE, INSERT, and EXECUTE privileges

---

## Installation Steps

### Step 1: Create Database Schema (2 minutes)

```sql
-- Connect to your Oracle database
sqlplus username/password@database

-- Execute table creation script
@sql/01_create_tables.sql
```

**Expected Output:** 
- 11 sequences created
- 11 tables created
- "Database schema created successfully!" message

### Step 2: Populate Sample Data (1 minute)

```sql
-- Insert sample data
@sql/02_insert_data.sql
```

**Expected Output:**
- 150+ records inserted across all tables
- "Data insertion completed successfully!" message
- Record count summary displayed

### Step 3: Create Triggers and Procedures (1 minute)

```sql
-- Enable output display
SET SERVEROUTPUT ON SIZE 1000000;

-- Create triggers and stored procedures
@sql/04_triggers_procedures.sql
```

**Expected Output:**
- 4 triggers created
- 4 stored procedures created

---

## Quick Tests

### Test 1: Verify Tables

```sql
-- List all tables
SELECT TABLE_NAME FROM USER_TABLES ORDER BY TABLE_NAME;

-- Count records in each table
SELECT 'CUSTOMER' AS TableName, COUNT(*) AS Records FROM CUSTOMER
UNION ALL SELECT 'DRIVER', COUNT(*) FROM DRIVER
UNION ALL SELECT 'RIDE', COUNT(*) FROM RIDE
UNION ALL SELECT 'PAYMENT', COUNT(*) FROM PAYMENT;
```

### Test 2: Run Sample Queries

```sql
-- Query 1: Recent rides
SELECT 
    C.Name AS CustomerName,
    D.Name AS DriverName,
    R.Fare
FROM RIDE R
JOIN CUSTOMER C ON R.CustomerID = C.CustomerID
JOIN DRIVER D ON R.DriverID = D.DriverID
WHERE R.Status = 'Completed'
  AND R.PickupDateTime >= SYSTIMESTAMP - INTERVAL '7' DAY;

-- Query 2: Top drivers
SELECT Name, Rating, Status
FROM DRIVER
WHERE Rating > 4.5
ORDER BY Rating DESC;
```

### Test 3: Test Triggers

```sql
-- Test driver availability trigger
SELECT DriverID, Status FROM DRIVER WHERE DriverID = 1;

UPDATE RIDE SET Status = 'Completed' 
WHERE RideID = 1 AND Status = 'InProgress';

SELECT DriverID, Status FROM DRIVER WHERE DriverID = 1;
-- Driver status should now be 'Available'
```

### Test 4: Test Stored Procedures

```sql
-- Test loyalty points notification
EXEC sp_notify_expiring_loyalty_points;

-- Test driver performance report
EXEC sp_driver_performance_report(1);

-- Test monthly revenue report
EXEC sp_monthly_revenue_report(2024, 12);
```

---

## Running All Queries

To execute all 8 required queries plus bonus queries:

```sql
@sql/03_queries.sql
```

This will run:
1. Rides completed in last 7 days
2. Drivers with rating > 4.5
3. Total revenue per month
4. Top 5 drivers by rides completed
5. Customers who cancelled > 3 rides
6. Vehicles needing maintenance
7. Maintenance and fuel costs per vehicle
8. Driver performance summary
9. Bonus analytics queries

---

## Common Issues and Solutions

### Issue 1: "Sequence does not exist"
**Solution:** Run `sql/01_create_tables.sql` first to create sequences

### Issue 2: "Table not found"
**Solution:** Ensure you're connected to the correct schema/database

### Issue 3: "Insufficient privileges"
**Solution:** Request CREATE, INSERT, and EXECUTE privileges from DBA

### Issue 4: "Invalid constraint"
**Solution:** Ensure foreign key tables exist before creating dependent tables

---

## Directory Structure

```
AKHIL_DBMS/
├── sql/
│   ├── 01_create_tables.sql      ← Start here
│   ├── 02_insert_data.sql        ← Then run this
│   ├── 03_queries.sql            ← Test with queries
│   └── 04_triggers_procedures.sql ← Finally, create automation
├── diagrams/
│   ├── ERD_Description.md
│   ├── Normalized_Relational_Model.md
│   └── UseCase_Diagram.md
├── documentation/
│   └── Report_Reflection.md
└── README.md                      ← Full documentation
```

---

## Verification Checklist

After installation, verify:

- [ ] 11 tables created
- [ ] 11 sequences created
- [ ] 150+ records inserted
- [ ] All constraints active
- [ ] 4 triggers created
- [ ] 4 stored procedures created
- [ ] Sample queries return results
- [ ] Triggers fire correctly
- [ ] Procedures execute successfully

---

## Next Steps

1. **Review Documentation:**
   - Read `README.md` for comprehensive overview
   - Check `diagrams/` for ERD and normalized model
   - Review `documentation/Report_Reflection.md` for design rationale

2. **Explore the Database:**
   - Run different queries from `sql/03_queries.sql`
   - Experiment with the stored procedures
   - Test the triggers with sample data updates

3. **Customization:**
   - Add more sample data
   - Create additional queries for your use cases
   - Extend triggers and procedures as needed

---

## Support

For issues or questions:
- Check `README.md` for detailed documentation
- Review SQL comments in script files
- Consult Oracle SQL documentation

---

## Performance Tips

1. **For large datasets:**
   - Create additional indexes on frequently queried columns
   - Consider partitioning large tables (RIDE, PAYMENT)

2. **For better query performance:**
   - Analyze tables after data population: `ANALYZE TABLE tablename COMPUTE STATISTICS;`
   - Use EXPLAIN PLAN to optimize slow queries

3. **For production deployment:**
   - Implement backup strategy
   - Set up monitoring
   - Configure appropriate buffer pools

---

## Database Statistics

After setup, your database will contain:

- **11 Tables** with complete relationships
- **150+ Records** across all entities
- **50+ Constraints** ensuring data integrity
- **15+ Indexes** for query optimization
- **4 Triggers** for business rule automation
- **4 Stored Procedures** for operations

---

## Sample Data Overview

| Table | Records | Description |
|-------|---------|-------------|
| CUSTOMER | 12 | User accounts |
| DRIVER | 12 | Driver profiles |
| CITY | 4 | Operational cities |
| VEHICLE | 12 | Fleet vehicles |
| RIDE | 22 | Ride bookings |
| PAYMENT | 19 | Transactions |
| MAINTENANCE | 15 | Service records |
| FEEDBACK | 15 | Customer ratings |
| FUEL_RECORD | 15 | Refueling data |
| DRIVER_AVAILABILITY | 20 | Shift schedules |
| LOYALTY_TRANSACTION | 21 | Points history |

---

## Time Estimate

- **Installation:** 5 minutes
- **Testing:** 10 minutes
- **Full exploration:** 30 minutes

Total time to fully understand the system: ~45 minutes

---

**Ready to Start?** Execute Step 1 above and begin exploring SuperRides STFMS!

---

*Last Updated: December 28, 2024*
