-- 1. Retrieve all successful bookings:

SELECT * FROM bookings
WHERE booking_status = 'Success';

view is created-----> SELECT * FROM successfull_bookings;


-- 2. Find the average ride distance for each vehicle type:

 CREATE VIEW ride_distance_for_each_vehicle AS
 SELECT vehicle_type, ROUND(AVG(ride_distance),2) as AVG_RIDE_DISTANCE 
 FROM bookings
 GROUP BY  vehicle_type;

-- 3. Get the total number of cancelled rides by customers

CREATE VIEW cancel_ride_by_customer AS
SELECT canceled_rides_by_customer, COUNT(canceled_rides_by_customer) AS total_canceled
FROM bookings
WHERE canceled_rides_by_customer != 'null'
GROUP BY canceled_rides_by_customer;

-- 4. List the top 5 customers who booked the highest number of rides:

CREATE VIEW top_5_customers AS
SELECT customer_id, COUNT (booking_id) AS total_rides
FROM bookings
GROUP BY customer_id 
ORDER BY total_rides DESC
LIMIT 5;


-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:

CREATE VIEW  cancelled_by_drivers AS
SELECT COUNT(canceled_rides_by_driver) FROM bookings
WHERE canceled_rides_by_driver = 'Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

CREATE VIEW Max_Min_Driver_rating AS
SELECT 
MAX(driver_ratings) AS max_ratings,
MIN(driver_ratings) AS min_ratings,
vehicle_type 
FROM bookings
WHERE vehicle_type = 'Prime Sedan'
GROUP BY vehicle_type;

 -- 7. Retrieve all rides where payment was made using UPI:

CREATE VIEW upi_payment AS
SELECT * FROM bookings
 WHERE payment_method = 'UPI';

-- 8. Find the average customer rating per vehicle type:

SELECT vehicle_type, AVG(CAST(NULLIF(customer_rating, 'null') AS NUMERIC)) AS avg_customer_rating
FROM bookings
GROUP BY vehicle_type;

-- explanations: 

-- NULLIF(customer_rating, 'null'):

-- NULLIF Function: This function takes two arguments and compares them.

-- Behavior: If customer_rating is equal to the string 'null', the function returns NULL. Otherwise, it returns the value of customer_rating.

-- Example:

-- If customer_rating is 'null', the result of NULLIF(customer_rating, 'null') will be NULL.

-- If customer_rating is '5', the result of NULLIF(customer_rating, 'null') will be '5'.

-- CAST(... AS NUMERIC):

-- CAST Function: This function is used to convert a value from one data type to another.

-- Behavior: It converts the result of the NULLIF function to a numeric data type.

-- Example:

-- If the result of NULLIF(customer_rating, 'null') is NULL, CAST(NULLIF(customer_rating, 'null') AS NUMERIC) will remain NULL.

-- If the result of NULLIF(customer_rating, 'null') is '5', CAST(NULLIF(customer_rating, 'null') AS NUMERIC) will convert '5' from a text (character) type to a numeric type (e.g., 5).

-- or, Modify the column "customer_rating" from text to numeric and then perform simple query.


-- 9. Calculate the total booking value of rides completed successfully:

SELECT booking_status,SUM(booking_value) AS total_successful_value 
FROM bookings
WHERE booking_status = 'Success'
GROUP BY booking_status;

-- 10. List all incomplete rides along with the reason:

CREATE VIEW incomplete_rides_reason AS
SELECT incomplete_rides, incomplete_rides_reason FROM bookings
WHERE incomplete_rides = 'Yes' and incomplete_rides_reason != 'null';

 
