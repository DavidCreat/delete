from rest_framework import serializers
from .models import Actividad, Meta, Grafico

class ActividadSerializer(serializers.ModelSerializer):
    class Meta:
        model = Actividad
        fields = '__all__'

    def validate_fecha(self, value):
        from datetime import date
        if value < date.today():
            raise serializers.ValidationError("La fecha no puede ser en el pasado.")
        return value

class MetaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Meta
        fields = '__all__'

    def validate_fecha_fin(self, value):
        if value < self.initial_data.get("fecha_inicio"):
            raise serializers.ValidationError("La fecha de fin no puede ser anterior a la fecha de inicio.")
        return value

    def validate_objetivo(self, value):
        if value <= 0:
            raise serializers.ValidationError("El objetivo debe ser un número positivo.")
        return value

class GraficoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Grafico
        fields = '__all__'

    def validate_valor(self, value):
        if value < 0:
            raise serializers.ValidationError("El valor no puede ser negativo.")
        return value
