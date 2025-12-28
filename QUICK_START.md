# Quick Start Guide - STFMS Database
## Testing and Demonstration Instructions

This guide provides step-by-step instructions for setting up, testing, and demonstrating the STFMS database system.

## Prerequisites

- Oracle Database 11g or later (or PostgreSQL with minor modifications)
- SQL*Plus, SQL Developer, or any Oracle-compatible SQL client
- Database user with CREATE TABLE, CREATE SEQUENCE, CREATE TRIGGER, CREATE PROCEDURE privileges

## Installation Steps

### Step 1: Connect to Database

```sql
-- Connect as your database user
sqlplus username/password@database

-- Or using SQL Developer, create a new connection
```

### Step 2: Create Tables and Constraints

```sql
-- Execute the DDL script
@sql/01_create_tables.sql

-- Verify table creation
SELECT table_name FROM user_tables ORDER BY table_name;

-- Expected output: 9 tables
-- CITY, CUSTOMER, DRIVER, FEEDBACK, LOYALTYPOINTS, 
-- MAINTENANCE, PAYMENT, RIDE, VEHICLE
```

### Step 3: Populate Sample Data

```sql
-- Execute the data population script
@sql/02_insert_data.sql

-- Verify data insertion
SELECT 'Cities' AS entity, COUNT(*) AS count FROM City
UNION ALL SELECT 'Customers', COUNT(*) FROM Customer
UNION ALL SELECT 'Drivers', COUNT(*) FROM Driver
UNION ALL SELECT 'Vehicles', COUNT(*) FROM Vehicle
UNION ALL SELECT 'Rides', COUNT(*) FROM Ride
UNION ALL SELECT 'Payments', COUNT(*) FROM Payment
UNION ALL SELECT 'Feedback', COUNT(*) FROM Feedback
UNION ALL SELECT 'Maintenance', COUNT(*) FROM Maintenance
UNION ALL SELECT 'Loyalty Points', COUNT(*) FROM LoyaltyPoints;

-- Expected: Total 144 records across all tables
```

### Step 4: Deploy Triggers

```sql
-- Execute the triggers script
@sql/04_triggers.sql

-- Verify trigger creation
SELECT trigger_name, table_name, status 
FROM user_triggers 
ORDER BY table_name, trigger_name;

-- Expected: 9 triggers in ENABLED status
```

### Step 5: Deploy Stored Procedures

```sql
-- Execute the procedures script
@sql/05_procedures.sql

-- Verify procedure creation
SELECT object_name, object_type, status 
FROM user_objects 
WHERE object_type = 'PROCEDURE'
ORDER BY object_name;

-- Expected: 5 procedures in VALID status
```

## Testing the System

### Test 1: Verify Data Integrity

```sql
-- Check foreign key relationships
SELECT 
    c.constraint_name,
    c.table_name,
    cc.column_name,
    c.r_constraint_name
FROM user_constraints c
JOIN user_cons_columns cc ON c.constraint_name = cc.constraint_name
WHERE c.constraint_type = 'R'
ORDER BY c.table_name;

-- Should show 13 foreign key relationships
```

### Test 2: Execute Business Queries

```sql
-- Enable output to see query results
SET PAGESIZE 100
SET LINESIZE 200

-- Execute all queries
@sql/03_queries.sql

-- Or execute individual queries:

-- Query 1: Recent rides (last 7 days)
SELECT 
    r.ride_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    d.first_name || ' ' || d.last_name AS driver_name,
    r.fare_amount,
    r.booking_time
FROM Ride r
JOIN Customer c ON r.customer_id = c.customer_id
JOIN Driver d ON r.driver_id = d.driver_id
WHERE r.status = 'Completed'
  AND r.booking_time >= CURRENT_TIMESTAMP - INTERVAL '7' DAY
ORDER BY r.booking_time DESC;

-- Expected: Multiple rides from December 23-27, 2024
```

### Test 3: Test Triggers

#### Test Trigger 1: Driver Status Update

```sql
-- Check current driver status
SELECT driver_id, status FROM Driver WHERE driver_id = 1;

-- Simulate completing a ride for driver 1
UPDATE Ride 
SET status = 'Completed' 
WHERE ride_id = 11 AND driver_id = 10;

-- Verify driver status changed to Available
SELECT driver_id, status FROM Driver WHERE driver_id = 10;
-- Expected: status = 'Available'

-- Rollback to maintain test data
ROLLBACK;
```

