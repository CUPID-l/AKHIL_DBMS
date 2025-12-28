-- ============================================================================
-- SuperRides Transportation & Fleet Management System (STFMS)
-- SQL Triggers and Stored Procedures - Task 6 (5 Marks)
-- Database: Oracle SQL
-- Module: CN5000 Database Systems
-- ============================================================================

-- ============================================================================
-- Trigger 1: Auto-mark driver as "Available" when ride status = "Completed"
-- (2 marks)
-- ============================================================================

-- Purpose: Automatically update driver status to 'Available' when a ride is completed
-- This ensures drivers become available for new assignments immediately

CREATE OR REPLACE TRIGGER trg_driver_available_on_ride_complete
AFTER UPDATE OF Status ON RIDE
FOR EACH ROW
WHEN (NEW.Status = 'Completed' OR NEW.Status = 'Cancelled')
BEGIN
    -- Update driver status to Available when ride is completed or cancelled
    UPDATE DRIVER
    SET Status = 'Available'
    WHERE DriverID = :NEW.DriverID
      AND Status = 'Busy';
    
    -- Log the status change
    DBMS_OUTPUT.PUT_LINE('Driver ' || :NEW.DriverID || ' is now Available after ride ' || :NEW.RideID);
END;
/

-- Test the trigger
-- UPDATE RIDE SET Status = 'Completed' WHERE RideID = 1;
-- SELECT DriverID, Status FROM DRIVER WHERE DriverID = (SELECT DriverID FROM RIDE WHERE RideID = 1);

COMMENT ON TABLE DRIVER IS 'Trigger trg_driver_available_on_ride_complete automatically sets driver status to Available';

-- ============================================================================
-- Trigger 2: Auto-schedule maintenance after every 20,000 km
-- (2 marks)
-- ============================================================================

-- Purpose: Automatically create a maintenance record when vehicle mileage exceeds 
-- threshold since last maintenance (20,000 km intervals)

CREATE OR REPLACE TRIGGER trg_auto_schedule_maintenance
AFTER UPDATE OF Mileage ON VEHICLE
FOR EACH ROW
WHEN (NEW.Mileage > OLD.Mileage)
DECLARE
    v_last_maintenance_mileage NUMBER;
    v_mileage_since_maintenance NUMBER;
    v_next_maintenance_id NUMBER;
BEGIN
    -- Get the mileage at last maintenance
    BEGIN
        SELECT NVL(MAX(MileageAtService), 0)
        INTO v_last_maintenance_mileage
        FROM MAINTENANCE
        WHERE VehicleID = :NEW.VehicleID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_last_maintenance_mileage := 0;
    END;
    
    -- Calculate mileage since last maintenance
    v_mileage_since_maintenance := :NEW.Mileage - v_last_maintenance_mileage;
    
    -- If mileage since last maintenance exceeds 20,000 km, schedule maintenance
    IF v_mileage_since_maintenance >= 20000 THEN
        -- Get next maintenance ID
        SELECT maintenance_seq.NEXTVAL INTO v_next_maintenance_id FROM DUAL;
        
        -- Insert new maintenance record
        INSERT INTO MAINTENANCE (
            MaintenanceID,
            VehicleID,
            MaintenanceDate,
            MaintenanceType,
            Description,
            Cost,
            MileageAtService,
            NextMaintenanceDue
        ) VALUES (
            v_next_maintenance_id,
            :NEW.VehicleID,
            SYSDATE + 7, -- Schedule for 7 days from now
            'Routine',
            'Auto-scheduled maintenance due to exceeding 20,000 km threshold',
            0, -- Cost to be determined after service
            :NEW.Mileage,
            :NEW.Mileage + 20000
        );
        
        -- Update vehicle status to indicate maintenance is due
        UPDATE VEHICLE
        SET Status = 'Maintenance'
        WHERE VehicleID = :NEW.VehicleID;
        
        -- Log the maintenance scheduling
        DBMS_OUTPUT.PUT_LINE('Maintenance scheduled for Vehicle ' || :NEW.VehicleID || 
                           ' - Mileage: ' || :NEW.Mileage || 
                           ' (Since last: ' || v_mileage_since_maintenance || ' km)');
    END IF;
