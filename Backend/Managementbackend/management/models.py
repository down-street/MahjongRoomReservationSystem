from django.db import models

# Create your models here.

# Customer model
class Customer(models.Model):
    PhoneNumber = models.CharField(max_length=15, primary_key=True)
    AccountBalance = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    RoomUsageStatus = models.CharField(
        max_length=10,
        choices=[(2, '预约'), (1, '正在使用'), (0, '未使用')],
        default=0
    )
    BlacklistStatus = models.BooleanField(default=False)

    def __str__(self):
        return self.PhoneNumber


# Staff model
class Staff(models.Model):
    StaffID = models.AutoField(primary_key=True)
    Username = models.CharField(max_length=255, unique=True)
    Password = models.CharField(max_length=255)
    Status = models.CharField(
        max_length=10,
        choices=[(1, '工作'), (0, '休息')],
        default=0
    )

    def __str__(self):
        return self.Username


# Admin model
class Admin(models.Model):
    AdminID = models.AutoField(primary_key=True)
    Username = models.CharField(max_length=255, unique=True)
    Password = models.CharField(max_length=255)
    AccessLevel = models.IntegerField()

    def __str__(self):
        return self.Username


# Items model
class Item(models.Model):
    ItemID = models.AutoField(primary_key=True)
    Name = models.CharField(max_length=255)
    Price = models.DecimalField(max_digits=10, decimal_places=2)
    Quantity = models.IntegerField(default=0)
    Description = models.TextField()

    def __str__(self):
        return self.Name


# Announcement model
class Announcement(models.Model):
    AnnouncementID = models.AutoField(primary_key=True)
    Content = models.TextField()

    def __str__(self):
        return f"Announcement {self.AnnouncementID}"


# Room model
class Room(models.Model):
    RoomID = models.AutoField(primary_key=True)
    Name = models.CharField(max_length=255)
    Price = models.DecimalField(max_digits=10, decimal_places=2)
    Description = models.TextField()
    Status = models.CharField(
        max_length=10,
        choices=[(0, '未使用'), (1, '已被预约'), (2, '正在使用'), (3, '正在清洁')],
        default=0
    )

    def __str__(self):
        return self.Name


# ProductOrder model
class ProductOrder(models.Model):
    OrderID = models.AutoField(primary_key=True)
    CustomerPhone = models.ForeignKey(Customer, on_delete=models.CASCADE)
    ItemID = models.ForeignKey(Item, on_delete=models.CASCADE)
    OrderTime = models.DateTimeField()
    StaffID = models.ForeignKey(Staff, on_delete=models.SET_NULL, null=True)
    Status = models.CharField(
        max_length=10,
        choices=[(1, '已送达'), (0, '未送达')],
        default=0
    )

    def __str__(self):
        return f"Order {self.OrderID}"


# RoomReservation model
class RoomReservation(models.Model):
    ReservationID = models.AutoField(primary_key=True)
    CustomerPhone = models.ForeignKey(Customer, on_delete=models.CASCADE)
    RoomID = models.ForeignKey(Room, on_delete=models.CASCADE)
    ReservationStartTime = models.DateTimeField()
    ReservationEndTime = models.DateTimeField()

    def __str__(self):
        return f"Reservation {self.ReservationID}"


# RoomUsageOrder model
class RoomUsageOrder(models.Model):
    UsageID = models.AutoField(primary_key=True)
    CustomerPhone = models.ForeignKey(Customer, on_delete=models.CASCADE)
    RoomID = models.ForeignKey(Room, on_delete=models.CASCADE)
    PlayTime = models.DateTimeField()
    PlayDuration = models.IntegerField()  # Unit: minutes

    def __str__(self):
        return f"Usage Order {self.UsageID}"


# RoomCleaningOrder model
class RoomCleaningOrder(models.Model):
    CleaningID = models.AutoField(primary_key=True)
    RoomID = models.ForeignKey(Room, on_delete=models.CASCADE)
    StaffID = models.ForeignKey(Staff, on_delete=models.SET_NULL, null=True)
    CleaningTime = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Cleaning Order {self.CleaningID}"
