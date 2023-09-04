use dataetna;

-- A variabiliser : customerID ligne 10
SELECT car.carID, 
car.carModel, 
car.seatsNumber, 
car.parkingID, 
SQRT(POW(69.1 * (car.lat - customer.lat), 2) + POW(69.1 * (customer.longi - car.longi) * COS(car.lat / 57.3), 2)) AS distance
FROM car, customer 
WHERE customer.customerID = 3 AND car.parkingID 
ORDER BY distance limit 10;