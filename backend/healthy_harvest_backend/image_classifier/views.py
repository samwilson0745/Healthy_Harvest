from image_classifier.predictor import predictor
from django.http import JsonResponse
from .serializers import history_serialize
from rest_framework import status
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def post(request):
    if request.method == 'POST':
        print(request.FILES['file'])
        file=request.FILES['file']
        response=predictor(file)     
        data={
                'crop_type':response['Type'],
                'image':file,
                'pics':response['Pics'],
                'class_name':response['Class'],
                'name':response['Name'],
                'fruit_name':response['FruitName'],
                'description':response['Description'],
                'cure':response['Cure'],
                'medications':response['Medications'],
                'maintaining':response['Maintaining']
            }
        
        serializer = history_serialize(data=data)
        if(serializer.is_valid()):
            serializer.save()
            return JsonResponse(serializer.data,status=status.HTTP_200_OK)
        return JsonResponse(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

    