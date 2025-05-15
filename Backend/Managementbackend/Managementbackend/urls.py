"""
URL configuration for Managementbackend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from management import views
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path('admin/', admin.site.urls),
    path('customer/login/', views.customer_login, name='customer_login'),
    path('reservation/cancel/<int:reservation_id>/', views.cancel_reservation, name='cancel_reservation'),
    path('reservation/reserve/', views.reserve_room, name='reserve_room'),
    path('customer/status/', views.view_customer_status, name='view_customer_status'),
    path('room/update/', views.update_room_info, name='update_room_info'),
    path('hdata/', views.homedata, name='homedata'),
    path('mnglogin/', views.mnglogin, name='mnglogin'),
    path('csrf/', views.get_csrf_token,name='csrf'),
    path('mnglogout/', views.mnglogout,name='mnglogout'),
    path('checklogin/', views.checklogin,name='checklogin'),
    path('getallstaff/', views.getallstaff,name='getallstaff'),
    path('getallcustomer/', views.getallcustomer,name='getallcustomer'),
    path('insertstaff/', views.insertstaff,name='insertstaff'),
    path('insertcustomer/', views.insertcustomer,name='insertcustomer'),
    path('updatestaff/', views.updatestaff,name='updatestaff'),
    path('updatecustomer/', views.updatecustomer,name='updatecustomer'),
    path('deletestaff/', views.deletestaff,name='deletestaff'),
    path('deletecustomer/', views.deletecustomer,name='deletecustomer'),
    path('getmyprofile/', views.getmyprofile,name='getmyprofile'),

    path('getallroom/', views.getallroom,name='getallroom'),
    path('insertroom/', views.insertroom,name='insertroom'),
    path('updateroom/', views.updateroom,name='updateroom'),
    path('blockroom/', views.blockroom,name='blockroom'),
    path('enableroom/', views.enableroom,name='enableroom'),

    path('getallgoods/', views.getallgoods,name='getallgoods'),
    path('getallgoodsstaff/', views.getallgoodsstaff,name='getallgoodsstaff'),
    path('insertgoods/', views.insertgoods,name='insertgoods'),
    path('updategoods/', views.updategoods,name='updategoods'),
    path('blockgoods/', views.blockgoods,name='blockgoods'),
    path('enablegoods/', views.enablegoods,name='enablegoods'),

    path('upload/', views.upload_image, name='upload_image'),

    path('getallproductorder/', views.getallproductorder, name='getallproductorder'),
    path('getallcleanorder/', views.getallcleanorder, name='getallcleanorder'),
    path('successproductorder/', views.successproductorder, name='successproductorder'),
    path('successcleanorder/', views.successcleanorder, name='successcleanorder'),
    path('cancelproductorder/', views.cancelproductorder, name='cancelproductorder'),
    path('cancelcleanorder/', views.cancelcleanorder, name='cancelcleanorder'),

    path('getallannouncement/', views.getallannouncement, name='getallannouncement'),
    path('insertannouncement/', views.insertannouncement, name='insertannouncement'),
    path('updateannouncement/', views.updateannouncement, name='updateannouncement'),
    path('deleteannouncement/', views.deleteannouncement, name='deleteannouncement'),




    path('login/', views.customerlogin, name='login'),
    path('getcustomerinfo/', views.getcustomerinfo, name='getcustomerinfo'),
    path('updatecustomerinfo/', views.updatecustomerinfo, name='updatecustomerinfo'),
    path('getroomorder/', views.getroomorder, name='getroomorder'),
    path('getgoodsorder/', views.getgoodsorder, name='getgoodsorder'),
    path('getallgoods/',views.getallgoods,name='getallgoods'),
    path('submitgoodsorder/',views.submitgoodsorder,name='submitgoodsorder'),

    path('getmyreservation/',views.getmyreservation,name='getmyreservation'),
    path('getallrooms/',views.getallrooms,name='getallrooms'),
    path('makereservation/',views.makereservation,name='makereservation'),
    path('cancelreservation/',views.cancelreservation,name='cancelreservation'),
    path('getannouncement/',views.getannouncement,name='getannouncement'),
    path('topbalance/',views.topbalance,name='topbalance'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)