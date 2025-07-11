# Generated by Django 4.2.7 on 2025-06-16 18:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('pharmacy', '0019_alter_notification_url'),
    ]

    operations = [
        migrations.AddField(
            model_name='notification',
            name='extra_data',
            field=models.JSONField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='notification',
            name='notification_type',
            field=models.CharField(choices=[('expiry', 'Product Expiry'), ('expired', 'Product Expired'), ('low_stock', 'Low Stock'), ('refill', 'Prescription Refill'), ('other', 'Other')], max_length=20),
        ),
    ]
