from rest_framework import viewsets
from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate
from django.http import JsonResponse
from rest_framework.permissions import IsAuthenticated
from rest_framework.viewsets import ModelViewSet
from .models import Actividad, Meta, Grafico
from .serializers import ActividadSerializer, MetaSerializer, GraficoSerializer

class RegisterView(APIView):
    def post(self, request):
        username = request.data.get('username')
        email = request.data.get('email')
        password = request.data.get('password')
        
        # Depuración
        print(f"Username: {username}, Email: {email}, Password: {password}")

        # Verificar si los campos están vacíos
        if not username or not email or not password:
            return Response({'error': 'Faltan campos obligatorios'}, status=status.HTTP_400_BAD_REQUEST)

        # Verificar si el nombre de usuario ya existe
        if User.objects.filter(username=username).exists():
            return Response({'error': 'El nombre de usuario ya existe'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = User.objects.create_user(username=username, email=email, password=password)
            token, _ = Token.objects.get_or_create(user=user)
            return Response({'token': token.key}, status=status.HTTP_201_CREATED)
        except Exception as e:
            print(f"Error al crear el usuario: {e}")
            return Response({'error': 'Hubo un error al registrar el usuario'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class LoginView(APIView):
    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        
        # Depuración
        print(f"Intento de login - Username: {username}, Password: {password}")
        
        user = authenticate(username=username, password=password)
        
        if user is not None:
            token, _ = Token.objects.get_or_create(user=user)
            return Response({'token': token.key}, status=status.HTTP_200_OK)
        else:
            print(f"Error de autenticación para el usuario: {username}")
            return Response({'error': 'Credenciales inválidas'}, status=status.HTTP_400_BAD_REQUEST)

# Nueva función api_root
def api_root(request):
    return JsonResponse({
        "message": "Bienvenido a la API de Actividad Física",
        "routes": {
            "Register": "/api/register/",
            "Login": "/api/login/ ",
            "Dashboard (protegido)": "/api/dashboard/ ",
        },
        "documentation": "https://tudocumentacionapi.com"
    })

# ViewSet para Actividades

class ActividadViewSet(viewsets.ModelViewSet):
    serializer_class = ActividadSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Actividad.objects.filter(usuario=self.request.user)

    def perform_create(self, serializer):
        if not serializer.is_valid():
            raise ValidationError("Verifica los campos requeridos.")
        serializer.save(usuario=self.request.user)

# ViewSet para Metas
class MetaViewSet(ModelViewSet):
    serializer_class = MetaSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Meta.objects.filter(usuario=self.request.user)

    def perform_create(self, serializer):
        if not serializer.validated_data.get('descripcion') or not serializer.validated_data.get('objetivo'):
            raise ValueError("La descripción y el objetivo de la meta son obligatorios.")
        serializer.save(usuario=self.request.user)

# ViewSet para Gráficos
class GraficoViewSet(ModelViewSet):
    serializer_class = GraficoSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Grafico.objects.filter(usuario=self.request.user)

    def perform_create(self, serializer):
        serializer.save(usuario=self.request.user)
