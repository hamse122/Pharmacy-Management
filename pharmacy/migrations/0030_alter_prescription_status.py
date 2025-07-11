# Generated by Django 4.2.7 on 2025-07-05 13:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('pharmacy', '0029_alter_prescription_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='prescription',
            name='status',
            field=models.CharField(choices=[('pending', 'Pending'), ('filled', 'Filled'), ('partially_filled', 'Partially Filled'), ('cancelled', 'Cancelled')], default='pending', max_length=20),
        ),
    ]
