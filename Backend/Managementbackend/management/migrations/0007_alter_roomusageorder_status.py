# Generated by Django 5.2 on 2025-05-05 21:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('management', '0006_delete_roomreservation'),
    ]

    operations = [
        migrations.AlterField(
            model_name='roomusageorder',
            name='Status',
            field=models.IntegerField(choices=[(0, '未开始'), (1, '正在使用'), (2, '已结束'), (3, '已取消')], default=0),
        ),
    ]