#### Test Trigger 2: Automatic Maintenance Scheduling

```sql
-- Check current vehicle status
SELECT vehicle_id, total_km, last_maintenance_km, status 
FROM Vehicle WHERE vehicle_id = 1;

-- Simulate vehicle reaching 20,000 km since last maintenance
UPDATE Vehicle 
SET total_km = last_maintenance_km + 20001
WHERE vehicle_id = 1;

-- Verify maintenance was scheduled
SELECT * FROM Maintenance 
WHERE vehicle_id = 1 
  AND status = 'Scheduled'
ORDER BY maintenance_id DESC
FETCH FIRST 1 ROW ONLY;

-- Expected: New maintenance record created

-- Verify vehicle status changed to Maintenance
SELECT vehicle_id, status FROM Vehicle WHERE vehicle_id = 1;
-- Expected: status = 'Maintenance'

-- Rollback
ROLLBACK;
```

### Test 4: Test Stored Procedures

#### Test Procedure: Loyalty Points Expiration Notification

```sql
-- Enable server output
SET SERVEROUTPUT ON SIZE 1000000;

-- Execute the procedure
BEGIN
    sp_notify_expiring_loyalty_points;
END;
/

-- Expected output: Notifications for customers with points expiring in 7 days
-- Check the output for notification details
```

#### Test Procedure: Assign Driver to Ride

```sql
-- Create a test pending ride
INSERT INTO Ride (
    ride_id, customer_id, pickup_location, dropoff_location,
    booking_time, fare_amount, status, ride_type, city_id
) VALUES (
    seq_ride.NEXTVAL, 1, 'Test Pickup', 'Test Dropoff',
    CURRENT_TIMESTAMP, 20.00, 'Pending', 'Standard', 1
);

-- Get the ride ID
SELECT ride_id FROM Ride WHERE status = 'Pending' ORDER BY ride_id DESC FETCH FIRST 1 ROW ONLY;

-- Assign driver to the ride (replace 999 with actual ride_id)
DECLARE
    v_assigned_driver_id NUMBER;
BEGIN
    sp_assign_driver_to_ride(999, v_assigned_driver_id);
    DBMS_OUTPUT.PUT_LINE('Assigned driver: ' || v_assigned_driver_id);
END;
/

-- Verify assignment
SELECT ride_id, driver_id, vehicle_id, status 
FROM Ride 
WHERE ride_id = 999;
-- Expected: driver_id and vehicle_id populated, status = 'Assigned'

-- Clean up
DELETE FROM Ride WHERE ride_id = 999;
COMMIT;
```

## Demonstration Scenarios

### Scenario 1: Complete Ride Workflow

```sql
-- 1. Customer books a ride (already in sample data)
SELECT * FROM Ride WHERE ride_id = 11;

-- 2. System assigns driver (trigger: driver status changes)
-- Already demonstrated above

-- 3. Driver starts ride
UPDATE Ride SET 
    status = 'In Progress',
    pickup_time = CURRENT_TIMESTAMP
WHERE ride_id = 11;

-- Check driver status changed to 'On Ride'
SELECT driver_id, status FROM Driver WHERE driver_id = 10;

-- 4. Driver completes ride
UPDATE Ride SET 
    status = 'Completed',
    dropoff_time = CURRENT_TIMESTAMP,
    distance_km = 15.5
WHERE ride_id = 11;

-- Check driver status changed back to 'Available'
SELECT driver_id, status FROM Driver WHERE driver_id = 10;

-- Check loyalty points awarded
SELECT * FROM LoyaltyPoints 
WHERE customer_id = 10 
ORDER BY loyalty_id DESC 
FETCH FIRST 1 ROW ONLY;

-- Rollback to preserve test data
ROLLBACK;
```

### Scenario 2: Vehicle Maintenance Tracking

