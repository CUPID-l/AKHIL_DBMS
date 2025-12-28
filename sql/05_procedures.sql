-- SuperRides Transportation & Fleet Management System (STFMS)
-- Stored Procedures Implementation
-- Q6: Stored Procedures (1 Mark)

-- ==============================================================================
-- Procedure: Send notification to customers with loyalty points expiring within 7 days (1 mark)
-- ==============================================================================

CREATE OR REPLACE PROCEDURE sp_notify_expiring_loyalty_points
IS
    -- Cursor to fetch customers with expiring points
    CURSOR c_expiring_points IS
        SELECT 
            lp.loyalty_id,
            lp.customer_id,
            c.first_name,
            c.last_name,
            c.email,
            c.phone,
            lp.points,
            lp.expiry_date,
            TRUNC(lp.expiry_date - SYSDATE) AS days_until_expiry
        FROM LoyaltyPoints lp
        JOIN Customer c ON lp.customer_id = c.customer_id
        WHERE lp.status = 'Active'
          AND lp.expiry_date BETWEEN SYSDATE AND SYSDATE + 7
          AND lp.points > 0
        ORDER BY lp.expiry_date;
    
    v_notification_count NUMBER := 0;
    v_total_points NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('Loyalty Points Expiration Notification Report');
    DBMS_OUTPUT.PUT_LINE('Generated on: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Loop through customers with expiring points
    FOR rec IN c_expiring_points LOOP
        v_notification_count := v_notification_count + 1;
        v_total_points := v_total_points + rec.points;
        
        -- Display notification (in real system, this would send email/SMS)
        DBMS_OUTPUT.PUT_LINE('Notification #' || v_notification_count);
        DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.first_name || ' ' || rec.last_name);
        DBMS_OUTPUT.PUT_LINE('Email: ' || rec.email);
        DBMS_OUTPUT.PUT_LINE('Phone: ' || rec.phone);
        DBMS_OUTPUT.PUT_LINE('Loyalty Points: ' || rec.points);
        DBMS_OUTPUT.PUT_LINE('Expiry Date: ' || TO_CHAR(rec.expiry_date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Days Until Expiry: ' || rec.days_until_expiry);
        DBMS_OUTPUT.PUT_LINE('Message: Your ' || rec.points || ' loyalty points will expire in ' || 
                             rec.days_until_expiry || ' day(s). Use them before ' || 
                             TO_CHAR(rec.expiry_date, 'DD-MON-YYYY') || '!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
        
    END LOOP;
    
    -- Display summary
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('Summary:');
    DBMS_OUTPUT.PUT_LINE('Total Notifications Sent: ' || v_notification_count);
    DBMS_OUTPUT.PUT_LINE('Total Points at Risk: ' || v_total_points);
    DBMS_OUTPUT.PUT_LINE('=================================================');
    
    -- If no expiring points found
    IF v_notification_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No loyalty points expiring in the next 7 days.');
    END IF;
    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END sp_notify_expiring_loyalty_points;
/

-- ==============================================================================
-- Additional Procedure: Assign driver to ride based on availability and location
-- ==============================================================================

CREATE OR REPLACE PROCEDURE sp_assign_driver_to_ride(
    p_ride_id IN NUMBER,
    p_assigned_driver_id OUT NUMBER
)
IS
    v_city_id NUMBER;
    v_vehicle_id NUMBER;
    v_ride_status VARCHAR2(20);
BEGIN
    -- Get ride details
    SELECT city_id, status
    INTO v_city_id, v_ride_status
    FROM Ride
    WHERE ride_id = p_ride_id;
    
    -- Check if ride is in pending status
    IF v_ride_status != 'Pending' THEN
        RAISE_APPLICATION_ERROR(-20002, 'Ride is not in pending status');
    END IF;
    
    -- Find available driver in the same city with highest rating
    SELECT driver_id
    INTO p_assigned_driver_id
    FROM (
        SELECT d.driver_id
        FROM Driver d
        WHERE d.city_id = v_city_id
          AND d.status = 'Available'
        ORDER BY d.average_rating DESC, d.total_rides DESC
    )
    WHERE ROWNUM = 1;
    
    -- Find available vehicle in the same city
    SELECT vehicle_id
    INTO v_vehicle_id
    FROM (
        SELECT v.vehicle_id
        FROM Vehicle v
        WHERE v.city_id = v_city_id
          AND v.status = 'Available'
        ORDER BY v.total_km
    )
    WHERE ROWNUM = 1;
    
    -- Update ride with driver and vehicle
    UPDATE Ride
    SET driver_id = p_assigned_driver_id,
        vehicle_id = v_vehicle_id,
        status = 'Assigned'
    WHERE ride_id = p_ride_id;
    
    -- Update driver status
    UPDATE Driver
    SET status = 'On Ride'
    WHERE driver_id = p_assigned_driver_id;
    
    -- Update vehicle status
    UPDATE Vehicle
    SET status = 'In Use'
    WHERE vehicle_id = v_vehicle_id;
    
    DBMS_OUTPUT.PUT_LINE('Ride ' || p_ride_id || ' assigned to driver ' || p_assigned_driver_id);
    
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No available driver or vehicle found in the city');
        p_assigned_driver_id := NULL;
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END sp_assign_driver_to_ride;
/

-- ==============================================================================
-- Additional Procedure: Generate monthly performance report for a driver
-- ==============================================================================

CREATE OR REPLACE PROCEDURE sp_driver_monthly_report(
    p_driver_id IN NUMBER,
    p_month IN VARCHAR2  -- Format: YYYY-MM
)
IS
    v_driver_name VARCHAR2(100);
    v_total_rides NUMBER;
    v_total_revenue NUMBER(10,2);
    v_avg_rating NUMBER(3,2);
    v_total_distance NUMBER(10,2);
    v_avg_fare NUMBER(10,2);
BEGIN
    -- Get driver name
    SELECT first_name || ' ' || last_name
    INTO v_driver_name
    FROM Driver
    WHERE driver_id = p_driver_id;
    
    -- Get performance metrics for the month
    SELECT 
        COUNT(r.ride_id),
        COALESCE(SUM(r.fare_amount), 0),
        COALESCE(AVG(f.rating), 0),
        COALESCE(SUM(r.distance_km), 0),
        COALESCE(AVG(r.fare_amount), 0)
    INTO 
        v_total_rides,
        v_total_revenue,
        v_avg_rating,
        v_total_distance,
        v_avg_fare
    FROM Ride r
    LEFT JOIN Feedback f ON r.ride_id = f.ride_id
    WHERE r.driver_id = p_driver_id
      AND r.status = 'Completed'
      AND TO_CHAR(r.booking_time, 'YYYY-MM') = p_month;
    
    -- Display report
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('Monthly Performance Report');
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('Driver: ' || v_driver_name || ' (ID: ' || p_driver_id || ')');
    DBMS_OUTPUT.PUT_LINE('Month: ' || p_month);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Performance Metrics:');
    DBMS_OUTPUT.PUT_LINE('  Total Rides: ' || v_total_rides);
    DBMS_OUTPUT.PUT_LINE('  Total Revenue: £' || TO_CHAR(v_total_revenue, '999,999.99'));
    DBMS_OUTPUT.PUT_LINE('  Average Fare: £' || TO_CHAR(v_avg_fare, '999.99'));
    DBMS_OUTPUT.PUT_LINE('  Total Distance: ' || TO_CHAR(v_total_distance, '999,999.99') || ' km');
    DBMS_OUTPUT.PUT_LINE('  Average Rating: ' || TO_CHAR(v_avg_rating, '9.99'));
    DBMS_OUTPUT.PUT_LINE('=================================================');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Driver not found with ID: ' || p_driver_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END sp_driver_monthly_report;
/

-- ==============================================================================
-- Additional Procedure: Process ride completion
-- ==============================================================================

CREATE OR REPLACE PROCEDURE sp_complete_ride(
    p_ride_id IN NUMBER,
    p_dropoff_time IN TIMESTAMP,
    p_distance_km IN NUMBER,
    p_fare_amount IN NUMBER
)
IS
    v_ride_status VARCHAR2(20);
BEGIN
    -- Check current ride status
    SELECT status
    INTO v_ride_status
    FROM Ride
    WHERE ride_id = p_ride_id;
    
    IF v_ride_status != 'In Progress' THEN
        RAISE_APPLICATION_ERROR(-20003, 'Ride is not in progress');
    END IF;
    
    -- Update ride details
    UPDATE Ride
    SET dropoff_time = p_dropoff_time,
        distance_km = p_distance_km,
        fare_amount = p_fare_amount,
        status = 'Completed'
    WHERE ride_id = p_ride_id;
    
    DBMS_OUTPUT.PUT_LINE('Ride ' || p_ride_id || ' completed successfully');
    
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Ride not found with ID: ' || p_ride_id);
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END sp_complete_ride;
/

-- ==============================================================================
-- Additional Procedure: Update vehicle maintenance status
-- ==============================================================================

CREATE OR REPLACE PROCEDURE sp_update_maintenance_status(
    p_maintenance_id IN NUMBER,
    p_new_status IN VARCHAR2,
    p_actual_cost IN NUMBER DEFAULT NULL
)
IS
    v_vehicle_id NUMBER;
    v_km_at_maintenance NUMBER;
BEGIN
    -- Get maintenance details
    SELECT vehicle_id, km_at_maintenance
    INTO v_vehicle_id, v_km_at_maintenance
    FROM Maintenance
    WHERE maintenance_id = p_maintenance_id;
    
    -- Update maintenance status
    UPDATE Maintenance
    SET status = p_new_status,
        cost = NVL(p_actual_cost, cost)
    WHERE maintenance_id = p_maintenance_id;
    
    -- If maintenance is completed, update vehicle
    IF p_new_status = 'Completed' THEN
        UPDATE Vehicle
        SET status = 'Available',
            last_maintenance_km = v_km_at_maintenance
        WHERE vehicle_id = v_vehicle_id;
        
        DBMS_OUTPUT.PUT_LINE('Maintenance completed for vehicle ' || v_vehicle_id);
    END IF;
    
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Maintenance record not found');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END sp_update_maintenance_status;
/

-- ==============================================================================
-- Test procedure execution
-- ==============================================================================

-- Enable output
SET SERVEROUTPUT ON SIZE 1000000;

-- Execute the main procedure
BEGIN
    sp_notify_expiring_loyalty_points;
END;
/

-- Display procedure information
SELECT object_name, object_type, status
FROM user_objects
WHERE object_type = 'PROCEDURE'
  AND object_name LIKE 'SP_%'
ORDER BY object_name;

COMMIT;
