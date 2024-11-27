<template>
  <div class="dashboard-container">
    <h1>Bienvenido, {{ usuario }}</h1>
    <p>¿Que quieres ver hoy?</p>
    <div class="opciones">
      <router-link to="/actividades" class="btn-opcion">Actividades</router-link>
      <router-link to="/metas" class="btn-opcion">Metas</router-link>
      <router-link to="/graficos" class="btn-opcion">Gráficos</router-link>
    </div>
    <button @click="cerrarSesion" class="btn-cerrar-sesion">Cerrar Sesión</button>
  </div>
</template>

<script>
import { useRouter } from "vue-router";

export default {
  name: "DashboardView",
  setup() {
    const router = useRouter();

    // Obtener el nombre de usuario y el token del localStorage
    const usuario = localStorage.getItem("username") || "Usuario";
    const accessToken = localStorage.getItem("accessToken");

    // Verificar si hay un token; si no, redirigir al login
    if (!accessToken) {
      router.push("/login");
    }

    const cerrarSesion = () => {
      // Eliminar los datos del localStorage
      localStorage.removeItem("accessToken");
      localStorage.removeItem("refreshToken");
      localStorage.removeItem("username");
      router.push("/login");
    };

    return {
      usuario,
      cerrarSesion,
    };
  },
};
</script>


<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body, html {
  height: 100%;
  width: 100%;
  overflow: hidden; /* Evita que la página se mueva al hacer scroll */
}

.dashboard-container {
  text-align: center;
  padding: 30px;
  background: linear-gradient(135deg, #6a11cb, #2575fc);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #fff;
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  overflow: hidden; /* Evita que se pueda hacer scroll */
}

h1 {
  font-size: 2.5rem;
  font-weight: 600;
  margin-bottom: 40px;
  text-transform: uppercase;
  letter-spacing: 1.5px;
  color: #fff;
}

.opciones {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  gap: 30px;
  justify-content: center;
  margin-top: 30px;
}

.btn-opcion {
  background-color: #ff6a00;
  color: white;
  padding: 20px 40px;
  border-radius: 10px;
  font-size: 1.2rem;
  text-decoration: none;
  box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, background-color 0.3s ease, box-shadow 0.3s ease;
}

.btn-opcion:hover {
  background-color: #ff7f32;
  transform: translateY(-5px);
  box-shadow: 0 15px 30px rgba(255, 127, 50, 0.4);
}

.btn-cerrar-sesion {
  background-color: #ff4b5c;
  color: white;
  padding: 15px 30px;
  border: none;
  border-radius: 10px;
  font-size: 1.1rem;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.3s ease;
  margin-top: 20px;
  box-shadow: 0 10px 20px rgba(255, 75, 92, 0.2);
}

.btn-cerrar-sesion:hover {
  background-color: #e63946;
  transform: translateY(-5px);
  box-shadow: 0 15px 30px rgba(230, 57, 70, 0.3);
}

.btn-cerrar-sesion:focus {
  outline: none;
}

@media screen and (max-width: 768px) {
  .opciones {
    flex-direction: column;
    gap: 20px;
  }

  .btn-opcion {
    padding: 15px 30px;
    font-size: 1.1rem;
  }

  .btn-cerrar-sesion {
    padding: 12px 25px;
    font-size: 1rem;
  }
}
</style>
