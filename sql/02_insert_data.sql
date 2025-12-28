-- SuperRides Transportation & Fleet Management System (STFMS)
-- Sample Data Population Script
-- Q4: Populate tables with at least 10 rows each

-- ==============================================================================
-- Insert Cities (UK Major Cities)
-- ==============================================================================
INSERT INTO City VALUES (1, 'London', 'Greater London');
INSERT INTO City VALUES (2, 'Manchester', 'North West England');
INSERT INTO City VALUES (3, 'Birmingham', 'West Midlands');
INSERT INTO City VALUES (4, 'Glasgow', 'Scotland');
INSERT INTO City VALUES (5, 'Leeds', 'Yorkshire');
INSERT INTO City VALUES (6, 'Liverpool', 'Merseyside');
INSERT INTO City VALUES (7, 'Newcastle', 'North East England');
INSERT INTO City VALUES (8, 'Bristol', 'South West England');
INSERT INTO City VALUES (9, 'Sheffield', 'South Yorkshire');
INSERT INTO City VALUES (10, 'Edinburgh', 'Scotland');

-- ==============================================================================
-- Insert Customers (at least 10 customers)
-- ==============================================================================
INSERT INTO Customer VALUES (1, 'James', 'Wilson', 'james.wilson@email.com', '07700900001', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 1, 'Active');
INSERT INTO Customer VALUES (2, 'Emma', 'Thompson', 'emma.thompson@email.com', '07700900002', TO_DATE('2024-02-20', 'YYYY-MM-DD'), 1, 'Active');
INSERT INTO Customer VALUES (3, 'Oliver', 'Brown', 'oliver.brown@email.com', '07700900003', TO_DATE('2024-03-10', 'YYYY-MM-DD'), 2, 'Active');
INSERT INTO Customer VALUES (4, 'Sophie', 'Davies', 'sophie.davies@email.com', '07700900004', TO_DATE('2024-04-05', 'YYYY-MM-DD'), 2, 'Active');
INSERT INTO Customer VALUES (5, 'George', 'Evans', 'george.evans@email.com', '07700900005', TO_DATE('2024-05-18', 'YYYY-MM-DD'), 3, 'Active');
INSERT INTO Customer VALUES (6, 'Charlotte', 'Roberts', 'charlotte.roberts@email.com', '07700900006', TO_DATE('2024-06-22', 'YYYY-MM-DD'), 3, 'Active');
INSERT INTO Customer VALUES (7, 'Harry', 'Johnson', 'harry.johnson@email.com', '07700900007', TO_DATE('2024-07-30', 'YYYY-MM-DD'), 4, 'Active');
INSERT INTO Customer VALUES (8, 'Amelia', 'Williams', 'amelia.williams@email.com', '07700900008', TO_DATE('2024-08-14', 'YYYY-MM-DD'), 4, 'Active');
INSERT INTO Customer VALUES (9, 'Jack', 'Jones', 'jack.jones@email.com', '07700900009', TO_DATE('2024-09-25', 'YYYY-MM-DD'), 5, 'Active');
INSERT INTO Customer VALUES (10, 'Olivia', 'Taylor', 'olivia.taylor@email.com', '07700900010', TO_DATE('2024-10-08', 'YYYY-MM-DD'), 1, 'Active');
INSERT INTO Customer VALUES (11, 'Thomas', 'Anderson', 'thomas.anderson@email.com', '07700900011', TO_DATE('2024-11-12', 'YYYY-MM-DD'), 2, 'Active');
INSERT INTO Customer VALUES (12, 'Isabella', 'Martin', 'isabella.martin@email.com', '07700900012', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 1, 'Active');
INSERT INTO Customer VALUES (13, 'William', 'Lee', 'william.lee@email.com', '07700900013', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 3, 'Active');
INSERT INTO Customer VALUES (14, 'Emily', 'White', 'emily.white@email.com', '07700900014', TO_DATE('2023-08-20', 'YYYY-MM-DD'), 2, 'Suspended');
INSERT INTO Customer VALUES (15, 'Michael', 'Harris', 'michael.harris@email.com', '07700900015', TO_DATE('2024-01-05', 'YYYY-MM-DD'), 1, 'Active');

