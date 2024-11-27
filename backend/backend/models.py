from django.contrib.auth.models import User
from django.db import models

class Actividad(models.Model):
    TIPO_CHOICES = [
        ('Cardio', 'Cardio'),
        ('Fuerza', 'Fuerza'),
        ('Yoga', 'Yoga'),
        ('Pilates', 'Pilates'),
        ('Correr', 'Correr'),
        ('Natación', 'Natación'),
        ('Ciclismo', 'Ciclismo'),
        ('Baile', 'Baile'),
        ('Fútbol', 'Fútbol'),
        ('Basquetbol', 'Basquetbol'),
        ('Tenis', 'Tenis'),
        ('Entrenamiento funcional', 'Entrenamiento funcional'),
        ('Escalada', 'Escalada'),
        ('Boxeo', 'Boxeo'),
        ('Artes marciales', 'Artes marciales')
    ]
    
    # Relación con el modelo de usuario
    usuario = models.ForeignKey(User, on_delete=models.CASCADE, related_name='actividades_actividades')
    
    # Tipo de actividad con opciones predefinidas
    tipo = models.CharField(max_length=50, choices=TIPO_CHOICES)
    
    # Duración de la actividad en minutos
    duracion = models.FloatField()
    
    # Descripción de la actividad (opcional)
    descripcion = models.TextField(blank=True, null=True)
    
    # Fecha de la actividad
    fecha = models.DateField(auto_now_add=False, null=True, blank=True)
    
    def __str__(self):
        return f"{self.tipo} - {self.usuario.username}"
    
    class Meta:
        app_label = 'backend'

class Meta(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE, related_name='metas_actividades')
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField()  # Descripción detallada de la meta
    objetivo = models.FloatField()  # Objetivo de la meta (cantidad de ejercicio)
    fecha_objetivo = models.DateField()

    def __str__(self):
        return f"{self.nombre} - {self.usuario.username}"

    class Meta:
        app_label = 'backend'

class Grafico(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE, related_name='graficos_actividades')
    titulo = models.CharField(max_length=100)
    datos = models.JSONField()  # Tipo de campo para los datos del gráfico
    fecha_creacion = models.DateField()

    def __str__(self):
        return f"{self.titulo} - {self.usuario.username}"

    class Meta:
        app_label = 'backend'
