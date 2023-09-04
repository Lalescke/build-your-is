use dataetna;

SELECT SQRT(POW(69.1 * (c.lat - T.lat), 2) + POW(69.1 * (T.longi - c.longi) * COS(c.lat / 57.3), 2)) AS distance, T.truckID
FROM trip t, car c, truck T
WHERE t.tripID = 7 
AND t.carID = c.carID
AND T.carAvailability > 0
ORDER BY distance ASC limit 1;