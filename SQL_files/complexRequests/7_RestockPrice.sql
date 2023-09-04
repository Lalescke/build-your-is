use dataetna;

SELECT DISTINCT r.restockID, (p.price - (c.pricePerDay * DATEDIFF(t.endingDate,t.startingDate))) as Price
FROM restock r, payment p, trip t, car c
WHERE r.tripID = p.tripID 
AND p.tripID = t.tripID
AND t.tripID = r.tripID
AND c.carID = t.carID;