```sql
-- 1. Check vehicles needing maintenance (Query 6)
SELECT 
    v.vehicle_id,
    v.vehicle_number,
    v.total_km,
    v.last_maintenance_km,
    (v.total_km - v.last_maintenance_km) AS km_since_maintenance
FROM Vehicle v
WHERE (v.total_km - v.last_maintenance_km) > 10000
ORDER BY km_since_maintenance DESC;

-- 2. Check maintenance history
SELECT 
    m.maintenance_id,
    m.vehicle_id,
    v.vehicle_number,
    m.maintenance_type,
    m.cost,
    m.maintenance_date
FROM Maintenance m
JOIN Vehicle v ON m.vehicle_id = v.vehicle_id
WHERE m.maintenance_type != 'Fuel'
ORDER BY m.maintenance_date DESC;

-- 3. Calculate total maintenance costs (Query 7)
SELECT 
    v.vehicle_number,
    SUM(CASE WHEN m.maintenance_type = 'Fuel' THEN m.cost ELSE 0 END) AS fuel_cost,
    SUM(CASE WHEN m.maintenance_type != 'Fuel' THEN m.cost ELSE 0 END) AS maintenance_cost,
    SUM(m.cost) AS total_cost
FROM Vehicle v
JOIN Maintenance m ON v.vehicle_id = m.vehicle_id
WHERE EXTRACT(YEAR FROM m.maintenance_date) = 2024
GROUP BY v.vehicle_id, v.vehicle_number
ORDER BY total_cost DESC;
```

### Scenario 3: Driver Performance Analysis

```sql
-- Execute Query 8: Driver Performance Summary
SELECT 
    d.driver_id,
    d.first_name || ' ' || d.last_name AS driver_name,
    COUNT(r.ride_id) AS total_rides,
    AVG(r.fare_amount) AS average_fare,
    SUM(r.fare_amount) AS total_revenue,
    d.average_rating,
    CASE 
        WHEN d.average_rating >= 4.8 THEN 'Excellent'
        WHEN d.average_rating >= 4.5 THEN 'Very Good'
        WHEN d.average_rating >= 4.0 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM Driver d
LEFT JOIN Ride r ON d.driver_id = r.driver_id AND r.status = 'Completed'
GROUP BY d.driver_id, d.first_name, d.last_name, d.average_rating
ORDER BY total_rides DESC, average_fare DESC
FETCH FIRST 10 ROWS ONLY;
```

### Scenario 4: Customer Behavior Analysis

```sql
-- Find customers with multiple cancellations (Query 5)
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    COUNT(r.ride_id) AS cancelled_rides,
    c.status
FROM Customer c
JOIN Ride r ON c.customer_id = r.customer_id
WHERE r.status = 'Cancelled'
  AND r.booking_time >= CURRENT_TIMESTAMP - INTERVAL '60' DAY
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.status
HAVING COUNT(r.ride_id) > 3
ORDER BY cancelled_rides DESC;

-- Check loyalty points for active customers
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(lp.points) AS total_points,
    COUNT(lp.loyalty_id) AS point_records
FROM Customer c
JOIN LoyaltyPoints lp ON c.customer_id = lp.customer_id
WHERE lp.status = 'Active'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_points DESC;
```

## Performance Testing

### Test Query Performance

```sql
-- Enable timing
SET TIMING ON;

-- Test Query 3: Monthly revenue (should execute in < 1 second)
SELECT 
    TO_CHAR(r.booking_time, 'YYYY-MM') AS month,
    COUNT(r.ride_id) AS total_rides,
    SUM(r.fare_amount) AS total_revenue
FROM Ride r
WHERE r.status = 'Completed'
GROUP BY TO_CHAR(r.booking_time, 'YYYY-MM')
ORDER BY month DESC;

-- Test Query 4: Top drivers (should execute in < 1 second)
SELECT 
    d.driver_id,
    d.first_name || ' ' || d.last_name AS driver_name,
    COUNT(r.ride_id) AS rides_completed
FROM Driver d
JOIN Ride r ON d.driver_id = r.driver_id
WHERE r.status = 'Completed'
  AND r.booking_time >= ADD_MONTHS(CURRENT_TIMESTAMP, -1)
GROUP BY d.driver_id, d.first_name, d.last_name
ORDER BY rides_completed DESC
FETCH FIRST 5 ROWS ONLY;

SET TIMING OFF;
```

### Check Index Usage