END;
/

-- Test the trigger
-- UPDATE VEHICLE SET Mileage = 85000 WHERE VehicleID = 1;
-- SELECT * FROM MAINTENANCE WHERE VehicleID = 1 ORDER BY MaintenanceDate DESC;

COMMENT ON TABLE MAINTENANCE IS 'Trigger trg_auto_schedule_maintenance creates maintenance records every 20,000 km';

-- ============================================================================
-- Additional Trigger: Update Driver Rating after Feedback
-- ============================================================================

-- Purpose: Automatically recalculate driver's average rating when new feedback is submitted

CREATE OR REPLACE TRIGGER trg_update_driver_rating
AFTER INSERT ON FEEDBACK
FOR EACH ROW
DECLARE
    v_avg_rating NUMBER(3,2);
BEGIN
    -- Calculate average rating from all feedback for this driver
    SELECT ROUND(AVG(Rating), 2)
    INTO v_avg_rating
    FROM FEEDBACK
    WHERE DriverID = :NEW.DriverID;
    
    -- Update driver's rating
    UPDATE DRIVER
    SET Rating = v_avg_rating
    WHERE DriverID = :NEW.DriverID;
    
    DBMS_OUTPUT.PUT_LINE('Driver ' || :NEW.DriverID || ' rating updated to ' || v_avg_rating);
END;
/

-- Test the trigger
-- INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 5, 1, 1, 5, 'Great service!', SYSDATE);
-- SELECT DriverID, Rating FROM DRIVER WHERE DriverID = 1;

-- ============================================================================
-- Additional Trigger: Update Customer Loyalty Points on Ride Completion
-- ============================================================================

-- Purpose: Award loyalty points to customers when they complete a ride
-- Points earned = 1 point per £1 spent (rounded down)

CREATE OR REPLACE TRIGGER trg_award_loyalty_points
AFTER INSERT ON PAYMENT
FOR EACH ROW
WHEN (NEW.PaymentStatus = 'Completed')
DECLARE
    v_points_earned NUMBER;
    v_customer_id NUMBER;
BEGIN
    -- Get customer ID from the ride
    SELECT CustomerID INTO v_customer_id
    FROM RIDE
    WHERE RideID = :NEW.RideID;
    
    -- Calculate points (1 point per £1)
    v_points_earned := FLOOR(:NEW.Amount);
    
    -- Update customer loyalty points
    UPDATE CUSTOMER
    SET LoyaltyPoints = LoyaltyPoints + v_points_earned
    WHERE CustomerID = v_customer_id;
    
    -- Record the transaction
    INSERT INTO LOYALTY_TRANSACTION (
        TransactionID,
        CustomerID,
        RideID,
        PointsChange,
        TransactionType,
        TransactionDate,
        ExpiryDate,
        Description
    ) VALUES (
        loyalty_trans_seq.NEXTVAL,
        v_customer_id,
        :NEW.RideID,
        v_points_earned,
        'Earned',
        SYSDATE,
        ADD_MONTHS(SYSDATE, 12), -- Points expire after 1 year
        'Points earned from ride #' || :NEW.RideID
    );
    
    DBMS_OUTPUT.PUT_LINE('Customer ' || v_customer_id || ' earned ' || v_points_earned || ' loyalty points');
END;
/

-- ============================================================================
-- Stored Procedure 1: Notify customers with loyalty points expiring within 7 days
-- (1 mark)
-- ============================================================================

-- Purpose: Identify and notify customers whose loyalty points are about to expire
-- This procedure would be called by a scheduled job daily

