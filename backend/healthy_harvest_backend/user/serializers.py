from rest_framework import serializers
from .models import CustomUser
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.settings import api_settings
from django.contrib.auth.models import update_last_login

class user_serialize(serializers.ModelSerializer):
    class Meta:
        model=CustomUser
        fields = "__all__"
    def create(self,validate_data):
        user = CustomUser(
            email=validate_data['email'],
            username=validate_data['username']
        )
        user.set_password(validate_data['password'])
        user.save()
        return user 
class MyTokenObtainPairSerializer(TokenObtainPairSerializer):

    def validate(self, attrs):
        data=super().validate(attrs)
        refresh  = self.get_token(self.user)
        
        data["refresh"] = str(refresh)
        data["access"] = str(refresh.access_token)
        data["username"] = str(self.user.username)
        
        if api_settings.UPDATE_LAST_LOGIN:
            update_last_login(None,self.user)
            
        return data

    @classmethod
    def get_token(cls, user):
        token = super(MyTokenObtainPairSerializer,cls).get_token(user)
        token['username'] = user.username
        return token