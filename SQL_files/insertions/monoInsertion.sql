use dataetna

-- INSERT INTO customer (customerName, IDCard, drivingLicenceID, customerAdress, code, city, lat, longi, email, password, created_at) VALUES ("Roger Bourdon", 123456, 123456, "157 Avenue Tristan le Duc, Bat A apt 404", 75014, "Paris", 48.81415, 2.39247, "roger.bourdon@gmail.com", "motdepasse123", "2022-04-19");

-- INSERT INTO parking (parkingName, lotNumberTotal, lotNumberFree, lat, longi, city) VALUES ("Indigo Balma", 5, 3, 43.63871, 1.47487, "Toulouse");

-- INSERT INTO truck (lat, longi, carCapacity, carAvailability) VALUES (43.78457, 7.49270, 4, 4);

-- INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Tesla", 5, 28, "electric", 75, 50, 48.85410, 2.33240, 1);

-- INSERT INTO trip (customerID, carID, startingParkingID, endingParkingID, startingDate, endingDate) VALUES (1, 4, 3, 12, "2022-11-19", "2022-11-30");

-- INSERT INTO payment (price, paymentOption, tripID) VALUES (750, "CB", 1);

-- INSERT INTO restock (restockDate, pickUpParkingID, depositParkingID, truckID, tripID) VALUES ("2022-11-17", 2, 7, 3, 3);
