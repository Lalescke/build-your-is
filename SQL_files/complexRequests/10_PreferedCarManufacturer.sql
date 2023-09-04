use dataetna;

SELECT c.carModel, count(c.carModel) AS leaseNumber
FROM car c, trip t 
WHERE c.carID = t.carID
GROUP BY c.carModel
ORDER BY leaseNumber DESC limit 1;