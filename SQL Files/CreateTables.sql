CREATE TABLE Customer
(
email VARCHAR(30),
fname VARCHAR(20) NOT NULL,
lname VARCHAR(20) NOT NULL,

CONSTRAINT Customer_PK PRIMARY KEY (email),
CONSTRAINT Email_Check CHECK (email LIKE '_%@_%._%')
);

CREATE TABLE Station
(
stationID VARCHAR(5),
stationName VARCHAR(20) NOT NULL,

CONSTRAINT Station_PK PRIMARY KEY (stationID)
);

CREATE TABLE Train
(
trainID VARCHAR(5),
model VARCHAR(10),
trainType CHAR(1),
capasity int NOT NULL,

CONSTRAINT Train_PK PRIMARY KEY (trainID),
CONSTRAINT Train_Type CHECK (trainType = 'E' OR trainType = 'S')
);

CREATE TABLE Account
(
username VARCHAR(20) NOT NULL,
password VARCHAR(16) NOT NULL,
cardNo CHAR(16) NOT NULL,
expMonth INT NOT NULL,
expYear INT NOT NULL,
CVV INT,
email VARCHAR(30),
phone CHAR(10),

CONSTRAINT Account_PK PRIMARY KEY (username),
CONSTRAINT Account_FK1 FOREIGN KEY (email) REFERENCES Customer(email) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT CardNo_Check CHECK (cardNo LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT ExpMonth_Check CHECK (expMonth between 1 and 12),
CONSTRAINT ExpYear_Check CHECK (expYear between 2020 and 2030),
CONSTRAINT CVV_Check CHECK (CVV LIKE '[0-9][0-9][0-9]'),
CONSTRAINT Phone_Check CHECK (phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT Password_Check CHECK (len(password) >= 8),
CONSTRAINT Username_Check CHECK (username LIKE '____%')
);

CREATE TABLE Payment
(
transactionID INT,
amount MONEY NOT NULL,
email VARCHAR(30)

CONSTRAINT Payment_PK PRIMARY KEY (transactionID),
CONSTRAINT Payment_FK1 FOREIGN KEY (email) REFERENCES Customer(email) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TrainClass
(
trainID VARCHAR(5),
classes int,

CONSTRAINT TrainClass_PK PRIMARY KEY (trainID, classes),
CONSTRAINT TrainClass_FK FOREIGN KEY (trainID) REFERENCES Train(trainID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Ticket
(
ticketNo INT,
class CHAR(1) NOT NULL,
price MONEY NOT NULL,
ticketType CHAR(1) NOT NULL,
email VARCHAR(30),
startStationID VARCHAR(5),
endStationID VARCHAR(5),
trainID VARCHAR(5),
seatNo int,

CONSTRAINT Ticket_PK PRIMARY KEY (ticketNo),
CONSTRAINT Ticket_FK1 FOREIGN KEY (email) REFERENCES Customer (email) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Ticket_FK2 FOREIGN KEY (startStationID) REFERENCES Station (stationID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Ticket_FK3 FOREIGN KEY (endStationID) REFERENCES Station (stationID) ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT Ticket_FK4 FOREIGN KEY (trainID) REFERENCES Train (trainID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT typeCheck CHECK (ticketType = 'F' OR ticketType = 'H'),
CONSTRAINT ClassCheck CHECK (class = '1' OR class = '2' OR class = '3')
);

CREATE TABLE Arrives
(
stationID VARCHAR(5),
trainID VARCHAR(5),
arrivalTime TIME NOT NULL,
platformNo INT,

CONSTRAINT Arrives_PK PRIMARY KEY (stationID, trainID),
CONSTRAINT Arrives_FK1 FOREIGN KEY (stationID) REFERENCES Station (stationID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Arrives_FK2 FOREIGN KEY (trainID) REFERENCES Train (trainID) ON DELETE CASCADE ON UPDATE CASCADE
);

