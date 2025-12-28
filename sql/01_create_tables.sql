-- SuperRides Transportation & Fleet Management System (STFMS)
-- Database Creation Script (DDL)
-- Q4: Create Tables with DDL scripts

-- Drop existing tables if they exist (for clean reinstallation)
DROP TABLE IF EXISTS Maintenance CASCADE;
DROP TABLE IF EXISTS Feedback CASCADE;
DROP TABLE IF EXISTS Payment CASCADE;
DROP TABLE IF EXISTS Ride CASCADE;
DROP TABLE IF EXISTS Driver CASCADE;
DROP TABLE IF EXISTS Vehicle CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;
DROP TABLE IF EXISTS City CASCADE;
DROP TABLE IF EXISTS LoyaltyPoints CASCADE;

-- ==============================================================================
-- Table: City
-- Stores information about cities where SuperRides operates
-- ==============================================================================
CREATE TABLE City (
    city_id NUMBER(10) PRIMARY KEY,
    city_name VARCHAR2(50) NOT NULL UNIQUE,
    region VARCHAR2(50) NOT NULL,
    CONSTRAINT chk_city_name CHECK (LENGTH(city_name) > 0)
);

-- ==============================================================================
-- Table: Customer
-- Stores customer registration and profile information
-- ==============================================================================
CREATE TABLE Customer (
    customer_id NUMBER(10) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    phone VARCHAR2(20) NOT NULL,
    registration_date DATE DEFAULT SYSDATE NOT NULL,
    city_id NUMBER(10) NOT NULL,
    status VARCHAR2(20) DEFAULT 'Active' NOT NULL,
    CONSTRAINT fk_customer_city FOREIGN KEY (city_id) REFERENCES City(city_id),
    CONSTRAINT chk_customer_status CHECK (status IN ('Active', 'Inactive', 'Suspended')),
    CONSTRAINT chk_customer_email CHECK (email LIKE '%@%.%')
);

-- ==============================================================================
-- Table: LoyaltyPoints
-- Tracks customer loyalty points and expiration dates
-- ==============================================================================
CREATE TABLE LoyaltyPoints (
    loyalty_id NUMBER(10) PRIMARY KEY,
    customer_id NUMBER(10) NOT NULL,
    points NUMBER(10) DEFAULT 0 NOT NULL,
    earned_date DATE DEFAULT SYSDATE NOT NULL,
    expiry_date DATE NOT NULL,
    status VARCHAR2(20) DEFAULT 'Active' NOT NULL,
    CONSTRAINT fk_loyalty_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT chk_loyalty_points CHECK (points >= 0),
    CONSTRAINT chk_loyalty_status CHECK (status IN ('Active', 'Expired', 'Redeemed'))
);

-- ==============================================================================
-- Table: Vehicle
-- Stores vehicle fleet information
-- ==============================================================================
CREATE TABLE Vehicle (
    vehicle_id NUMBER(10) PRIMARY KEY,
    vehicle_number VARCHAR2(20) NOT NULL UNIQUE,
    vehicle_type VARCHAR2(30) NOT NULL,
    make VARCHAR2(50) NOT NULL,
    model VARCHAR2(50) NOT NULL,
    year NUMBER(4) NOT NULL,
    total_km NUMBER(10) DEFAULT 0 NOT NULL,
    last_maintenance_km NUMBER(10) DEFAULT 0 NOT NULL,
    status VARCHAR2(20) DEFAULT 'Available' NOT NULL,
    city_id NUMBER(10) NOT NULL,
    CONSTRAINT fk_vehicle_city FOREIGN KEY (city_id) REFERENCES City(city_id),
    CONSTRAINT chk_vehicle_type CHECK (vehicle_type IN ('Sedan', 'SUV', 'Hatchback', 'Van', 'Electric')),
    CONSTRAINT chk_vehicle_status CHECK (status IN ('Available', 'In Use', 'Maintenance', 'Retired')),
    CONSTRAINT chk_vehicle_year CHECK (year BETWEEN 2010 AND 2026),
    CONSTRAINT chk_total_km CHECK (total_km >= 0),
    CONSTRAINT chk_last_maintenance_km CHECK (last_maintenance_km >= 0)
);

-- ==============================================================================
-- Table: Driver
-- Stores driver information and performance metrics
-- ==============================================================================
CREATE TABLE Driver (
    driver_id NUMBER(10) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    phone VARCHAR2(20) NOT NULL,
    license_number VARCHAR2(30) NOT NULL UNIQUE,
    license_expiry DATE NOT NULL,
    joining_date DATE DEFAULT SYSDATE NOT NULL,
    status VARCHAR2(20) DEFAULT 'Available' NOT NULL,
    average_rating NUMBER(3,2) DEFAULT 5.00,
    total_rides NUMBER(10) DEFAULT 0,
    city_id NUMBER(10) NOT NULL,
    CONSTRAINT fk_driver_city FOREIGN KEY (city_id) REFERENCES City(city_id),
    CONSTRAINT chk_driver_status CHECK (status IN ('Available', 'On Ride', 'Off Duty', 'Suspended')),
    CONSTRAINT chk_driver_rating CHECK (average_rating BETWEEN 0 AND 5),
    CONSTRAINT chk_driver_email CHECK (email LIKE '%@%.%'),
    CONSTRAINT chk_total_rides CHECK (total_rides >= 0)
);

