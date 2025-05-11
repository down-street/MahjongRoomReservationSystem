from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, redirect
from django.http import JsonResponse
from .models import Customer, Staff, Admin, Room, Item,  ProductOrder,Income,UserProfile,RoomUsageOrder,OrderItem,RoomCleaningOrder,Announcement
from django.db.models import Q
from django.contrib.auth import authenticate, login
from django.shortcuts import render, redirect
from django.contrib.auth.hashers import check_password
import jwt
from django.conf import settings
from datetime import datetime, timedelta
from django.utils import timezone
from collections import OrderedDict
from functools import wraps
from django.shortcuts import redirect

from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json
from django.views.decorators.csrf import ensure_csrf_cookie
from django.contrib.auth.decorators import login_required
from django.core.files.storage import FileSystemStorage
import os 
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

def login_required_api(view_func):
    @wraps(view_func)
    def _wrapped_view(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return JsonResponse({'message': '未登录'}, status=403)
        return view_func(request, *args, **kwargs)
    return _wrapped_view

@csrf_exempt
def checklogin(request):
    if request.user.is_authenticated:
        return JsonResponse({
            'message': '已登录',
            'username': request.user.username,  # 或 .first_name / .email
            'role': request.user.userprofile.role  # 假设有一个 UserProfile 模型
        }, status=200)
    else:
        return JsonResponse({'message': '未登录'}, status=401)
# 管理主页
@login_required_api
def homedata(request):
    if request.method == "GET":
        print("test")
        data = {}
        data ['chart1'] = {item.Name: item.Quantity for item in Item.objects.order_by('Quantity')[:10]}

        data ['chart2'] = {}
        for room in Room.objects.all():
            if room.get_Status_display() not in data ['chart2']:
                data ['chart2'][room.get_Status_display()] = 0
            data ['chart2'][room.get_Status_display()] += 1
        data ['chart3'] = {}
        for staff in Staff.objects.all():
            if staff.get_Status_display() not in data ['chart3']:
                data ['chart3'][staff.get_Status_display()] = 0
            data ['chart3'][staff.get_Status_display()] += 1
        data['chart4'] = {}
        recent_dates = list(
            Income.objects.order_by('-date')
            .values_list('date', flat=True)
            .distinct()[:7]
        )

        # 按升序排列以便绘图时间顺序正确
        recent_dates = sorted(recent_dates)

        # 批量获取对应的收入
        totalincomes = Income.objects.filter(date__in=recent_dates).values('date', 'total_income')
        roomincomes = Income.objects.filter(date__in=recent_dates).values('date', 'room_income')
        itemincomes = Income.objects.filter(date__in=recent_dates).values('date', 'item_income')

        # 构建日期 -> 收入的映射字典
        totalincome_map = {entry['date']: entry['total_income'] for entry in totalincomes}
        roomincome_map = {entry['date']: entry['room_income'] for entry in roomincomes}
        itemincome_map = {entry['date']: entry['item_income'] for entry in itemincomes}

        # 初始化返回数据结构
        data['chart4']['date'] = []
        data['chart4']['total_income'] = []
        data['chart4']['room_income'] = []
        data['chart4']['item_income'] = []

        # 构建图表数据
        for date in recent_dates:
            date_str = date.strftime('%Y-%m-%d')
            data['chart4']['date'].append(date_str)
            data['chart4']['total_income'].append(totalincome_map.get(date, 0))
            data['chart4']['room_income'].append(roomincome_map.get(date, 0))
            data['chart4']['item_income'].append(itemincome_map.get(date, 0))
        
        return JsonResponse(data,status=200)


@ensure_csrf_cookie
def get_csrf_token(request):
    return JsonResponse({'message': 'CSRF cookie set'})
    
@csrf_exempt
def mnglogin(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            username = data.get('username')
            password = data.get('password')

            user = authenticate(request, username=username, password=password)

            if user is not None:
                # 可以扩展检查 is_staff 或 is_superuser 等权限
                if user.is_active:
                    login(request, user)
                    return JsonResponse({'message': '登录成功'}, status=200)
                else:
                    return JsonResponse({'message': '账号已被禁用'}, status=403)
            else:
                return JsonResponse({'message': '用户名或密码错误'}, status=401)

        except json.JSONDecodeError:
            return JsonResponse({'message': '请求体格式错误'}, status=400)

    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def mnglogout(request):
    logout(request)
    return JsonResponse({'message': '登出成功'}, status=200)


def getallstaff(request):
    if request.method == 'GET':
        staff_list = Staff.objects.all()
        staff_data = []
        for staff in staff_list:
            staff_data.append({
                'realname': staff.name,
                'name': staff.profile.user.username,
                'status': staff.get_Status_display(),
            })
        return JsonResponse({'staff': staff_data}, status=200)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)
def getallcustomer(request):
    if request.method == 'GET':
        customer_list = Customer.objects.all()
        customer_data = []
        for customer in customer_list:
            customer_data.append({
                'name': customer.profile.user.username,
                'phone_number': customer.PhoneNumber,
                'status': customer.get_RoomUsageStatus_display(),
                'balance': customer.AccountBalance,
                'blocked': customer.BlacklistStatus,
            })
        return JsonResponse({'customer': customer_data}, status=200)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)

