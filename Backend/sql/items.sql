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
);