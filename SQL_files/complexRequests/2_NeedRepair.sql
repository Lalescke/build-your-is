use dataetna;

SELECT * FROM car
WHERE parkingID IS NULL
AND (
    SELECT COUNT(*) AS nb 
    FROM trip 
    WHERE trip.carID = car.carID
    AND NOW() BETWEEN trip.startingDate AND trip.endingDate
    ) = 0; 