def insertcustomer(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            name = data.get('name')
            phone_number = data.get('phone_number')
            password = data.get('password')
            user = User.objects.create_user(username=name, password=password)
            profile = UserProfile.objects.create(
                user=user,
                role='customer'
            )
            customer = Customer(
                profile=profile,
                PhoneNumber=phone_number,
                AccountBalance=0.00,
                RoomUsageStatus=0,
                BlacklistStatus=False
            )
            user.save()
            profile.save()
            customer.save()
            return JsonResponse({'message': '顾客添加成功'}, status=201)
        except Exception as e:
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)
def insertstaff(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            name = data.get('name')
            password = data.get('password')
            status = data.get('status')
            realname = data.get('realname')
            
            user = User.objects.create_user(username=name, password=password)
            
            profile = UserProfile.objects.create(
                user=user,
                role='staff'
            )
            
            staff = Staff(
                profile=profile,
                Status=status,
                name=realname
            )
            user.save()
            profile.save()
            staff.save()
            return JsonResponse({'message': '员工添加成功'}, status=201)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)
def updatestaff(request):
    print(request.method)
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            role = data.get('role')

            print(data)
            if role == 'staff':
                name = data.get('name')
                status = data.get('status')
                realname = data.get('realname')
                user = User.objects.get(username=name)
                staff = Staff.objects.get(profile__user=user)
                #print(staff)
                staff.name = realname
                staff.profile.user.username = name
                staff.Status = status
                password = data.get('password')
                if password:
                    user.set_password(password)
                    user.save()
                staff.save()
                return JsonResponse({'message': '员工信息更新成功'}, status=200)
            elif role == 'admin':
                name = data.get('name')
                user = User.objects.get(username=name)
                admin = Admin.objects.get(profile__user=user)
                password = data.get('password')
                if password:
                    user.set_password(password)
                    user.save()
                #print(staff)
                admin.save()
                return JsonResponse({'message': '管理员信息更新成功'}, status=200)
        except Staff.DoesNotExist:
            return JsonResponse({'message': '员工不存在'}, status=404)
        except Exception as e:
            #print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 PUT 请求'}, status=405)
