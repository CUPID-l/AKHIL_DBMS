# Entity Relationship Diagram (ERD) - STFMS
## Q1: ERD Design (10 Marks)

## Overview
The SuperRides Transportation & Fleet Management System (STFMS) database is designed to manage a comprehensive ride-hailing and logistics operation across multiple UK cities. The ERD captures all key entities, their attributes, and relationships necessary for the business operations.

## Entities and Attributes

### 1. City
**Purpose**: Stores information about cities where SuperRides operates.

**Attributes**:
- `city_id` (PK) - Unique identifier for each city
- `city_name` - Name of the city (UNIQUE)
- `region` - Region/area where city is located

### 2. Customer
**Purpose**: Stores customer registration and profile information.

**Attributes**:
- `customer_id` (PK) - Unique identifier for each customer
- `first_name` - Customer's first name
- `last_name` - Customer's last name
- `email` - Customer's email address (UNIQUE)
- `phone` - Contact phone number
- `registration_date` - Date when customer registered
- `city_id` (FK) - References City entity
- `status` - Account status (Active, Inactive, Suspended)

### 3. LoyaltyPoints
**Purpose**: Tracks customer loyalty points and expiration dates.

**Attributes**:
- `loyalty_id` (PK) - Unique identifier for loyalty record
- `customer_id` (FK) - References Customer entity
- `points` - Number of loyalty points
- `earned_date` - Date when points were earned
- `expiry_date` - Date when points expire
- `status` - Status of points (Active, Expired, Redeemed)

### 4. Vehicle
**Purpose**: Stores vehicle fleet information.

**Attributes**:
- `vehicle_id` (PK) - Unique identifier for each vehicle
- `vehicle_number` - Registration/license plate (UNIQUE)
- `vehicle_type` - Type of vehicle (Sedan, SUV, Hatchback, Van, Electric)
- `make` - Vehicle manufacturer
- `model` - Vehicle model
- `year` - Manufacturing year
- `total_km` - Total kilometers driven
- `last_maintenance_km` - Kilometers at last maintenance
- `status` - Vehicle status (Available, In Use, Maintenance, Retired)
- `city_id` (FK) - References City entity

### 5. Driver
**Purpose**: Stores driver information and performance metrics.

**Attributes**:
- `driver_id` (PK) - Unique identifier for each driver
- `first_name` - Driver's first name
- `last_name` - Driver's last name
- `email` - Driver's email address (UNIQUE)
- `phone` - Contact phone number
- `license_number` - Driving license number (UNIQUE)
- `license_expiry` - License expiration date
- `joining_date` - Date when driver joined
- `status` - Driver status (Available, On Ride, Off Duty, Suspended)
- `average_rating` - Average customer rating
- `total_rides` - Total number of rides completed
- `city_id` (FK) - References City entity

### 6. Ride
**Purpose**: Stores ride booking and completion information.

**Attributes**:
- `ride_id` (PK) - Unique identifier for each ride
- `customer_id` (FK) - References Customer entity
- `driver_id` (FK) - References Driver entity (nullable for pending/cancelled rides)
- `vehicle_id` (FK) - References Vehicle entity (nullable for pending/cancelled rides)
- `pickup_location` - Pickup address/location
- `dropoff_location` - Dropoff address/location
- `booking_time` - When ride was booked
- `pickup_time` - Actual pickup time
- `dropoff_time` - Actual dropoff time
- `distance_km` - Distance traveled
- `fare_amount` - Total fare charged
- `status` - Ride status (Pending, Assigned, In Progress, Completed, Cancelled)
- `ride_type` - Type of ride (Standard, Premium, Shared, Corporate, Parcel Delivery)
- `city_id` (FK) - References City entity

### 7. Payment
**Purpose**: Stores payment transaction information.

**Attributes**:
- `payment_id` (PK) - Unique identifier for each payment
- `ride_id` (FK) - References Ride entity
- `payment_method` - Method used (Card, Cash, Digital Wallet, Corporate Account)
- `amount` - Payment amount
- `payment_status` - Status (Pending, Completed, Failed, Refunded)
- `payment_time` - When payment was processed
- `transaction_id` - External transaction reference (UNIQUE)

### 8. Feedback
**Purpose**: Stores customer feedback and ratings for completed rides.

**Attributes**:
- `feedback_id` (PK) - Unique identifier for feedback
- `ride_id` (FK) - References Ride entity (UNIQUE - one feedback per ride)
- `customer_id` (FK) - References Customer entity
- `driver_id` (FK) - References Driver entity
- `rating` - Numeric rating (1-5)
- `comments` - Text comments
- `feedback_date` - When feedback was submitted

### 9. Maintenance
**Purpose**: Stores vehicle maintenance records including service and fuel costs.

