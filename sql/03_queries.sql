-- SuperRides Transportation & Fleet Management System (STFMS)
-- Business Intelligence Queries
-- Q5: SQL Queries to Generate Desired Outputs (15 Marks)

-- ==============================================================================
-- Query 1: List all rides completed in the last 7 days (1 mark)
-- Including customer name, driver name, and fare amount
-- ==============================================================================
SELECT 
    r.ride_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    d.first_name || ' ' || d.last_name AS driver_name,
    r.pickup_location,
    r.dropoff_location,
    r.booking_time,
    r.distance_km,
    r.fare_amount,
    r.status
FROM Ride r
JOIN Customer c ON r.customer_id = c.customer_id
JOIN Driver d ON r.driver_id = d.driver_id
WHERE r.status = 'Completed'
  AND r.booking_time >= CURRENT_TIMESTAMP - INTERVAL '7' DAY
ORDER BY r.booking_time DESC;

-- ==============================================================================
-- Query 2: Display all drivers with an average rating above 4.5 (1 mark)
-- ==============================================================================
SELECT 
    driver_id,
    first_name || ' ' || last_name AS driver_name,
    email,
    phone,
    license_number,
    average_rating,
    total_rides,
    status,
    joining_date
FROM Driver
WHERE average_rating > 4.5
ORDER BY average_rating DESC, total_rides DESC;

-- ==============================================================================
-- Query 3: Calculate the total revenue generated from rides per month (2 marks)
-- ==============================================================================
SELECT 
    TO_CHAR(r.booking_time, 'YYYY-MM') AS month,
    TO_CHAR(r.booking_time, 'Month YYYY') AS month_name,
    COUNT(r.ride_id) AS total_rides,
    SUM(r.fare_amount) AS total_revenue,
    AVG(r.fare_amount) AS average_fare,
    MIN(r.fare_amount) AS min_fare,
    MAX(r.fare_amount) AS max_fare
FROM Ride r
WHERE r.status = 'Completed'
GROUP BY TO_CHAR(r.booking_time, 'YYYY-MM'), TO_CHAR(r.booking_time, 'Month YYYY')
ORDER BY TO_CHAR(r.booking_time, 'YYYY-MM') DESC;

-- ==============================================================================
-- Query 4: List the top 5 drivers who completed the most rides in the past month (2 marks)
-- ==============================================================================
SELECT 
    d.driver_id,
    d.first_name || ' ' || d.last_name AS driver_name,
    d.email,
    d.average_rating,
    COUNT(r.ride_id) AS rides_completed,
    SUM(r.fare_amount) AS total_revenue,
    AVG(r.fare_amount) AS avg_fare_per_ride,
    c.city_name
FROM Driver d
JOIN Ride r ON d.driver_id = r.driver_id
JOIN City c ON d.city_id = c.city_id
WHERE r.status = 'Completed'
  AND r.booking_time >= ADD_MONTHS(CURRENT_TIMESTAMP, -1)
GROUP BY d.driver_id, d.first_name, d.last_name, d.email, d.average_rating, c.city_name
ORDER BY rides_completed DESC, total_revenue DESC
FETCH FIRST 5 ROWS ONLY;

-- ==============================================================================
-- Query 5: Show customers who cancelled more than 3 rides in the last 60 days (2 marks)
-- ==============================================================================
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    c.phone,
    c.status AS customer_status,
    COUNT(r.ride_id) AS cancelled_rides,
    MIN(r.booking_time) AS first_cancellation,
    MAX(r.booking_time) AS last_cancellation,
    ci.city_name
FROM Customer c
JOIN Ride r ON c.customer_id = r.customer_id
JOIN City ci ON c.city_id = ci.city_id
WHERE r.status = 'Cancelled'
  AND r.booking_time >= CURRENT_TIMESTAMP - INTERVAL '60' DAY
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.phone, c.status, ci.city_name
HAVING COUNT(r.ride_id) > 3
ORDER BY cancelled_rides DESC;

-- ==============================================================================
-- Query 6: Find vehicles that have gone more than 10,000 km since last maintenance (2 marks)
-- ==============================================================================
SELECT 
    v.vehicle_id,
    v.vehicle_number,
    v.vehicle_type,
    v.make || ' ' || v.model AS vehicle_model,
    v.year,
    v.total_km,
    v.last_maintenance_km,
    (v.total_km - v.last_maintenance_km) AS km_since_maintenance,
    v.status,
    c.city_name
FROM Vehicle v
JOIN City c ON v.city_id = c.city_id
WHERE (v.total_km - v.last_maintenance_km) > 10000
ORDER BY (v.total_km - v.last_maintenance_km) DESC;

-- ==============================================================================
-- Query 7: Calculate the total cost of maintenance and fuel per vehicle in current year (2 marks)
-- ==============================================================================
SELECT 
    v.vehicle_id,
    v.vehicle_number,
    v.make || ' ' || v.model AS vehicle_model,
    v.vehicle_type,
    SUM(CASE WHEN m.maintenance_type = 'Fuel' THEN m.cost ELSE 0 END) AS total_fuel_cost,
    SUM(CASE WHEN m.maintenance_type != 'Fuel' THEN m.cost ELSE 0 END) AS total_maintenance_cost,
    SUM(m.cost) AS total_cost,
    COUNT(CASE WHEN m.maintenance_type != 'Fuel' THEN 1 END) AS maintenance_count,
    COUNT(CASE WHEN m.maintenance_type = 'Fuel' THEN 1 END) AS fuel_count,
    c.city_name
