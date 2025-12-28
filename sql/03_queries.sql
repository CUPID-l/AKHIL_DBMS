-- ============================================================================
-- SuperRides Transportation & Fleet Management System (STFMS)
-- SQL Queries - Task 5 (15 Marks)
-- Database: Oracle SQL
-- Module: CN5000 Database Systems
-- ============================================================================

-- ============================================================================
-- Query 1: List all rides completed in last 7 days (1 mark)
-- Shows customer name, driver name, and fare
-- ============================================================================

SELECT 
    C.Name AS CustomerName,
    D.Name AS DriverName,
    R.PickupLocation,
    R.DropoffLocation,
    R.PickupDateTime,
    R.DropoffDateTime,
    R.Fare
FROM RIDE R
JOIN CUSTOMER C ON R.CustomerID = C.CustomerID
JOIN DRIVER D ON R.DriverID = D.DriverID
WHERE R.Status = 'Completed'
  AND R.PickupDateTime >= SYSTIMESTAMP - INTERVAL '7' DAY
ORDER BY R.PickupDateTime DESC;

COMMENT ON TABLE RIDE IS 'Query 1: Lists completed rides from the last 7 days with customer and driver details';

-- ============================================================================
-- Query 2: Display drivers with average rating > 4.5 (1 mark)
-- Shows driver details and their current rating
-- ============================================================================

SELECT 
    DriverID,
    Name AS DriverName,
    LicenseNumber,
    Phone,
    Rating,
    Status,
    JoinDate,
    (SELECT COUNT(*) FROM RIDE WHERE DriverID = D.DriverID AND Status = 'Completed') AS TotalRidesCompleted
FROM DRIVER D
WHERE Rating > 4.5
ORDER BY Rating DESC, Name;

COMMENT ON TABLE DRIVER IS 'Query 2: Lists all drivers with rating greater than 4.5';

-- ============================================================================
-- Query 3: Calculate total revenue per month (2 marks)
-- Shows monthly revenue breakdown for the current year
-- ============================================================================

SELECT 
    TO_CHAR(P.Timestamp, 'YYYY') AS Year,
    TO_CHAR(P.Timestamp, 'MM') AS Month,
    TO_CHAR(P.Timestamp, 'Month') AS MonthName,
    COUNT(P.PaymentID) AS TotalTransactions,
    SUM(P.Amount) AS TotalRevenue,
    AVG(P.Amount) AS AverageTransactionValue,
    MIN(P.Amount) AS MinimumFare,
    MAX(P.Amount) AS MaximumFare
FROM PAYMENT P
WHERE P.PaymentStatus = 'Completed'
  AND EXTRACT(YEAR FROM P.Timestamp) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY TO_CHAR(P.Timestamp, 'YYYY'), TO_CHAR(P.Timestamp, 'MM'), TO_CHAR(P.Timestamp, 'Month')
ORDER BY TO_CHAR(P.Timestamp, 'YYYY'), TO_CHAR(P.Timestamp, 'MM');

-- Alternative: Revenue per month for all time
SELECT 
    TO_CHAR(P.Timestamp, 'YYYY-MM') AS YearMonth,
    TO_CHAR(P.Timestamp, 'Month YYYY') AS MonthYear,
    COUNT(P.PaymentID) AS TotalTransactions,
    SUM(P.Amount) AS TotalRevenue,
    ROUND(AVG(P.Amount), 2) AS AvgTransactionValue
FROM PAYMENT P
WHERE P.PaymentStatus = 'Completed'
GROUP BY TO_CHAR(P.Timestamp, 'YYYY-MM'), TO_CHAR(P.Timestamp, 'Month YYYY')
ORDER BY TO_CHAR(P.Timestamp, 'YYYY-MM');

-- ============================================================================
-- Query 4: Top 5 drivers by rides completed in past month (2 marks)
-- Shows driver performance ranking
-- ============================================================================

