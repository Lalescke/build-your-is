use dataetna;

-- Big select to filter by dates, so that one trip with 2 cars from the same points won't be taken into account
SELECT SUM(final.distance) as distance, final.truckID
FROM (SELECT DISTINCT SQRT(POW(69.1 * (p1.lat - p2.lat), 2) + POW(69.1 * (p2.longi - p1.longi) * COS(p1.lat / 57.3), 2)) AS distance, r.truckID, r.restockDate
    FROM (SELECT p.lat, p.longi, r.truckID, p.parkingID, r.tripID
        FROM parking p 
        INNER JOIN restock r ON r.pickUpParkingID = p.parkingID) p1,
        (SELECT p.lat, p.longi, r.truckID, p.parkingID, r.tripID
        FROM parking p 
        INNER JOIN restock r ON r.depositParkingID = p.parkingID) p2,
        restock r
    WHERE r.depositParkingID = p2.parkingID 
    AND r.pickUpParkingID = p1.parkingID 
    AND r.truckID = p1.truckID 
    AND p1.truckID = p2.truckID 
    AND r.truckID = p2.truckID
    AND r.tripID = p1.tripID
    AND r.tripID = p2.tripID) final
GROUP BY final.truckID;



    /*
SELECT SQRT(POW(69.1 * (p1.lat - p2.lat), 2) + POW(69.1 * (p2.longi - p1.longi) * COS(p1.lat / 57.3), 2)) AS distance, r.truckID, r.restockDate
FROM (SELECT p.lat, p.longi, r.truckID, p.parkingID, r.tripID
    FROM parking p 
    INNER JOIN restock r ON r.pickUpParkingID = p.parkingID) p1,
    (SELECT p.lat, p.longi, r.truckID, p.parkingID, r.tripID
    FROM parking p 
    INNER JOIN restock r ON r.depositParkingID = p.parkingID) p2,
    restock r
WHERE r.depositParkingID = p2.parkingID 
AND r.pickUpParkingID = p1.parkingID 
AND r.truckID = p1.truckID 
AND p1.truckID = p2.truckID 
AND r.truckID = p2.truckID
AND r.tripID = p1.tripID
AND r.tripID = p2.tripID;