-- ==============================================================================
-- Table: Ride
-- Stores ride booking and completion information
-- ==============================================================================
CREATE TABLE Ride (
    ride_id NUMBER(10) PRIMARY KEY,
    customer_id NUMBER(10) NOT NULL,
    driver_id NUMBER(10),
    vehicle_id NUMBER(10),
    pickup_location VARCHAR2(200) NOT NULL,
    dropoff_location VARCHAR2(200) NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    pickup_time TIMESTAMP,
    dropoff_time TIMESTAMP,
    distance_km NUMBER(8,2),
    fare_amount NUMBER(10,2) NOT NULL,
    status VARCHAR2(20) DEFAULT 'Pending' NOT NULL,
    ride_type VARCHAR2(30) DEFAULT 'Standard' NOT NULL,
    city_id NUMBER(10) NOT NULL,
    CONSTRAINT fk_ride_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_ride_driver FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
    CONSTRAINT fk_ride_vehicle FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id),
    CONSTRAINT fk_ride_city FOREIGN KEY (city_id) REFERENCES City(city_id),
    CONSTRAINT chk_ride_status CHECK (status IN ('Pending', 'Assigned', 'In Progress', 'Completed', 'Cancelled')),
    CONSTRAINT chk_ride_type CHECK (ride_type IN ('Standard', 'Premium', 'Shared', 'Corporate', 'Parcel Delivery')),
    CONSTRAINT chk_fare_amount CHECK (fare_amount >= 0),
    CONSTRAINT chk_distance CHECK (distance_km >= 0)
);

-- ==============================================================================
-- Table: Payment
-- Stores payment transaction information
-- ==============================================================================
CREATE TABLE Payment (
    payment_id NUMBER(10) PRIMARY KEY,
    ride_id NUMBER(10) NOT NULL,
    payment_method VARCHAR2(30) NOT NULL,
    amount NUMBER(10,2) NOT NULL,
    payment_status VARCHAR2(20) DEFAULT 'Pending' NOT NULL,
    payment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    transaction_id VARCHAR2(100) UNIQUE,
    CONSTRAINT fk_payment_ride FOREIGN KEY (ride_id) REFERENCES Ride(ride_id) ON DELETE CASCADE,
    CONSTRAINT chk_payment_method CHECK (payment_method IN ('Card', 'Cash', 'Digital Wallet', 'Corporate Account')),
    CONSTRAINT chk_payment_status CHECK (payment_status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    CONSTRAINT chk_payment_amount CHECK (amount >= 0)
);

-- ==============================================================================
-- Table: Feedback
-- Stores customer feedback and ratings for completed rides
-- ==============================================================================
CREATE TABLE Feedback (
    feedback_id NUMBER(10) PRIMARY KEY,
    ride_id NUMBER(10) NOT NULL,
    customer_id NUMBER(10) NOT NULL,
    driver_id NUMBER(10) NOT NULL,
    rating NUMBER(2) NOT NULL,
    comments VARCHAR2(500),
    feedback_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT fk_feedback_ride FOREIGN KEY (ride_id) REFERENCES Ride(ride_id) ON DELETE CASCADE,
    CONSTRAINT fk_feedback_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_feedback_driver FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
    CONSTRAINT chk_feedback_rating CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT uk_feedback_ride UNIQUE (ride_id)
);

-- ==============================================================================
-- Table: Maintenance
-- Stores vehicle maintenance records including service and fuel costs
-- ==============================================================================
CREATE TABLE Maintenance (
    maintenance_id NUMBER(10) PRIMARY KEY,
    vehicle_id NUMBER(10) NOT NULL,
    maintenance_date DATE DEFAULT SYSDATE NOT NULL,
    maintenance_type VARCHAR2(50) NOT NULL,
    cost NUMBER(10,2) NOT NULL,
    description VARCHAR2(500),
    km_at_maintenance NUMBER(10) NOT NULL,
    next_maintenance_due NUMBER(10),
    status VARCHAR2(20) DEFAULT 'Scheduled' NOT NULL,
    CONSTRAINT fk_maintenance_vehicle FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id) ON DELETE CASCADE,
    CONSTRAINT chk_maintenance_type CHECK (maintenance_type IN ('Routine Service', 'Repair', 'Inspection', 'Fuel', 'Emergency')),
    CONSTRAINT chk_maintenance_cost CHECK (cost >= 0),
    CONSTRAINT chk_maintenance_status CHECK (status IN ('Scheduled', 'In Progress', 'Completed', 'Cancelled')),
    CONSTRAINT chk_km_maintenance CHECK (km_at_maintenance >= 0)
);

-- ==============================================================================
-- Create Sequences for Primary Keys (Oracle-specific)
-- ==============================================================================
CREATE SEQUENCE seq_city START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_customer START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_loyalty START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_vehicle START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_driver START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ride START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_payment START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_feedback START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_maintenance START WITH 1 INCREMENT BY 1;

-- ==============================================================================
-- Create Indexes for Performance Optimization
-- ==============================================================================
CREATE INDEX idx_customer_email ON Customer(email);
CREATE INDEX idx_customer_city ON Customer(city_id);
CREATE INDEX idx_driver_city ON Driver(city_id);
CREATE INDEX idx_driver_status ON Driver(status);
CREATE INDEX idx_vehicle_status ON Vehicle(status);
CREATE INDEX idx_ride_customer ON Ride(customer_id);
CREATE INDEX idx_ride_driver ON Ride(driver_id);
CREATE INDEX idx_ride_status ON Ride(status);
CREATE INDEX idx_ride_booking ON Ride(booking_time);
CREATE INDEX idx_payment_ride ON Payment(ride_id);
CREATE INDEX idx_feedback_driver ON Feedback(driver_id);
CREATE INDEX idx_maintenance_vehicle ON Maintenance(vehicle_id);
CREATE INDEX idx_loyalty_customer ON LoyaltyPoints(customer_id);

-- Script completed successfully
COMMIT;
