drop database if exists MahjongReservation;
create database MahjongReservation;

use MahjongReservation;

CREATE TABLE Customer (
    PhoneNumber VARCHAR(15) NOT NULL PRIMARY KEY,
    AccountBalance DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    RoomUsageStatus ENUM('预约', '正在使用', '未使用') NOT NULL DEFAULT '未使用',
    BlacklistStatus BOOLEAN NOT NULL DEFAULT FALSE
);