SELECT * FROM (
    SELECT 
        D.DriverID,
        D.Name AS DriverName,
        D.Rating,
        D.Status,
        COUNT(R.RideID) AS RidesCompleted,
        SUM(R.Fare) AS TotalRevenue,
        ROUND(AVG(R.Fare), 2) AS AverageFare,
        ROUND(AVG(R.Distance), 2) AS AverageDistance
    FROM DRIVER D
    JOIN RIDE R ON D.DriverID = R.DriverID
    WHERE R.Status = 'Completed'
      AND R.PickupDateTime >= ADD_MONTHS(SYSDATE, -1)
    GROUP BY D.DriverID, D.Name, D.Rating, D.Status
    ORDER BY COUNT(R.RideID) DESC, SUM(R.Fare) DESC
)
WHERE ROWNUM <= 5;

-- ============================================================================
-- Query 5: Customers who cancelled more than 3 rides in last 60 days (2 marks)
-- Identifies customers with poor booking behavior
-- ============================================================================

SELECT 
    C.CustomerID,
    C.Name AS CustomerName,
    C.Email,
    C.Phone,
    COUNT(R.RideID) AS CancelledRides,
    (SELECT COUNT(*) 
     FROM RIDE 
     WHERE CustomerID = C.CustomerID 
       AND Status = 'Completed' 
       AND PickupDateTime >= SYSDATE - 60) AS CompletedRides,
    C.LoyaltyPoints,
    C.RegistrationDate
FROM CUSTOMER C
JOIN RIDE R ON C.CustomerID = R.CustomerID
WHERE R.Status = 'Cancelled'
  AND R.PickupDateTime >= SYSDATE - 60
GROUP BY C.CustomerID, C.Name, C.Email, C.Phone, C.LoyaltyPoints, C.RegistrationDate
HAVING COUNT(R.RideID) > 3
ORDER BY COUNT(R.RideID) DESC;

-- ============================================================================
-- Query 6: Vehicles with more than 10,000 km since last maintenance (2 marks)
-- Identifies vehicles that need maintenance
-- ============================================================================

SELECT 
    V.VehicleID,
    V.RegistrationType,
    V.Model,
    V.Year,
    V.Mileage AS CurrentMileage,
    V.LastMaintenanceDate,
    V.Status,
    NVL(M.MileageAtService, 0) AS LastMaintenanceMileage,
    (V.Mileage - NVL(M.MileageAtService, 0)) AS KmSinceLastMaintenance
FROM VEHICLE V
LEFT JOIN (
    SELECT 
        VehicleID,
        MAX(MileageAtService) AS MileageAtService
    FROM MAINTENANCE
    GROUP BY VehicleID
) M ON V.VehicleID = M.VehicleID
WHERE (V.Mileage - NVL(M.MileageAtService, 0)) > 10000
ORDER BY (V.Mileage - NVL(M.MileageAtService, 0)) DESC;

-- Alternative query with maintenance details
SELECT 
    V.VehicleID,
    V.RegistrationType,
    V.Model,
    V.Mileage,
    V.LastMaintenanceDate,
    COALESCE(
        (SELECT MAX(MileageAtService) 
         FROM MAINTENANCE 
         WHERE VehicleID = V.VehicleID), 
        0
    ) AS LastServiceMileage,
    V.Mileage - COALESCE(
        (SELECT MAX(MileageAtService) 
         FROM MAINTENANCE 
         WHERE VehicleID = V.VehicleID), 
        0
    ) AS MileageSinceService
FROM VEHICLE V
WHERE V.Mileage - COALESCE(
    (SELECT MAX(MileageAtService) 
     FROM MAINTENANCE 
     WHERE VehicleID = V.VehicleID), 
    0
) > 10000
ORDER BY MileageSinceService DESC;

-- ============================================================================
-- Query 7: Total maintenance and fuel cost per vehicle in current year (2 marks)
-- Shows vehicle operating costs
-- ============================================================================

SELECT 
    V.VehicleID,
    V.RegistrationType,
    V.Model,
    V.Year,
    V.Mileage,
    V.Status,
    COALESCE(SUM(M.Cost), 0) AS TotalMaintenanceCost,
    COALESCE(SUM(F.Cost), 0) AS TotalFuelCost,
    COALESCE(SUM(M.Cost), 0) + COALESCE(SUM(F.Cost), 0) AS TotalOperatingCost,
    COUNT(DISTINCT M.MaintenanceID) AS MaintenanceCount,
    COUNT(DISTINCT F.FuelID) AS FuelRefillCount
