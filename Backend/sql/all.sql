drop database if exists MahjongReservation;
create database MahjongReservation;

use MahjongReservation;

CREATE TABLE Customer (
    PhoneNumber VARCHAR(15) NOT NULL PRIMARY KEY,
    AccountBalance DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    RoomUsageStatus ENUM('预约', '正在使用', '未使用') NOT NULL DEFAULT '未使用',
    BlacklistStatus BOOLEAN NOT NULL DEFAULT FALSE
);
-- 创建服务人员表
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Status ENUM('工作', '休息') NOT NULL
);

-- 创建管理人员表
CREATE TABLE Admins (
    AdminID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    AccessLevel INT NOT NULL
);
-- Table for items
CREATE TABLE Items (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    Description TEXT
);

-- 创建公告表
CREATE TABLE Announcements (
    AnnouncementID INT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL
);

-- 创建棋牌室表
CREATE TABLE Rooms (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Description TEXT,
    Status ENUM('未使用', '已被预约', '正在使用', '正在清洁') NOT NULL DEFAULT '未使用'
);-- 创建商品订单表
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
);-- 插入一些商品（饮料）到 Items 表，指定价格和数量
INSERT INTO Items (Name, Price, Quantity, Description) VALUES
('矿泉水', 3.00, 100, '清凉解渴的矿泉水'),
('可乐', 5.00, 50, '冰爽可乐，适合聚会饮用'),
('橙汁', 8.00, 30, '新鲜橙汁，富含维生素C'),
('绿茶', 6.00, 40, '清香绿茶，提神醒脑'),
('啤酒', 12.00, 20, '冰镇啤酒，麻将房畅饮必备');

-- 插入一个管理员账户
INSERT INTO Admins (Username, Password, AccessLevel) VALUES
('admin', 'admin', 1);
