# ERD Diagram - Visual Representation
## SuperRides Transportation & Fleet Management System

This file provides a text-based representation of the ERD that can be used with diagramming tools like Draw.io, Lucidchart, or ERDPlus.

## Entity-Relationship Diagram Structure

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      STFMS Entity-Relationship Diagram                      │
└─────────────────────────────────────────────────────────────────────────────┘

┌──────────────┐
│    CITY      │
├──────────────┤
│ •city_id PK  │
│  city_name   │
│  region      │
└──────┬───────┘
       │
       │ 1
       │
       │ N (has customers, drivers, vehicles, rides in)
       │
       ├─────────────────────┬─────────────────────┬─────────────────────┐
       │                     │                     │                     │
       │                     │                     │                     │
       │ N                   │ N                   │ N                   │ N
┌──────┴───────┐      ┌──────┴───────┐      ┌──────┴───────┐      ┌──────┴───────┐
│   CUSTOMER   │      │    DRIVER    │      │   VEHICLE    │      │     RIDE     │
├──────────────┤      ├──────────────┤      ├──────────────┤      ├──────────────┤
│•customer_id  │      │•driver_id PK │      │•vehicle_id   │      │•ride_id PK   │
│ first_name   │      │ first_name   │      │ vehicle_num  │      │ customer_id FK│
│ last_name    │      │ last_name    │      │ vehicle_type │      │ driver_id FK │
│ email UQ     │      │ email UQ     │      │ make         │      │ vehicle_id FK│
│ phone        │      │ phone        │      │ model        │      │ city_id FK   │
│ reg_date     │      │ license_no UQ│      │ year         │      │ pickup_loc   │
│ city_id FK   │      │ license_exp  │      │ total_km     │      │ dropoff_loc  │
│ status       │      │ joining_date │      │ last_maint_km│      │ booking_time │
└──────┬───────┘      │ status       │      │ status       │      │ pickup_time  │
       │              │ avg_rating   │      │ city_id FK   │      │ dropoff_time │
       │ 1            │ total_rides  │      └──────┬───────┘      │ distance_km  │
       │              │ city_id FK   │             │              │ fare_amount  │
       │              └──────┬───────┘             │              │ status       │
       │                     │                     │              │ ride_type    │
       │ N                   │ 1                   │ 1            └──────┬───────┘
       │                     │                     │                     │
       │              ┌──────┴───────┐      ┌──────┴───────┐            │
       │              │              │      │              │            │
       │              │ N            │ N    │ 1            │ 1          │
┌──────┴───────┐      │        ┌─────┴──────────┐         │      ┌─────┴──────────┐
│ LOYALTYPTS   │      │        │   MAINTENANCE  │         │      │    PAYMENT     │
├──────────────┤      │        ├────────────────┤         │      ├────────────────┤
│•loyalty_id PK│      │        │•maintenance_id │         │      │•payment_id PK  │
│ customer_id  │      │        │ vehicle_id FK  │         │      │ ride_id FK     │
│ points       │      │        │ maint_date     │         │      │ payment_method │
│ earned_date  │      │        │ maint_type     │         │      │ amount         │
│ expiry_date  │      │        │ cost           │         │      │ payment_status │
│ status       │      │        │ description    │         │      │ payment_time   │
└──────────────┘      │        │ km_at_maint    │         │      │ transaction_id │
                      │        │ next_maint_due │         │      └────────────────┘
                      │        │ status         │         │
                      │        └────────────────┘         │
                      │                                   │
                      │ N                                 │ N
                      │                                   │
               ┌──────┴───────┐                           │
               │   FEEDBACK   │                           │
               ├──────────────┤                           │
               │•feedback_id  │◄──────────────────────────┘
               │ ride_id FK UQ│      1 (feedback for)
               │ customer_id  │
               │ driver_id FK │
               │ rating       │
               │ comments     │
               │ feedback_date│
               └──────────────┘

Legend:
  •  = Primary Key
  PK = Primary Key
  FK = Foreign Key
  UQ = Unique constraint
  ◄─ = One-to-One relationship
  ├─ = One-to-Many relationship
  1  = One (mandatory)
  N  = Many