FROM VEHICLE V
LEFT JOIN MAINTENANCE M ON V.VehicleID = M.VehicleID 
    AND EXTRACT(YEAR FROM M.MaintenanceDate) = EXTRACT(YEAR FROM SYSDATE)
LEFT JOIN FUEL_RECORD F ON V.VehicleID = F.VehicleID 
    AND EXTRACT(YEAR FROM F.FuelDate) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY V.VehicleID, V.RegistrationType, V.Model, V.Year, V.Mileage, V.Status
ORDER BY TotalOperatingCost DESC;

-- Detailed breakdown version
SELECT 
    V.VehicleID,
    V.RegistrationType,
    V.Model,
    COALESCE(MC.MaintenanceCost, 0) AS MaintenanceCost,
    COALESCE(MC.MaintenanceCount, 0) AS MaintenanceVisits,
    COALESCE(FC.FuelCost, 0) AS FuelCost,
    COALESCE(FC.FuelFillups, 0) AS FuelFillups,
    COALESCE(MC.MaintenanceCost, 0) + COALESCE(FC.FuelCost, 0) AS TotalCost
FROM VEHICLE V
LEFT JOIN (
    SELECT 
        VehicleID,
        SUM(Cost) AS MaintenanceCost,
        COUNT(*) AS MaintenanceCount
    FROM MAINTENANCE
    WHERE EXTRACT(YEAR FROM MaintenanceDate) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY VehicleID
) MC ON V.VehicleID = MC.VehicleID
LEFT JOIN (
    SELECT 
        VehicleID,
        SUM(Cost) AS FuelCost,
        COUNT(*) AS FuelFillups
    FROM FUEL_RECORD
    WHERE EXTRACT(YEAR FROM FuelDate) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY VehicleID
) FC ON V.VehicleID = FC.VehicleID
ORDER BY TotalCost DESC;

-- ============================================================================
-- Query 8: Driver performance summary (3 marks)
-- Comprehensive driver analytics including total rides, average fare, rating
-- ============================================================================

