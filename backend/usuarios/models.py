from django.db import models

class Usuario(models.Model):
    id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
    nombre = models.CharField(max_length=100)
    correo = models.EmailField(max_length=254, unique=True)  # Asegúrate de que el campo sea 'correo', no 'email'
    fecha_nacimiento = models.DateField(blank=True, null=True)
    fecha_registro = models.DateTimeField(auto_now_add=True)
