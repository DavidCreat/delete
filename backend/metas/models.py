# proyecto2024/backend/metas/models.py

from django.db import models
from usuarios.models import Usuario

class Meta(models.Model):
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    tipo = models.CharField(max_length=50, choices=[('calorias', 'Calorías'), ('distancia', 'Distancia')])
    objetivo = models.FloatField(help_text="Valor objetivo de la meta")
    fecha_inicio = models.DateTimeField(auto_now_add=True)
    fecha_fin = models.DateTimeField()

    def __str__(self):
        return f"Meta {self.tipo} - {self.usuario.nombre} - {self.fecha_inicio} a {self.fecha_fin}"
