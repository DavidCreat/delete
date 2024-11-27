from rest_framework import serializers
from .models import Actividad, Meta, Grafico
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token

class RegisterSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=150)
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True, style={'input_type': 'password'})

    def validate_email(self, value):
        if User.objects.filter(email=value).exists():
            raise serializers.ValidationError("Ya existe un usuario con este correo electrónico.")
        return value

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password']
        )
        return user

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=150)
    password = serializers.CharField(write_only=True, style={'input_type': 'password'})

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')
        user = authenticate(username=username, password=password)

        if user is None:
            raise serializers.ValidationError("Credenciales inválidas")

        token, created = Token.objects.get_or_create(user=user)
        return {'token': token.key}

class ActividadSerializer(serializers.ModelSerializer):
    tipo = serializers.ChoiceField(choices=Actividad.TIPO_CHOICES)
    usuario = serializers.StringRelatedField(read_only=True)  # Mostrar usuario como texto en lugar de ID

    class Meta:
        model = Actividad
        fields = ['id', 'nombre', 'tipo', 'duracion', 'descripcion', 'fecha', 'usuario_id']
        extra_kwargs = {
            'nombre': {'required': True},
            'tipo': {'required': True},
            'duracion': {'required': True},
            'descripcion': {'required': True},
            'fecha': {'required': True},
            'usuario_id': {'required': True}
        }

    def validate_fecha(self, value):
        from datetime import date
        if value < date.today():
            raise serializers.ValidationError("La fecha no puede ser en el pasado.")
        return value

class MetaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Meta
        fields = ['id', 'nombre', 'descripcion', 'objetivo', 'fecha_objetivo', 'usuario']

    def validate_fecha_objetivo(self, value):
        from datetime import date
        if value < date.today():
            raise serializers.ValidationError("La fecha objetivo no puede ser en el pasado.")
        return value

    def validate_objetivo(self, value):
        if value <= 0:
            raise serializers.ValidationError("El objetivo debe ser un número positivo.")
        return value

class GraficoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Grafico
        fields = ['id', 'usuario', 'titulo', 'datos', 'fecha_creacion']

    def validate_datos(self, value):
        if not isinstance(value, dict):
            raise serializers.ValidationError("Los datos deben ser un diccionario JSON.")
        return value