CREATE OR REPLACE PROCEDURE sp_notify_expiring_loyalty_points
IS
    -- Cursor to fetch customers with expiring points
    CURSOR c_expiring_points IS
        SELECT DISTINCT
            C.CustomerID,
            C.Name,
            C.Email,
            C.Phone,
            LT.ExpiryDate,
            SUM(LT.PointsChange) AS ExpiringPoints
        FROM CUSTOMER C
        JOIN LOYALTY_TRANSACTION LT ON C.CustomerID = LT.CustomerID
        WHERE LT.ExpiryDate BETWEEN SYSDATE AND SYSDATE + 7
          AND LT.TransactionType IN ('Earned', 'Adjusted')
          AND LT.PointsChange > 0
        GROUP BY C.CustomerID, C.Name, C.Email, C.Phone, LT.ExpiryDate
        HAVING SUM(LT.PointsChange) > 0
        ORDER BY LT.ExpiryDate;
    
    v_notification_count NUMBER := 0;
    v_days_until_expiry NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    DBMS_OUTPUT.PUT_LINE('LOYALTY POINTS EXPIRY NOTIFICATION REPORT');
    DBMS_OUTPUT.PUT_LINE('Generated: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Loop through customers with expiring points
    FOR rec IN c_expiring_points LOOP
        v_days_until_expiry := ROUND(rec.ExpiryDate - SYSDATE);
        
        -- Display notification message
        DBMS_OUTPUT.PUT_LINE('ALERT: Customer Notification Required');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || rec.CustomerID);
        DBMS_OUTPUT.PUT_LINE('Customer Name: ' || rec.Name);
        DBMS_OUTPUT.PUT_LINE('Email: ' || rec.Email);
        DBMS_OUTPUT.PUT_LINE('Phone: ' || rec.Phone);
        DBMS_OUTPUT.PUT_LINE('Expiring Points: ' || rec.ExpiringPoints);
        DBMS_OUTPUT.PUT_LINE('Expiry Date: ' || TO_CHAR(rec.ExpiryDate, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Days Until Expiry: ' || v_days_until_expiry);
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Message to Customer:');
        DBMS_OUTPUT.PUT_LINE('Dear ' || rec.Name || ',');
        DBMS_OUTPUT.PUT_LINE('Your ' || rec.ExpiringPoints || ' loyalty points will expire on ' || 
                           TO_CHAR(rec.ExpiryDate, 'DD-MON-YYYY') || ' (' || v_days_until_expiry || ' days).');
        DBMS_OUTPUT.PUT_LINE('Use them before they expire! Book a ride today.');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('=======================================================');
        DBMS_OUTPUT.PUT_LINE('');
        
        v_notification_count := v_notification_count + 1;
    END LOOP;
    
    -- Summary
    IF v_notification_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No customers with expiring loyalty points in the next 7 days.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total notifications sent: ' || v_notification_count);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in sp_notify_expiring_loyalty_points: ' || SQLERRM);
        RAISE;
END sp_notify_expiring_loyalty_points;
/

-- Test the procedure
-- EXEC sp_notify_expiring_loyalty_points;

-- ============================================================================
-- Stored Procedure 2: Generate Driver Performance Report
-- ============================================================================

-- Purpose: Generate comprehensive performance report for a specific driver

CREATE OR REPLACE PROCEDURE sp_driver_performance_report(
    p_driver_id IN NUMBER
)
IS
    v_driver_name VARCHAR2(100);
    v_rating NUMBER(3,2);
    v_status VARCHAR2(20);
    v_join_date DATE;
    v_total_rides NUMBER;
    v_completed_rides NUMBER;
    v_cancelled_rides NUMBER;
    v_total_revenue NUMBER(10,2);
    v_avg_fare NUMBER(10,2);
    v_total_distance NUMBER(10,2);
    v_avg_rating NUMBER(3,2);
BEGIN
    -- Get driver information
    SELECT Name, Rating, Status, JoinDate
    INTO v_driver_name, v_rating, v_status, v_join_date
    FROM DRIVER
    WHERE DriverID = p_driver_id;
    
    -- Get ride statistics
    SELECT 
        COUNT(*),
        SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END),
        SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END),
        NVL(SUM(CASE WHEN Status = 'Completed' THEN Fare END), 0),
        NVL(AVG(CASE WHEN Status = 'Completed' THEN Fare END), 0),
        NVL(SUM(CASE WHEN Status = 'Completed' THEN Distance END), 0)
    INTO v_total_rides, v_completed_rides, v_cancelled_rides, 
         v_total_revenue, v_avg_fare, v_total_distance
    FROM RIDE
    WHERE DriverID = p_driver_id;
    
    -- Get average feedback rating
    SELECT NVL(AVG(Rating), v_rating)
    INTO v_avg_rating
    FROM FEEDBACK
    WHERE DriverID = p_driver_id;
    
    -- Display report
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    DBMS_OUTPUT.PUT_LINE('        DRIVER PERFORMANCE REPORT');
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    DBMS_OUTPUT.PUT_LINE('Driver ID: ' || p_driver_id);
    DBMS_OUTPUT.PUT_LINE('Driver Name: ' || v_driver_name);
    DBMS_OUTPUT.PUT_LINE('Current Status: ' || v_status);
    DBMS_OUTPUT.PUT_LINE('Join Date: ' || TO_CHAR(v_join_date, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Days with Company: ' || ROUND(SYSDATE - v_join_date));
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('RIDE STATISTICS:');
    DBMS_OUTPUT.PUT_LINE('Total Rides: ' || v_total_rides);
    DBMS_OUTPUT.PUT_LINE('Completed Rides: ' || v_completed_rides);
    DBMS_OUTPUT.PUT_LINE('Cancelled Rides: ' || v_cancelled_rides);
    DBMS_OUTPUT.PUT_LINE('Completion Rate: ' || 
                       ROUND((v_completed_rides * 100.0) / NULLIF(v_total_rides, 0), 2) || '%');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('FINANCIAL PERFORMANCE:');
    DBMS_OUTPUT.PUT_LINE('Total Revenue: £' || ROUND(v_total_revenue, 2));
    DBMS_OUTPUT.PUT_LINE('Average Fare: £' || ROUND(v_avg_fare, 2));
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('RATINGS:');
    DBMS_OUTPUT.PUT_LINE('Current Rating: ' || v_rating);
    DBMS_OUTPUT.PUT_LINE('Average Feedback Rating: ' || ROUND(v_avg_rating, 2));
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('DISTANCE:');
    DBMS_OUTPUT.PUT_LINE('Total Distance: ' || ROUND(v_total_distance, 2) || ' km');
    DBMS_OUTPUT.PUT_LINE('Average Distance per Ride: ' || 
                       ROUND(v_total_distance / NULLIF(v_completed_rides, 0), 2) || ' km');
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Driver ID ' || p_driver_id || ' not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END sp_driver_performance_report;
/

-- Test the procedure
-- EXEC sp_driver_performance_report(1);

-- ============================================================================
-- Stored Procedure 3: Process Monthly Revenue Report
-- ============================================================================

CREATE OR REPLACE PROCEDURE sp_monthly_revenue_report(
    p_year IN NUMBER DEFAULT NULL,
    p_month IN NUMBER DEFAULT NULL
)
IS
    v_year NUMBER := NVL(p_year, EXTRACT(YEAR FROM SYSDATE));
    v_month NUMBER := NVL(p_month, EXTRACT(MONTH FROM SYSDATE));
    v_total_revenue NUMBER(10,2);
    v_transaction_count NUMBER;
    v_avg_fare NUMBER(10,2);
    
    CURSOR c_payment_details IS
        SELECT 
            PaymentMethod,
            COUNT(*) AS TransactionCount,
            SUM(Amount) AS TotalAmount,
            AVG(Amount) AS AvgAmount
        FROM PAYMENT
        WHERE EXTRACT(YEAR FROM Timestamp) = v_year
          AND EXTRACT(MONTH FROM Timestamp) = v_month
          AND PaymentStatus = 'Completed'
        GROUP BY PaymentMethod
        ORDER BY SUM(Amount) DESC;
BEGIN
    -- Calculate totals
    SELECT 
        NVL(SUM(Amount), 0),
        COUNT(*),
        NVL(AVG(Amount), 0)
    INTO v_total_revenue, v_transaction_count, v_avg_fare
    FROM PAYMENT
    WHERE EXTRACT(YEAR FROM Timestamp) = v_year
      AND EXTRACT(MONTH FROM Timestamp) = v_month
      AND PaymentStatus = 'Completed';
    
    -- Display report
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    DBMS_OUTPUT.PUT_LINE('        MONTHLY REVENUE REPORT');
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    DBMS_OUTPUT.PUT_LINE('Period: ' || TO_CHAR(TO_DATE(v_month, 'MM'), 'Month') || ' ' || v_year);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Revenue: £' || ROUND(v_total_revenue, 2));
    DBMS_OUTPUT.PUT_LINE('Total Transactions: ' || v_transaction_count);
    DBMS_OUTPUT.PUT_LINE('Average Transaction Value: £' || ROUND(v_avg_fare, 2));
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    DBMS_OUTPUT.PUT_LINE('BREAKDOWN BY PAYMENT METHOD:');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    
    FOR rec IN c_payment_details LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.PaymentMethod, 15) || 
                           LPAD(rec.TransactionCount, 10) || ' transactions' ||
                           LPAD('£' || ROUND(rec.TotalAmount, 2), 15));
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('=======================================================');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END sp_monthly_revenue_report;
/

