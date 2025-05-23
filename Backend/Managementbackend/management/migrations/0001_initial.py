# Generated by Django 5.2 on 2025-05-04 11:02

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Announcement',
            fields=[
                ('AnnouncementID', models.AutoField(primary_key=True, serialize=False)),
                ('Content', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='Customer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('PhoneNumber', models.CharField(default='', max_length=15, unique=True)),
                ('AccountBalance', models.DecimalField(decimal_places=2, default=0.0, max_digits=10)),
                ('RoomUsageStatus', models.IntegerField(choices=[(2, '预约'), (1, '正在使用'), (0, '未使用')], default=0)),
                ('BlacklistStatus', models.BooleanField(default=False)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Income',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateField(unique=True)),
                ('room_income', models.DecimalField(decimal_places=2, default=0.0, max_digits=12)),
                ('item_income', models.DecimalField(decimal_places=2, default=0.0, max_digits=12)),
                ('total_income', models.DecimalField(decimal_places=2, editable=False, max_digits=12)),
            ],
        ),
        migrations.CreateModel(
            name='Item',
            fields=[
                ('ItemID', models.AutoField(primary_key=True, serialize=False)),
                ('Name', models.CharField(max_length=255)),
                ('Price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('Quantity', models.IntegerField(default=0)),
                ('Description', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='Room',
            fields=[
                ('RoomID', models.AutoField(primary_key=True, serialize=False)),
                ('Name', models.CharField(max_length=255)),
                ('Price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('Description', models.TextField()),
                ('Status', models.IntegerField(choices=[(0, '未使用'), (1, '已被预约'), (2, '正在使用'), (3, '正在清洁')], default=0)),
            ],
        ),
        migrations.CreateModel(
            name='Staff',
            fields=[
                ('StaffID', models.AutoField(primary_key=True, serialize=False)),
                ('Status', models.IntegerField(choices=[(1, '工作'), (0, '休息')], default=0)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='RoomReservation',
            fields=[
                ('ReservationID', models.AutoField(primary_key=True, serialize=False)),
                ('ReservationStartTime', models.DateTimeField()),
                ('ReservationEndTime', models.DateTimeField()),
                ('CustomerPhone', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='management.customer')),
                ('RoomID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='management.room')),
            ],
        ),
        migrations.CreateModel(
            name='RoomUsageOrder',
            fields=[
                ('UsageID', models.AutoField(primary_key=True, serialize=False)),
                ('PlayTime', models.DateTimeField()),
                ('PlayDuration', models.IntegerField()),
                ('CustomerPhone', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='management.customer')),
                ('RoomID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='management.room')),
            ],
        ),
        migrations.CreateModel(
            name='RoomCleaningOrder',
            fields=[
                ('CleaningID', models.AutoField(primary_key=True, serialize=False)),
                ('CleaningTime', models.DateTimeField(auto_now_add=True)),
                ('RoomID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='management.room')),
                ('StaffID', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='management.staff')),
            ],
        ),
        migrations.CreateModel(
            name='ProductOrder',
            fields=[
                ('OrderID', models.AutoField(primary_key=True, serialize=False)),
                ('OrderTime', models.DateTimeField()),
                ('Status', models.IntegerField(choices=[(1, '已送达'), (0, '未送达')], default=0)),
                ('CustomerPhone', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='management.customer')),
                ('ItemID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='management.item')),
                ('StaffID', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='management.staff')),
            ],
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('role', models.CharField(choices=[('customer', 'Customer'), ('staff', 'Staff'), ('admin', 'Admin')], max_length=10)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.AddField(
            model_name='staff',
            name='profile',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='management.userprofile'),
        ),
        migrations.AddField(
            model_name='customer',
            name='profile',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='management.userprofile'),
        ),
        migrations.CreateModel(
            name='Admin',
            fields=[
                ('AdminID', models.AutoField(primary_key=True, serialize=False)),
                ('AccessLevel', models.IntegerField(default=1)),
                ('profile', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='management.userprofile')),
            ],
            options={
                'abstract': False,
            },
        ),
    ]
