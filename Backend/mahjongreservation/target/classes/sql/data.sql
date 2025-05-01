-- 插入一些商品（饮料）到 Items 表，指定价格和数量
INSERT INTO Items (Name, Price, Quantity, Description) VALUES
('矿泉水', 3.00, 100, '清凉解渴的矿泉水'),
('可乐', 5.00, 50, '冰爽可乐，适合聚会饮用'),
('橙汁', 8.00, 30, '新鲜橙汁，富含维生素C'),
('绿茶', 6.00, 40, '清香绿茶，提神醒脑'),
('啤酒', 12.00, 20, '冰镇啤酒，麻将房畅饮必备');

-- 插入一个管理员账户
INSERT INTO Admins (Username, Password, AccessLevel) VALUES
('admin', 'admin', 1);
