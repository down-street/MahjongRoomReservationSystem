from django.db import models
from django.utils import timezone
from datetime import timedelta
from django.db.models import Sum
from django.contrib.auth.models import User
from django.contrib import admin

# Create your models here.

# 用户角色配置
class UserProfile(models.Model):
    ROLE_CHOICES = (
        ('customer', 'Customer'),
        ('staff', 'Staff'),
        ('admin', 'Admin'),
    )

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    role = models.CharField(max_length=10, choices=ROLE_CHOICES)

    def __str__(self):
        return f"{self.user.username} ({self.role})"
 
# 抽象基类，统一继承接口
class BaseUserExtension(models.Model):
    profile = models.OneToOneField(UserProfile, on_delete=models.CASCADE)

    class Meta:
        abstract = True

# Customer 模型（保持字段名一致）
class Customer(BaseUserExtension):
    PhoneNumber = models.CharField(max_length=15, unique=True,null=False,default="")
    AccountBalance = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    RoomUsageStatus = models.IntegerField(
        choices=[(2, '已预约'), (1, '正在使用'), (0, '未使用')],
        default=0
    )
    BlacklistStatus = models.BooleanField(default=False)

    def __str__(self):
        return self.PhoneNumber

# Staff 模型（保持字段名一致）
class Staff(BaseUserExtension):
    StaffID = models.AutoField(primary_key=True)
    Status = models.IntegerField(
        choices=[(1, '工作'), (0, '休息')],
        default=0
    )
    name = models.CharField(max_length=255, default="")
    def __str__(self):
        return self.profile.user.username

# Admin 模型（保持字段名一致）
class Admin(BaseUserExtension):
    AdminID = models.AutoField(primary_key=True)
    AccessLevel = models.IntegerField(default=1)

    def __str__(self):
        return self.profile.user.username


# Items model
class Item(models.Model):
    ItemID = models.AutoField(primary_key=True)
    Name = models.CharField(max_length=255)
    Price = models.DecimalField(max_digits=10, decimal_places=2)
    Quantity = models.IntegerField(default=0)
    Image = models.ImageField(upload_to='', null=True, blank=True)
    Description = models.TextField()

    Disabled = models.BooleanField(default=False)

    def __str__(self):
        return self.Name


# Announcement model
class Announcement(models.Model):
    AnnouncementID = models.AutoField(primary_key=True)
    Content = models.TextField()
    Image = models.ImageField(upload_to='', null=True, blank=True)

    def __str__(self):
        return f"Announcement {self.AnnouncementID}"


# Room model
class Room(models.Model):
    RoomID = models.AutoField(primary_key=True)
    Name = models.CharField(max_length=255)
    Price = models.DecimalField(max_digits=10, decimal_places=2)
    Description = models.TextField()
    Status = models.IntegerField(
        choices=[(0, '未使用'), (1, '已被预约'), (2, '正在使用'), (3, '正在清洁')],
        default=0
    )
    Closed = models.BooleanField(default=False)
    def __str__(self):
        return self.Name

class ProductOrder(models.Model):
    OrderID = models.AutoField(primary_key=True)
    CustomerPhone = models.ForeignKey(Customer, on_delete=models.CASCADE)
    OrderTime = models.DateTimeField(null=True, blank=True)
    StaffID = models.ForeignKey(Staff, on_delete=models.SET_NULL, null=True,blank=True)
    Status = models.IntegerField(
        choices=[(1, '已送达'), (0, '未送达'),(2, '已取消')],
        default=0
    )
    Items = models.ManyToManyField('Item', through='OrderItem')  # 多对多中间表

    def __str__(self):
        return f"Order {self.OrderID}"

class OrderItem(models.Model):
    ProductOrder = models.ForeignKey(ProductOrder, on_delete=models.CASCADE)
    Item = models.ForeignKey(Item, on_delete=models.CASCADE)
    Quantity = models.PositiveIntegerField(default=1)

    def __str__(self):
        return f"Order {self.ProductOrder.OrderID} - Item {self.Item.Name} x{self.Quantity}"







# RoomUsageOrder model
class RoomUsageOrder(models.Model):
    UsageID = models.AutoField(primary_key=True)
    Customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    Room = models.ForeignKey(Room, on_delete=models.CASCADE)

    Status = models.IntegerField(
        choices=[(0, '未开始'), (1, '正在使用'), (2, '已结束'), (3, '已取消')],
        default=0
    )

    StartTime = models.DateTimeField(default=timezone.now)
    EndTime = models.DateTimeField()
    DurationTime = models.IntegerField()  # Unit: minutes
    def save(self, *args, **kwargs):
        self.DurationTime=(self.EndTime - self.StartTime).total_seconds() /60 # 自动计算
        super().save(*args, **kwargs)
    def __str__(self):
        return f"Usage Order {self.UsageID}"


# RoomCleaningOrder model
class RoomCleaningOrder(models.Model):
    CleaningID = models.AutoField(primary_key=True)
    RoomID = models.ForeignKey(Room, on_delete=models.CASCADE)
    StaffID = models.ForeignKey(Staff, on_delete=models.SET_NULL, null=True,blank=True)
    CleaningTime = models.DateTimeField(auto_now_add=True)
    Status = models.IntegerField(
        choices=[(1, '已完成'), (0, '未完成')],
        default=0
    )
    def __str__(self):
        return f"Cleaning Order {self.CleaningID}"

class Income(models.Model):
    date = models.DateField(unique=True)  # 每天唯一
    room_income = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    item_income = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    total_income = models.DecimalField(max_digits=12, decimal_places=2, editable=False)  # 设置为不可编辑

    def save(self, *args, **kwargs):
        self.total_income = self.room_income + self.item_income  # 自动计算
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.date}: ¥{self.total_income}"


admin.site.register(UserProfile)
admin.site.register(Customer)
admin.site.register(Staff)
admin.site.register(Admin)
admin.site.register(Item)
admin.site.register(Announcement)
admin.site.register(Room)
admin.site.register(ProductOrder)
admin.site.register(RoomUsageOrder)
admin.site.register(RoomCleaningOrder)
admin.site.register(Income)
admin.site.register(OrderItem)
# Register your models here.