from mysql.connector import connect, Error

### Method to send an SQL request  
def sendRequest(req, select):
    print(req)
    try:
        conn = connect(
            host="localhost",
            user="root",
            password="root",
            database="dataetna",
        )
        with conn as connection:
            with connection.cursor() as cursor:
                cursor.execute(req)
                if (select) :
                    for col in cursor.description:
                        print(col[0], end="   ")
                    print("")
                    for db in cursor:
                        print(db) 
                else :
                    conn.commit()
    except Error as e:
        print(e)
        
### Method to insert a row
def insertRow (table, args):
    if table == "car":
        columns = " (carModel, seatsNumber, trunkSize, engineType, energyLevelPerc, pricePerDay, lat, longi, parkingID) "
    elif table == "customer":
        columns = " (customerName, IDCard, drivingLicenceID, customerAdress, code, city, lat, longi, email, password, created_at) "
    elif table == "parking":
        columns = " (parkingName, lotNumberTotal, lotNumberFree, lat, longi, city) "
    elif table == "truck":
        columns = " (lat, longi, carCapacity, carAvailability) "
    elif table == "trip":
        columns = " (customerID, carID, startingParkingID, endingParkingID, startingDate, endingDate) "
    elif table == "payment":
        columns = " (price, paymentOption, tripID) "
    elif table == "restock":
        columns = " (restockDate, pickUpParkingID, depositParkingID, truckID, tripID) "
    req = "INSERT INTO " + table + columns + " VALUES (" + ", ".join(args) + ");"
    sendRequest(req, False)

### Method to drop a row
def dropRow (table, ID):
    arg = table + "ID"  
    req = "DELETE FROM " + table +" WHERE " + arg + " = " + ID + ";"
    sendRequest(req, False)

### Method to update a row
def updateRow (table, columns, values, ID):
    arg = table + "ID"  
    req = "UPDATE " + table + " SET "
    for count in range(0, len(columns)) :
        req += columns[count] + " = " + values[count]
        if count != len(columns)-1:
            req += ", " 
    req += " WHERE " + arg + " = " + ID + ";"   
    sendRequest(req, False)



#########################
### Start of the main ###
#########################

