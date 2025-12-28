# Data Dictionary - STFMS Database
## SuperRides Transportation & Fleet Management System

## Table: City

**Purpose**: Stores information about cities where SuperRides operates.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| city_id | NUMBER(10) | PRIMARY KEY | Unique identifier for each city |
| city_name | VARCHAR2(50) | NOT NULL, UNIQUE | Name of the city |
| region | VARCHAR2(50) | NOT NULL | Region or area where city is located |

**Constraints**:
- `chk_city_name`: City name length must be > 0

---

## Table: Customer

**Purpose**: Stores customer registration and profile information.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| customer_id | NUMBER(10) | PRIMARY KEY | Unique identifier for each customer |
| first_name | VARCHAR2(50) | NOT NULL | Customer's first name |
| last_name | VARCHAR2(50) | NOT NULL | Customer's last name |
| email | VARCHAR2(100) | NOT NULL, UNIQUE | Customer's email address |
| phone | VARCHAR2(20) | NOT NULL | Contact phone number |
| registration_date | DATE | NOT NULL, DEFAULT SYSDATE | Date of registration |
| city_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References City(city_id) |
| status | VARCHAR2(20) | NOT NULL, DEFAULT 'Active' | Account status |

**Constraints**:
- `fk_customer_city`: Foreign key to City table
- `chk_customer_status`: Status must be 'Active', 'Inactive', or 'Suspended'
- `chk_customer_email`: Email must contain '@' and '.'

---

## Table: LoyaltyPoints

**Purpose**: Tracks customer loyalty points and expiration dates.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| loyalty_id | NUMBER(10) | PRIMARY KEY | Unique identifier for loyalty record |
| customer_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References Customer(customer_id) |
| points | NUMBER(10) | NOT NULL, DEFAULT 0 | Number of loyalty points |
| earned_date | DATE | NOT NULL, DEFAULT SYSDATE | Date when points were earned |
| expiry_date | DATE | NOT NULL | Date when points expire |
| status | VARCHAR2(20) | NOT NULL, DEFAULT 'Active' | Status of points |

**Constraints**:
- `fk_loyalty_customer`: Foreign key to Customer table with CASCADE DELETE
- `chk_loyalty_points`: Points must be >= 0
- `chk_loyalty_status`: Status must be 'Active', 'Expired', or 'Redeemed'

---

## Table: Vehicle

**Purpose**: Stores vehicle fleet information.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| vehicle_id | NUMBER(10) | PRIMARY KEY | Unique identifier for each vehicle |
| vehicle_number | VARCHAR2(20) | NOT NULL, UNIQUE | Registration/license plate number |
| vehicle_type | VARCHAR2(30) | NOT NULL | Type of vehicle |
| make | VARCHAR2(50) | NOT NULL | Vehicle manufacturer |
| model | VARCHAR2(50) | NOT NULL | Vehicle model |
| year | NUMBER(4) | NOT NULL | Manufacturing year |
| total_km | NUMBER(10) | NOT NULL, DEFAULT 0 | Total kilometers driven |
| last_maintenance_km | NUMBER(10) | NOT NULL, DEFAULT 0 | Kilometers at last maintenance |
| status | VARCHAR2(20) | NOT NULL, DEFAULT 'Available' | Vehicle status |
| city_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References City(city_id) |

**Constraints**:
- `fk_vehicle_city`: Foreign key to City table
- `chk_vehicle_type`: Type must be 'Sedan', 'SUV', 'Hatchback', 'Van', or 'Electric'
- `chk_vehicle_status`: Status must be 'Available', 'In Use', 'Maintenance', or 'Retired'
- `chk_vehicle_year`: Year must be between 2010 and 2026
- `chk_total_km`: Total kilometers must be >= 0
- `chk_last_maintenance_km`: Last maintenance km must be >= 0

---

## Table: Driver

**Purpose**: Stores driver information and performance metrics.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| driver_id | NUMBER(10) | PRIMARY KEY | Unique identifier for each driver |
| first_name | VARCHAR2(50) | NOT NULL | Driver's first name |
| last_name | VARCHAR2(50) | NOT NULL | Driver's last name |
| email | VARCHAR2(100) | NOT NULL, UNIQUE | Driver's email address |
| phone | VARCHAR2(20) | NOT NULL | Contact phone number |
| license_number | VARCHAR2(30) | NOT NULL, UNIQUE | Driving license number |
| license_expiry | DATE | NOT NULL | License expiration date |
| joining_date | DATE | NOT NULL, DEFAULT SYSDATE | Date when driver joined |
| status | VARCHAR2(20) | NOT NULL, DEFAULT 'Available' | Driver availability status |
| average_rating | NUMBER(3,2) | DEFAULT 5.00 | Average customer rating (0-5) |
| total_rides | NUMBER(10) | DEFAULT 0 | Total number of rides completed |
| city_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References City(city_id) |