SELECT 
    D.DriverID,
    D.Name AS DriverName,
    D.LicenseNumber,
    D.Phone,
    D.Status,
    D.Rating AS CurrentRating,
    D.JoinDate,
    -- Ride Statistics
    COUNT(R.RideID) AS TotalRides,
    SUM(CASE WHEN R.Status = 'Completed' THEN 1 ELSE 0 END) AS CompletedRides,
    SUM(CASE WHEN R.Status = 'Cancelled' THEN 1 ELSE 0 END) AS CancelledRides,
    -- Financial Performance
    COALESCE(SUM(CASE WHEN R.Status = 'Completed' THEN R.Fare END), 0) AS TotalRevenue,
    COALESCE(ROUND(AVG(CASE WHEN R.Status = 'Completed' THEN R.Fare END), 2), 0) AS AvgFare,
    COALESCE(MAX(CASE WHEN R.Status = 'Completed' THEN R.Fare END), 0) AS MaxFare,
    COALESCE(MIN(CASE WHEN R.Status = 'Completed' THEN R.Fare END), 0) AS MinFare,
    -- Distance Statistics
    COALESCE(ROUND(SUM(CASE WHEN R.Status = 'Completed' THEN R.Distance END), 2), 0) AS TotalDistance,
    COALESCE(ROUND(AVG(CASE WHEN R.Status = 'Completed' THEN R.Distance END), 2), 0) AS AvgDistance,
    -- Customer Feedback
    COALESCE(ROUND(AVG(F.Rating), 2), D.Rating) AS AvgFeedbackRating,
    COUNT(DISTINCT F.FeedbackID) AS FeedbackCount,
    -- Performance Metrics
    ROUND(
        SUM(CASE WHEN R.Status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / 
        NULLIF(COUNT(R.RideID), 0), 
        2
    ) AS CompletionRate,
    -- Time with Company
    ROUND(MONTHS_BETWEEN(SYSDATE, D.JoinDate), 1) AS MonthsWithCompany,
    -- Recent Activity (last 30 days)
    (SELECT COUNT(*) 
     FROM RIDE 
     WHERE DriverID = D.DriverID 
       AND Status = 'Completed' 
       AND PickupDateTime >= SYSDATE - 30) AS RidesLast30Days
FROM DRIVER D
LEFT JOIN RIDE R ON D.DriverID = R.DriverID
LEFT JOIN FEEDBACK F ON D.DriverID = F.DriverID
GROUP BY D.DriverID, D.Name, D.LicenseNumber, D.Phone, D.Status, D.Rating, D.JoinDate
ORDER BY TotalRevenue DESC, CompletedRides DESC;

-- ============================================================================
-- Additional Performance Analysis Query
-- ============================================================================

-- Top Performers Summary
SELECT 
    D.Name AS DriverName,
    D.Rating,
    COUNT(R.RideID) AS RidesCompleted,
    ROUND(AVG(R.Fare), 2) AS AvgFare,
    SUM(R.Fare) AS TotalEarnings,
    ROUND(AVG(F.Rating), 2) AS AvgCustomerRating,
    CASE 
        WHEN D.Rating >= 4.8 AND COUNT(R.RideID) >= 10 THEN 'Excellent'
        WHEN D.Rating >= 4.5 AND COUNT(R.RideID) >= 5 THEN 'Good'
        WHEN D.Rating >= 4.0 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS PerformanceCategory
FROM DRIVER D
LEFT JOIN RIDE R ON D.DriverID = R.DriverID AND R.Status = 'Completed'
LEFT JOIN FEEDBACK F ON D.DriverID = F.DriverID
GROUP BY D.DriverID, D.Name, D.Rating
ORDER BY D.Rating DESC, COUNT(R.RideID) DESC;

-- ============================================================================
-- BONUS QUERIES - Additional Analytics
-- ============================================================================

-- Popular Routes Analysis
SELECT 
    R.PickupLocation,
    R.DropoffLocation,
    COUNT(*) AS TripCount,
    ROUND(AVG(R.Fare), 2) AS AvgFare,
    ROUND(AVG(R.Distance), 2) AS AvgDistance
FROM RIDE R
WHERE R.Status = 'Completed'
GROUP BY R.PickupLocation, R.DropoffLocation
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- Customer Loyalty Analysis
SELECT 
    C.CustomerID,
    C.Name,
    C.LoyaltyPoints,
    COUNT(R.RideID) AS TotalRides,
    SUM(CASE WHEN R.Status = 'Completed' THEN R.Fare ELSE 0 END) AS TotalSpent,
    ROUND(AVG(F.Rating), 2) AS AvgRatingGiven
FROM CUSTOMER C
LEFT JOIN RIDE R ON C.CustomerID = R.CustomerID
LEFT JOIN FEEDBACK F ON C.CustomerID = F.CustomerID
GROUP BY C.CustomerID, C.Name, C.LoyaltyPoints
ORDER BY TotalSpent DESC;

-- Fleet Utilization
SELECT 
    V.VehicleID,
    V.RegistrationType,
    V.Model,
    COUNT(R.RideID) AS TotalRides,
    SUM(R.Distance) AS TotalDistanceCovered,
    ROUND(AVG(R.Fare), 2) AS AvgFarePerRide
FROM VEHICLE V
LEFT JOIN RIDE R ON V.VehicleID = R.VehicleID AND R.Status = 'Completed'
GROUP BY V.VehicleID, V.RegistrationType, V.Model
ORDER BY COUNT(R.RideID) DESC;

-- Payment Method Analysis
SELECT 
    P.PaymentMethod,
    COUNT(*) AS TransactionCount,
    SUM(P.Amount) AS TotalAmount,
    ROUND(AVG(P.Amount), 2) AS AvgAmount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM PAYMENT), 2) AS Percentage
FROM PAYMENT P
WHERE P.PaymentStatus = 'Completed'
GROUP BY P.PaymentMethod
ORDER BY COUNT(*) DESC;

-- ============================================================================
-- END OF QUERY SCRIPTS
-- ============================================================================

COMMENT ON TABLE RIDE IS 'All 8 required queries completed with additional bonus analytics';
