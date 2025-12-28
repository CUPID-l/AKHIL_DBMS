# Normalized Relational Model - SuperRides STFMS

## Third Normal Form (3NF) Table Schemas

### Normalization Overview
All tables have been normalized to Third Normal Form (3NF) ensuring:
- **1NF**: No repeating groups, atomic values only
- **2NF**: No partial dependencies (all non-key attributes fully dependent on primary key)
- **3NF**: No transitive dependencies (all non-key attributes depend only on primary key)

---

## Table Schemas

### 1. CUSTOMER
```
CUSTOMER(
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Phone VARCHAR2(20) UNIQUE NOT NULL,
    Address VARCHAR2(200),
    RegistrationDate DATE NOT NULL,
    LoyaltyPoints NUMBER DEFAULT 0
)
```

**Primary Key**: CustomerID  
**Unique Constraints**: Email, Phone  
**Default Values**: LoyaltyPoints = 0  
**Check Constraints**: LoyaltyPoints >= 0

---

### 2. DRIVER
```
DRIVER(
    DriverID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    LicenseNumber VARCHAR2(50) UNIQUE NOT NULL,
    Phone VARCHAR2(20) UNIQUE NOT NULL,
    Rating NUMBER(3,2) DEFAULT 5.0,
    Status VARCHAR2(20) DEFAULT 'Available',
    JoinDate DATE NOT NULL
)
```

**Primary Key**: DriverID  
**Unique Constraints**: LicenseNumber, Phone  
**Default Values**: Rating = 5.0, Status = 'Available'  
**Check Constraints**: 
- Rating BETWEEN 0 AND 5
- Status IN ('Available', 'Busy', 'Offline')

---

### 3. CITY
```
CITY(
    CityID NUMBER PRIMARY KEY,
    CityName VARCHAR2(50) UNIQUE NOT NULL,
    Region VARCHAR2(50),
    OperationsStartDate DATE NOT NULL
)
```

**Primary Key**: CityID  
**Unique Constraints**: CityName  
**Check Constraints**: CityName IN ('London', 'Manchester', 'Birmingham', 'Glasgow')

---

### 4. VEHICLE
```
VEHICLE(
    VehicleID NUMBER PRIMARY KEY,
    RegistrationType VARCHAR2(20) UNIQUE NOT NULL,
    Model VARCHAR2(50) NOT NULL,
    Year NUMBER(4) NOT NULL,
    Mileage NUMBER DEFAULT 0,
    Status VARCHAR2(20) DEFAULT 'Active',
    LastMaintenanceDate DATE
)
```

**Primary Key**: VehicleID  
**Unique Constraints**: RegistrationType  
**Default Values**: Mileage = 0, Status = 'Active'  
**Check Constraints**: 
- Year BETWEEN 2015 AND 2025
- Status IN ('Active', 'Maintenance', 'Retired')
- Mileage >= 0

---

### 5. RIDE
```
RIDE(
    RideID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    DriverID NUMBER NOT NULL,
    VehicleID NUMBER NOT NULL,
    PickupLocation VARCHAR2(200) NOT NULL,
    DropoffLocation VARCHAR2(200) NOT NULL,
    PickupDateTime TIMESTAMP NOT NULL,
    DropoffDateTime TIMESTAMP,
    Status VARCHAR2(20) DEFAULT 'Requested',
    Fare NUMBER(10,2),
    Distance NUMBER(10,2),
    RideType VARCHAR2(20) DEFAULT 'Passenger',
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (DriverID) REFERENCES DRIVER(DriverID),
    FOREIGN KEY (VehicleID) REFERENCES VEHICLE(VehicleID)
)
```

**Primary Key**: RideID  
**Foreign Keys**: 
- CustomerID → CUSTOMER(CustomerID)
- DriverID → DRIVER(DriverID)
- VehicleID → VEHICLE(VehicleID)

**Check Constraints**: 
- Status IN ('Requested', 'InProgress', 'Completed', 'Cancelled')
- RideType IN ('Passenger', 'Corporate', 'Delivery')
- Fare >= 0
- Distance >= 0
- DropoffDateTime > PickupDateTime (when not null)

---