**Constraints**:
- `fk_driver_city`: Foreign key to City table
- `chk_driver_status`: Status must be 'Available', 'On Ride', 'Off Duty', or 'Suspended'
- `chk_driver_rating`: Rating must be between 0 and 5
- `chk_driver_email`: Email must contain '@' and '.'
- `chk_total_rides`: Total rides must be >= 0

---

## Table: Ride

**Purpose**: Stores ride booking and completion information.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| ride_id | NUMBER(10) | PRIMARY KEY | Unique identifier for each ride |
| customer_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References Customer(customer_id) |
| driver_id | NUMBER(10) | FOREIGN KEY | References Driver(driver_id), nullable |
| vehicle_id | NUMBER(10) | FOREIGN KEY | References Vehicle(vehicle_id), nullable |
| pickup_location | VARCHAR2(200) | NOT NULL | Pickup address or location |
| dropoff_location | VARCHAR2(200) | NOT NULL | Dropoff address or location |
| booking_time | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | When ride was booked |
| pickup_time | TIMESTAMP | | Actual pickup time |
| dropoff_time | TIMESTAMP | | Actual dropoff time |
| distance_km | NUMBER(8,2) | | Distance traveled in kilometers |
| fare_amount | NUMBER(10,2) | NOT NULL | Total fare charged |
| status | VARCHAR2(20) | NOT NULL, DEFAULT 'Pending' | Ride status |
| ride_type | VARCHAR2(30) | NOT NULL, DEFAULT 'Standard' | Type of ride service |
| city_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References City(city_id) |

**Constraints**:
- `fk_ride_customer`: Foreign key to Customer table
- `fk_ride_driver`: Foreign key to Driver table
- `fk_ride_vehicle`: Foreign key to Vehicle table
- `fk_ride_city`: Foreign key to City table
- `chk_ride_status`: Status must be 'Pending', 'Assigned', 'In Progress', 'Completed', or 'Cancelled'
- `chk_ride_type`: Type must be 'Standard', 'Premium', 'Shared', 'Corporate', or 'Parcel Delivery'
- `chk_fare_amount`: Fare must be >= 0
- `chk_distance`: Distance must be >= 0

---

## Table: Payment

**Purpose**: Stores payment transaction information.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| payment_id | NUMBER(10) | PRIMARY KEY | Unique identifier for each payment |
| ride_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References Ride(ride_id) |
| payment_method | VARCHAR2(30) | NOT NULL | Method of payment |
| amount | NUMBER(10,2) | NOT NULL | Payment amount |
| payment_status | VARCHAR2(20) | NOT NULL, DEFAULT 'Pending' | Status of payment |
| payment_time | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | When payment was processed |
| transaction_id | VARCHAR2(100) | UNIQUE | External transaction reference |

**Constraints**:
- `fk_payment_ride`: Foreign key to Ride table with CASCADE DELETE
- `chk_payment_method`: Method must be 'Card', 'Cash', 'Digital Wallet', or 'Corporate Account'
- `chk_payment_status`: Status must be 'Pending', 'Completed', 'Failed', or 'Refunded'
- `chk_payment_amount`: Amount must be >= 0

---

## Table: Feedback

**Purpose**: Stores customer feedback and ratings for completed rides.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| feedback_id | NUMBER(10) | PRIMARY KEY | Unique identifier for feedback |
| ride_id | NUMBER(10) | NOT NULL, FOREIGN KEY, UNIQUE | References Ride(ride_id) |
| customer_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References Customer(customer_id) |
| driver_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References Driver(driver_id) |
| rating | NUMBER(2) | NOT NULL | Numeric rating (1-5) |
| comments | VARCHAR2(500) | | Optional text comments |
| feedback_date | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | When feedback was submitted |

**Constraints**:
- `fk_feedback_ride`: Foreign key to Ride table with CASCADE DELETE
- `fk_feedback_customer`: Foreign key to Customer table
- `fk_feedback_driver`: Foreign key to Driver table
- `chk_feedback_rating`: Rating must be between 1 and 5
- `uk_feedback_ride`: Each ride can have only one feedback

---

## Table: Maintenance

