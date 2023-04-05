from django.urls import path
from . import views 


urlpatterns=[
    path('classify',views.post,name='index'),
]
