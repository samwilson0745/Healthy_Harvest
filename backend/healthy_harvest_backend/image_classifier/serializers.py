from rest_framework import serializers
from .models import History

class history_serialize(serializers.ModelSerializer):
    crop_type = serializers.CharField(max_length=20,allow_blank = True)
    description = serializers.CharField(max_length=10000,allow_blank=True)
    fruit_name=serializers.CharField(max_length=20,allow_blank=True)
    cure=serializers.CharField(max_length=10000,allow_blank=True)

    class Meta:
        model=History
        fields = ["crop_type","image","pics","class_name","fruit_name","name","description","cure","medications","maintaining"]