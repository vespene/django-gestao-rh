# Generated by Django 3.1 on 2020-08-31 01:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('employees', '0005_auto_20200829_2228'),
    ]

    operations = [
        migrations.AddField(
            model_name='employee',
            name='job_title',
            field=models.CharField(default='employee', max_length=100),
            preserve_default=False,
        ),
    ]
