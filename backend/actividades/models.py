from django.db import models

class Actividad(models.Model):
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField(default="Sin descripción") 
    fecha = models.DateField()
    usuario = models.ForeignKey('auth.User', related_name='actividades_backend', on_delete=models.CASCADE)
    duracion = models.IntegerField(default=30) 

    def __str__(self):
        return self.nombre

class Meta(models.Model):  # Aquí se define el modelo Meta
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField(default="Sin descripción") 
    usuario = models.ForeignKey('auth.User', related_name='metas_backend', on_delete=models.CASCADE)
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    objetivo = models.IntegerField()

    def __str__(self):
        return self.nombre

class Grafico(models.Model):
    actividad = models.ForeignKey(Actividad, related_name='graficos_backend', on_delete=models.CASCADE)
    tipo = models.CharField(max_length=50)
    fecha = models.DateField()
    valor = models.FloatField()

    def __str__(self):
        return f"{self.tipo} - {self.actividad.nombre}"
