-- ============================================================================
-- SuperRides Transportation & Fleet Management System (STFMS)
-- SQL DDL Scripts - Table Creation
-- Database: Oracle SQL
-- Module: CN5000 Database Systems
-- ============================================================================

-- Drop existing tables (in reverse order of dependencies)
DROP TABLE LOYALTY_TRANSACTION CASCADE CONSTRAINTS;
DROP TABLE DRIVER_AVAILABILITY CASCADE CONSTRAINTS;
DROP TABLE FUEL_RECORD CASCADE CONSTRAINTS;
DROP TABLE FEEDBACK CASCADE CONSTRAINTS;
DROP TABLE MAINTENANCE CASCADE CONSTRAINTS;
DROP TABLE PAYMENT CASCADE CONSTRAINTS;
DROP TABLE RIDE CASCADE CONSTRAINTS;
DROP TABLE VEHICLE CASCADE CONSTRAINTS;
DROP TABLE CITY CASCADE CONSTRAINTS;
DROP TABLE DRIVER CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;

-- Drop sequences if they exist
DROP SEQUENCE customer_seq;
DROP SEQUENCE driver_seq;
DROP SEQUENCE city_seq;
DROP SEQUENCE vehicle_seq;
DROP SEQUENCE ride_seq;
DROP SEQUENCE payment_seq;
DROP SEQUENCE maintenance_seq;
DROP SEQUENCE feedback_seq;
DROP SEQUENCE fuel_seq;
DROP SEQUENCE availability_seq;
DROP SEQUENCE loyalty_trans_seq;

-- ============================================================================
-- Create Sequences for Auto-incrementing Primary Keys
-- ============================================================================

CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE driver_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE city_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE vehicle_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE ride_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE payment_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE maintenance_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE feedback_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE fuel_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE availability_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE loyalty_trans_seq START WITH 1 INCREMENT BY 1 NOCACHE;

-- ============================================================================
-- Table 1: CUSTOMER
-- Stores customer/user information
-- ============================================================================