```sql
-- Verify indexes are being used
SELECT index_name, table_name, uniqueness 
FROM user_indexes 
ORDER BY table_name, index_name;

-- Expected: 13 indexes plus automatic PK/UK indexes
```

## Troubleshooting

### Issue: Tables Already Exist

```sql
-- Drop all tables in correct order (respects foreign keys)
DROP TABLE Maintenance CASCADE CONSTRAINTS;
DROP TABLE Feedback CASCADE CONSTRAINTS;
DROP TABLE Payment CASCADE CONSTRAINTS;
DROP TABLE Ride CASCADE CONSTRAINTS;
DROP TABLE Driver CASCADE CONSTRAINTS;
DROP TABLE Vehicle CASCADE CONSTRAINTS;
DROP TABLE LoyaltyPoints CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE City CASCADE CONSTRAINTS;

-- Drop sequences
DROP SEQUENCE seq_maintenance;
DROP SEQUENCE seq_feedback;
DROP SEQUENCE seq_payment;
DROP SEQUENCE seq_ride;
DROP SEQUENCE seq_driver;
DROP SEQUENCE seq_vehicle;
DROP SEQUENCE seq_loyalty;
DROP SEQUENCE seq_customer;
DROP SEQUENCE seq_city;

-- Then re-run step 2
```

### Issue: Triggers Not Firing

```sql
-- Check trigger status
SELECT trigger_name, status FROM user_triggers;

-- Enable trigger if disabled
ALTER TRIGGER trigger_name ENABLE;

-- Compile trigger if invalid
ALTER TRIGGER trigger_name COMPILE;
```

### Issue: Procedures Not Working

```sql
-- Check procedure status
SELECT object_name, status FROM user_objects WHERE object_type = 'PROCEDURE';

-- Recompile procedure if invalid
ALTER PROCEDURE procedure_name COMPILE;

-- Check for errors
SELECT * FROM user_errors WHERE name = 'PROCEDURE_NAME';
```

## Clean Up (After Testing)

```sql
-- Drop all objects
DROP TABLE Maintenance CASCADE CONSTRAINTS;
DROP TABLE Feedback CASCADE CONSTRAINTS;
DROP TABLE Payment CASCADE CONSTRAINTS;
DROP TABLE Ride CASCADE CONSTRAINTS;
DROP TABLE Driver CASCADE CONSTRAINTS;
DROP TABLE Vehicle CASCADE CONSTRAINTS;
DROP TABLE LoyaltyPoints CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE City CASCADE CONSTRAINTS;

DROP SEQUENCE seq_maintenance;
DROP SEQUENCE seq_feedback;
DROP SEQUENCE seq_payment;
DROP SEQUENCE seq_ride;
DROP SEQUENCE seq_driver;
DROP SEQUENCE seq_vehicle;
DROP SEQUENCE seq_loyalty;
DROP SEQUENCE seq_customer;
DROP SEQUENCE seq_city;

-- Verify cleanup
SELECT COUNT(*) FROM user_tables;
-- Expected: 0
```

## Presentation Tips

1. **Start with ERD**: Show the diagram explaining entities and relationships
2. **Demo USE CASES**: Walk through customer booking a ride scenario
3. **Show Sample Data**: Display a few records from each table
4. **Execute Query 8**: Driver performance summary (most impressive)
5. **Demo Triggers**: Show automatic driver status update
6. **Run Procedure**: Execute loyalty points notification
7. **Show Reports**: Monthly revenue and top drivers queries

## Additional Resources

- Full documentation: `docs/` directory
- ERD description: `docs/ERD_Description.md`
- USE CASE details: `docs/UseCase_Description.md`
- Data dictionary: `docs/Data_Dictionary.md`
- Reflection report: `docs/Reflection_Report.md`

## Success Criteria Checklist

- ✅ All 9 tables created successfully
- ✅ All constraints enforced (PK, FK, CHECK, UNIQUE)
- ✅ Sample data loaded (144 total records)
- ✅ All 8 required queries execute correctly
- ✅ All triggers function as expected
- ✅ All procedures execute without errors
- ✅ No data integrity violations
- ✅ Query performance is acceptable (< 2 seconds)

**System Status**: ✅ READY FOR DEMONSTRATION
