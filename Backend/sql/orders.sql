-- 创建商品订单表
CREATE TABLE ProductOrders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerPhone VARCHAR(20) NOT NULL,
    ItemID INT NOT NULL,
    OrderTime DATETIME NOT NULL,
    StaffID INT,
    Status ENUM('已送达', '未送达') NOT NULL DEFAULT '未送达',
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID) ON DELETE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID) ON DELETE SET NULL,
    FOREIGN KEY (CustomerPhone) REFERENCES Customer(PhoneNumber) ON DELETE CASCADE
);

-- 创建棋牌室预约订单表
CREATE TABLE RoomReservations (
    ReservationID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerPhone VARCHAR(20) NOT NULL,
    RoomID INT NOT NULL,
    ReservationStartTime DATETIME NOT NULL,
    ReservationEndTime DATETIME NOT NULL,
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID) ON DELETE CASCADE,
    FOREIGN KEY (CustomerPhone) REFERENCES Customer(PhoneNumber) ON DELETE CASCADE
);

-- 创建棋牌室使用订单表
CREATE TABLE RoomUsageOrders (
    UsageID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerPhone VARCHAR(20) NOT NULL,
    RoomID INT NOT NULL,
    PlayTime DATETIME NOT NULL,
    PlayDuration INT NOT NULL, -- 单位：分钟
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID) ON DELETE CASCADE,
    FOREIGN KEY (CustomerPhone) REFERENCES Customer(PhoneNumber) ON DELETE CASCADE
);

-- 创建棋牌室清洁订单表
CREATE TABLE RoomCleaningOrders (
    CleaningID INT AUTO_INCREMENT PRIMARY KEY,
    RoomID INT NOT NULL,
    StaffID INT,
    CleaningTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID) ON DELETE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID) ON DELETE SET NULL
);