-- Test the procedure
-- EXEC sp_monthly_revenue_report(2024, 12);

-- ============================================================================
-- Stored Procedure 4: Schedule Vehicle for Maintenance
-- ============================================================================

CREATE OR REPLACE PROCEDURE sp_schedule_vehicle_maintenance(
    p_vehicle_id IN NUMBER,
    p_maintenance_type IN VARCHAR2 DEFAULT 'Routine',
    p_description IN VARCHAR2 DEFAULT NULL
)
IS
    v_current_mileage NUMBER;
    v_registration VARCHAR2(20);
    v_maintenance_id NUMBER;
BEGIN
    -- Get vehicle details
    SELECT Mileage, RegistrationType
    INTO v_current_mileage, v_registration
    FROM VEHICLE
    WHERE VehicleID = p_vehicle_id;
    
    -- Create maintenance record
    SELECT maintenance_seq.NEXTVAL INTO v_maintenance_id FROM DUAL;
    
    INSERT INTO MAINTENANCE (
        MaintenanceID,
        VehicleID,
        MaintenanceDate,
        MaintenanceType,
        Description,
        Cost,
        MileageAtService,
        NextMaintenanceDue
    ) VALUES (
        v_maintenance_id,
        p_vehicle_id,
        SYSDATE + 3, -- Schedule for 3 days from now
        p_maintenance_type,
        NVL(p_description, 'Scheduled maintenance'),
        0,
        v_current_mileage,
        v_current_mileage + 20000
    );
    
    -- Update vehicle status
    UPDATE VEHICLE
    SET Status = 'Maintenance',
        LastMaintenanceDate = SYSDATE + 3
    WHERE VehicleID = p_vehicle_id;
    
    DBMS_OUTPUT.PUT_LINE('Maintenance scheduled successfully!');
    DBMS_OUTPUT.PUT_LINE('Vehicle: ' || v_registration);
    DBMS_OUTPUT.PUT_LINE('Maintenance ID: ' || v_maintenance_id);
    DBMS_OUTPUT.PUT_LINE('Type: ' || p_maintenance_type);
    DBMS_OUTPUT.PUT_LINE('Scheduled Date: ' || TO_CHAR(SYSDATE + 3, 'DD-MON-YYYY'));
    
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Vehicle ID ' || p_vehicle_id || ' not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END sp_schedule_vehicle_maintenance;
/

-- Test the procedure
-- EXEC sp_schedule_vehicle_maintenance(1, 'Routine', 'Annual service');

-- ============================================================================
-- Enable DBMS_OUTPUT (for testing)
-- ============================================================================

SET SERVEROUTPUT ON SIZE 1000000;

-- ============================================================================
-- END OF TRIGGERS AND PROCEDURES
-- ============================================================================

COMMENT ON TABLE DRIVER IS 'Includes triggers and procedures for automated operations';