### 6. PAYMENT
```
PAYMENT(
    PaymentID NUMBER PRIMARY KEY,
    RideID NUMBER UNIQUE NOT NULL,
    Amount NUMBER(10,2) NOT NULL,
    PaymentMethod VARCHAR2(20) NOT NULL,
    PaymentStatus VARCHAR2(20) DEFAULT 'Pending',
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RideID) REFERENCES RIDE(RideID)
)
```

**Primary Key**: PaymentID  
**Foreign Keys**: RideID → RIDE(RideID)  
**Unique Constraints**: RideID (1:1 relationship with RIDE)  
**Check Constraints**: 
- Amount > 0
- PaymentMethod IN ('Cash', 'Card', 'Wallet')
- PaymentStatus IN ('Pending', 'Completed', 'Failed')

---

### 7. MAINTENANCE
```
MAINTENANCE(
    MaintenanceID NUMBER PRIMARY KEY,
    VehicleID NUMBER NOT NULL,
    MaintenanceDate DATE NOT NULL,
    MaintenanceType VARCHAR2(50) NOT NULL,
    Description VARCHAR2(500),
    Cost NUMBER(10,2) NOT NULL,
    MileageAtService NUMBER NOT NULL,
    NextMaintenanceDue NUMBER,
    FOREIGN KEY (VehicleID) REFERENCES VEHICLE(VehicleID)
)
```

**Primary Key**: MaintenanceID  
**Foreign Keys**: VehicleID → VEHICLE(VehicleID)  
**Check Constraints**: 
- MaintenanceType IN ('Routine', 'Repair', 'Emergency')
- Cost >= 0
- MileageAtService >= 0
- NextMaintenanceDue > MileageAtService (when not null)

---

### 8. FEEDBACK
```
FEEDBACK(
    FeedbackID NUMBER PRIMARY KEY,
    RideID NUMBER UNIQUE NOT NULL,
    CustomerID NUMBER NOT NULL,
    DriverID NUMBER NOT NULL,
    Rating NUMBER(1) NOT NULL,
    Comments VARCHAR2(1000),
    FeedbackDate DATE DEFAULT SYSDATE,
    FOREIGN KEY (RideID) REFERENCES RIDE(RideID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (DriverID) REFERENCES DRIVER(DriverID)
)
```

**Primary Key**: FeedbackID  
**Foreign Keys**: 
- RideID → RIDE(RideID)
- CustomerID → CUSTOMER(CustomerID)
- DriverID → DRIVER(DriverID)

**Unique Constraints**: RideID (one feedback per ride)  
**Check Constraints**: Rating BETWEEN 1 AND 5

---

### 9. FUEL_RECORD
```
FUEL_RECORD(
    FuelID NUMBER PRIMARY KEY,
    VehicleID NUMBER NOT NULL,
    FuelDate DATE NOT NULL,
    LitersAdded NUMBER(10,2) NOT NULL,
    Cost NUMBER(10,2) NOT NULL,
    MileageAtFill NUMBER NOT NULL,
    FuelType VARCHAR2(20) NOT NULL,
    FOREIGN KEY (VehicleID) REFERENCES VEHICLE(VehicleID)
)
```

**Primary Key**: FuelID  
**Foreign Keys**: VehicleID → VEHICLE(VehicleID)  
**Check Constraints**: 
- LitersAdded > 0
- Cost > 0
- MileageAtFill >= 0
- FuelType IN ('Petrol', 'Diesel', 'Electric')

---

### 10. DRIVER_AVAILABILITY
```
DRIVER_AVAILABILITY(
    AvailabilityID NUMBER PRIMARY KEY,
    DriverID NUMBER NOT NULL,
    CityID NUMBER NOT NULL,
    ShiftDate DATE NOT NULL,
    ShiftStartTime TIMESTAMP NOT NULL,
    ShiftEndTime TIMESTAMP NOT NULL,
    Status VARCHAR2(20) DEFAULT 'Scheduled',
    FOREIGN KEY (DriverID) REFERENCES DRIVER(DriverID),
    FOREIGN KEY (CityID) REFERENCES CITY(CityID)
)
```

**Primary Key**: AvailabilityID  
**Foreign Keys**: 
- DriverID → DRIVER(DriverID)
- CityID → CITY(CityID)

**Check Constraints**: 
- Status IN ('Scheduled', 'Active', 'Completed')
- ShiftEndTime > ShiftStartTime

---