CREATE TABLE CUSTOMER (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Phone VARCHAR2(20) UNIQUE NOT NULL,
    Address VARCHAR2(200),
    RegistrationDate DATE DEFAULT SYSDATE NOT NULL,
    LoyaltyPoints NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT chk_loyalty_points CHECK (LoyaltyPoints >= 0),
    CONSTRAINT chk_email_format CHECK (REGEXP_LIKE(Email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'))
);

COMMENT ON TABLE CUSTOMER IS 'Stores customer account information and loyalty points';
COMMENT ON COLUMN CUSTOMER.CustomerID IS 'Unique identifier for each customer';
COMMENT ON COLUMN CUSTOMER.LoyaltyPoints IS 'Current balance of loyalty points';

-- ============================================================================
-- Table 2: DRIVER
-- Stores driver information and status
-- ============================================================================

CREATE TABLE DRIVER (
    DriverID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    LicenseNumber VARCHAR2(50) UNIQUE NOT NULL,
    Phone VARCHAR2(20) UNIQUE NOT NULL,
    Rating NUMBER(3,2) DEFAULT 5.0 NOT NULL,
    Status VARCHAR2(20) DEFAULT 'Available' NOT NULL,
    JoinDate DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT chk_driver_rating CHECK (Rating >= 0 AND Rating <= 5),
    CONSTRAINT chk_driver_status CHECK (Status IN ('Available', 'Busy', 'Offline'))
);

COMMENT ON TABLE DRIVER IS 'Stores driver information, ratings, and current availability status';
COMMENT ON COLUMN DRIVER.Rating IS 'Average customer rating (0-5 scale)';
COMMENT ON COLUMN DRIVER.Status IS 'Current availability: Available, Busy, or Offline';

-- ============================================================================
-- Table 3: CITY
-- Stores operational cities
-- ============================================================================

CREATE TABLE CITY (
    CityID NUMBER PRIMARY KEY,
    CityName VARCHAR2(50) UNIQUE NOT NULL,
    Region VARCHAR2(50),
    OperationsStartDate DATE NOT NULL,
    CONSTRAINT chk_city_name CHECK (CityName IN ('London', 'Manchester', 'Birmingham', 'Glasgow'))
);

COMMENT ON TABLE CITY IS 'Stores cities where SuperRides operates';
COMMENT ON COLUMN CITY.CityName IS 'Name of operational city';

-- ============================================================================
-- Table 4: VEHICLE
-- Stores vehicle/fleet information
-- ============================================================================

CREATE TABLE VEHICLE (
    VehicleID NUMBER PRIMARY KEY,
    RegistrationType VARCHAR2(20) UNIQUE NOT NULL,
    Model VARCHAR2(50) NOT NULL,
    Year NUMBER(4) NOT NULL,
    Mileage NUMBER DEFAULT 0 NOT NULL,
    Status VARCHAR2(20) DEFAULT 'Active' NOT NULL,
    LastMaintenanceDate DATE,
    CONSTRAINT chk_vehicle_year CHECK (Year >= 2015 AND Year <= 2025),
    CONSTRAINT chk_vehicle_status CHECK (Status IN ('Active', 'Maintenance', 'Retired')),
    CONSTRAINT chk_vehicle_mileage CHECK (Mileage >= 0)
);

COMMENT ON TABLE VEHICLE IS 'Stores fleet vehicle information and maintenance status';
COMMENT ON COLUMN VEHICLE.RegistrationType IS 'Vehicle registration/license plate number';
COMMENT ON COLUMN VEHICLE.Status IS 'Current status: Active, Maintenance, or Retired';

-- ============================================================================
-- Table 5: RIDE
-- Stores ride/booking information
-- ============================================================================

CREATE TABLE RIDE (
    RideID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    DriverID NUMBER NOT NULL,
    VehicleID NUMBER NOT NULL,
    PickupLocation VARCHAR2(200) NOT NULL,
    DropoffLocation VARCHAR2(200) NOT NULL,
    PickupDateTime TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    DropoffDateTime TIMESTAMP,
    Status VARCHAR2(20) DEFAULT 'Requested' NOT NULL,
    Fare NUMBER(10,2),
    Distance NUMBER(10,2),
    RideType VARCHAR2(20) DEFAULT 'Passenger' NOT NULL,
    CONSTRAINT fk_ride_customer FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    CONSTRAINT fk_ride_driver FOREIGN KEY (DriverID) REFERENCES DRIVER(DriverID),
    CONSTRAINT fk_ride_vehicle FOREIGN KEY (VehicleID) REFERENCES VEHICLE(VehicleID),
    CONSTRAINT chk_ride_status CHECK (Status IN ('Requested', 'InProgress', 'Completed', 'Cancelled')),
    CONSTRAINT chk_ride_type CHECK (RideType IN ('Passenger', 'Corporate', 'Delivery')),
    CONSTRAINT chk_ride_fare CHECK (Fare IS NULL OR Fare >= 0),
    CONSTRAINT chk_ride_distance CHECK (Distance IS NULL OR Distance >= 0),
    CONSTRAINT chk_ride_datetime CHECK (DropoffDateTime IS NULL OR DropoffDateTime > PickupDateTime)
);

COMMENT ON TABLE RIDE IS 'Stores ride booking and completion information';
COMMENT ON COLUMN RIDE.Status IS 'Ride status: Requested, InProgress, Completed, or Cancelled';
COMMENT ON COLUMN RIDE.RideType IS 'Service type: Passenger, Corporate, or Delivery';

CREATE INDEX idx_ride_customer ON RIDE(CustomerID);
CREATE INDEX idx_ride_driver ON RIDE(DriverID);
CREATE INDEX idx_ride_vehicle ON RIDE(VehicleID);
CREATE INDEX idx_ride_status ON RIDE(Status);
CREATE INDEX idx_ride_pickup_date ON RIDE(PickupDateTime);

-- ============================================================================
-- Table 6: PAYMENT
-- Stores payment transaction information
-- ============================================================================

CREATE TABLE PAYMENT (
    PaymentID NUMBER PRIMARY KEY,
    RideID NUMBER UNIQUE NOT NULL,
    Amount NUMBER(10,2) NOT NULL,
    PaymentMethod VARCHAR2(20) NOT NULL,
    PaymentStatus VARCHAR2(20) DEFAULT 'Pending' NOT NULL,
    Timestamp TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_payment_ride FOREIGN KEY (RideID) REFERENCES RIDE(RideID),
    CONSTRAINT chk_payment_amount CHECK (Amount > 0),
    CONSTRAINT chk_payment_method CHECK (PaymentMethod IN ('Cash', 'Card', 'Wallet')),
    CONSTRAINT chk_payment_status CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed'))
);

COMMENT ON TABLE PAYMENT IS 'Stores payment transaction details for rides';
COMMENT ON COLUMN PAYMENT.PaymentStatus IS 'Payment status: Pending, Completed, or Failed';

CREATE INDEX idx_payment_ride ON PAYMENT(RideID);
CREATE INDEX idx_payment_status ON PAYMENT(PaymentStatus);

-- ============================================================================
-- Table 7: MAINTENANCE
-- Stores vehicle maintenance records
-- ============================================================================

CREATE TABLE MAINTENANCE (
    MaintenanceID NUMBER PRIMARY KEY,
    VehicleID NUMBER NOT NULL,
    MaintenanceDate DATE DEFAULT SYSDATE NOT NULL,
    MaintenanceType VARCHAR2(50) NOT NULL,
    Description VARCHAR2(500),
    Cost NUMBER(10,2) NOT NULL,
    MileageAtService NUMBER NOT NULL,
    NextMaintenanceDue NUMBER,
    CONSTRAINT fk_maintenance_vehicle FOREIGN KEY (VehicleID) REFERENCES VEHICLE(VehicleID),
    CONSTRAINT chk_maintenance_type CHECK (MaintenanceType IN ('Routine', 'Repair', 'Emergency')),
    CONSTRAINT chk_maintenance_cost CHECK (Cost >= 0),
    CONSTRAINT chk_maintenance_mileage CHECK (MileageAtService >= 0),
    CONSTRAINT chk_next_maintenance CHECK (NextMaintenanceDue IS NULL OR NextMaintenanceDue > MileageAtService)
);

COMMENT ON TABLE MAINTENANCE IS 'Stores vehicle maintenance and service records';
COMMENT ON COLUMN MAINTENANCE.MaintenanceType IS 'Type: Routine, Repair, or Emergency';
COMMENT ON COLUMN MAINTENANCE.NextMaintenanceDue IS 'Mileage when next maintenance is due';

CREATE INDEX idx_maintenance_vehicle ON MAINTENANCE(VehicleID);
CREATE INDEX idx_maintenance_date ON MAINTENANCE(MaintenanceDate);

-- ============================================================================
-- Table 8: FEEDBACK
-- Stores customer feedback and ratings
-- ============================================================================

CREATE TABLE FEEDBACK (
    FeedbackID NUMBER PRIMARY KEY,
    RideID NUMBER UNIQUE NOT NULL,
    CustomerID NUMBER NOT NULL,
    DriverID NUMBER NOT NULL,
    Rating NUMBER(1) NOT NULL,
    Comments VARCHAR2(1000),
    FeedbackDate DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_feedback_ride FOREIGN KEY (RideID) REFERENCES RIDE(RideID),
    CONSTRAINT fk_feedback_customer FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    CONSTRAINT fk_feedback_driver FOREIGN KEY (DriverID) REFERENCES DRIVER(DriverID),
    CONSTRAINT chk_feedback_rating CHECK (Rating BETWEEN 1 AND 5)
);

COMMENT ON TABLE FEEDBACK IS 'Stores customer feedback and ratings for completed rides';
COMMENT ON COLUMN FEEDBACK.Rating IS 'Customer rating on 1-5 scale';

CREATE INDEX idx_feedback_ride ON FEEDBACK(RideID);
CREATE INDEX idx_feedback_driver ON FEEDBACK(DriverID);
CREATE INDEX idx_feedback_rating ON FEEDBACK(Rating);

-- ============================================================================
-- Table 9: FUEL_RECORD
-- Stores vehicle fuel/charging records
-- ============================================================================

CREATE TABLE FUEL_RECORD (
    FuelID NUMBER PRIMARY KEY,
    VehicleID NUMBER NOT NULL,
    FuelDate DATE DEFAULT SYSDATE NOT NULL,
    LitersAdded NUMBER(10,2) NOT NULL,
    Cost NUMBER(10,2) NOT NULL,
    MileageAtFill NUMBER NOT NULL,
    FuelType VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_fuel_vehicle FOREIGN KEY (VehicleID) REFERENCES VEHICLE(VehicleID),
    CONSTRAINT chk_fuel_liters CHECK (LitersAdded > 0),
    CONSTRAINT chk_fuel_cost CHECK (Cost > 0),
    CONSTRAINT chk_fuel_mileage CHECK (MileageAtFill >= 0),
    CONSTRAINT chk_fuel_type CHECK (FuelType IN ('Petrol', 'Diesel', 'Electric'))
);

COMMENT ON TABLE FUEL_RECORD IS 'Stores vehicle refueling and charging records';
COMMENT ON COLUMN FUEL_RECORD.FuelType IS 'Type: Petrol, Diesel, or Electric';

CREATE INDEX idx_fuel_vehicle ON FUEL_RECORD(VehicleID);
CREATE INDEX idx_fuel_date ON FUEL_RECORD(FuelDate);

-- ============================================================================
-- Table 10: DRIVER_AVAILABILITY
-- Stores driver schedule and availability
-- ============================================================================

CREATE TABLE DRIVER_AVAILABILITY (
    AvailabilityID NUMBER PRIMARY KEY,
    DriverID NUMBER NOT NULL,
    CityID NUMBER NOT NULL,
    ShiftDate DATE NOT NULL,
    ShiftStartTime TIMESTAMP NOT NULL,
    ShiftEndTime TIMESTAMP NOT NULL,
    Status VARCHAR2(20) DEFAULT 'Scheduled' NOT NULL,
    CONSTRAINT fk_availability_driver FOREIGN KEY (DriverID) REFERENCES DRIVER(DriverID),
    CONSTRAINT fk_availability_city FOREIGN KEY (CityID) REFERENCES CITY(CityID),
    CONSTRAINT chk_availability_status CHECK (Status IN ('Scheduled', 'Active', 'Completed')),
    CONSTRAINT chk_shift_time CHECK (ShiftEndTime > ShiftStartTime)
);

COMMENT ON TABLE DRIVER_AVAILABILITY IS 'Stores driver work schedules and shift information';
COMMENT ON COLUMN DRIVER_AVAILABILITY.Status IS 'Shift status: Scheduled, Active, or Completed';

CREATE INDEX idx_availability_driver ON DRIVER_AVAILABILITY(DriverID);
CREATE INDEX idx_availability_city ON DRIVER_AVAILABILITY(CityID);
CREATE INDEX idx_availability_date ON DRIVER_AVAILABILITY(ShiftDate);

-- ============================================================================
-- Table 11: LOYALTY_TRANSACTION
-- Stores loyalty points transaction history
-- ============================================================================

CREATE TABLE LOYALTY_TRANSACTION (
    TransactionID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    RideID NUMBER,
    PointsChange NUMBER NOT NULL,
    TransactionType VARCHAR2(20) NOT NULL,
    TransactionDate DATE DEFAULT SYSDATE NOT NULL,
    ExpiryDate DATE,
    Description VARCHAR2(200),
    CONSTRAINT fk_loyalty_customer FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    CONSTRAINT fk_loyalty_ride FOREIGN KEY (RideID) REFERENCES RIDE(RideID),
    CONSTRAINT chk_points_change CHECK (PointsChange != 0),
    CONSTRAINT chk_transaction_type CHECK (TransactionType IN ('Earned', 'Redeemed', 'Expired', 'Adjusted'))
);

COMMENT ON TABLE LOYALTY_TRANSACTION IS 'Stores customer loyalty points transaction history';
COMMENT ON COLUMN LOYALTY_TRANSACTION.PointsChange IS 'Points added (positive) or deducted (negative)';
COMMENT ON COLUMN LOYALTY_TRANSACTION.TransactionType IS 'Type: Earned, Redeemed, Expired, or Adjusted';

CREATE INDEX idx_loyalty_customer ON LOYALTY_TRANSACTION(CustomerID);
CREATE INDEX idx_loyalty_expiry ON LOYALTY_TRANSACTION(ExpiryDate);

-- ============================================================================
-- END OF DDL SCRIPTS
-- ============================================================================

-- Commit all changes
COMMIT;

-- Display table creation summary
SELECT 'Database schema created successfully!' AS Status FROM DUAL;
SELECT TABLE_NAME, NUM_ROWS 
FROM USER_TABLES 
WHERE TABLE_NAME IN ('CUSTOMER', 'DRIVER', 'CITY', 'VEHICLE', 'RIDE', 
                     'PAYMENT', 'MAINTENANCE', 'FEEDBACK', 'FUEL_RECORD',
                     'DRIVER_AVAILABILITY', 'LOYALTY_TRANSACTION')
ORDER BY TABLE_NAME;
