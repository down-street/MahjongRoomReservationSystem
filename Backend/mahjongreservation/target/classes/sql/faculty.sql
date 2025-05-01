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
