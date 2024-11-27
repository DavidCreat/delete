# proyecto2024/backend/accounts/views.py

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
import json

@csrf_exempt
def register_view(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        username = data.get('username')
        email = data.get('email')
        password = data.get('password')
        if not User.objects.filter(username=username).exists():
            user = User.objects.create_user(username=username, email=email, password=password)
            return JsonResponse({'status': 'Registro exitoso'})
        else:
            return JsonResponse({'status': 'Usuario ya existe'}, status=400)
    return JsonResponse({'status': 'Método no permitido'}, status=405)

@csrf_exempt
def login_view(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        username = data.get('username')
        password = data.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return JsonResponse({'status': 'Inicio de sesión exitoso'})
        else:
            return JsonResponse({'status': 'Credenciales incorrectas'}, status=400)
    return JsonResponse({'status': 'Método no permitido'}, status=405)
