# Generated by Django 5.2 on 2025-05-05 21:32

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('management', '0005_roomusageorder_status'),
    ]

    operations = [
        migrations.DeleteModel(
            name='RoomReservation',
        ),
    ]
