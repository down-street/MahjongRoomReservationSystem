from django.test import TestCase

# Create your tests here.
from django.test import TestCase
from django.urls import reverse
from .models import Customer, Staff, Admin, Room, Item
from django.contrib.auth import get_user_model

# 创建一些测试数据
class TestModels(TestCase):

    def setUp(self):
        # Create a test customer
        self.customer = Customer.objects.create(
            PhoneNumber='1234567890', 
            AccountBalance=100.00, 
            RoomUsageStatus='未使用', 
            BlacklistStatus=False
        )

        # Create a test admin
        self.admin = Admin.objects.create(
            Username='admin', 
            Password='admin', 
            AccessLevel=1
        )

        # Create a test room
        self.room = Room.objects.create(
            Name='Room 1',
            Price=50.00,
            Description='Test room',
            Status='未使用'
        )

        # Create a test item
        self.item = Item.objects.create(
            Name='矿泉水',
            Price=3.00,
            Quantity=100,
            Description='清凉解渴的矿泉水'
        )

    # Test customer login
    def test_customer_login(self):
        response = self.client.post(reverse('customer_login'), {
            'phone_number': '1234567890',
            'password': 'password'  # Password should be handled appropriately
        })
        self.assertEqual(response.status_code, 200)

    # Test reserve room
    def test_reserve_room(self):
        response = self.client.post(reverse('reserve_room'), {
            'room_id': self.room.id,
            'reservation_start': '2025-05-02 10:00:00',
            'reservation_end': '2025-05-02 12:00:00'
        })
        self.assertEqual(response.status_code, 200)

    # Test cancel reservation
    def test_cancel_reservation(self):
        response = self.client.post(reverse('cancel_reservation', kwargs={'reservation_id': 1}))
        self.assertEqual(response.status_code, 200)

    # Test view customer status
    def test_view_customer_status(self):
        response = self.client.get(reverse('view_customer_status'))
        self.assertEqual(response.status_code, 200)

    # Test update room info as admin
    def test_update_room_info(self):
        response = self.client.post(reverse('update_room_info'), {
            'room_id': self.room.id,
            'status': '已被预约'
        })
        self.assertEqual(response.status_code, 200)
