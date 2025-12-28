# Entity Relationship Diagram (ERD) - SuperRides STFMS

## Overview
This ERD represents the SuperRides Transportation & Fleet Management System (STFMS) database design.

## Entities and Attributes

### 1. CUSTOMER
- **CustomerID** (PK) - Unique identifier for each customer
- Name - Customer full name
- Email - Customer email address (UNIQUE)
- Phone - Contact phone number (UNIQUE)
- Address - Customer residential address
- RegistrationDate - Date when customer registered
- LoyaltyPoints - Current loyalty points balance

### 2. DRIVER
- **DriverID** (PK) - Unique identifier for each driver
- Name - Driver full name
- LicenseNumber - Driving license number (UNIQUE)
- Phone - Contact phone number (UNIQUE)
- Rating - Average rating (0-5)
- Status - Current status (Available/Busy/Offline)
- JoinDate - Date when driver joined

### 3. VEHICLE
- **VehicleID** (PK) - Unique identifier for each vehicle
- RegistrationType - Vehicle registration/license plate (UNIQUE)
- Model - Vehicle model and make
- Year - Manufacturing year
- Mileage - Current odometer reading
- Status - Current status (Active/Maintenance/Retired)
- LastMaintenanceDate - Date of last maintenance

### 4. RIDE
- **RideID** (PK) - Unique identifier for each ride
- CustomerID (FK) - References CUSTOMER
- DriverID (FK) - References DRIVER
- VehicleID (FK) - References VEHICLE
- PickupLocation - Starting location
- DropoffLocation - Destination location
- PickupDateTime - Date and time of pickup
- DropoffDateTime - Date and time of dropoff
- Status - Ride status (Requested/InProgress/Completed/Cancelled)
- Fare - Total fare amount
- Distance - Distance traveled in km
- RideType - Type of service (Passenger/Corporate/Delivery)

### 5. PAYMENT
- **PaymentID** (PK) - Unique identifier for each payment
- RideID (FK) - References RIDE (UNIQUE - one payment per ride)
- Amount - Payment amount
- PaymentMethod - Method of payment (Cash/Card/Wallet)
- PaymentStatus - Status (Pending/Completed/Failed)
- Timestamp - Date and time of payment

### 6. MAINTENANCE
- **MaintenanceID** (PK) - Unique identifier for each maintenance record
- VehicleID (FK) - References VEHICLE
- MaintenanceDate - Date of maintenance
- MaintenanceType - Type of maintenance (Routine/Repair/Emergency)
- Description - Details of work performed
- Cost - Total cost of maintenance
- MileageAtService - Vehicle mileage at time of service
- NextMaintenanceDue - Expected next maintenance mileage

### 7. FEEDBACK
- **FeedbackID** (PK) - Unique identifier for each feedback
- RideID (FK) - References RIDE (UNIQUE - one feedback per ride)
- CustomerID (FK) - References CUSTOMER
- DriverID (FK) - References DRIVER
- Rating - Customer rating (1-5)
- Comments - Customer feedback text
- FeedbackDate - Date feedback was submitted

### 8. FUEL_RECORD
- **FuelID** (PK) - Unique identifier for each fuel record
- VehicleID (FK) - References VEHICLE
- FuelDate - Date of refueling
- LitersAdded - Amount of fuel added (liters)
- Cost - Total cost
- MileageAtFill - Vehicle mileage at time of refueling
- FuelType - Type of fuel (Petrol/Diesel/Electric)

### 9. CITY
- **CityID** (PK) - Unique identifier for each city
- CityName - Name of city (London/Manchester/Birmingham/Glasgow)
- Region - Geographic region
- OperationsStartDate - Date operations began in this city

### 10. DRIVER_AVAILABILITY
- **AvailabilityID** (PK) - Unique identifier for availability record
- DriverID (FK) - References DRIVER
- CityID (FK) - References CITY
- ShiftDate - Date of shift
- ShiftStartTime - Start time of availability
- ShiftEndTime - End time of availability
- Status - Shift status (Scheduled/Active/Completed)

### 11. LOYALTY_TRANSACTION
- **TransactionID** (PK) - Unique identifier for each transaction
- CustomerID (FK) - References CUSTOMER
- RideID (FK) - References RIDE (nullable)
- PointsChange - Points added or deducted
- TransactionType - Type (Earned/Redeemed/Expired/Adjusted)
- TransactionDate - Date of transaction
- ExpiryDate - Date when points expire
- Description - Transaction description

