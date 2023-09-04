use dataetna

INSERT INTO customer (customerName, IDCard, drivingLicenceID, customerAdress, code, city, lat, longi, email, password, created_at) VALUES ("Roger Bourdon", 123456, 123456, "157 Avenue Tristan le Duc, Bat A apt 404", 75014, "Paris", 48.81415, 2.39247, "roger.bourdon@gmail.com", "motdepasse123", "2022-04-19");
INSERT INTO customer (customerName, IDCard, drivingLicenceID, customerAdress, code, city, lat, longi, email, password, created_at) VALUES ("Roger Frelon", 12345, 12345, "158 Avenue Tristan le Duc, Bat A apt 404", 13000, "Marseille", 43.29496, 5.37399, "roger.frelon@gmail.com", "motdepasse1234", "2022-04-20");
INSERT INTO customer (customerName, IDCard, drivingLicenceID, customerAdress, code, city, lat, longi, email, password, created_at) VALUES ("Roger Abeille", 1234, 1234, "159 Avenue Tristan le Duc, Bat A apt 404", 31000, "Toulouse", 43.59871, 1.44406, "roger.abeille@gmail.com", "motdepasse12345", "2022-04-21");

INSERT INTO parking (parkingName, lotNumberTotal, lotNumberFree, lat, longi, city) VALUES ("Indigo Charenton", 5, 3, 48.81359, 2.35487, "Paris");
INSERT INTO parking (parkingName, lotNumberTotal, lotNumberFree, lat, longi, city) VALUES ("Indigo Balma", 5, 3, 43.63871, 1.47487, "Toulouse");
INSERT INTO parking (parkingName, lotNumberTotal, lotNumberFree, lat, longi, city) VALUES ("Vinci Soyeux", 35, 12, 45.75108, 4.82859, "Lyon");
INSERT INTO parking (parkingName, lotNumberTotal, lotNumberFree, lat, longi, city) VALUES ("Vinci Tron", 35, 12, 43.78457, 7.49270, "Menton");

INSERT INTO truck (lat, longi, carCapacity, carAvailability) VALUES (43.78457, 7.49270, 4, 4);
INSERT INTO truck (lat, longi, carCapacity, carAvailability) VALUES (45.71489, 4.85687, 6, 6);
INSERT INTO truck (lat, longi, carCapacity, carAvailability) VALUES (48.85410, 2.33240, 2, 2);

INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Tesla", 5, 28, "electric", 99, 50, 48.82410, 2.35240, 1);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Tesla", 5, 35, "electric", 84, 50, 46.13482, 3.48548, 2);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Tesla", 5, 35, "electric", 99, 50, 48.81359, 2.35487, 3);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Tesla", 5, 35, "electric", 99, 50, 48.82410, 2.35240, 1);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Audi", 5, 30, "gasoline", 87, 40, 48.88410, 2.41240, 3);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Audi", 5, 30, "gasoline", 46, 40, 48.88410, 2.41240, NULL);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Audi", 5, 30, "gasoline", 75, 40, 48.88410, 2.41240, NULL);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Audi", 5, 50, "gasoline", 99, 40, 43.52871, 1.40250, 3);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Audi", 5, 57, "diesel", 97, 50, 43.57841, 1.41240, 2);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Audi", 5, 57, "diesel", 20, 50, 46.58756, 3.58796, 1);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Audi", 5, 35, "diesel", 57, 50, 43.78457, 7.49270, 3);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Peugeot", 7, 40, "gasoline", 98, 60, 45.71489, 4.85687, 1);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Peugeot", 7, 40, "gasoline", 78, 60, 45.79875, 4.78932, 3);
INSERT INTO car (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) VALUES ("Peugeot", 7, 60, "gasoline", 58, 60, 43.61871, 1.35240, NULL);

INSERT INTO trip (customerID, carID, startingParkingID, endingParkingID, startingDate, endingDate) VALUES (1, 4, 1, 2, "2022-10-09", "2022-10-13");
INSERT INTO trip (customerID, carID, startingParkingID, endingParkingID, startingDate, endingDate) VALUES (2, 8, 4, 2, "2022-12-20", "2022-12-25");
INSERT INTO trip (customerID, carID, startingParkingID, endingParkingID, startingDate, endingDate) VALUES (3, 2, 1, 4, "2022-11-02", "2022-11-08");
INSERT INTO trip (customerID, carID, startingParkingID, endingParkingID, startingDate, endingDate) VALUES (3, 2, 4, 3, "2022-12-18", "2022-12-24");
INSERT INTO trip (customerID, carID, startingParkingID, endingParkingID, startingDate, endingDate) VALUES (1, 7, 1, 4, "2022-11-17", "2022-11-29");

INSERT INTO payment (price, paymentOption, tripID) VALUES (300, "CB", 1);
INSERT INTO payment (price, paymentOption, tripID) VALUES (310, "CB", 2);
INSERT INTO payment (price, paymentOption, tripID) VALUES (300, "Cash", 3);
INSERT INTO payment (price, paymentOption, tripID) VALUES (500, "Cash", 4);
INSERT INTO payment (price, paymentOption, tripID) VALUES (650, "CB", 5);


INSERT INTO restock (restockDate, pickUpParkingID, depositParkingID, truckID, tripID) VALUES ("2022-10-07", 4, 1, 2, 1);
INSERT INTO restock (restockDate, pickUpParkingID, depositParkingID, truckID, tripID) VALUES ("2022-12-17", 2, 4, 3, 2);
INSERT INTO restock (restockDate, pickUpParkingID, depositParkingID, truckID, tripID) VALUES ("2022-12-17", 2, 4, 3, 4);
INSERT INTO restock (restockDate, pickUpParkingID, depositParkingID, truckID, tripID) VALUES ("2022-11-15", 3, 1, 3, 5);