### 11. LOYALTY_TRANSACTION
```
LOYALTY_TRANSACTION(
    TransactionID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    RideID NUMBER,
    PointsChange NUMBER NOT NULL,
    TransactionType VARCHAR2(20) NOT NULL,
    TransactionDate DATE DEFAULT SYSDATE,
    ExpiryDate DATE,
    Description VARCHAR2(200),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (RideID) REFERENCES RIDE(RideID)
)
```

**Primary Key**: TransactionID  
**Foreign Keys**: 
- CustomerID → CUSTOMER(CustomerID)
- RideID → RIDE(RideID) (nullable)

**Check Constraints**: 
- TransactionType IN ('Earned', 'Redeemed', 'Expired', 'Adjusted')
- PointsChange != 0

---

## Integrity Constraints Summary

### Referential Integrity Constraints
All foreign keys enforce referential integrity with CASCADE or RESTRICT rules:
- ON DELETE RESTRICT: Prevents deletion if referenced records exist
- ON DELETE CASCADE: Automatically deletes dependent records (used selectively)

### Domain Constraints
- All primary keys are NOT NULL and UNIQUE
- Email and phone numbers have UNIQUE constraints
- Enumerated fields use CHECK constraints
- Numeric fields have range validations
- Date/time fields ensure logical ordering

### Entity Integrity
- Every table has a single-attribute primary key (surrogate key)
- No null values allowed in primary keys

### Business Rules Enforced
1. LoyaltyPoints cannot be negative
2. Driver ratings must be between 0 and 5
3. Vehicle year must be reasonable (2015-2025)
4. Ride dropoff time must be after pickup time
5. Payment amount must be positive
6. Shift end time must be after start time
7. Feedback rating must be 1-5
8. City names restricted to operational cities

---

## Functional Dependencies

### CUSTOMER
- CustomerID → {Name, Email, Phone, Address, RegistrationDate, LoyaltyPoints}

### DRIVER
- DriverID → {Name, LicenseNumber, Phone, Rating, Status, JoinDate}
- LicenseNumber → {DriverID} (alternate key)

### VEHICLE
- VehicleID → {RegistrationType, Model, Year, Mileage, Status, LastMaintenanceDate}
- RegistrationType → {VehicleID} (alternate key)

### RIDE
- RideID → {CustomerID, DriverID, VehicleID, PickupLocation, DropoffLocation, PickupDateTime, DropoffDateTime, Status, Fare, Distance, RideType}

### PAYMENT
- PaymentID → {RideID, Amount, PaymentMethod, PaymentStatus, Timestamp}
- RideID → {PaymentID} (alternate key for 1:1 relationship)

### MAINTENANCE
- MaintenanceID → {VehicleID, MaintenanceDate, MaintenanceType, Description, Cost, MileageAtService, NextMaintenanceDue}

### FEEDBACK
- FeedbackID → {RideID, CustomerID, DriverID, Rating, Comments, FeedbackDate}
- RideID → {FeedbackID} (alternate key for 1:1 relationship)

### FUEL_RECORD
- FuelID → {VehicleID, FuelDate, LitersAdded, Cost, MileageAtFill, FuelType}

### DRIVER_AVAILABILITY
- AvailabilityID → {DriverID, CityID, ShiftDate, ShiftStartTime, ShiftEndTime, Status}

### LOYALTY_TRANSACTION
- TransactionID → {CustomerID, RideID, PointsChange, TransactionType, TransactionDate, ExpiryDate, Description}

---

## Normalization Verification

### First Normal Form (1NF) ✓
- All attributes contain atomic values
- No repeating groups
- Each table has a primary key

### Second Normal Form (2NF) ✓
- All tables are in 1NF
- All non-key attributes are fully functionally dependent on the primary key
- No partial dependencies (all PKs are single-attribute)

### Third Normal Form (3NF) ✓
- All tables are in 2NF
- No transitive dependencies
- All non-key attributes depend only on the primary key

---

## Index Recommendations

For optimal performance, create indexes on:
1. Foreign key columns (CustomerID, DriverID, VehicleID in RIDE)
2. Frequently queried columns (Status, PickupDateTime in RIDE)
3. Unique constraints (Email, Phone in CUSTOMER)
4. Join columns (RideID in PAYMENT and FEEDBACK)
