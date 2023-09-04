use dataetna;

SELECT AVG(DATEDIFF(endingDate,startingDate)) AS mean, customerID FROM trip GROUP BY customerID;