**Attributes**:
- `maintenance_id` (PK) - Unique identifier for maintenance record
- `vehicle_id` (FK) - References Vehicle entity
- `maintenance_date` - Date of maintenance
- `maintenance_type` - Type (Routine Service, Repair, Inspection, Fuel, Emergency)
- `cost` - Cost of maintenance/fuel
- `description` - Details of work performed
- `km_at_maintenance` - Vehicle kilometers at time of maintenance
- `next_maintenance_due` - Kilometers when next maintenance is due
- `status` - Status (Scheduled, In Progress, Completed, Cancelled)

## Relationships and Cardinality

### City Relationships
- **City to Customer**: One-to-Many (1:N)
  - One city has many customers
  - Each customer is registered in one city
  
- **City to Driver**: One-to-Many (1:N)
  - One city has many drivers
  - Each driver is based in one city
  
- **City to Vehicle**: One-to-Many (1:N)
  - One city has many vehicles
  - Each vehicle is stationed in one city
  
- **City to Ride**: One-to-Many (1:N)
  - One city has many rides
  - Each ride occurs in one city

### Customer Relationships
- **Customer to Ride**: One-to-Many (1:N)
  - One customer can book many rides
  - Each ride is booked by one customer
  
- **Customer to LoyaltyPoints**: One-to-Many (1:N)
  - One customer can have multiple loyalty point records
  - Each loyalty record belongs to one customer
  
- **Customer to Feedback**: One-to-Many (1:N)
  - One customer can provide feedback for many rides
  - Each feedback is from one customer

### Driver Relationships
- **Driver to Ride**: One-to-Many (1:N)
  - One driver can complete many rides
  - Each ride is completed by one driver (when assigned)
  
- **Driver to Feedback**: One-to-Many (1:N)
  - One driver can receive feedback from many rides
  - Each feedback is about one driver

### Vehicle Relationships
- **Vehicle to Ride**: One-to-Many (1:N)
  - One vehicle can be used for many rides
  - Each ride uses one vehicle (when assigned)
  
- **Vehicle to Maintenance**: One-to-Many (1:N)
  - One vehicle has many maintenance records
  - Each maintenance record is for one vehicle

### Ride Relationships
- **Ride to Payment**: One-to-One (1:1)
  - Each completed ride has one payment
  - Each payment is for one ride
  
- **Ride to Feedback**: One-to-One (1:1)
  - Each completed ride can have one feedback
  - Each feedback is for one ride

## Normalization Analysis

### First Normal Form (1NF)
✓ All tables have atomic values
✓ Each column contains values of single type
✓ Each column has unique name
✓ No repeating groups

### Second Normal Form (2NF)
✓ All tables are in 1NF
✓ All non-key attributes are fully functionally dependent on primary key
✓ No partial dependencies exist

### Third Normal Form (3NF)
✓ All tables are in 2NF
✓ No transitive dependencies exist
✓ All non-key attributes depend only on primary key

## Business Rules Implemented

1. **Email Validation**: Customer and driver emails must contain '@' and '.'
2. **Status Constraints**: All status fields have defined valid values
3. **Rating Constraints**: Ratings must be between 1-5 (feedback) or 0-5 (driver average)
4. **Date Validation**: Registration, joining, and expiry dates are properly constrained
5. **Referential Integrity**: All foreign keys maintain referential integrity with CASCADE where appropriate
6. **Unique Constraints**: Email addresses, license numbers, vehicle numbers, and transaction IDs are unique
7. **Default Values**: Appropriate defaults for status fields and timestamps
8. **Check Constraints**: Non-negative values for amounts, distances, and points

## ERD Diagram Notation

The ERD uses the following notation:
- **Rectangles**: Entities
- **Ovals**: Attributes
- **Diamonds**: Relationships
- **Lines**: Connections between entities
- **Crow's Foot**: Cardinality indicators
  - One: Single line
  - Many: Three-pronged "crow's foot"
  - Mandatory: Solid line
  - Optional: Dashed line

## Design Decisions

1. **Separate LoyaltyPoints Table**: Allows tracking of multiple point awards with different expiry dates
2. **Nullable Driver/Vehicle in Ride**: Supports pending and cancelled rides before assignment
3. **Maintenance Type Includes Fuel**: Tracks all vehicle-related costs in one place
4. **Separate City Entity**: Normalizes location data and enables city-level reporting
5. **Feedback One-to-One with Ride**: Ensures single feedback per ride for data integrity
6. **Status Fields**: Enable workflow management and business process tracking
7. **Timestamp Precision**: Booking, pickup, and dropoff times use TIMESTAMP for accuracy
8. **Cascading Deletes**: Applied selectively (e.g., Payment, Feedback) to maintain data integrity

## Future Enhancements

Potential extensions to the ERD:
- Route tracking with GPS coordinates
- Driver shift scheduling
- Vehicle insurance and registration details
- Promotional campaigns and discounts
- Multi-currency support for international expansion
- Real-time vehicle location tracking
- Driver earnings and commission structure
- Customer preferred payment methods
