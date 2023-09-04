use dataetna;

SELECT t.carID, SUM(DATEDIFF(t.endingDate,t.startingDate)) AS duration 
FROM trip t 
WHERE t.startingDate > "2022-08-12"
GROUP BY t.carID 
ORDER BY duration DESC
limit 1; 