```

## Relationships in Detail

### 1. City ──< Customer (One-to-Many)
- One city has many customers
- Each customer is registered in exactly one city
- FK: Customer.city_id → City.city_id

### 2. City ──< Driver (One-to-Many)
- One city has many drivers
- Each driver is based in exactly one city
- FK: Driver.city_id → City.city_id

### 3. City ──< Vehicle (One-to-Many)
- One city has many vehicles
- Each vehicle is stationed in exactly one city
- FK: Vehicle.city_id → City.city_id

### 4. City ──< Ride (One-to-Many)
- One city has many rides
- Each ride occurs in exactly one city
- FK: Ride.city_id → City.city_id

### 5. Customer ──< Ride (One-to-Many)
- One customer can book many rides
- Each ride is booked by exactly one customer
- FK: Ride.customer_id → Customer.customer_id

### 6. Customer ──< LoyaltyPoints (One-to-Many)
- One customer can have many loyalty point records
- Each loyalty record belongs to exactly one customer
- FK: LoyaltyPoints.customer_id → Customer.customer_id
- CASCADE DELETE

### 7. Customer ──< Feedback (One-to-Many)
- One customer can provide feedback for many rides
- Each feedback is from exactly one customer
- FK: Feedback.customer_id → Customer.customer_id

### 8. Driver ──< Ride (One-to-Many, Optional)
- One driver can complete many rides
- Each completed ride has exactly one driver
- Ride can exist without driver (pending/cancelled)
- FK: Ride.driver_id → Driver.driver_id (nullable)

### 9. Driver ──< Feedback (One-to-Many)
- One driver can receive feedback from many rides
- Each feedback is about exactly one driver
- FK: Feedback.driver_id → Driver.driver_id

### 10. Vehicle ──< Ride (One-to-Many, Optional)
- One vehicle can be used for many rides
- Each completed ride uses exactly one vehicle
- Ride can exist without vehicle (pending/cancelled)
- FK: Ride.vehicle_id → Vehicle.vehicle_id (nullable)

### 11. Vehicle ──< Maintenance (One-to-Many)
- One vehicle has many maintenance records
- Each maintenance record is for exactly one vehicle
- FK: Maintenance.vehicle_id → Vehicle.vehicle_id
- CASCADE DELETE

### 12. Ride ─── Payment (One-to-One)
- Each completed ride has exactly one payment
- Each payment is for exactly one ride
- FK: Payment.ride_id → Ride.ride_id
- CASCADE DELETE

### 13. Ride ─── Feedback (One-to-One, Optional)
- Each completed ride can have at most one feedback
- Each feedback is for exactly one ride
- FK: Feedback.ride_id → Ride.ride_id (UNIQUE)
- CASCADE DELETE

## Cardinality Notation

```
Crow's Foot Notation:
  │    = Exactly one (mandatory)
  ○│   = Zero or one (optional)
  ├─   = One or more (mandatory many)
  ○├─  = Zero or more (optional many)
```

## Entity Details for Diagram Tools

### Draw.io / Lucidchart Instructions

1. **Create Entities** (Rectangles):
   - City
   - Customer
   - LoyaltyPoints
   - Vehicle
   - Driver
   - Ride
   - Payment
   - Feedback
   - Maintenance

2. **Add Attributes** (Ovals or list inside entity):
   - Primary keys: Underline or prefix with •
   - Foreign keys: Indicate with (FK)
   - Unique constraints: Add (UQ)

3. **Draw Relationships** (Diamonds or Lines):
   - Use crow's foot notation
   - Label relationships with verbs
   - Add cardinality (1, N)

4. **Layout Suggestions**:
   - Place City at the top center
   - Place Customer, Driver, Vehicle below City
   - Place Ride in the center
   - Place LoyaltyPoints near Customer
   - Place Maintenance near Vehicle
   - Place Payment and Feedback near Ride

## Alternative Text Representation (Simple)

```
CITY (1) ──has─→ (N) CUSTOMER
CITY (1) ──has─→ (N) DRIVER
CITY (1) ──has─→ (N) VEHICLE
CITY (1) ──has─→ (N) RIDE

CUSTOMER (1) ──books─→ (N) RIDE
CUSTOMER (1) ──earns─→ (N) LOYALTYPOINTS
CUSTOMER (1) ──provides─→ (N) FEEDBACK

