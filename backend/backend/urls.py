from django.contrib import admin
from django.urls import path, include
from usuarios.views import RegisterView, LoginView
from rest_framework.routers import DefaultRouter
from actividades.views import ActividadViewSet, MetaViewSet, GraficoViewSet
from django.http import HttpResponse

# Vista de ejemplo para la URL raíz
def home(request):
    return HttpResponse("Bienvenido a la API de Actividad Física")

# Configuración del router para los ViewSets
router = DefaultRouter()
router.register(r'actividades', ActividadViewSet, basename='actividades')
router.register(r'metas', MetaViewSet, basename='metas')
router.register(r'graficos', GraficoViewSet, basename='graficos')

urlpatterns = [
    path('', home, name='api-root'),  # Vista de bienvenida para la raíz
    path('admin/', admin.site.urls),  # Ruta para el admin de Django
    path('api/', include(router.urls)),  # Incluye las rutas de los ViewSets
    path('api/register/', RegisterView.as_view(), name='register'),  # Ruta para el registro
    path('api/login/', LoginView.as_view(), name='login'),  # Ruta para el login
]
