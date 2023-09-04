use dataetna;

-- It will be considered that customers pay at the starting date, while receiving the car.
SELECT SUM(p.price) AS total 
FROM payment p, trip t 
WHERE t.customerID = 2  
AND t.tripID = p.tripID 
AND t.startingDate > DATE(NOW()-INTERVAL 1 MONTH)