print("Welcome to the interactive script!")
ans = ""
while (ans != "EXIT"):
    ans = input("Do you wish to update a row (U), to delete a row (D), to insert a row (I), to access a complex method (CM) or to acces a Complex Request (CR) ? \nWrite EXIT to leave\n").upper()
    
    if ans == "U":
        table = input("What table do you want to update?\n").lower()
        sendRequest("DESC " + table + ";", True)
        columns = list(input("What columns do you want to update ? format : col1,col2,col3...\n").split(","))
        values = list(input("What new values do you want thes columns to take ? format : val1,val2,val3...\nDates should ba YYYY-MM-DD, do not forget to put double quotes around strings and dates\n").split(","))
        tableID = input("What is the ID of the " + table + " that you want to update?\n")
        updateRow(table, columns, values, tableID)
        
    elif ans == "D":
        table = input("What table do you want to delete from?\n").lower()
        tableID = input("What is the ID of the " + table + " that you want to delete?\n")
        dropRow(table, tableID)
    
    elif ans == "I":
        table = input("What table do you want to insert into?\n").lower()
        sendRequest("DESC " + table + ";", True)
        values = list(input("What are the values of this new " + table + "? Write them in the samer order as above, format: val1,val2,val3...\nDates should ba YYYY-MM-DD, do not forget to put double quotes around strings and dates\n").split(","))
        insertRow(table, values)
    
    elif ans == "CM":
        method = input(("Write the number of your method:\n"
                           "1- New trip\n"))
        
        if method == "1":
            sendRequest("DESC trip;", True)
            values = list(input("What are the values of this new trip? Write them in the samer order as above, format: val1,val2,val3...\nDates should ba YYYY-MM-DD, do not forget to put double quotes around strings and dates\n").split(","))
            insertRow("trip", values)
            
            print("Your tripID is: ")
            sendRequest("SELECT MAX(tripID) FROM trip", True)
            sendRequest("DESC payment;", True)
            values = list(input("Now, what are the values of the associated payment? Write them in the samer order as above, format: val1,val2,val3...\nDates should be YYYY-MM-DD, do not forget to put double quotes around strings and dates\n").split(","))
            insertRow("payment", values)
    
    elif ans == "CR":
        reqNumber = input(("Write the number of your request:\n"
                           "1- 10 closest cars of a given customer\n"
                           "2- Which cars need repair?\n"
                           "3- Total payment for the past month for a given customer\n"
                           "4- Average duration of a trip per customer\n"
                           "5- Total duration for a given trip\n"
                           "6- Turnover for the past month\n"
                           "7- Price of restocks\n"
                           "8- Most rented car since a given date\n"
                           "9- Total distance covered by each truck\n"
                           "10- Prefered car manufacturer among our customers\n"
                           "11- Better truck for a given trip restock\n"))
        
        if reqNumber == "1":
            custID = input("What is the ID of the customer?\n")
            req = ("SELECT car.carID, "
                "car.carModel, " 
                "car.seatsNumber, "
                "car.parkingID, "
                "SQRT(POW(69.1 * (car.lat - customer.lat), 2) + POW(69.1 * (customer.longi - car.longi) * COS(car.lat / 57.3), 2)) AS distance "
                "FROM car, customer "
                "WHERE customer.customerID = "+ custID +" AND car.parkingID " 
                "ORDER BY distance limit 10;")
            sendRequest(req, True)
            
        elif reqNumber == "2":
            req = ("SELECT * FROM car "
                "WHERE parkingID IS NULL "
                "AND ( "
                "    SELECT COUNT(*) AS nb " 
                "   FROM trip "
                "    WHERE trip.carID = car.carID "
                "    AND NOW() BETWEEN trip.startingDate AND trip.endingDate "
                "    ) = 0;" )
            sendRequest(req, True)
            
        elif reqNumber == "3":
            custID = input("What is the ID of the customer?\n")
            req = ("SELECT SUM(p.price) AS total "
                "FROM payment p, trip t "
                "WHERE t.customerID = " + custID + " "
                "AND t.tripID = p.tripID "
                "AND t.startingDate > DATE(NOW()-INTERVAL 1 MONTH)" )
            sendRequest(req, True)
            
        elif reqNumber == "4":
            req = ("SELECT AVG(DATEDIFF(endingDate,startingDate)) AS mean, customerID FROM trip GROUP BY customerID;")
            sendRequest(req, True)
        
        elif reqNumber == "5":
            tripID = input("What tripID do you need?\n")
            req = ("SELECT SUM(DATEDIFF(endingDate,startingDate)) AS mean FROM trip WHERE tripID = " + tripID + ";")
            sendRequest(req, True)
            
        elif reqNumber == "6":
            req = ("SELECT SUM(p.price) AS total "
                "FROM payment p, trip t "
                "WHERE t.tripID = p.tripID "
                "AND t.startingDate > DATE(NOW()-INTERVAL 1 MONTH)")
            sendRequest(req, True)

        elif reqNumber == "7":
            req = ("SELECT DISTINCT r.restockID, (p.price - (c.pricePerDay * DATEDIFF(t.endingDate,t.startingDate))) as Price "
                "FROM restock r, payment p, trip t, car c "
                "WHERE r.tripID = p.tripID "
                "AND p.tripID = t.tripID "
                "AND t.tripID = r.tripID "
                "AND c.carID = t.carID;")
            sendRequest(req, True)
            
        elif reqNumber == "8":
            dateDesired = input("From which date do you want to compare the cars ?\nDates should be YYYY-MM-DD, do not forget to put double quotes around them\n")
            req = ("SELECT t.carID, SUM(DATEDIFF(t.endingDate,t.startingDate)) AS duration "
                "FROM trip t "
                "WHERE t.startingDate > ") + dateDesired + (" GROUP BY t.carID "
                "ORDER BY duration DESC "
                "limit 1;")
            sendRequest(req, True)
            
        elif reqNumber == "9":
            req = ("SELECT SUM(final.distance) as distance, final.truckID "
                "FROM (SELECT DISTINCT SQRT(POW(69.1 * (p1.lat - p2.lat), 2) + POW(69.1 * (p2.longi - p1.longi) * COS(p1.lat / 57.3), 2)) AS distance, r.truckID, r.restockDate "
                "    FROM (SELECT p.lat, p.longi, r.truckID, p.parkingID, r.tripID "
                "        FROM parking p "
                "        INNER JOIN restock r ON r.pickUpParkingID = p.parkingID) p1, "
                "        (SELECT p.lat, p.longi, r.truckID, p.parkingID, r.tripID "
                "        FROM parking p "
                "        INNER JOIN restock r ON r.depositParkingID = p.parkingID) p2, "
                "        restock r "
                "    WHERE r.depositParkingID = p2.parkingID "
                "    AND r.pickUpParkingID = p1.parkingID "
                "    AND r.truckID = p1.truckID "
                "    AND p1.truckID = p2.truckID "
                "    AND r.truckID = p2.truckID "
                "    AND r.tripID = p1.tripID "
                "    AND r.tripID = p2.tripID) final "
                "GROUP BY final.truckID;")
            sendRequest(req, True)

        elif reqNumber == "10":
            req = ("SELECT c.carModel, count(c.carModel) AS leaseNumber "
                "FROM car c, trip t "
                "WHERE c.carID = t.carID "
                "GROUP BY c.carModel "
                "ORDER BY leaseNumber DESC limit 1;")
            sendRequest(req, True)

        elif reqNumber == "11":
            tripID = input("What trip needs a restock ?\n")
            req = ("SELECT SQRT(POW(69.1 * (c.lat - T.lat), 2) + POW(69.1 * (T.longi - c.longi) * COS(c.lat / 57.3), 2)) AS distance, T.truckID "
                "FROM trip t, car c, truck T "
                "WHERE t.tripID = ") + tripID + (" AND t.carID = c.carID "
                "AND T.carAvailability > 0 "
                "ORDER BY distance ASC limit 1;")
            sendRequest(req, True)
    
    elif ans == "EXIT":
        print("See you soon!")
        
    else :
        print("Wrong input, try again, it's not that hard.")