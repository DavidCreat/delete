from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.authtoken.models import Token
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from actividades.models import Actividad, Meta, Grafico
from actividades.serializers import ActividadSerializer, MetaSerializer, GraficoSerializer

# RegisterView y LoginView
class RegisterView(APIView):
    def post(self, request, *args, **kwargs):
        try:
            username = request.data.get('username')
            password = request.data.get('password')
            email = request.data.get('email')

            if not username or not password or not email:
                return Response({"error": "Faltan campos requeridos"}, status=status.HTTP_400_BAD_REQUEST)

            if User.objects.filter(username=username).exists():
                return Response({"error": "El nombre de usuario ya está en uso"}, status=status.HTTP_400_BAD_REQUEST)
            if User.objects.filter(email=email).exists():
                return Response({"error": "El correo electrónico ya está en uso"}, status=status.HTTP_400_BAD_REQUEST)

            user = User.objects.create_user(username=username, password=password, email=email)
            token = Token.objects.create(user=user)

            return Response({
                "message": "Usuario creado correctamente",
                "token": token.key
            }, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)



class LoginView(APIView):
    def post(self, request, *args, **kwargs):
        username = request.data.get('username')
        password = request.data.get('password')
        user = authenticate(username=username, password=password)

        if user is not None:
            token, created = Token.objects.get_or_create(user=user)
            return Response({
                "message": "Inicio de sesión exitoso",
                "token": token.key
            }, status=status.HTTP_200_OK)
        else:
            return Response({"error": "El nombre de usuario o la contraseña no son válidos"}, status=status.HTTP_401_UNAUTHORIZED)

# ViewSets
class ActividadViewSet(viewsets.ModelViewSet):
    queryset = Actividad.objects.all()
    serializer_class = ActividadSerializer

class MetaViewSet(viewsets.ModelViewSet):
    queryset = Meta.objects.all()
    serializer_class = MetaSerializer

class GraficoViewSet(viewsets.ModelViewSet):
    queryset = Grafico.objects.all()
    serializer_class = GraficoSerializer
