from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, redirect
from django.http import JsonResponse
from .models import Customer, Staff, Admin, Room, Item, RoomReservation, ProductOrder
from django.contrib.auth import authenticate, login

# 顾客登录
def customer_login(request):
    if request.method == "POST":
        phone_number = request.POST.get('phone_number')
        password = request.POST.get('password')  # Assume you handle password separately
        try:
            customer = Customer.objects.get(PhoneNumber=phone_number)
            # Perform password check if needed
            login(request, customer)
            return JsonResponse({"message": "登录成功"})
        except Customer.DoesNotExist:
            return JsonResponse({"message": "顾客不存在"}, status=400)
    return render(request, "login.html")

# 棋牌室预约（保留十分钟）
def reserve_room(request):
    if request.method == "POST":
        customer = request.user  # Assuming user is a Customer object
        room_id = request.POST.get('room_id')
        room = Room.objects.get(id=room_id)
        reservation_start = request.POST.get('reservation_start')  # datetime
        reservation_end = request.POST.get('reservation_end')  # datetime
        
        # Check if the room is available for the specified time
        existing_reservation = RoomReservation.objects.filter(RoomID=room, ReservationStartTime__lte=reservation_end, ReservationEndTime__gte=reservation_start)
        if existing_reservation.exists():
            return JsonResponse({"message": "棋牌室已被预约"}, status=400)

        RoomReservation.objects.create(CustomerPhone=customer, RoomID=room, ReservationStartTime=reservation_start, ReservationEndTime=reservation_end)
        return JsonResponse({"message": "预约成功"})
    return render(request, "reserve_room.html")

# 取消预约
def cancel_reservation(request, reservation_id):
    reservation = RoomReservation.objects.get(id=reservation_id)
    if reservation.CustomerPhone != request.user:
        return JsonResponse({"message": "只能取消自己的预约"}, status=403)
    reservation.delete()
    return JsonResponse({"message": "预约取消成功"})

# 查看当前用户状态
def view_customer_status(request):
    customer = request.user
    status = {
        "phone_number": customer.PhoneNumber,
        "balance": customer.AccountBalance,
        "room_status": customer.RoomUsageStatus,
        "blacklist_status": customer.BlacklistStatus
    }
    return JsonResponse(status)

# 查看棋牌室状态
def view_room_status(request):
    rooms = Room.objects.all()
    status = [{"room_id": room.RoomID, "name": room.Name, "status": room.Status} for room in rooms]
    return JsonResponse({"rooms": status})

# 查看商品、购买商品
def view_items(request):
    items = Item.objects.all()
    items_data = [{"item_id": item.ItemID, "name": item.Name, "price": item.Price, "quantity": item.Quantity} for item in items]
    return JsonResponse({"items": items_data})

def purchase_item(request):
    if request.method == "POST":
        customer = request.user
        item_id = request.POST.get('item_id')
        quantity = int(request.POST.get('quantity'))
        item = Item.objects.get(id=item_id)
        
        if item.Quantity < quantity:
            return JsonResponse({"message": "库存不足"}, status=400)
        
        item.Quantity -= quantity
        item.save()

        ProductOrder.objects.create(CustomerPhone=customer, ItemID=item, OrderTime=request.POST.get('order_time'), Status='未送达')
        return JsonResponse({"message": "购买成功"})
    return render(request, "purchase_item.html")

# 管理者登录
def admin_login(request):
    if request.method == "POST":
        username = request.POST.get('username')
        password = request.POST.get('password')  # Assume you handle password separately
        try:
            admin = Admin.objects.get(Username=username)
            # Perform password check if needed
            login(request, admin)
            return JsonResponse({"message": "管理员登录成功"})
        except Admin.DoesNotExist:
            return JsonResponse({"message": "管理员不存在"}, status=400)
    return render(request, "admin_login.html")

# 更新棋牌室信息
def update_room_info(request):
    if request.method == "POST":
        room_id = request.POST.get('room_id')
        new_status = request.POST.get('status')
        try:
            room = Room.objects.get(id=room_id)
            room.Status = new_status
            room.save()
            return JsonResponse({"message": "棋牌室状态更新成功"})
        except Room.DoesNotExist:
            return JsonResponse({"message": "棋牌室不存在"}, status=400)
