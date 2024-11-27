# proyecto2024/backend/graficos/models.py

from django.db import models
from usuarios.models import Usuario

class Grafico(models.Model):
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    fecha = models.DateTimeField(auto_now_add=True)
    tipo = models.CharField(max_length=50, choices=[('calorias', 'Calorías'), ('distancia', 'Distancia')])
    valor = models.FloatField()

    def __str__(self):
        return f"{self.tipo} - {self.usuario.nombre} - {self.fecha}"