FROM Vehicle v
JOIN Maintenance m ON v.vehicle_id = m.vehicle_id
JOIN City c ON v.city_id = c.city_id
WHERE EXTRACT(YEAR FROM m.maintenance_date) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY v.vehicle_id, v.vehicle_number, v.make, v.model, v.vehicle_type, c.city_name
ORDER BY total_cost DESC;

-- ==============================================================================
-- Query 8: Display each driver's performance summary (3 marks)
-- Including total rides, average fare, and average rating
-- ==============================================================================
SELECT 
    d.driver_id,
    d.first_name || ' ' || d.last_name AS driver_name,
    d.email,
    d.license_number,
    d.joining_date,
    d.status,
    -- Ride statistics
    COUNT(r.ride_id) AS total_rides_completed,
    COALESCE(AVG(r.fare_amount), 0) AS average_fare,
    COALESCE(SUM(r.fare_amount), 0) AS total_revenue,
    COALESCE(SUM(r.distance_km), 0) AS total_distance_km,
    -- Rating statistics
    d.average_rating,
    COUNT(f.feedback_id) AS total_feedback_count,
    COALESCE(AVG(f.rating), 0) AS calculated_avg_rating,
    -- Performance metrics
    ROUND(COUNT(r.ride_id) / 
        GREATEST(MONTHS_BETWEEN(SYSDATE, d.joining_date), 1), 2) AS avg_rides_per_month,
    CASE 
        WHEN d.average_rating >= 4.8 THEN 'Excellent'
        WHEN d.average_rating >= 4.5 THEN 'Very Good'
        WHEN d.average_rating >= 4.0 THEN 'Good'
        WHEN d.average_rating >= 3.5 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_category,
    -- City information
    ci.city_name,
    ci.region
FROM Driver d
LEFT JOIN Ride r ON d.driver_id = r.driver_id AND r.status = 'Completed'
LEFT JOIN Feedback f ON d.driver_id = f.driver_id
JOIN City ci ON d.city_id = ci.city_id
GROUP BY 
    d.driver_id, 
    d.first_name, 
    d.last_name, 
    d.email, 
    d.license_number,
    d.joining_date,
    d.status,
    d.average_rating,
    d.total_rides,
    ci.city_name,
    ci.region
ORDER BY total_rides_completed DESC, average_fare DESC;

-- ==============================================================================
-- Additional Analytical Queries (Bonus queries for deeper insights)
-- ==============================================================================

-- Query 9: Monthly ride trends by city
SELECT 
    c.city_name,
    TO_CHAR(r.booking_time, 'YYYY-MM') AS month,
    COUNT(r.ride_id) AS total_rides,
    SUM(r.fare_amount) AS revenue,
    AVG(r.fare_amount) AS avg_fare
FROM Ride r
JOIN City c ON r.city_id = c.city_id
WHERE r.status = 'Completed'
GROUP BY c.city_name, TO_CHAR(r.booking_time, 'YYYY-MM')
ORDER BY c.city_name, month DESC;

-- Query 10: Customer loyalty analysis
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(CASE WHEN r.status = 'Completed' THEN 1 END) AS completed_rides,
    COUNT(CASE WHEN r.status = 'Cancelled' THEN 1 END) AS cancelled_rides,
    SUM(CASE WHEN r.status = 'Completed' THEN r.fare_amount ELSE 0 END) AS total_spent,
    COALESCE(SUM(lp.points), 0) AS total_loyalty_points,
    ci.city_name
FROM Customer c
LEFT JOIN Ride r ON c.customer_id = r.customer_id
LEFT JOIN LoyaltyPoints lp ON c.customer_id = lp.customer_id AND lp.status = 'Active'
JOIN City ci ON c.city_id = ci.city_id
GROUP BY c.customer_id, c.first_name, c.last_name, ci.city_name
HAVING COUNT(CASE WHEN r.status = 'Completed' THEN 1 END) > 0
ORDER BY completed_rides DESC, total_spent DESC;

-- Query 11: Vehicle utilization and efficiency
SELECT 
    v.vehicle_id,
    v.vehicle_number,
    v.make || ' ' || v.model AS vehicle_model,
    v.vehicle_type,
    COUNT(r.ride_id) AS total_rides,
    SUM(r.distance_km) AS total_distance,
    SUM(r.fare_amount) AS total_revenue,
    ROUND(SUM(r.fare_amount) / NULLIF(COUNT(r.ride_id), 0), 2) AS avg_revenue_per_ride,
    v.total_km,
    c.city_name
FROM Vehicle v
LEFT JOIN Ride r ON v.vehicle_id = r.vehicle_id AND r.status = 'Completed'
JOIN City c ON v.city_id = c.city_id
GROUP BY v.vehicle_id, v.vehicle_number, v.make, v.model, v.vehicle_type, v.total_km, c.city_name
ORDER BY total_rides DESC;

-- Query 12: Payment method distribution
SELECT 
    p.payment_method,
    COUNT(*) AS transaction_count,
    SUM(p.amount) AS total_amount,
    AVG(p.amount) AS average_amount,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM Payment p
WHERE p.payment_status = 'Completed'
GROUP BY p.payment_method
ORDER BY total_amount DESC;