## Relationships

### One-to-Many Relationships:
1. **CUSTOMER → RIDE** (1:N)
   - One customer can book many rides
   - Each ride belongs to one customer

2. **DRIVER → RIDE** (1:N)
   - One driver can complete many rides
   - Each ride is assigned to one driver

3. **VEHICLE → RIDE** (1:N)
   - One vehicle can be used for many rides
   - Each ride uses one vehicle

4. **VEHICLE → MAINTENANCE** (1:N)
   - One vehicle can have many maintenance records
   - Each maintenance record is for one vehicle

5. **VEHICLE → FUEL_RECORD** (1:N)
   - One vehicle can have many fuel records
   - Each fuel record is for one vehicle

6. **CUSTOMER → FEEDBACK** (1:N)
   - One customer can submit many feedback entries
   - Each feedback is submitted by one customer

7. **DRIVER → FEEDBACK** (1:N)
   - One driver can receive many feedback entries
   - Each feedback is about one driver

8. **CUSTOMER → LOYALTY_TRANSACTION** (1:N)
   - One customer can have many loyalty transactions
   - Each transaction belongs to one customer

9. **CITY → DRIVER_AVAILABILITY** (1:N)
   - One city can have many driver availability records
   - Each availability record is for one city

10. **DRIVER → DRIVER_AVAILABILITY** (1:N)
    - One driver can have many availability records
    - Each availability record belongs to one driver

### One-to-One Relationships:
1. **RIDE → PAYMENT** (1:1)
   - Each ride has exactly one payment
   - Each payment is for one ride

2. **RIDE → FEEDBACK** (1:1 optional)
   - Each ride can have one feedback (optional)
   - Each feedback is for one ride

### Optional Relationships:
1. **RIDE → LOYALTY_TRANSACTION** (1:0..1)
   - A ride may generate a loyalty transaction
   - A loyalty transaction may be associated with a ride

## Cardinality Notations

- Customer ||--o{ Ride : "books"
- Driver ||--o{ Ride : "completes"
- Vehicle ||--o{ Ride : "used_for"
- Ride ||--|| Payment : "has"
- Ride ||--o| Feedback : "receives"
- Vehicle ||--o{ Maintenance : "undergoes"
- Vehicle ||--o{ FuelRecord : "consumes"
- Customer ||--o{ Feedback : "submits"
- Driver ||--o{ Feedback : "receives"
- Customer ||--o{ LoyaltyTransaction : "earns/uses"
- City ||--o{ DriverAvailability : "has"
- Driver ||--o{ DriverAvailability : "scheduled_for"
- Ride ||--o| LoyaltyTransaction : "generates"

## Design Considerations

1. **No Many-to-Many Relationships**: All M:N relationships have been resolved using junction tables
   - DRIVER_AVAILABILITY serves as junction between DRIVER and CITY for availability scheduling

2. **Referential Integrity**: All foreign keys enforce referential integrity

3. **Data Integrity**: Appropriate constraints ensure data quality (UNIQUE, NOT NULL, CHECK)

4. **Scalability**: Design supports 200,000+ users and 2,000+ vehicles

5. **Audit Trail**: Timestamp fields track important events

## ERD Diagram

The complete ERD can be created using tools like:
- Draw.io (https://draw.io)
- Lucidchart (https://lucidchart.com)
- ERDPlus (https://erdplus.com)
- Visual Paradigm
- MySQL Workbench

### Recommended Layout:
```
[CITY]
   |
   | 1:N
   v
[DRIVER_AVAILABILITY]
   ^
   | N:1
   |
[DRIVER] ----1:N----> [RIDE] <----N:1---- [CUSTOMER]
   ^                     |                      |
   |                     |                      |
   | 1:N                 | N:1                  | 1:N
   |                     v                      v
   |                  [VEHICLE]          [LOYALTY_TRANSACTION]
[FEEDBACK]              |
   ^                    | 1:N
   | 1:1                v
   |              [MAINTENANCE]
[RIDE]                  
   |                 [VEHICLE]
   | 1:1                |
   v                    | 1:N
[PAYMENT]               v
                  [FUEL_RECORD]
```

## Notes
- All entities are in 3rd Normal Form (3NF)
- Primary keys are single-attribute surrogate keys
- Foreign keys maintain referential integrity
- Appropriate indexes should be created on foreign keys for performance
