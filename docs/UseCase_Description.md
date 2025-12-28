# USE CASE Diagram - STFMS
## Q3: USE CASE Diagram (5 Marks)

## Overview
This document describes the USE CASE diagram for the SuperRides Transportation & Fleet Management System (STFMS), showing interactions between actors and system functionalities.

## Actors

### 1. Customer
**Description**: End-users who book and use rides through the SuperRides platform.

**Responsibilities**:
- Register and manage account
- Book rides
- Track ride status
- Make payments
- Provide feedback and ratings
- View ride history
- Check loyalty points

### 2. Driver
**Description**: Professional drivers who provide transportation services using SuperRides platform.

**Responsibilities**:
- Register and manage profile
- View assigned rides
- Accept/decline ride requests
- Update ride status
- Navigate to locations
- Complete rides
- View earnings and performance

### 3. System Administrator
**Description**: Staff members who manage the overall system operations and maintenance.

**Responsibilities**:
- Manage users (customers and drivers)
- Manage vehicle fleet
- Monitor system performance
- Generate reports
- Handle disputes
- Manage maintenance schedules
- Configure system settings
- Approve driver applications

### 4. System (Automated Actor)
**Description**: The STFMS itself acting autonomously to perform automated tasks.

**Responsibilities**:
- Automatically assign drivers to rides
- Process payments automatically
- Send notifications
- Schedule maintenance
- Award loyalty points
- Generate automated reports

## Use Cases

### Customer Use Cases

#### UC1: Register Account
**Actor**: Customer
**Description**: New customer creates an account on the platform.
**Preconditions**: Customer has valid email and phone number.
**Flow**:
1. Customer provides personal information
2. System validates information
3. System creates account
4. System sends confirmation

#### UC2: Book Ride
**Actor**: Customer
**Description**: Customer books a ride from pickup to dropoff location.
**Preconditions**: Customer is logged in and has active account.
**Flow**:
1. Customer enters pickup and dropoff locations
2. System calculates fare estimate
3. Customer selects ride type
4. Customer confirms booking
5. System creates ride request
**Extends**: Calculate Fare, Assign Driver

#### UC3: Track Ride
**Actor**: Customer
**Description**: Customer monitors real-time status of booked ride.
**Preconditions**: Customer has active ride booking.
**Flow**:
1. Customer opens ride tracking interface
2. System displays current ride status
3. System shows estimated arrival time
4. System updates location in real-time

#### UC4: Make Payment
**Actor**: Customer
**Description**: Customer pays for completed ride.
**Preconditions**: Ride is completed.
**Flow**:
1. System displays fare amount
2. Customer selects payment method
3. System processes payment
4. System generates receipt
**Includes**: Process Payment Transaction

#### UC5: Submit Feedback
**Actor**: Customer
**Description**: Customer provides rating and comments for completed ride.
**Preconditions**: Ride is completed and paid.
**Flow**:
1. Customer rates driver (1-5 stars)
2. Customer optionally adds comments
3. System records feedback
4. System updates driver rating
**Extends**: Update Driver Rating

#### UC6: View Ride History
**Actor**: Customer
**Description**: Customer views past rides and transaction history.
**Preconditions**: Customer is logged in.
**Flow**:
1. Customer accesses ride history
2. System displays list of past rides
3. Customer can view ride details
4. Customer can download receipts

#### UC7: Check Loyalty Points
**Actor**: Customer
**Description**: Customer views current and expiring loyalty points.
**Preconditions**: Customer is logged in.
**Flow**:
1. Customer accesses loyalty points section
2. System displays total active points
3. System shows points expiring soon
4. System shows redemption options

### Driver Use Cases

#### UC8: Register as Driver
**Actor**: Driver
**Description**: New driver applies to join SuperRides platform.
**Preconditions**: Driver has valid driving license and vehicle.
**Flow**:
1. Driver submits application with documents
2. System validates license information
3. Admin reviews application
4. System approves and creates driver account

#### UC9: View Assigned Rides
**Actor**: Driver
**Description**: Driver views rides assigned to them.
**Preconditions**: Driver is logged in and available.
**Flow**:
1. Driver opens dashboard
2. System displays assigned rides
3. Driver can view ride details
4. Driver can navigate to pickup location

#### UC10: Accept/Decline Ride
**Actor**: Driver
**Description**: Driver responds to ride assignment.
**Preconditions**: Ride is assigned to driver.
**Flow**:
1. System notifies driver of new ride
2. Driver views ride details
3. Driver accepts or declines
4. System updates ride status

#### UC11: Start Ride
**Actor**: Driver
**Description**: Driver indicates ride has started.
**Preconditions**: Driver has arrived at pickup location.
**Flow**:
1. Driver confirms customer pickup
2. Driver marks ride as in progress
3. System records pickup time
4. System updates driver status to "On Ride"

#### UC12: Complete Ride
**Actor**: Driver
**Description**: Driver indicates ride is completed.
**Preconditions**: Ride is in progress.
**Flow**:
1. Driver arrives at dropoff location
2. Driver enters actual distance and fare
3. System marks ride as completed
4. System updates driver status to "Available"
**Includes**: Process Payment, Award Loyalty Points

#### UC13: View Performance
**Actor**: Driver
**Description**: Driver views performance metrics and earnings.
**Preconditions**: Driver is logged in.
**Flow**:
1. Driver accesses performance dashboard
2. System displays total rides, earnings, rating
3. Driver can view detailed reports
4. Driver can filter by date range

### System Administrator Use Cases

