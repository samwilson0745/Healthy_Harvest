import datetime
import os
from django.db import models

# Create your models here.
def filepath(request,filename):
    old_filename = filename
    timeNow = datetime.datetime.now().strftime('%Y%m%d%H:%M:%S')
    filename = "%s%s" % (timeNow,old_filename)
    return os.path.join('classify/',filename)


class History(models.Model):
    crop_type = models.CharField(max_length=20,null=True)
    image = models.FileField(upload_to=filepath,)
    pics = models.JSONField(null=True)
    class_name = models.CharField(max_length=100)
    fruit_name = models.CharField(max_length=100,null=True)
    name=models.CharField(max_length=100)
    description=models.CharField(max_length=500,null=True)
    cure=models.CharField(max_length=10000,null=True)
    date_time = models.DateTimeField(auto_now_add=True)
    medications = models.JSONField(null=True)
    maintaining= models.JSONField(null=True)
