-- SuperRides Transportation & Fleet Management System (STFMS)
-- Triggers Implementation
-- Q6: Triggers (4 Marks)

-- ==============================================================================
-- Trigger 1: Automatically mark a driver as "Available" when their assigned 
-- ride's status changes to "Completed" (2 marks)
-- ==============================================================================

CREATE OR REPLACE TRIGGER trg_driver_status_on_ride_complete
AFTER UPDATE OF status ON Ride
FOR EACH ROW
WHEN (NEW.status = 'Completed' AND OLD.status != 'Completed')
BEGIN
    -- Update driver status to Available when ride is completed
    IF :NEW.driver_id IS NOT NULL THEN
        UPDATE Driver
        SET status = 'Available'
        WHERE driver_id = :NEW.driver_id
          AND status = 'On Ride';
        
        -- Log the status change (optional)
        DBMS_OUTPUT.PUT_LINE('Driver ' || :NEW.driver_id || ' status updated to Available after completing ride ' || :NEW.ride_id);
    END IF;
END;
/

-- ==============================================================================
-- Trigger 2: Automatically schedule maintenance after every 20,000 km driven (2 marks)
-- ==============================================================================

CREATE OR REPLACE TRIGGER trg_schedule_maintenance
AFTER UPDATE OF total_km ON Vehicle
FOR EACH ROW
WHEN (NEW.total_km - NEW.last_maintenance_km >= 20000)
BEGIN
    -- Insert a scheduled maintenance record
    INSERT INTO Maintenance (
        maintenance_id,
        vehicle_id,
        maintenance_date,
        maintenance_type,
        cost,
        description,
        km_at_maintenance,
        next_maintenance_due,
        status
    ) VALUES (
        seq_maintenance.NEXTVAL,
        :NEW.vehicle_id,
        SYSDATE + 7,  -- Schedule for 7 days from now
        'Routine Service',
        0,  -- Cost will be determined after service
        'Automatic maintenance scheduled - ' || (:NEW.total_km - :NEW.last_maintenance_km) || ' km since last service',
        :NEW.total_km,
        :NEW.total_km + 20000,
        'Scheduled'
    );
    
    -- Update vehicle status to indicate maintenance is due
    UPDATE Vehicle
    SET status = 'Maintenance'
    WHERE vehicle_id = :NEW.vehicle_id;
    
    -- Log the maintenance scheduling
    DBMS_OUTPUT.PUT_LINE('Maintenance scheduled for vehicle ' || :NEW.vehicle_id || ' at ' || :NEW.total_km || ' km');
END;
/

-- ==============================================================================
-- Additional Trigger: Update driver statistics after feedback
-- ==============================================================================

CREATE OR REPLACE TRIGGER trg_update_driver_rating
AFTER INSERT ON Feedback
FOR EACH ROW
BEGIN
    -- Recalculate driver's average rating
    UPDATE Driver d
    SET average_rating = (
        SELECT ROUND(AVG(f.rating), 2)
        FROM Feedback f
        WHERE f.driver_id = :NEW.driver_id
    )
    WHERE d.driver_id = :NEW.driver_id;
    
    DBMS_OUTPUT.PUT_LINE('Driver ' || :NEW.driver_id || ' rating updated after new feedback');
END;
/

-- ==============================================================================
-- Additional Trigger: Update driver's total rides count
-- ==============================================================================

CREATE OR REPLACE TRIGGER trg_update_driver_ride_count
AFTER UPDATE OF status ON Ride
FOR EACH ROW
WHEN (NEW.status = 'Completed' AND OLD.status != 'Completed')
BEGIN
    -- Increment driver's total rides count
    IF :NEW.driver_id IS NOT NULL THEN
        UPDATE Driver
        SET total_rides = total_rides + 1
        WHERE driver_id = :NEW.driver_id;
        
        DBMS_OUTPUT.PUT_LINE('Driver ' || :NEW.driver_id || ' total rides incremented');
    END IF;
END;
/

-- ==============================================================================
-- Additional Trigger: Set driver status to "On Ride" when ride is in progress
-- ==============================================================================