#### UC14: Manage Users
**Actor**: System Administrator
**Description**: Admin manages customer and driver accounts.
**Preconditions**: Admin is logged in with appropriate permissions.
**Flow**:
1. Admin searches for user
2. Admin views user details
3. Admin can suspend/activate accounts
4. System updates user status

#### UC15: Manage Vehicle Fleet
**Actor**: System Administrator
**Description**: Admin manages vehicle information and assignments.
**Preconditions**: Admin is logged in.
**Flow**:
1. Admin adds/updates vehicle information
2. Admin assigns vehicles to cities
3. Admin monitors vehicle status
4. Admin schedules maintenance

#### UC16: Generate Reports
**Actor**: System Administrator
**Description**: Admin generates business intelligence reports.
**Preconditions**: Admin is logged in.
**Flow**:
1. Admin selects report type
2. Admin specifies parameters (date range, city, etc.)
3. System generates report
4. Admin can export or print report

#### UC17: Handle Disputes
**Actor**: System Administrator
**Description**: Admin resolves customer complaints and disputes.
**Preconditions**: Dispute has been raised.
**Flow**:
1. Admin reviews dispute details
2. Admin investigates ride history
3. Admin makes decision
4. System processes refund if applicable

#### UC18: Schedule Maintenance
**Actor**: System Administrator
**Description**: Admin schedules and tracks vehicle maintenance.
**Preconditions**: Admin is logged in.
**Flow**:
1. Admin views vehicles due for maintenance
2. Admin schedules maintenance appointment
3. System updates vehicle status
4. System notifies relevant parties

### Automated System Use Cases

#### UC19: Assign Driver
**Actor**: System
**Description**: System automatically assigns available driver to ride request.
**Preconditions**: Ride is in pending status.
**Flow**:
1. System receives ride request
2. System finds available drivers in same city
3. System selects driver based on rating and proximity
4. System assigns driver and vehicle
5. System notifies driver

#### UC20: Process Payment
**Actor**: System
**Description**: System processes payment transaction.
**Preconditions**: Ride is completed.
**Flow**:
1. System calculates final fare
2. System charges customer payment method
3. System records transaction
4. System generates receipt
**Includes**: Generate Receipt

#### UC21: Send Notifications
**Actor**: System
**Description**: System sends automated notifications to users.
**Flow**:
1. System detects trigger event
2. System determines recipients
3. System generates notification message
4. System sends via email/SMS

#### UC22: Award Loyalty Points
**Actor**: System
**Description**: System automatically awards points on ride completion.
**Preconditions**: Ride is completed and paid.
**Flow**:
1. System calculates points based on fare
2. System creates loyalty points record
3. System sets expiry date (12 months)
4. System updates customer total

#### UC23: Auto-Schedule Maintenance
**Actor**: System
**Description**: System automatically schedules maintenance after 20,000 km.
**Preconditions**: Vehicle has driven 20,000 km since last maintenance.
**Flow**:
1. System detects vehicle mileage threshold
2. System creates maintenance record
3. System updates vehicle status
4. System notifies admin

#### UC24: Notify Expiring Points
**Actor**: System
**Description**: System notifies customers of points expiring within 7 days.
**Flow**:
1. System checks loyalty points daily
2. System identifies points expiring in 7 days
3. System generates notification for each customer
4. System sends notifications

## Use Case Relationships

### Include Relationships
- **Book Ride** includes **Calculate Fare**
- **Make Payment** includes **Process Payment Transaction**
- **Complete Ride** includes **Process Payment**
- **Complete Ride** includes **Award Loyalty Points**
- **Process Payment** includes **Generate Receipt**

### Extend Relationships
- **Book Ride** extends **Assign Driver**
- **Submit Feedback** extends **Update Driver Rating**
- **Cancel Ride** extends **Process Refund**

### Generalization Relationships
- **Register Account** is generalized from:
  - Register Customer Account
  - Register Driver Account
- **View Dashboard** is generalized from:
  - Customer Dashboard
  - Driver Dashboard
  - Admin Dashboard

## System Boundaries

The STFMS system boundary includes:
- User authentication and authorization
- Ride booking and management
- Payment processing
- Feedback and rating system
- Loyalty points management
- Vehicle and maintenance tracking
- Reporting and analytics

External systems (outside boundary):
- Payment gateway providers
- SMS/Email notification services
- GPS and mapping services
- Government license verification systems

## Use Case Priorities

### High Priority (Core Functionality)
- Register Account
- Book Ride
- Assign Driver
- Complete Ride
- Process Payment
- Submit Feedback

### Medium Priority (Enhanced Experience)
- Track Ride
- View Ride History
- Check Loyalty Points
- View Performance
- Generate Reports

### Low Priority (Administrative)
- Handle Disputes
- Manage Users
- Configure System Settings

## Non-Functional Requirements

### Performance
- Ride assignment within 30 seconds
- Payment processing within 5 seconds
- Real-time ride tracking updates every 10 seconds

### Security
- Encrypted payment information
- Secure authentication
- Role-based access control
- Audit trail for all transactions

### Usability
- Mobile-responsive interface
- Maximum 3 clicks to book a ride
- Clear status indicators
- Accessibility compliance

### Reliability
- 99.9% system uptime
- Automatic failover for critical components
- Data backup every 6 hours
- Disaster recovery plan

## Use Case Diagram Notation

The USE CASE diagram uses standard UML notation:
- **Ovals**: Use cases
- **Stick Figures**: Actors
- **Lines**: Associations between actors and use cases
- **Dashed Arrows with <<include>>**: Include relationships
- **Dashed Arrows with <<extend>>**: Extend relationships
- **Solid Arrows**: Generalization relationships
- **Rectangle**: System boundary