-- ==============================================================================
-- Insert Loyalty Points
-- ==============================================================================
INSERT INTO LoyaltyPoints VALUES (1, 1, 250, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2025-11-01', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (2, 2, 180, TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_DATE('2025-11-15', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (3, 3, 450, TO_DATE('2024-10-20', 'YYYY-MM-DD'), TO_DATE('2025-10-20', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (4, 5, 120, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2025-12-01', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (5, 7, 300, TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2025-11-20', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (6, 10, 90, TO_DATE('2024-12-15', 'YYYY-MM-DD'), TO_DATE('2025-12-15', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (7, 1, 150, TO_DATE('2024-01-10', 'YYYY-MM-DD'), TO_DATE('2025-01-10', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (8, 12, 200, TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_DATE('2025-12-20', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (9, 13, 500, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (10, 15, 175, TO_DATE('2024-12-25', 'YYYY-MM-DD'), TO_DATE('2025-12-25', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (11, 2, 80, TO_DATE('2024-01-05', 'YYYY-MM-DD'), TO_DATE('2025-01-05', 'YYYY-MM-DD'), 'Active');
INSERT INTO LoyaltyPoints VALUES (12, 8, 220, TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_DATE('2025-12-10', 'YYYY-MM-DD'), 'Active');

-- ==============================================================================
-- Insert Vehicles (at least 10 vehicles)
-- ==============================================================================
INSERT INTO Vehicle VALUES (1, 'LN12ABC', 'Sedan', 'Toyota', 'Camry', 2022, 45000, 35000, 'Available', 1);
INSERT INTO Vehicle VALUES (2, 'LN13DEF', 'SUV', 'Honda', 'CR-V', 2023, 28000, 22000, 'Available', 1);
INSERT INTO Vehicle VALUES (3, 'MN14GHI', 'Hatchback', 'Ford', 'Focus', 2021, 52000, 42000, 'Available', 2);
INSERT INTO Vehicle VALUES (4, 'MN15JKL', 'Sedan', 'Hyundai', 'Elantra', 2022, 38000, 28000, 'Available', 2);
INSERT INTO Vehicle VALUES (5, 'BM16MNO', 'SUV', 'Nissan', 'Qashqai', 2023, 21000, 15000, 'Available', 3);
INSERT INTO Vehicle VALUES (6, 'BM17PQR', 'Van', 'Mercedes', 'Sprinter', 2020, 95000, 85000, 'Maintenance', 3);
INSERT INTO Vehicle VALUES (7, 'GL18STU', 'Electric', 'Tesla', 'Model 3', 2024, 12000, 5000, 'Available', 4);
INSERT INTO Vehicle VALUES (8, 'GL19VWX', 'Sedan', 'Volkswagen', 'Passat', 2021, 58000, 48000, 'Available', 4);
INSERT INTO Vehicle VALUES (9, 'LD20YZA', 'SUV', 'Kia', 'Sportage', 2022, 34000, 24000, 'Available', 5);
INSERT INTO Vehicle VALUES (10, 'LN21BCD', 'Hatchback', 'Mazda', 'Mazda3', 2023, 18000, 12000, 'Available', 1);
INSERT INTO Vehicle VALUES (11, 'LN22EFG', 'Sedan', 'Toyota', 'Corolla', 2022, 41000, 31000, 'In Use', 1);
INSERT INTO Vehicle VALUES (12, 'MN23HIJ', 'Electric', 'Nissan', 'Leaf', 2024, 8000, 2000, 'Available', 2);
INSERT INTO Vehicle VALUES (13, 'BM24KLM', 'SUV', 'Ford', 'Kuga', 2023, 25000, 18000, 'Available', 3);
INSERT INTO Vehicle VALUES (14, 'GL25NOP', 'Sedan', 'BMW', '3 Series', 2023, 19000, 12000, 'Available', 4);
INSERT INTO Vehicle VALUES (15, 'LN26QRS', 'Van', 'Ford', 'Transit', 2021, 78000, 68000, 'Available', 1);

-- ==============================================================================
-- Insert Drivers (at least 10 drivers)
-- ==============================================================================
INSERT INTO Driver VALUES (1, 'David', 'Smith', 'david.smith@superrides.com', '07800100001', 'DL12345678', TO_DATE('2027-06-30', 'YYYY-MM-DD'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'Available', 4.85, 342, 1);
INSERT INTO Driver VALUES (2, 'Sarah', 'Johnson', 'sarah.johnson@superrides.com', '07800100002', 'DL23456789', TO_DATE('2026-08-15', 'YYYY-MM-DD'), TO_DATE('2023-03-20', 'YYYY-MM-DD'), 'Available', 4.92, 428, 1);
INSERT INTO Driver VALUES (3, 'Michael', 'Brown', 'michael.brown@superrides.com', '07800100003', 'DL34567890', TO_DATE('2027-12-20', 'YYYY-MM-DD'), TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'Available', 4.65, 298, 2);
INSERT INTO Driver VALUES (4, 'Jessica', 'Davis', 'jessica.davis@superrides.com', '07800100004', 'DL45678901', TO_DATE('2026-09-10', 'YYYY-MM-DD'), TO_DATE('2023-07-05', 'YYYY-MM-DD'), 'Available', 4.78, 315, 2);
INSERT INTO Driver VALUES (5, 'Daniel', 'Wilson', 'daniel.wilson@superrides.com', '07800100005', 'DL56789012', TO_DATE('2027-11-25', 'YYYY-MM-DD'), TO_DATE('2023-08-12', 'YYYY-MM-DD'), 'Available', 4.88, 387, 3);
INSERT INTO Driver VALUES (6, 'Rachel', 'Moore', 'rachel.moore@superrides.com', '07800100006', 'DL67890123', TO_DATE('2026-07-18', 'YYYY-MM-DD'), TO_DATE('2023-09-28', 'YYYY-MM-DD'), 'Available', 4.55, 265, 3);
INSERT INTO Driver VALUES (7, 'Andrew', 'Taylor', 'andrew.taylor@superrides.com', '07800100007', 'DL78901234', TO_DATE('2027-05-30', 'YYYY-MM-DD'), TO_DATE('2023-11-15', 'YYYY-MM-DD'), 'Available', 4.71, 289, 4);
INSERT INTO Driver VALUES (8, 'Laura', 'Anderson', 'laura.anderson@superrides.com', '07800100008', 'DL89012345', TO_DATE('2026-10-22', 'YYYY-MM-DD'), TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Available', 4.82, 245, 4);
INSERT INTO Driver VALUES (9, 'Christopher', 'Thomas', 'chris.thomas@superrides.com', '07800100009', 'DL90123456', TO_DATE('2027-08-14', 'YYYY-MM-DD'), TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Available', 4.67, 198, 5);
INSERT INTO Driver VALUES (10, 'Emma', 'Jackson', 'emma.jackson@superrides.com', '07800100010', 'DL01234567', TO_DATE('2026-12-05', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Available', 4.91, 276, 1);
INSERT INTO Driver VALUES (11, 'Robert', 'White', 'robert.white@superrides.com', '07800100011', 'DL11234568', TO_DATE('2027-03-15', 'YYYY-MM-DD'), TO_DATE('2024-04-22', 'YYYY-MM-DD'), 'Available', 4.58, 156, 2);
INSERT INTO Driver VALUES (12, 'Sophie', 'Martin', 'sophie.martin@superrides.com', '07800100012', 'DL22345679', TO_DATE('2026-11-28', 'YYYY-MM-DD'), TO_DATE('2024-05-18', 'YYYY-MM-DD'), 'Off Duty', 4.73, 189, 3);
INSERT INTO Driver VALUES (13, 'James', 'Lee', 'james.lee@superrides.com', '07800100013', 'DL33456780', TO_DATE('2027-09-10', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 'Available', 4.95, 412, 1);
INSERT INTO Driver VALUES (14, 'Hannah', 'Harris', 'hannah.harris@superrides.com', '07800100014', 'DL44567891', TO_DATE('2026-06-20', 'YYYY-MM-DD'), TO_DATE('2024-08-15', 'YYYY-MM-DD'), 'Available', 4.62, 178, 2);
INSERT INTO Driver VALUES (15, 'Matthew', 'Clark', 'matthew.clark@superrides.com', '07800100015', 'DL55678902', TO_DATE('2027-10-05', 'YYYY-MM-DD'), TO_DATE('2024-09-20', 'YYYY-MM-DD'), 'Available', 4.80, 223, 4);

-- ==============================================================================
-- Insert Rides (at least 10 rides with variety of statuses and dates)
-- ==============================================================================
-- Recent completed rides (last 7 days)
INSERT INTO Ride VALUES (1, 1, 1, 1, 'Heathrow Airport', 'Central London', TIMESTAMP '2024-12-27 09:30:00', TIMESTAMP '2024-12-27 09:45:00', TIMESTAMP '2024-12-27 10:25:00', 24.5, 45.50, 'Completed', 'Standard', 1);
INSERT INTO Ride VALUES (2, 2, 2, 2, 'Kings Cross Station', 'Canary Wharf', TIMESTAMP '2024-12-26 14:20:00', TIMESTAMP '2024-12-26 14:35:00', TIMESTAMP '2024-12-26 15:05:00', 12.3, 28.75, 'Completed', 'Premium', 1);
INSERT INTO Ride VALUES (3, 3, 3, 3, 'Manchester Airport', 'City Centre', TIMESTAMP '2024-12-25 11:15:00', TIMESTAMP '2024-12-25 11:30:00', TIMESTAMP '2024-12-25 12:00:00', 18.7, 35.20, 'Completed', 'Standard', 2);
INSERT INTO Ride VALUES (4, 4, 4, 4, 'Trafford Centre', 'Old Trafford', TIMESTAMP '2024-12-24 16:45:00', TIMESTAMP '2024-12-24 17:00:00', TIMESTAMP '2024-12-24 17:25:00', 8.5, 18.50, 'Completed', 'Shared', 2);
INSERT INTO Ride VALUES (5, 5, 5, 5, 'Birmingham New Street', 'Bull Ring', TIMESTAMP '2024-12-23 10:00:00', TIMESTAMP '2024-12-23 10:10:00', TIMESTAMP '2024-12-23 10:30:00', 5.2, 12.80, 'Completed', 'Standard', 3);

-- Older completed rides
INSERT INTO Ride VALUES (6, 1, 1, 1, 'Westminster', 'London Eye', TIMESTAMP '2024-11-15 18:30:00', TIMESTAMP '2024-11-15 18:40:00', TIMESTAMP '2024-11-15 18:55:00', 3.8, 10.50, 'Completed', 'Standard', 1);
INSERT INTO Ride VALUES (7, 6, 6, 6, 'Birmingham Airport', 'Solihull', TIMESTAMP '2024-11-20 08:00:00', TIMESTAMP '2024-11-20 08:15:00', TIMESTAMP '2024-11-20 08:45:00', 15.3, 32.00, 'Completed', 'Corporate', 3);
INSERT INTO Ride VALUES (8, 7, 7, 7, 'Glasgow Central', 'West End', TIMESTAMP '2024-12-10 12:30:00', TIMESTAMP '2024-12-10 12:45:00', TIMESTAMP '2024-12-10 13:10:00', 7.9, 16.75, 'Completed', 'Standard', 4);
INSERT INTO Ride VALUES (9, 8, 8, 8, 'Buchanan Street', 'Glasgow Airport', TIMESTAMP '2024-12-12 06:00:00', TIMESTAMP '2024-12-12 06:15:00', TIMESTAMP '2024-12-12 06:50:00', 19.2, 38.50, 'Completed', 'Premium', 4);
INSERT INTO Ride VALUES (10, 9, 9, 9, 'Leeds Station', 'Leeds Arena', TIMESTAMP '2024-12-18 20:15:00', TIMESTAMP '2024-12-18 20:25:00', TIMESTAMP '2024-12-18 20:40:00', 4.5, 11.25, 'Completed', 'Standard', 5);

-- In Progress and Assigned rides
INSERT INTO Ride VALUES (11, 10, 10, 10, 'Tower Bridge', 'Oxford Street', TIMESTAMP '2024-12-28 08:00:00', TIMESTAMP '2024-12-28 08:15:00', NULL, NULL, 22.50, 'In Progress', 'Standard', 1);
INSERT INTO Ride VALUES (12, 11, 11, 11, 'Piccadilly Circus', 'Wembley Stadium', TIMESTAMP '2024-12-28 07:30:00', NULL, NULL, NULL, 28.00, 'Assigned', 'Premium', 1);

-- Cancelled rides
INSERT INTO Ride VALUES (13, 2, NULL, NULL, 'Baker Street', 'Camden Town', TIMESTAMP '2024-12-20 15:00:00', NULL, NULL, NULL, 15.00, 'Cancelled', 'Standard', 1);
INSERT INTO Ride VALUES (14, 2, NULL, NULL, 'Covent Garden', 'Shoreditch', TIMESTAMP '2024-12-15 12:30:00', NULL, NULL, NULL, 18.50, 'Cancelled', 'Standard', 1);
INSERT INTO Ride VALUES (15, 2, NULL, NULL, 'Hyde Park', 'Notting Hill', TIMESTAMP '2024-11-28 14:00:00', NULL, NULL, NULL, 12.75, 'Cancelled', 'Standard', 1);
INSERT INTO Ride VALUES (16, 14, NULL, NULL, 'Piccadilly', 'Leicester Square', TIMESTAMP '2024-11-10 16:45:00', NULL, NULL, NULL, 8.50, 'Cancelled', 'Standard', 1);
INSERT INTO Ride VALUES (17, 14, NULL, NULL, 'Bond Street', 'Oxford Circus', TIMESTAMP '2024-10-25 11:20:00', NULL, NULL, NULL, 7.25, 'Cancelled', 'Standard', 1);
INSERT INTO Ride VALUES (18, 14, NULL, NULL, 'Victoria Station', 'Paddington', TIMESTAMP '2024-10-18 09:30:00', NULL, NULL, NULL, 14.00, 'Cancelled', 'Standard', 1);

-- More recent completed rides for queries
INSERT INTO Ride VALUES (19, 12, 13, 13, 'Euston Station', 'St Pancras', TIMESTAMP '2024-12-27 17:00:00', TIMESTAMP '2024-12-27 17:10:00', TIMESTAMP '2024-12-27 17:25:00', 2.8, 9.50, 'Completed', 'Standard', 1);
INSERT INTO Ride VALUES (20, 13, 2, 2, 'Marble Arch', 'Greenwich', TIMESTAMP '2024-12-26 10:30:00', TIMESTAMP '2024-12-26 10:45:00', TIMESTAMP '2024-12-26 11:30:00', 16.4, 32.80, 'Completed', 'Standard', 1);
INSERT INTO Ride VALUES (21, 15, 5, 5, 'Broad Street', 'Digbeth', TIMESTAMP '2024-12-27 13:15:00', TIMESTAMP '2024-12-27 13:25:00', TIMESTAMP '2024-12-27 13:45:00', 6.7, 14.90, 'Completed', 'Standard', 3);
INSERT INTO Ride VALUES (22, 10, 13, 13, 'Stratford', 'London Bridge', TIMESTAMP '2024-12-25 19:00:00', TIMESTAMP '2024-12-25 19:15:00', TIMESTAMP '2024-12-25 19:50:00', 11.8, 25.60, 'Completed', 'Premium', 1);
INSERT INTO Ride VALUES (23, 7, 15, 14, 'Kelvingrove', 'George Square', TIMESTAMP '2024-12-27 14:30:00', TIMESTAMP '2024-12-27 14:40:00', TIMESTAMP '2024-12-27 14:55:00', 4.2, 10.80, 'Completed', 'Standard', 4);
INSERT INTO Ride VALUES (24, 11, 3, 3, 'Deansgate', 'Northern Quarter', TIMESTAMP '2024-12-26 21:00:00', TIMESTAMP '2024-12-26 21:10:00', TIMESTAMP '2024-12-26 21:25:00', 3.5, 9.75, 'Completed', 'Standard', 2);
INSERT INTO Ride VALUES (25, 1, 2, 2, 'Richmond', 'Wimbledon', TIMESTAMP '2024-12-24 11:30:00', TIMESTAMP '2024-12-24 11:45:00', TIMESTAMP '2024-12-24 12:15:00', 9.3, 20.50, 'Completed', 'Standard', 1);

-- ==============================================================================
-- Insert Payments
-- ==============================================================================
INSERT INTO Payment VALUES (1, 1, 'Card', 45.50, 'Completed', TIMESTAMP '2024-12-27 10:30:00', 'TXN1001');
INSERT INTO Payment VALUES (2, 2, 'Digital Wallet', 28.75, 'Completed', TIMESTAMP '2024-12-26 15:10:00', 'TXN1002');
INSERT INTO Payment VALUES (3, 3, 'Card', 35.20, 'Completed', TIMESTAMP '2024-12-25 12:05:00', 'TXN1003');
INSERT INTO Payment VALUES (4, 4, 'Cash', 18.50, 'Completed', TIMESTAMP '2024-12-24 17:30:00', 'TXN1004');
INSERT INTO Payment VALUES (5, 5, 'Card', 12.80, 'Completed', TIMESTAMP '2024-12-23 10:35:00', 'TXN1005');
INSERT INTO Payment VALUES (6, 6, 'Digital Wallet', 10.50, 'Completed', TIMESTAMP '2024-11-15 19:00:00', 'TXN1006');
INSERT INTO Payment VALUES (7, 7, 'Corporate Account', 32.00, 'Completed', TIMESTAMP '2024-11-20 08:50:00', 'TXN1007');
INSERT INTO Payment VALUES (8, 8, 'Card', 16.75, 'Completed', TIMESTAMP '2024-12-10 13:15:00', 'TXN1008');
INSERT INTO Payment VALUES (9, 9, 'Card', 38.50, 'Completed', TIMESTAMP '2024-12-12 07:00:00', 'TXN1009');
INSERT INTO Payment VALUES (10, 10, 'Cash', 11.25, 'Completed', TIMESTAMP '2024-12-18 20:45:00', 'TXN1010');
INSERT INTO Payment VALUES (11, 19, 'Card', 9.50, 'Completed', TIMESTAMP '2024-12-27 17:30:00', 'TXN1011');
INSERT INTO Payment VALUES (12, 20, 'Digital Wallet', 32.80, 'Completed', TIMESTAMP '2024-12-26 11:35:00', 'TXN1012');
INSERT INTO Payment VALUES (13, 21, 'Card', 14.90, 'Completed', TIMESTAMP '2024-12-27 13:50:00', 'TXN1013');
INSERT INTO Payment VALUES (14, 22, 'Card', 25.60, 'Completed', TIMESTAMP '2024-12-25 20:00:00', 'TXN1014');
INSERT INTO Payment VALUES (15, 23, 'Cash', 10.80, 'Completed', TIMESTAMP '2024-12-27 15:00:00', 'TXN1015');
INSERT INTO Payment VALUES (16, 24, 'Digital Wallet', 9.75, 'Completed', TIMESTAMP '2024-12-26 21:30:00', 'TXN1016');
INSERT INTO Payment VALUES (17, 25, 'Card', 20.50, 'Completed', TIMESTAMP '2024-12-24 12:20:00', 'TXN1017');

-- ==============================================================================
-- Insert Feedback
-- ==============================================================================
INSERT INTO Feedback VALUES (1, 1, 1, 1, 5, 'Excellent service, very professional driver', TIMESTAMP '2024-12-27 10:30:00');
INSERT INTO Feedback VALUES (2, 2, 2, 2, 5, 'Great experience, highly recommend', TIMESTAMP '2024-12-26 15:15:00');
INSERT INTO Feedback VALUES (3, 3, 3, 3, 4, 'Good service, on time', TIMESTAMP '2024-12-25 12:10:00');
INSERT INTO Feedback VALUES (4, 4, 4, 4, 5, 'Very friendly and helpful', TIMESTAMP '2024-12-24 17:35:00');
INSERT INTO Feedback VALUES (5, 5, 5, 5, 5, 'Clean vehicle, smooth ride', TIMESTAMP '2024-12-23 10:40:00');
INSERT INTO Feedback VALUES (6, 6, 1, 1, 4, 'Reliable service', TIMESTAMP '2024-11-15 19:05:00');
INSERT INTO Feedback VALUES (7, 7, 6, 6, 4, 'Professional driver', TIMESTAMP '2024-11-20 08:55:00');
INSERT INTO Feedback VALUES (8, 8, 7, 7, 5, 'Excellent journey', TIMESTAMP '2024-12-10 13:20:00');
INSERT INTO Feedback VALUES (9, 9, 8, 8, 5, 'Very punctual and courteous', TIMESTAMP '2024-12-12 07:05:00');
INSERT INTO Feedback VALUES (10, 10, 9, 9, 4, 'Good experience overall', TIMESTAMP '2024-12-18 20:50:00');
INSERT INTO Feedback VALUES (11, 19, 12, 13, 5, 'Outstanding service!', TIMESTAMP '2024-12-27 17:35:00');
INSERT INTO Feedback VALUES (12, 20, 13, 2, 5, 'Perfect ride', TIMESTAMP '2024-12-26 11:40:00');
INSERT INTO Feedback VALUES (13, 21, 15, 5, 5, 'Highly professional', TIMESTAMP '2024-12-27 13:55:00');
INSERT INTO Feedback VALUES (14, 22, 10, 13, 5, 'Exceptional driver', TIMESTAMP '2024-12-25 20:05:00');
INSERT INTO Feedback VALUES (15, 23, 7, 15, 5, 'Great service', TIMESTAMP '2024-12-27 15:05:00');

-- ==============================================================================
-- Insert Maintenance Records
-- ==============================================================================
INSERT INTO Maintenance VALUES (1, 1, TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'Routine Service', 250.00, 'Oil change and tire rotation', 35000, 55000, 'Completed');
INSERT INTO Maintenance VALUES (2, 2, TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'Routine Service', 280.00, 'Full service inspection', 22000, 42000, 'Completed');
INSERT INTO Maintenance VALUES (3, 3, TO_DATE('2024-09-20', 'YYYY-MM-DD'), 'Routine Service', 320.00, 'Major service', 42000, 62000, 'Completed');
INSERT INTO Maintenance VALUES (4, 4, TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Routine Service', 240.00, 'Oil change and filter replacement', 28000, 48000, 'Completed');
INSERT INTO Maintenance VALUES (5, 5, TO_DATE('2024-12-05', 'YYYY-MM-DD'), 'Routine Service', 290.00, 'Brake inspection and service', 15000, 35000, 'Completed');
INSERT INTO Maintenance VALUES (6, 6, TO_DATE('2024-12-20', 'YYYY-MM-DD'), 'Repair', 1200.00, 'Transmission repair', 85000, 105000, 'In Progress');
INSERT INTO Maintenance VALUES (7, 7, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'Routine Service', 180.00, 'Battery check and software update', 5000, 25000, 'Completed');
INSERT INTO Maintenance VALUES (8, 8, TO_DATE('2024-10-25', 'YYYY-MM-DD'), 'Routine Service', 310.00, 'Full service', 48000, 68000, 'Completed');
INSERT INTO Maintenance VALUES (9, 9, TO_DATE('2024-11-18', 'YYYY-MM-DD'), 'Routine Service', 260.00, 'Service and inspection', 24000, 44000, 'Completed');
INSERT INTO Maintenance VALUES (10, 10, TO_DATE('2024-12-10', 'YYYY-MM-DD'), 'Routine Service', 220.00, 'Minor service', 12000, 32000, 'Completed');
INSERT INTO Maintenance VALUES (11, 11, TO_DATE('2024-10-30', 'YYYY-MM-DD'), 'Routine Service', 270.00, 'Full service and tire check', 31000, 51000, 'Completed');
INSERT INTO Maintenance VALUES (12, 1, TO_DATE('2024-12-15', 'YYYY-MM-DD'), 'Fuel', 65.00, 'Fuel refill', 45000, NULL, 'Completed');
INSERT INTO Maintenance VALUES (13, 2, TO_DATE('2024-12-16', 'YYYY-MM-DD'), 'Fuel', 58.00, 'Fuel refill', 28000, NULL, 'Completed');
INSERT INTO Maintenance VALUES (14, 3, TO_DATE('2024-12-17', 'YYYY-MM-DD'), 'Fuel', 62.00, 'Fuel refill', 52000, NULL, 'Completed');
INSERT INTO Maintenance VALUES (15, 5, TO_DATE('2024-12-18', 'YYYY-MM-DD'), 'Fuel', 55.00, 'Fuel refill', 21000, NULL, 'Completed');
INSERT INTO Maintenance VALUES (16, 8, TO_DATE('2024-12-19', 'YYYY-MM-DD'), 'Fuel', 70.00, 'Fuel refill', 58000, NULL, 'Completed');
INSERT INTO Maintenance VALUES (17, 13, TO_DATE('2024-12-20', 'YYYY-MM-DD'), 'Fuel', 60.00, 'Fuel refill', 25000, NULL, 'Completed');
INSERT INTO Maintenance VALUES (18, 15, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Routine Service', 350.00, 'Annual major service', 68000, 88000, 'Completed');
INSERT INTO Maintenance VALUES (19, 4, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 'Fuel', 54.00, 'Fuel refill', 38000, NULL, 'Completed');
INSERT INTO Maintenance VALUES (20, 9, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Fuel', 59.00, 'Fuel refill', 34000, NULL, 'Completed');

-- Commit all changes
COMMIT;

-- Display summary
SELECT 'Data population completed successfully!' AS Status FROM DUAL;
SELECT 'Cities: ' || COUNT(*) AS Summary FROM City
UNION ALL
SELECT 'Customers: ' || COUNT(*) FROM Customer
UNION ALL
SELECT 'Drivers: ' || COUNT(*) FROM Driver
UNION ALL
SELECT 'Vehicles: ' || COUNT(*) FROM Vehicle
UNION ALL
SELECT 'Rides: ' || COUNT(*) FROM Ride
UNION ALL
SELECT 'Payments: ' || COUNT(*) FROM Payment
UNION ALL
SELECT 'Feedback: ' || COUNT(*) FROM Feedback
UNION ALL
SELECT 'Maintenance: ' || COUNT(*) FROM Maintenance
UNION ALL
SELECT 'Loyalty Points: ' || COUNT(*) FROM LoyaltyPoints;