**Purpose**: Stores vehicle maintenance records including service and fuel costs.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| maintenance_id | NUMBER(10) | PRIMARY KEY | Unique identifier for maintenance record |
| vehicle_id | NUMBER(10) | NOT NULL, FOREIGN KEY | References Vehicle(vehicle_id) |
| maintenance_date | DATE | NOT NULL, DEFAULT SYSDATE | Date of maintenance |
| maintenance_type | VARCHAR2(50) | NOT NULL | Type of maintenance |
| cost | NUMBER(10,2) | NOT NULL | Cost of maintenance/fuel |
| description | VARCHAR2(500) | | Details of work performed |
| km_at_maintenance | NUMBER(10) | NOT NULL | Vehicle kilometers at time of maintenance |
| next_maintenance_due | NUMBER(10) | | Kilometers when next maintenance is due |
| status | VARCHAR2(20) | NOT NULL, DEFAULT 'Scheduled' | Status of maintenance |

**Constraints**:
- `fk_maintenance_vehicle`: Foreign key to Vehicle table with CASCADE DELETE
- `chk_maintenance_type`: Type must be 'Routine Service', 'Repair', 'Inspection', 'Fuel', or 'Emergency'
- `chk_maintenance_cost`: Cost must be >= 0
- `chk_maintenance_status`: Status must be 'Scheduled', 'In Progress', 'Completed', or 'Cancelled'
- `chk_km_maintenance`: Kilometers at maintenance must be >= 0

---

## Sequences

| Sequence Name | Purpose |
|---------------|---------|
| seq_city | Generates unique IDs for City table |
| seq_customer | Generates unique IDs for Customer table |
| seq_loyalty | Generates unique IDs for LoyaltyPoints table |
| seq_vehicle | Generates unique IDs for Vehicle table |
| seq_driver | Generates unique IDs for Driver table |
| seq_ride | Generates unique IDs for Ride table |
| seq_payment | Generates unique IDs for Payment table |
| seq_feedback | Generates unique IDs for Feedback table |
| seq_maintenance | Generates unique IDs for Maintenance table |

---

## Indexes

| Index Name | Table | Column(s) | Purpose |
|------------|-------|-----------|---------|
| idx_customer_email | Customer | email | Fast email lookup |
| idx_customer_city | Customer | city_id | City-based customer queries |
| idx_driver_city | Driver | city_id | City-based driver queries |
| idx_driver_status | Driver | status | Available driver searches |
| idx_vehicle_status | Vehicle | status | Available vehicle searches |
| idx_ride_customer | Ride | customer_id | Customer ride history |
| idx_ride_driver | Ride | driver_id | Driver ride history |
| idx_ride_status | Ride | status | Status-based filtering |
| idx_ride_booking | Ride | booking_time | Date-based queries |
| idx_payment_ride | Payment | ride_id | Payment lookup by ride |
| idx_feedback_driver | Feedback | driver_id | Driver feedback queries |
| idx_maintenance_vehicle | Maintenance | vehicle_id | Vehicle maintenance history |
| idx_loyalty_customer | LoyaltyPoints | customer_id | Customer loyalty queries |

---

## Relationships Summary

| Parent Table | Child Table | Relationship | Cardinality |
|--------------|-------------|--------------|-------------|
| City | Customer | One-to-Many | 1:N |
| City | Driver | One-to-Many | 1:N |
| City | Vehicle | One-to-Many | 1:N |
| City | Ride | One-to-Many | 1:N |
| Customer | Ride | One-to-Many | 1:N |
| Customer | LoyaltyPoints | One-to-Many | 1:N |
| Customer | Feedback | One-to-Many | 1:N |
| Driver | Ride | One-to-Many | 1:N |
| Driver | Feedback | One-to-Many | 1:N |
| Vehicle | Ride | One-to-Many | 1:N |
| Vehicle | Maintenance | One-to-Many | 1:N |
| Ride | Payment | One-to-One | 1:1 |
| Ride | Feedback | One-to-One | 1:1 |

---

## Business Rules

1. **Email Uniqueness**: Each customer and driver must have a unique email address
2. **License Uniqueness**: Each driver must have a unique license number
3. **Vehicle Uniqueness**: Each vehicle must have a unique registration number
4. **Rating Range**: Customer ratings must be between 1-5, driver averages between 0-5
5. **Status Values**: All status fields accept only predefined valid values
6. **Non-negative Values**: Amounts, distances, points, and kilometers must be >= 0
7. **Ride Assignment**: Rides can exist without driver/vehicle (for pending/cancelled status)
8. **Feedback Limitation**: Each ride can have at most one feedback entry
9. **Loyalty Expiration**: Loyalty points expire 12 months after earned date
10. **Maintenance Threshold**: Automatic maintenance scheduling after 20,000 km

---

## Data Integrity Rules

1. **Referential Integrity**: All foreign keys enforce parent-child relationships
2. **Cascading Deletes**: Applied on LoyaltyPoints, Payment, Feedback, and Maintenance
3. **Entity Integrity**: All tables have well-defined primary keys
4. **Domain Integrity**: Data types and check constraints ensure valid values
5. **User-Defined Integrity**: Business rules implemented via triggers and procedures