DRIVER (1) ──completes─→ (N) RIDE
DRIVER (1) ──receives─→ (N) FEEDBACK

VEHICLE (1) ──used_for─→ (N) RIDE
VEHICLE (1) ──requires─→ (N) MAINTENANCE

RIDE (1) ──has─→ (1) PAYMENT
RIDE (1) ──has─→ (0..1) FEEDBACK
```

## Chen Notation (Alternative)

```
[City] ══<has>══ [Customer]
  1                  N

[City] ══<has>══ [Driver]
  1                  N

[City] ══<has>══ [Vehicle]
  1                  N

[Customer] ══<books>══ [Ride]
     1                   N

[Driver] ══<completes>══ [Ride]
   1                      N

[Vehicle] ══<used_in>══ [Ride]
    1                     N

[Ride] ══<has>══ [Payment]
  1                 1

[Ride] ══<receives>══ [Feedback]
  1                     0..1
```

## Database Diagram Export Format

For automatic diagram generation tools, use this format:

```sql
-- ERDPlus / QuickDBD Format

City
-
city_id INT PK
city_name VARCHAR(50) UNIQUE
region VARCHAR(50)

Customer
-
customer_id INT PK
first_name VARCHAR(50)
last_name VARCHAR(50)
email VARCHAR(100) UNIQUE
phone VARCHAR(20)
registration_date DATE
city_id INT FK >- City.city_id
status VARCHAR(20)

Driver
-
driver_id INT PK
first_name VARCHAR(50)
last_name VARCHAR(50)
email VARCHAR(100) UNIQUE
phone VARCHAR(20)
license_number VARCHAR(30) UNIQUE
license_expiry DATE
joining_date DATE
status VARCHAR(20)
average_rating DECIMAL(3,2)
total_rides INT
city_id INT FK >- City.city_id

Vehicle
-
vehicle_id INT PK
vehicle_number VARCHAR(20) UNIQUE
vehicle_type VARCHAR(30)
make VARCHAR(50)
model VARCHAR(50)
year INT
total_km INT
last_maintenance_km INT
status VARCHAR(20)
city_id INT FK >- City.city_id

Ride
-
ride_id INT PK
customer_id INT FK >- Customer.customer_id
driver_id INT FK >0 Driver.driver_id
vehicle_id INT FK >0 Vehicle.vehicle_id
city_id INT FK >- City.city_id
pickup_location VARCHAR(200)
dropoff_location VARCHAR(200)
booking_time TIMESTAMP
pickup_time TIMESTAMP
dropoff_time TIMESTAMP
distance_km DECIMAL(8,2)
fare_amount DECIMAL(10,2)
status VARCHAR(20)
ride_type VARCHAR(30)

Payment
-
payment_id INT PK
ride_id INT FK - Ride.ride_id
payment_method VARCHAR(30)
amount DECIMAL(10,2)
payment_status VARCHAR(20)
payment_time TIMESTAMP
transaction_id VARCHAR(100) UNIQUE

Feedback
-
feedback_id INT PK
ride_id INT FK - Ride.ride_id
customer_id INT FK >- Customer.customer_id
driver_id INT FK >- Driver.driver_id
rating INT
comments VARCHAR(500)
feedback_date TIMESTAMP

LoyaltyPoints
-
loyalty_id INT PK
customer_id INT FK >- Customer.customer_id
points INT
earned_date DATE
expiry_date DATE
status VARCHAR(20)

Maintenance
-
maintenance_id INT PK
vehicle_id INT FK >- Vehicle.vehicle_id
maintenance_date DATE
maintenance_type VARCHAR(50)
cost DECIMAL(10,2)
description VARCHAR(500)
km_at_maintenance INT
next_maintenance_due INT
status VARCHAR(20)
```

## Color Coding Recommendations

- **City**: Light Blue (#E3F2FD)
- **Customer**: Light Green (#E8F5E9)
- **Driver**: Light Orange (#FFF3E0)
- **Vehicle**: Light Purple (#F3E5F5)
- **Ride**: Light Yellow (#FFFDE7) - Central entity
- **Payment**: Light Cyan (#E0F7FA)
- **Feedback**: Light Pink (#FCE4EC)
- **LoyaltyPoints**: Light Lime (#F9FBE7)
- **Maintenance**: Light Gray (#F5F5F5)
