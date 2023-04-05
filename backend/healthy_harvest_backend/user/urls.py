from django.urls import path
from . import views
from rest_framework_simplejwt import views as jwt_views

urlpatterns = [
    path('register',views.register,name='create_user'),
    path('token',views.MyTokenObtainPairView.as_view(),name='token_obtain_pair'),
    path('token/refresh',jwt_views.TokenRefreshView.as_view(),name='token_refresh')
]
