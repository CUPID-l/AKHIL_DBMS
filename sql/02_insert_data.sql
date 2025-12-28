-- ============================================================================
-- SuperRides Transportation & Fleet Management System (STFMS)
-- SQL Data Population Scripts
-- Database: Oracle SQL
-- Module: CN5000 Database Systems
-- ============================================================================

-- ============================================================================
-- Insert Data into CUSTOMER Table (10+ records)
-- ============================================================================

INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'John Smith', 'john.smith@email.com', '07700900123', '123 Baker Street, London', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 250);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'Emma Wilson', 'emma.wilson@email.com', '07700900124', '45 Oxford Road, Manchester', TO_DATE('2024-02-20', 'YYYY-MM-DD'), 180);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'James Brown', 'james.brown@email.com', '07700900125', '78 High Street, Birmingham', TO_DATE('2024-03-10', 'YYYY-MM-DD'), 320);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'Sophie Taylor', 'sophie.taylor@email.com', '07700900126', '92 Princes Street, Glasgow', TO_DATE('2024-01-25', 'YYYY-MM-DD'), 450);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'Oliver Davies', 'oliver.davies@email.com', '07700900127', '156 King Street, London', TO_DATE('2024-04-05', 'YYYY-MM-DD'), 95);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'Charlotte Evans', 'charlotte.evans@email.com', '07700900128', '234 Queen Street, Manchester', TO_DATE('2024-02-14', 'YYYY-MM-DD'), 210);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'Thomas Anderson', 'thomas.anderson@email.com', '07700900129', '67 Market Street, Birmingham', TO_DATE('2024-05-20', 'YYYY-MM-DD'), 540);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'Amelia Robinson', 'amelia.robinson@email.com', '07700900130', '189 George Street, Glasgow', TO_DATE('2024-03-18', 'YYYY-MM-DD'), 385);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'Harry Mitchell', 'harry.mitchell@email.com', '07700900131', '321 Park Lane, London', TO_DATE('2024-06-12', 'YYYY-MM-DD'), 120);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'Isabella Clark', 'isabella.clark@email.com', '07700900132', '445 Victoria Road, Manchester', TO_DATE('2024-01-30', 'YYYY-MM-DD'), 670);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'George Wright', 'george.wright@email.com', '07700900133', '89 Station Road, Birmingham', TO_DATE('2024-04-22', 'YYYY-MM-DD'), 150);
INSERT INTO CUSTOMER VALUES (customer_seq.NEXTVAL, 'Lily Thompson', 'lily.thompson@email.com', '07700900134', '512 Sauchiehall Street, Glasgow', TO_DATE('2024-05-08', 'YYYY-MM-DD'), 280);

-- ============================================================================
-- Insert Data into DRIVER Table (10+ records)
-- ============================================================================

INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'David Johnson', 'DL12345678', '07800900201', 4.8, 'Available', TO_DATE('2023-06-01', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Sarah Williams', 'DL23456789', '07800900202', 4.9, 'Available', TO_DATE('2023-07-15', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Michael Jones', 'DL34567890', '07800900203', 4.5, 'Busy', TO_DATE('2023-08-20', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Emily Davis', 'DL45678901', '07800900204', 4.7, 'Available', TO_DATE('2023-09-10', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Robert Miller', 'DL56789012', '07800900205', 4.6, 'Available', TO_DATE('2023-05-25', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Jessica Wilson', 'DL67890123', '07800900206', 4.9, 'Offline', TO_DATE('2023-10-12', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Daniel Moore', 'DL78901234', '07800900207', 4.4, 'Available', TO_DATE('2023-11-05', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Laura Taylor', 'DL89012345', '07800900208', 4.8, 'Busy', TO_DATE('2023-04-18', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Christopher Brown', 'DL90123456', '07800900209', 4.7, 'Available', TO_DATE('2024-01-08', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Rachel White', 'DL01234567', '07800900210', 4.5, 'Available', TO_DATE('2024-02-22', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Matthew Harris', 'DL11223344', '07800900211', 4.6, 'Available', TO_DATE('2023-12-15', 'YYYY-MM-DD'));
INSERT INTO DRIVER VALUES (driver_seq.NEXTVAL, 'Hannah Martin', 'DL22334455', '07800900212', 4.9, 'Busy', TO_DATE('2024-03-01', 'YYYY-MM-DD'));

-- ============================================================================
-- Insert Data into CITY Table (4 records)
-- ============================================================================

INSERT INTO CITY VALUES (city_seq.NEXTVAL, 'London', 'South East England', TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO CITY VALUES (city_seq.NEXTVAL, 'Manchester', 'North West England', TO_DATE('2020-06-15', 'YYYY-MM-DD'));
INSERT INTO CITY VALUES (city_seq.NEXTVAL, 'Birmingham', 'West Midlands', TO_DATE('2021-01-20', 'YYYY-MM-DD'));
INSERT INTO CITY VALUES (city_seq.NEXTVAL, 'Glasgow', 'Scotland', TO_DATE('2021-08-10', 'YYYY-MM-DD'));

-- ============================================================================
-- Insert Data into VEHICLE Table (12+ records)
-- ============================================================================

INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'LX20ABC', 'Toyota Prius Hybrid', 2020, 45000, 'Active', TO_DATE('2024-11-15', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'MN21XYZ', 'Honda Civic', 2021, 32000, 'Active', TO_DATE('2024-11-20', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'BM19DEF', 'Nissan Leaf Electric', 2019, 58000, 'Maintenance', TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'GL22GHI', 'Volkswagen Passat', 2022, 18000, 'Active', TO_DATE('2024-12-01', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'LX21JKL', 'Tesla Model 3', 2021, 28000, 'Active', TO_DATE('2024-11-10', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'MN20MNO', 'Ford Focus', 2020, 52000, 'Active', TO_DATE('2024-10-25', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'BM22PQR', 'Hyundai Ioniq', 2022, 15000, 'Active', TO_DATE('2024-12-05', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'GL21STU', 'Kia Optima', 2021, 38000, 'Active', TO_DATE('2024-11-18', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'LX19VWX', 'Skoda Octavia', 2019, 67000, 'Maintenance', TO_DATE('2024-09-20', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'MN22YZA', 'Mazda 3', 2022, 12000, 'Active', TO_DATE('2024-12-10', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'BM20BCD', 'Vauxhall Insignia', 2020, 48000, 'Active', TO_DATE('2024-11-05', 'YYYY-MM-DD'));
INSERT INTO VEHICLE VALUES (vehicle_seq.NEXTVAL, 'GL23EFG', 'Audi A4', 2023, 8000, 'Active', TO_DATE('2024-12-15', 'YYYY-MM-DD'));

-- ============================================================================
-- Insert Data into RIDE Table (20+ records)
-- ============================================================================

INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 1, 1, 1, 'Heathrow Airport', '123 Baker Street, London', TO_TIMESTAMP('2024-12-20 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-20 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 35.50, 18.5, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 2, 2, 2, 'Manchester Airport', '45 Oxford Road, Manchester', TO_TIMESTAMP('2024-12-21 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-21 10:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 22.75, 12.3, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 3, 3, 3, '78 High Street, Birmingham', 'NEC Birmingham', TO_TIMESTAMP('2024-12-22 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-22 14:55:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 28.90, 15.7, 'Corporate');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 4, 4, 4, 'Glasgow Central Station', '92 Princes Street, Glasgow', TO_TIMESTAMP('2024-12-23 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-23 17:05:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 12.50, 5.2, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 5, 5, 5, '156 King Street, London', 'British Museum', TO_TIMESTAMP('2024-12-24 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-24 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 18.25, 8.4, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 6, 6, 6, '234 Queen Street, Manchester', 'Old Trafford Stadium', TO_TIMESTAMP('2024-12-20 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-20 19:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 15.80, 7.1, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 7, 7, 7, '67 Market Street, Birmingham', 'Birmingham Airport', TO_TIMESTAMP('2024-12-21 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-21 06:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 32.40, 16.8, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 8, 8, 8, '189 George Street, Glasgow', 'Glasgow University', TO_TIMESTAMP('2024-12-22 08:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-22 09:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 14.60, 6.3, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 9, 9, 9, '321 Park Lane, London', 'Tower Bridge', TO_TIMESTAMP('2024-12-23 13:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-23 13:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 21.30, 10.5, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 10, 10, 10, '445 Victoria Road, Manchester', 'Trafford Centre', TO_TIMESTAMP('2024-12-24 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 19.75, 9.2, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 1, 1, 1, 'London Eye', 'Covent Garden', TO_TIMESTAMP('2024-12-25 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-25 10:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 11.50, 4.2, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 2, 2, 2, 'MediaCity UK', 'Piccadilly Gardens', TO_TIMESTAMP('2024-12-25 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Cancelled', NULL, NULL, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 3, 3, 11, 'Birmingham New Street', 'Bullring Shopping Centre', TO_TIMESTAMP('2024-12-26 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-26 09:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 9.80, 3.8, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 4, 4, 4, 'Kelvingrove Art Gallery', 'Glasgow Science Centre', TO_TIMESTAMP('2024-12-26 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-26 14:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 13.20, 5.9, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 5, 5, 5, 'Hyde Park', 'Westminster Abbey', TO_TIMESTAMP('2024-12-27 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-27 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 16.90, 7.6, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 6, 6, 6, 'Manchester Arena', 'Northern Quarter', TO_TIMESTAMP('2024-12-27 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Cancelled', NULL, NULL, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 7, 7, 7, 'Cadbury World', 'Birmingham City Centre', TO_TIMESTAMP('2024-12-27 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-27 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 24.50, 11.8, 'Delivery');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 8, 8, 8, 'Glasgow Airport', 'City Centre', TO_TIMESTAMP('2024-12-27 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-27 08:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 28.75, 14.2, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 9, 9, 9, 'Oxford Street', 'Kings Cross Station', TO_TIMESTAMP('2024-12-27 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-27 17:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 19.40, 8.9, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 10, 10, 10, 'Etihad Stadium', 'Deansgate', TO_TIMESTAMP('2024-12-27 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-27 18:55:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 14.25, 6.1, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 11, 11, 11, 'Library of Birmingham', 'Aston University', TO_TIMESTAMP('2024-12-27 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Cancelled', NULL, NULL, 'Passenger');
INSERT INTO RIDE VALUES (ride_seq.NEXTVAL, 12, 12, 12, 'Buchanan Street', 'West End', TO_TIMESTAMP('2024-12-27 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-27 12:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 10.90, 4.5, 'Passenger');

-- ============================================================================
-- Insert Data into PAYMENT Table (for completed rides only)
-- ============================================================================

INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 1, 35.50, 'Card', 'Completed', TO_TIMESTAMP('2024-12-20 09:16:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 2, 22.75, 'Wallet', 'Completed', TO_TIMESTAMP('2024-12-21 10:36:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 3, 28.90, 'Card', 'Completed', TO_TIMESTAMP('2024-12-22 14:56:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 4, 12.50, 'Cash', 'Completed', TO_TIMESTAMP('2024-12-23 17:06:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 5, 18.25, 'Card', 'Completed', TO_TIMESTAMP('2024-12-24 12:01:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 6, 15.80, 'Wallet', 'Completed', TO_TIMESTAMP('2024-12-20 19:26:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 7, 32.40, 'Card', 'Completed', TO_TIMESTAMP('2024-12-21 06:51:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 8, 14.60, 'Cash', 'Completed', TO_TIMESTAMP('2024-12-22 09:11:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 9, 21.30, 'Card', 'Completed', TO_TIMESTAMP('2024-12-23 13:51:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 10, 19.75, 'Wallet', 'Completed', TO_TIMESTAMP('2024-12-24 16:01:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 11, 11.50, 'Card', 'Completed', TO_TIMESTAMP('2024-12-25 10:36:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 13, 9.80, 'Cash', 'Completed', TO_TIMESTAMP('2024-12-26 09:51:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 14, 13.20, 'Wallet', 'Completed', TO_TIMESTAMP('2024-12-26 14:26:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 15, 16.90, 'Card', 'Completed', TO_TIMESTAMP('2024-12-27 11:31:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 17, 24.50, 'Card', 'Completed', TO_TIMESTAMP('2024-12-27 16:21:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 18, 28.75, 'Wallet', 'Completed', TO_TIMESTAMP('2024-12-27 08:11:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 19, 19.40, 'Card', 'Completed', TO_TIMESTAMP('2024-12-27 17:36:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 20, 14.25, 'Cash', 'Completed', TO_TIMESTAMP('2024-12-27 18:56:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO PAYMENT VALUES (payment_seq.NEXTVAL, 22, 10.90, 'Wallet', 'Completed', TO_TIMESTAMP('2024-12-27 12:51:00', 'YYYY-MM-DD HH24:MI:SS'));

-- ============================================================================
-- Insert Data into MAINTENANCE Table (15+ records)
-- ============================================================================

INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 1, TO_DATE('2024-11-15', 'YYYY-MM-DD'), 'Routine', 'Regular service: oil change, filter replacement, brake check', 185.00, 45000, 65000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 2, TO_DATE('2024-11-20', 'YYYY-MM-DD'), 'Routine', '20,000 mile service', 220.50, 32000, 52000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 3, TO_DATE('2024-10-05', 'YYYY-MM-DD'), 'Repair', 'Battery replacement and brake pad replacement', 450.75, 58000, 78000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 4, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'Routine', 'Oil and filter change', 120.00, 18000, 38000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 5, TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Routine', 'Tire rotation and alignment', 95.50, 28000, 48000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 6, TO_DATE('2024-10-25', 'YYYY-MM-DD'), 'Repair', 'Transmission fluid replacement', 380.00, 52000, 72000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 7, TO_DATE('2024-12-05', 'YYYY-MM-DD'), 'Routine', 'First service - comprehensive check', 150.00, 15000, 35000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 8, TO_DATE('2024-11-18', 'YYYY-MM-DD'), 'Routine', 'Service and MOT', 240.00, 38000, 58000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 9, TO_DATE('2024-09-20', 'YYYY-MM-DD'), 'Emergency', 'Clutch replacement', 680.00, 67000, 87000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 10, TO_DATE('2024-12-10', 'YYYY-MM-DD'), 'Routine', 'Oil change and safety check', 110.00, 12000, 32000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 11, TO_DATE('2024-11-05', 'YYYY-MM-DD'), 'Routine', 'Major service', 295.00, 48000, 68000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 12, TO_DATE('2024-12-15', 'YYYY-MM-DD'), 'Routine', 'New vehicle first check', 85.00, 8000, 28000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 1, TO_DATE('2024-08-10', 'YYYY-MM-DD'), 'Routine', 'Regular service', 175.00, 25000, 45000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 3, TO_DATE('2024-07-15', 'YYYY-MM-DD'), 'Repair', 'Front suspension repair', 520.00, 38000, 58000);
INSERT INTO MAINTENANCE VALUES (maintenance_seq.NEXTVAL, 6, TO_DATE('2024-06-20', 'YYYY-MM-DD'), 'Routine', 'Annual service', 210.00, 32000, 52000);

-- ============================================================================
-- Insert Data into FEEDBACK Table (15+ records - one per completed ride)
-- ============================================================================

INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 1, 1, 1, 5, 'Excellent driver, very professional and punctual!', TO_DATE('2024-12-20', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 2, 2, 2, 5, 'Great service, smooth ride.', TO_DATE('2024-12-21', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 3, 3, 3, 4, 'Good driver, but traffic made us late.', TO_DATE('2024-12-22', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 4, 4, 4, 5, 'Very friendly and helpful driver.', TO_DATE('2024-12-23', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 5, 5, 5, 4, 'Pleasant journey, clean vehicle.', TO_DATE('2024-12-24', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 6, 6, 6, 5, 'Perfect service! Highly recommend.', TO_DATE('2024-12-20', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 7, 7, 7, 4, 'Good ride, driver was a bit quiet.', TO_DATE('2024-12-21', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 8, 8, 8, 5, 'Amazing driver, made my morning commute enjoyable.', TO_DATE('2024-12-22', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 9, 9, 9, 4, 'Nice experience, vehicle could be cleaner.', TO_DATE('2024-12-23', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 10, 10, 10, 5, 'Outstanding service from start to finish!', TO_DATE('2024-12-24', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 11, 1, 1, 5, 'Another great ride with this driver!', TO_DATE('2024-12-25', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 13, 3, 3, 3, 'Average experience, nothing special.', TO_DATE('2024-12-26', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 14, 4, 4, 5, 'Superb driver, very knowledgeable about the city.', TO_DATE('2024-12-26', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 15, 5, 5, 4, 'Good service, slightly expensive.', TO_DATE('2024-12-27', 'YYYY-MM-DD'));
INSERT INTO FEEDBACK VALUES (feedback_seq.NEXTVAL, 17, 7, 7, 5, 'Delivery was on time and driver was professional.', TO_DATE('2024-12-27', 'YYYY-MM-DD'));

-- ============================================================================
-- Insert Data into FUEL_RECORD Table (15+ records)
-- ============================================================================

INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 1, TO_DATE('2024-12-15', 'YYYY-MM-DD'), 45.20, 63.28, 44850, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 2, TO_DATE('2024-12-18', 'YYYY-MM-DD'), 48.50, 67.90, 31920, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 3, TO_DATE('2024-12-10', 'YYYY-MM-DD'), 52.00, 45.00, 57950, 'Electric');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 4, TO_DATE('2024-12-05', 'YYYY-MM-DD'), 50.30, 70.42, 17890, 'Diesel');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 5, TO_DATE('2024-12-12', 'YYYY-MM-DD'), 55.00, 48.00, 27920, 'Electric');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 6, TO_DATE('2024-12-20', 'YYYY-MM-DD'), 46.80, 65.52, 51840, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 7, TO_DATE('2024-12-08', 'YYYY-MM-DD'), 50.00, 42.50, 14950, 'Electric');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 8, TO_DATE('2024-12-19', 'YYYY-MM-DD'), 47.20, 66.08, 37920, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 9, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 49.00, 68.60, 66850, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 10, TO_DATE('2024-12-14', 'YYYY-MM-DD'), 44.50, 62.30, 11920, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 11, TO_DATE('2024-12-16', 'YYYY-MM-DD'), 48.00, 67.20, 47880, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 12, TO_DATE('2024-12-17', 'YYYY-MM-DD'), 42.00, 58.80, 7950, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 1, TO_DATE('2024-11-28', 'YYYY-MM-DD'), 46.00, 64.40, 44200, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 2, TO_DATE('2024-12-02', 'YYYY-MM-DD'), 47.50, 66.50, 31350, 'Petrol');
INSERT INTO FUEL_RECORD VALUES (fuel_seq.NEXTVAL, 4, TO_DATE('2024-11-20', 'YYYY-MM-DD'), 51.00, 71.40, 17250, 'Diesel');

-- ============================================================================
-- Insert Data into DRIVER_AVAILABILITY Table (20+ records)
-- ============================================================================

INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 1, 1, TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-20 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 2, 2, TO_DATE('2024-12-21', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-21 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-21 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 3, 3, TO_DATE('2024-12-22', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-22 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-22 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 4, 4, TO_DATE('2024-12-23', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-23 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-23 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 5, 1, TO_DATE('2024-12-24', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-24 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-24 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 6, 2, TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-21 02:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 7, 3, TO_DATE('2024-12-21', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-21 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-21 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 8, 4, TO_DATE('2024-12-22', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-22 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-22 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 9, 1, TO_DATE('2024-12-23', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-23 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-23 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 10, 2, TO_DATE('2024-12-24', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-24 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-24 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 11, 3, TO_DATE('2024-12-27', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-27 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-27 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 12, 4, TO_DATE('2024-12-27', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-27 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-27 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 1, 1, TO_DATE('2024-12-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-28 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-28 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 2, 2, TO_DATE('2024-12-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-28 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-28 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 3, 3, TO_DATE('2024-12-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-28 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-28 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 4, 4, TO_DATE('2024-12-29', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-29 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-29 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 5, 1, TO_DATE('2024-12-29', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-29 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-29 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 6, 2, TO_DATE('2024-12-29', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-29 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-30 02:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 7, 3, TO_DATE('2024-12-30', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-30 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-30 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled');
INSERT INTO DRIVER_AVAILABILITY VALUES (availability_seq.NEXTVAL, 8, 4, TO_DATE('2024-12-30', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-30 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-12-30 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled');

-- ============================================================================
-- Insert Data into LOYALTY_TRANSACTION Table (20+ records)
-- ============================================================================

INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 1, 1, 35, 'Earned', TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_DATE('2025-12-20', 'YYYY-MM-DD'), 'Points earned from ride #1');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 2, 2, 22, 'Earned', TO_DATE('2024-12-21', 'YYYY-MM-DD'), TO_DATE('2025-12-21', 'YYYY-MM-DD'), 'Points earned from ride #2');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 3, 3, 28, 'Earned', TO_DATE('2024-12-22', 'YYYY-MM-DD'), TO_DATE('2025-12-22', 'YYYY-MM-DD'), 'Points earned from ride #3');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 4, 4, 12, 'Earned', TO_DATE('2024-12-23', 'YYYY-MM-DD'), TO_DATE('2025-12-23', 'YYYY-MM-DD'), 'Points earned from ride #4');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 5, 5, 18, 'Earned', TO_DATE('2024-12-24', 'YYYY-MM-DD'), TO_DATE('2025-12-24', 'YYYY-MM-DD'), 'Points earned from ride #5');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 6, 6, 15, 'Earned', TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_DATE('2025-12-20', 'YYYY-MM-DD'), 'Points earned from ride #6');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 7, 7, 32, 'Earned', TO_DATE('2024-12-21', 'YYYY-MM-DD'), TO_DATE('2025-12-21', 'YYYY-MM-DD'), 'Points earned from ride #7');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 8, 8, 14, 'Earned', TO_DATE('2024-12-22', 'YYYY-MM-DD'), TO_DATE('2025-12-22', 'YYYY-MM-DD'), 'Points earned from ride #8');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 9, 9, 21, 'Earned', TO_DATE('2024-12-23', 'YYYY-MM-DD'), TO_DATE('2025-12-23', 'YYYY-MM-DD'), 'Points earned from ride #9');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 10, 10, 19, 'Earned', TO_DATE('2024-12-24', 'YYYY-MM-DD'), TO_DATE('2025-12-24', 'YYYY-MM-DD'), 'Points earned from ride #10');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 1, 11, 11, 'Earned', TO_DATE('2024-12-25', 'YYYY-MM-DD'), TO_DATE('2025-12-25', 'YYYY-MM-DD'), 'Points earned from ride #11');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 3, 13, 9, 'Earned', TO_DATE('2024-12-26', 'YYYY-MM-DD'), TO_DATE('2025-12-26', 'YYYY-MM-DD'), 'Points earned from ride #13');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 4, 14, 13, 'Earned', TO_DATE('2024-12-26', 'YYYY-MM-DD'), TO_DATE('2025-12-26', 'YYYY-MM-DD'), 'Points earned from ride #14');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 5, 15, 16, 'Earned', TO_DATE('2024-12-27', 'YYYY-MM-DD'), TO_DATE('2025-12-27', 'YYYY-MM-DD'), 'Points earned from ride #15');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 7, 17, 24, 'Earned', TO_DATE('2024-12-27', 'YYYY-MM-DD'), TO_DATE('2025-12-27', 'YYYY-MM-DD'), 'Points earned from ride #17');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 1, NULL, 100, 'Adjusted', TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Welcome bonus');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 4, NULL, 300, 'Adjusted', TO_DATE('2024-01-25', 'YYYY-MM-DD'), TO_DATE('2025-01-25', 'YYYY-MM-DD'), 'Referral bonus');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 7, NULL, 200, 'Adjusted', TO_DATE('2024-05-20', 'YYYY-MM-DD'), TO_DATE('2025-05-20', 'YYYY-MM-DD'), 'Promotional points');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 10, NULL, 300, 'Adjusted', TO_DATE('2024-01-30', 'YYYY-MM-DD'), TO_DATE('2025-01-30', 'YYYY-MM-DD'), 'First ride bonus');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 6, NULL, -50, 'Redeemed', TO_DATE('2024-11-15', 'YYYY-MM-DD'), NULL, 'Redeemed for discount');
INSERT INTO LOYALTY_TRANSACTION VALUES (loyalty_trans_seq.NEXTVAL, 10, NULL, -150, 'Redeemed', TO_DATE('2024-12-10', 'YYYY-MM-DD'), NULL, 'Redeemed for ride credit');

-- ============================================================================
-- Commit all data
-- ============================================================================

COMMIT;

-- ============================================================================
-- Verification Queries
-- ============================================================================

SELECT 'Data insertion completed successfully!' AS Status FROM DUAL;

-- Display record counts
SELECT 'CUSTOMER' AS TableName, COUNT(*) AS RecordCount FROM CUSTOMER
UNION ALL
SELECT 'DRIVER', COUNT(*) FROM DRIVER
UNION ALL
SELECT 'CITY', COUNT(*) FROM CITY
UNION ALL
SELECT 'VEHICLE', COUNT(*) FROM VEHICLE
UNION ALL
SELECT 'RIDE', COUNT(*) FROM RIDE
UNION ALL
SELECT 'PAYMENT', COUNT(*) FROM PAYMENT
UNION ALL
SELECT 'MAINTENANCE', COUNT(*) FROM MAINTENANCE
UNION ALL
SELECT 'FEEDBACK', COUNT(*) FROM FEEDBACK
UNION ALL
SELECT 'FUEL_RECORD', COUNT(*) FROM FUEL_RECORD
UNION ALL
SELECT 'DRIVER_AVAILABILITY', COUNT(*) FROM DRIVER_AVAILABILITY
UNION ALL
SELECT 'LOYALTY_TRANSACTION', COUNT(*) FROM LOYALTY_TRANSACTION;
