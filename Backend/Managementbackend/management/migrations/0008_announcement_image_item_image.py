# Generated by Django 5.2 on 2025-05-05 21:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('management', '0007_alter_roomusageorder_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='announcement',
            name='Image',
            field=models.ImageField(blank=True, null=True, upload_to='announcements/'),
        ),
        migrations.AddField(
            model_name='item',
            name='Image',
            field=models.ImageField(blank=True, null=True, upload_to='items/'),
        ),
    ]
