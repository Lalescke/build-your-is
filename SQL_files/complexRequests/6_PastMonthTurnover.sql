use dataetna;

SELECT SUM(p.price) AS total 
FROM payment p, trip t 
WHERE t.tripID = p.tripID 
AND t.startingDate > DATE(NOW()-INTERVAL 1 MONTH)