from django.http import JsonResponse
from rest_framework import status
from django.views.decorators.csrf import csrf_exempt
from .models import CustomUser
from .serializers import user_serialize,MyTokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView 
from rest_framework.permissions import AllowAny
@csrf_exempt
def register(request):
    if request.method == 'POST':
        username=request.POST['username']
        password = request.POST['password']
        email = request.POST['email']
        
        data={
            "username":username,
            "password":password,
            "email":email
        }
        serializer = user_serialize(data=data)
        if(serializer.is_valid()):
            serializer.save()
            user = serializer.data
            response = {
                "username":user['username'],
                "date_joined":user['date_joined'],
                "success":True
            }
            return JsonResponse(response,status=status.HTTP_200_OK)
        return JsonResponse(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

class MyTokenObtainPairView(TokenObtainPairView):
    permission_classes = (AllowAny,)
    serializer_class = MyTokenObtainPairSerializer

    def post(self,request,*args,**kwargs):
        serializer = self.get_serializer(data=request.data)
        if(serializer.is_valid()):
            return JsonResponse(serializer.validated_data,status = status.HTTP_200_OK)
        return JsonResponse(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
           
