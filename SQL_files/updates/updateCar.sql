use dataetna

-- Send to reparation
UPDATE car SET parkingID = NULL
WHERE carID = 18

-- Return from reparation
/*
SET @parkID = 8;

UPDATE car SET parkingID = @parkID, lat = (SELECT lat FROM parking WHERE parkingID = @parkID), longi = (SELECT longi FROM parking WHERE parkingID = @parkID)
WHERE carID = 18