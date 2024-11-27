# proyecto2024/backend/usuarios/urls.py

from django.urls import path
from .views import LoginView, RegisterView
from . import views

urlpatterns = [
    path('login/', LoginView.as_view(), name='login'),  # Ruta para login
    path('register/', RegisterView.as_view(), name='register'),  # Ruta para registro
]