def updatecustomer(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            customer_id = data.get('id')
            name = data.get('name')
            phone_number = data.get('phone_number')
            status = data.get('status')
            balance = data.get('balance')
            blocked = data.get('blocked')
            print(data)

            user = User.objects.get(username=name)
            customer = Customer.objects.get(profile__user=user)

            customer.PhoneNumber = phone_number
            customer.AccountBalance = balance
            customer.BlacklistStatus = blocked
            customer.save()
            return JsonResponse({'message': '顾客信息更新成功'}, status=200)
        except Exception as e:
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)
def deletestaff(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            #print(data)
            name = data.get('name')
            # 查找 Staff
            staff = Staff.objects.get(profile__user__username=name)
            #print(staff)
            # 获取关联的 UserProfile 和 User
            user_profile = staff.profile
            user = user_profile.user

            # 删除 Staff，UserProfile 和 User
            staff.delete()
            user_profile.delete()
            user.delete()
            return JsonResponse({'message': '员工删除成功'}, status=200)
        except Staff.DoesNotExist:
            return JsonResponse({'message': '员工不存在'}, status=404)
        except Exception as e:
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)
def deletecustomer(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            #print(data)
            name = data.get('name')
            # 查找 Staff
            customer = Customer.objects.get(profile__user__username=name)
            #print(staff)
            # 获取关联的 UserProfile 和 User
            user_profile = customer.profile
            user = user_profile.user

            # 删除 Staff，UserProfile 和 User
            customer.delete()
            user_profile.delete()
            user.delete()
            return JsonResponse({'message': '顾客删除成功'}, status=200)
        except Customer.DoesNotExist:
            return JsonResponse({'message': '顾客不存在'}, status=404)
        except Exception as e:
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def getmyprofile(request):
    try:
        user= request.user
        #print(staff)
        # 获取关联的 UserProfile 和 User
        role = user.userprofile.role
        if role == 'staff':
            staff = Staff.objects.get(profile__user=user)
            return JsonResponse({
            'realname': staff.name,
            'username': staff.profile.user.username,
            'status': staff.get_Status_display(),
            'role'  : role,
            }, status=200)
        elif role == 'admin':
            admin = Admin.objects.get(profile__user=user)
            #print(admin.profile.user.username)
            return JsonResponse({
            'username': admin.profile.user.username,
            'role': role,
            }, status=200)
    except Staff.DoesNotExist:
        return JsonResponse({'message': '员工不存在'}, status=404)
    except Exception as e:
        #print(str(e))
        return JsonResponse({'message': str(e)}, status=400)




def getallroom(request):
    if request.method == 'GET':
        room_list = Room.objects.all()
        room_data = []
        for room in room_list:
            order = RoomUsageOrder.objects.filter(Q(Room=room) & (Q(Status=0) | Q(Status=1)))
            
            if order.exists():
                order = order.first()
                order.save()
                #print(order.Status)
            room_data.append({
                'room_id': room.RoomID,
                'name': room.Name,
                'status': room.get_Status_display(),
                'description': room.Description,
                'price': room.Price,
                'phone_number': order.Customer.PhoneNumber if order else None,
                'start_time': order.StartTime if order else None,
                'end_time': order.EndTime if order else None,
                'blocked': room.Closed,
            })
        return JsonResponse({'room': room_data}, status=200)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)

def insertroom(request):
    if request.method == 'POST':
        try:

            data = json.loads(request.body)
            name = data.get('name')
            description = data.get('description')
            price = data.get('price')
            room = Room(
                Name=name,
                Description=description,
                Price=price
            )
            room.save()
            return JsonResponse({'message': '房间添加成功'}, status=201)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)