CREATE OR REPLACE TRIGGER trg_driver_on_ride
AFTER UPDATE OF status ON Ride
FOR EACH ROW
WHEN (NEW.status = 'In Progress' AND OLD.status = 'Assigned')
BEGIN
    -- Update driver status to On Ride
    IF :NEW.driver_id IS NOT NULL THEN
        UPDATE Driver
        SET status = 'On Ride'
        WHERE driver_id = :NEW.driver_id;
        
        DBMS_OUTPUT.PUT_LINE('Driver ' || :NEW.driver_id || ' status set to On Ride for ride ' || :NEW.ride_id);
    END IF;
END;
/

-- ==============================================================================
-- Additional Trigger: Validate ride fare before insert/update
-- ==============================================================================

CREATE OR REPLACE TRIGGER trg_validate_ride_fare
BEFORE INSERT OR UPDATE OF fare_amount, distance_km ON Ride
FOR EACH ROW
BEGIN
    -- Ensure fare is reasonable based on distance (minimum £2 per km)
    IF :NEW.distance_km IS NOT NULL AND :NEW.fare_amount IS NOT NULL THEN
        IF :NEW.fare_amount < (:NEW.distance_km * 2) THEN
            :NEW.fare_amount := :NEW.distance_km * 2;
            DBMS_OUTPUT.PUT_LINE('Fare adjusted to minimum rate for ride ' || :NEW.ride_id);
        END IF;
    END IF;
    
    -- Set booking time if not specified
    IF :NEW.booking_time IS NULL THEN
        :NEW.booking_time := CURRENT_TIMESTAMP;
    END IF;
END;
/

-- ==============================================================================
-- Additional Trigger: Update vehicle mileage after completed ride
-- ==============================================================================

CREATE OR REPLACE TRIGGER trg_update_vehicle_km
AFTER UPDATE OF status ON Ride
FOR EACH ROW
WHEN (NEW.status = 'Completed' AND OLD.status != 'Completed' AND NEW.distance_km IS NOT NULL)
BEGIN
    -- Update vehicle's total kilometers
    IF :NEW.vehicle_id IS NOT NULL THEN
        UPDATE Vehicle
        SET total_km = total_km + :NEW.distance_km
        WHERE vehicle_id = :NEW.vehicle_id;
        
        DBMS_OUTPUT.PUT_LINE('Vehicle ' || :NEW.vehicle_id || ' mileage updated by ' || :NEW.distance_km || ' km');
    END IF;
END;
/

-- ==============================================================================
-- Additional Trigger: Prevent deletion of active rides
-- ==============================================================================

CREATE OR REPLACE TRIGGER trg_prevent_active_ride_delete
BEFORE DELETE ON Ride
FOR EACH ROW
BEGIN
    IF :OLD.status IN ('Assigned', 'In Progress') THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Cannot delete active ride ' || :OLD.ride_id || '. Please cancel it first.');
    END IF;
END;
/

-- ==============================================================================
-- Additional Trigger: Award loyalty points on ride completion
-- ==============================================================================

CREATE OR REPLACE TRIGGER trg_award_loyalty_points
AFTER UPDATE OF status ON Ride
FOR EACH ROW
WHEN (NEW.status = 'Completed' AND OLD.status != 'Completed')
DECLARE
    v_points NUMBER;
BEGIN
    -- Calculate points: 1 point per £1 spent
    v_points := FLOOR(:NEW.fare_amount);
    
    -- Insert loyalty points record
    IF v_points > 0 THEN
        INSERT INTO LoyaltyPoints (
            loyalty_id,
            customer_id,
            points,
            earned_date,
            expiry_date,
            status
        ) VALUES (
            seq_loyalty.NEXTVAL,
            :NEW.customer_id,
            v_points,
            SYSDATE,
            ADD_MONTHS(SYSDATE, 12),  -- Points expire in 12 months
            'Active'
        );
        
        DBMS_OUTPUT.PUT_LINE('Awarded ' || v_points || ' loyalty points to customer ' || :NEW.customer_id);
    END IF;
END;
/

-- ==============================================================================
-- Test the triggers
-- ==============================================================================

-- Enable DBMS_OUTPUT to see trigger messages
SET SERVEROUTPUT ON;

-- Display trigger information
SELECT trigger_name, table_name, triggering_event, status
FROM user_triggers
WHERE table_name IN ('RIDE', 'VEHICLE', 'FEEDBACK', 'DRIVER')
ORDER BY table_name, trigger_name;

COMMIT;