def updateroom(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            room_id = data.get('room_id')
            name = data.get('name')
            description = data.get('description')
            price = data.get('price')
            # print(name,description,price)
            room = Room.objects.get(RoomID=room_id)
            room.Name = name
            room.Description = description
            room.Price = price
            room.save()
            return JsonResponse({'message': '房间信息更新成功'}, status=200)
        except Exception as e:
            # print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)
def blockroom(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            room_id = data
            room = Room.objects.get(RoomID=room_id)
            room.Closed = True
            room.save()
            return JsonResponse({'message': '房间删除成功'}, status=200)
        except Room.DoesNotExist:
            return JsonResponse({'message': '房间不存在'}, status=404)
        except Exception as e:
           #print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def enableroom(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            room_id = data
            room = Room.objects.get(RoomID=room_id)
            room.Closed = False
            room.save()
            return JsonResponse({'message': '房间启用成功'}, status=200)
        except Room.DoesNotExist:
            return JsonResponse({'message': '房间不存在'}, status=404)
        except Exception as e:
            #print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)


def getallgoods(request):
    if request.method == 'GET':
        goods_list = Item.objects.all()
        goods_data = []
        url = None
        for goods in goods_list:
            if goods.Image:
                if goods.Image.url.startswith('/media/media/'):
                    url = goods.Image.url.replace('/media/media/', '/media/')
                else:
                    url = goods.Image.url
            goods_data.append({
                'goods_id': goods.ItemID,
                'name': goods.Name,
                'price': goods.Price,
                'quantity': goods.Quantity,
                'description': goods.Description,
                'image': url if goods.Image else None,
                'disabled':  "已下架" if goods.Disabled == True else "在售",
            })
        return JsonResponse({'goods': goods_data}, status=200)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)

def insertgoods(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            name = data.get('name')
            price = data.get('price')
            quantity = data.get('quantity')
            description = data.get('description')
            image = data.get('imageUrl')  # Assuming you handle file upload separately
            if image:
                image = image[3:]
            goods = Item(
                Name=name,
                Price=price,
                Quantity=quantity,
                Description=description,
                Image=image
            )
            goods.save()
            return JsonResponse({'message': '商品添加成功'}, status=201)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def updategoods(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            goods_id = data.get('goods_id')
            name = data.get('name')
            price = data.get('price')
            quantity = data.get('quantity')
            description = data.get('description')
            image = data.get('imageUrl')  # Assuming you handle file upload separately
            goods = Item.objects.get(ItemID=goods_id)
            goods.Name = name
            goods.Price = price
            goods.Quantity = quantity
            goods.Description = description
            if image:
                goods.Image = image[3:]
            #print(goods.Image)
            goods.save()
            return JsonResponse({'message': '商品信息更新成功'}, status=200)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def blockgoods(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            goods_id = data
            goods = Item.objects.get(ItemID=goods_id)
            goods.Disabled= 1
            goods.save()
            return JsonResponse({'message': '商品删除成功'}, status=200)
        except Item.DoesNotExist:
            return JsonResponse({'message': '商品不存在'}, status=404)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def enablegoods(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            goods_id = data
            goods = Item.objects.get(ItemID=goods_id)
            goods.Disabled= 0
            goods.save()
            return JsonResponse({'message': '商品启用成功'}, status=200)
        except Item.DoesNotExist:
            return JsonResponse({'message': '商品不存在'}, status=404)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

@csrf_exempt
def upload_image(request):
    if request.method == 'POST' and request.FILES.get('file'):
        uploaded_file = request.FILES['file']
        
        # 设置上传路径
        upload_path = ''  # 你想要指定的目录路径
        fs = FileSystemStorage(location=os.path.join(settings.MEDIA_ROOT, upload_path))

        # 保存文件
        filename = fs.save(uploaded_file.name, uploaded_file)
        file_url = fs.url(filename)  # 获取上传文件的 URL 地址

        # 返回成功信息
        return JsonResponse({'url': file_url})
    
    return JsonResponse({'error': 'No file uploaded'}, status=400)

def getallproductorder(request):
    if request.method == 'GET':
        productorder_list = ProductOrder.objects.filter(Status=0)
        productorder_data = []
        for productorder in productorder_list:
            order_items = OrderItem.objects.filter(ProductOrder=productorder)
            items = {}
            for oi in order_items:
                items[oi.Item.Name]=oi.Quantity
            # print(items)
            productorder_data.append({
                'productorder_id': productorder.OrderID,
                'phone_number': productorder.CustomerPhone.PhoneNumber,
                'items': items,
            })
        return JsonResponse({'productorder': productorder_data}, status=200)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)

def getallcleanorder(request):
    if request.method == 'GET':
        cleanorder_list = RoomCleaningOrder.objects.filter(Status=0)
        
        cleanorder_data = []
        for cleanorder in cleanorder_list:
            #print(cleanorder)
            room = cleanorder.RoomID
            cleanorder_data.append({
                'cleanorder_id': cleanorder.CleaningID,
                'room_id': cleanorder.RoomID.RoomID,
                'room_name': room.Name,
            })
        return JsonResponse({'cleanorder': cleanorder_data}, status=200)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)

def successproductorder(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            productorder_id = data
            productorder = ProductOrder.objects.get(OrderID=productorder_id)
            productorder.Status = 1
            productorder.save()
            return JsonResponse({'message': '商品订单成功'}, status=200)
        except ProductOrder.DoesNotExist:
            return JsonResponse({'message': '商品订单不存在'}, status=404)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def successcleanorder(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            cleanorder_id = data
            cleanorder = RoomCleaningOrder.objects.get(CleaningID=cleanorder_id)
            cleanorder.Status = 1
            cleanorder.save()
            return JsonResponse({'message': '清洁订单成功'}, status=200)
        except RoomCleaningOrder.DoesNotExist:
            return JsonResponse({'message': '清洁订单不存在'}, status=404)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def cancelproductorder(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            productorder_id = data
            productorder = ProductOrder.objects.get(OrderID=productorder_id)
            productorder.Status = 2
            productorder.save()
            return JsonResponse({'message': '商品订单取消成功'}, status=200)
        except ProductOrder.DoesNotExist:
            return JsonResponse({'message': '商品订单不存在'}, status=404)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)
def cancelcleanorder(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            cleanorder_id = data
            cleanorder = RoomCleaningOrder.objects.get(CleaningID=cleanorder_id)
            cleanorder.Status = 2
            cleanorder.save()
            return JsonResponse({'message': '清洁订单取消成功'}, status=200)
        except RoomCleaningOrder.DoesNotExist:
            return JsonResponse({'message': '清洁订单不存在'}, status=404)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def getallannouncement(request):
    if request.method == 'GET':

        announcement_list = Announcement.objects.all()
        announcement_data = []
        
        for announcement in announcement_list:
            url = None
            if announcement.Image:
                if announcement.Image.url.startswith('/media/media/'):
                    url = announcement.Image.url.replace('/media/media/', '/media/')
                else:
                    url = announcement.Image.url
                    
            announcement_data.append({
                'id': announcement.AnnouncementID,
                'announcement_id': announcement.AnnouncementID,
                'content': announcement.Content,
                'ImageUrl': url if announcement.Image else None,
            })
        return JsonResponse({'announcement': announcement_data}, status=200)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)

def insertannouncement(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            content = data.get('content')
            image = data.get('imageUrl')  # Assuming you handle file upload separately
            if image:
                image = image[3:]
            announcement = Announcement(
                Content=content,
                Image=image
            )
            announcement.save()
            return JsonResponse({'message': '公告添加成功'}, status=201)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def updateannouncement(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            announcement_id = data.get('announcement_id')
            content = data.get('content')
            image = data.get('imageUrl')  # Assuming you handle file upload separately
            announcement = Announcement.objects.get(AnnouncementID=announcement_id)
            announcement.Content = content
            if image:
                announcement.Image = image[3:]
            print(announcement.Image)
            announcement.save()
            return JsonResponse({'message': '公告信息更新成功'}, status=200)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def deleteannouncement(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            announcement_id = data
            announcement = Announcement.objects.get(AnnouncementID=announcement_id)
            announcement.delete()
            return JsonResponse({'message': '公告删除成功'}, status=200)
        except Announcement.DoesNotExist:
            return JsonResponse({'message': '公告不存在'}, status=404)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

def check_code(phone_number,code):
    now = datetime.now()
    time_part = now.hour * 100 + now.minute
    if (int(phone_number)+time_part) %10000 == code:
        return True
    else:
        return False

@csrf_exempt
def customerlogin(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        phone_number = data.get('username')
        password = data.get('password')
        if check_code(phone_number,password):
            if Customer.objects.filter(PhoneNumber=phone_number).exists():
                customer = Customer.objects.get(PhoneNumber=phone_number)
                user = customer.profile.user
                if customer.BlacklistStatus:
                    return JsonResponse({'message': '账号已被封禁'}, status=403)
                # 这里可以添加更多的登录逻辑，比如设置 session 等
            else:
                user = User.objects.create_user(username=phone_number, password="")
                profile = UserProfile.objects.create(
                    user=user,
                    role='Customer'
                )
            login(request, user)
            return JsonResponse({'message': '登录成功'}, status=200)
        else:
            if Customer.objects.filter(PhoneNumber=phone_number).exists():
                customer = Customer.objects.get(PhoneNumber=phone_number)
                user = customer.profile.user
                if customer.BlacklistStatus:
                    return JsonResponse({'message': '账号已被封禁'}, status=403)
                user = authenticate(request, username=user.username, password=password)
                if user is not None:
                    login(request, user)
                    return JsonResponse({'message': '登录成功'}, status=200)
                else:
                    return JsonResponse({'message': '用户名或密码错误'}, status=401)
            else:
                return JsonResponse({'message': '用户不存在'}, status=404)
def getcustomerinfo(request):
    if request.method == 'GET':
        user= request.user
        customer = Customer.objects.get(profile__user=user)
        data = {
            "username": user.username,
            "balance": customer.AccountBalance,
            "status": customer.RoomUsageStatus,
        }
        return JsonResponse(data)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)

def updatecustomerinfo(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            user= request.user
            user.set_password(data.get('password'))
            user.save()
            return JsonResponse({'message': '顾客信息更新成功'}, status=200)
        except Exception as e:
            print(str(e))
            return JsonResponse({'message': str(e)}, status=400)
    return JsonResponse({'message': '仅支持 POST 请求'}, status=405)

import math
def getroomorder(request):
    if request.method == 'GET':
        user= request.user
        customer = Customer.objects.get(profile__user=user)
        order_list = RoomUsageOrder.objects.filter(Customer=customer)
        order_data = []
        for order in order_list:
            order_data.append({
                'name': order.Room.Name,
                'starttime': order.StartTime.strftime('%m-%d %H:%M'),
                'endtime': order.EndTime.strftime('%m-%d %H:%M'),
                'status': order.get_Status_display(),   
                'price': order.Room.Price*math.ceil((order.EndTime-order.StartTime).seconds/3600),
            })
        return JsonResponse({'order': order_data}, status=200)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)

def getgoodsorder(request):
    if request.method == 'GET':
        user= request.user
        customer = Customer.objects.get(profile__user=user)
        order_list = ProductOrder.objects.filter(CustomerPhone=customer)
        order_data = []


        for order in order_list:
            order_items = OrderItem.objects.filter(ProductOrder=order)
            items = {}
            for oi in order_items:
                items[oi.Item.Name]=oi.Quantity
            order_data.append({
                'name': items,
                'status': order.get_Status_display(),   
                'price': sum([oi.Item.Price * oi.Quantity for oi in order_items]),
                'starttime': order.OrderTime.strftime('%m-%d %H:%M'),
            })
        return JsonResponse({'order': order_data}, status=200)
    return JsonResponse({'message': '仅支持 GET 请求'}, status=405)

def getallgoods(request):
    if request.method == 'GET':
        goods_list = Item.objects.filter(Quantity__gt=0, Disabled=0)
        goods_data=[]
        for goods in goods_list:
            if goods.Image:
                if goods.Image.url.startswith('/media/media/'):
                    url = goods.Image.url.replace('/media/media/', '/media/')
                else:
                    url = goods.Image.url
            goods_data.append(
                {
                    'id':goods.ItemID,
                    'name':goods.Name,
                    'price':goods.Price,
                    'quantity':goods.Quantity,
                    'desc':goods.Description,
                    'count':0,
                    'image':url if goods.Image else None
                }
            )
        return JsonResponse({'goods': goods_data}, status=200)

from django.db import transaction
from decimal import Decimal
@transaction.atomic
def submitgoodsorder(request):
    """
    接收 JSON: { items: [{ item_id, quantity }, ...] }
    检查余额、库存，创建订单，扣库存扣余额。
    """
    if request.method != 'POST':
        return JsonResponse({'code': 400, 'message': 'Bad request'}, status=400)

    try:
        payload = json.loads(request.body)
        items = payload
        if not items:
            return JsonResponse({'code': 400, 'message': '没有要提交的商品'}, status=400)

        # 获取 Customer
        customer = Customer.objects.get(profile__user=request.user)

        # 计算总价 & 检查库存
        total = 0.00
        total = Decimal(str(total))
        item_objs = []
        for entry in items:
            itm = Item.objects.select_for_update().get(ItemID=entry['item_id'], Disabled=False)
            qty = int(entry['quantity'])
            if itm.Quantity < qty:
                return JsonResponse({
                    'code': 409,
                    'message': f'商品“{itm.Name}”库存不足'
                }, status=409)
            total += itm.Price * qty
            item_objs.append((itm, qty))

        # 检查余额
        
        if customer.AccountBalance < total:
            return JsonResponse({
                'code': 402,
                'message': '余额不足',
                'balance': float(customer.AccountBalance)
            }, status=402)

        # 创建订单
        order = ProductOrder.objects.create(
            CustomerPhone=customer,
            OrderTime=timezone.now(),
            Status=0  # 未送达
        )

        # 创建 OrderItem 并扣库存
        for itm, qty in item_objs:
            OrderItem.objects.create(ProductOrder=order, Item=itm, Quantity=qty)
            itm.Quantity -= qty
            itm.save()


        customer.AccountBalance -= total
        customer.save()

        return JsonResponse({'code': 200, 'message': '订单提交成功', 'order_id': order.OrderID})

    except Customer.DoesNotExist:
        return JsonResponse({'code': 401, 'message': '用户不存在'}, status=200)
    except Item.DoesNotExist:
        return JsonResponse({'code': 404, 'message': '商品不存在'}, status=200)
    except Exception as e:
        print(e)
        return JsonResponse({'code': 500, 'message': f'服务器错误: {e}'}, status=500)

def getmyreservation(request):
    if request.method=='GET':
        user=request.user
        customer=Customer.objects.get(profile__user=user)
        order=RoomUsageOrder.objects.filter(Customer=customer,Status__lte=1).first()
        if order:
            start_str = order.StartTime.strftime("%Y-%m-%d %H:%M")
            end_str = order.EndTime.strftime("%Y-%m-%d %H:%M")
            data={
                "id":order.Room.RoomID,
                "name":order.Room.Name,
                'starttime':start_str,
                'endtime':end_str
            }
            return JsonResponse({'data':data},status=200)
        else:
            return JsonResponse({'data':''},status=200)

def getallrooms(request):
    if request.method=='GET':
        room_list = Room.objects.all()
        data=[]
        for room in room_list:
            if room.Closed==1:
                continue
            else:
                data.append(
                    {
                        "id":room.RoomID,
                        "name":room.Name,
                        "description":room.Description,
                        "price":room.Price,
                        "status":room.Status
                    }
                )
        return JsonResponse({'data':data},status=200)

from datetime import datetime, date, time
def makereservation(request):
    if request.method != 'POST':
        return JsonResponse({'error': '只支持 POST'}, status=405)

    try:
        data = json.loads(request.body)
        user = request.user
        customer = Customer.objects.get(profile__user=user)

        # 获取传入的时:分 字符串
        start_str = data.get('starttime')  # e.g. "8:00"
        end_str   = data.get('endtime')    # e.g. "8:02"
        room_id   = data.get('room_id')

        # 查房间
        room = Room.objects.get(RoomID=room_id)

        # 今天的日期
        today = date.today()

        # 解析时:分
        sh, sm = map(int, start_str.split(':'))
        eh, em = map(int, end_str.split(':'))

        # 构造 datetime（本地时区）
        # 如果你启用了时区支持，请用 timezone.make_aware
        naive_start = datetime.combine(today, time(sh, sm))
        naive_end   = datetime.combine(today, time(eh, em))

        # 如果需要时区信息：
        start_dt = timezone.make_aware(naive_start, timezone.get_current_timezone())
        end_dt   = timezone.make_aware(naive_end,   timezone.get_current_timezone())

        # 保存房间状态
        print(room.Name)
        room.Status = 1
        room.save()

        # 创建预约
        order = RoomUsageOrder.objects.create(
            Customer=customer,
            Room=room,
            Status=0,
            StartTime=start_dt,
            EndTime=end_dt,
        )

        # 标记用户状态
        customer.RoomUsageStatus = 2
        customer.save()

        return JsonResponse({'message': '预约成功', 'order_id': order.UsageID}, status=200)

    except Customer.DoesNotExist:
        return JsonResponse({'error': '用户不存在'}, status=404)
    except Room.DoesNotExist:
        return JsonResponse({'error': '房间不存在'}, status=404)
    except Exception as e:
        print(str(e))
        return JsonResponse({'error': f'服务器错误：{e}'}, status=500)

def cancelreservation(request):
    if request.method=='POST':
        data = json.loads(request.body)
        print(data)
        user=request.user
        customer=Customer.objects.get(profile__user=user)
        id = data
        room = Room.objects.get(RoomID=id)
        room.Status = 0
        order = RoomUsageOrder.objects.get(UsageID=id)
        order.Status=3
        print(room.Name)
        room.save()
        order.save()
        customer.RoomUsageStatus=0
        customer.save()
        return JsonResponse({'message': '成功'}, status=200)

