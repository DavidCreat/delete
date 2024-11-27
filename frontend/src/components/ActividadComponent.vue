<template>
  <div class="actividad-component">
    <h1>Gestión de Actividades</h1>
    <form @submit.prevent="agregarActividad">
      <input v-model="nuevaActividad.nombre" placeholder="Nombre de la actividad" required />
      <input v-model="nuevaActividad.tipo" placeholder="Tipo de actividad" required />
      <textarea v-model="nuevaActividad.descripcion" placeholder="Descripción detallada" required></textarea>
      <input v-model="nuevaActividad.duracion" type="number" step="0.1" placeholder="Duración (horas)" required />
      <input v-model="nuevaActividad.fecha" type="date" required />
      <button type="submit">Agregar Actividad</button>
    </form>
    <ul>
      <li v-for="actividad in actividades" :key="actividad.id">
        <strong>{{ actividad.nombre }}</strong> - {{ actividad.descripcion }} ({{ actividad.fecha }})
        <button @click="editarActividad(actividad)">Editar</button>
        <button @click="eliminarActividad(actividad.id)">Eliminar</button>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      actividades: [],
      nuevaActividad: {
        nombre: "",
        tipo: "",
        descripcion: "",
        duracion: "",
        fecha: "",
      },
    };
  },
  methods: {
    obtenerActividades() {
      const token = localStorage.getItem("token");
      if (!token) {
        console.error("No se encuentra el token. Debes iniciar sesión.");
        // Redirigir al login si el token no está disponible
        this.$router.push("/login");
        return;
      }

      axios.get("http://127.0.0.1:8000/api/actividades/", {
        headers: {
          Authorization: `Bearer ${token}`  // Token en el encabezado
        }
      })
        .then(response => {
          this.actividades = response.data;
        })
        .catch(error => {
          console.error("Error al obtener actividades:", error);
        });
    },
    agregarActividad() {
      const token = localStorage.getItem("token");  // Recuperamos el token del almacenamiento local

      if (!token) {
        console.error("No se encuentra el token. Debes iniciar sesión.");
        // Redirigir al login si el token no está disponible
        this.$router.push("/login");
        return;
      }

      axios.post("http://127.0.0.1:8000/api/actividades/", this.nuevaActividad, {
        headers: {
          Authorization: `Bearer ${token}`  // Agregamos el token en las cabeceras
        }
      })
        .then(response => {
          this.actividades.push(response.data);
          this.nuevaActividad = { nombre: "", tipo: "", descripcion: "", duracion: "", fecha: "" };
        })
        .catch(error => {
          console.error("Error al agregar actividad:", error);
        });
    },
    editarActividad(actividad) {
      const nombre = prompt("Nuevo nombre:", actividad.nombre);
      const descripcion = prompt("Nueva descripción:", actividad.descripcion);
      const fecha = prompt("Nueva fecha (YYYY-MM-DD):", actividad.fecha);
      const tipo = prompt("Nuevo tipo:", actividad.tipo);
      const duracion = prompt("Nueva duración (horas):", actividad.duracion);

      if (nombre && descripcion && fecha && tipo && duracion) {
        const token = localStorage.getItem("token");  // Recuperamos el token

        if (!token) {
          console.error("No se encuentra el token. Debes iniciar sesión.");
          // Redirigir al login si el token no está disponible
          this.$router.push("/login");
          return;
        }

        axios.put(`http://127.0.0.1:8000/api/actividades/${actividad.id}/`, {
          nombre, descripcion, fecha, tipo, duracion
        }, {
          headers: {
            Authorization: `Bearer ${token}`
          }
        })
        .then(() => {
          this.obtenerActividades();
        })
        .catch(error => {
          console.error("Error al editar actividad:", error);
        });
      }
    },
    eliminarActividad(id) {
      const token = localStorage.getItem("token");  // Recuperamos el token

      if (!token) {
        console.error("No se encuentra el token. Debes iniciar sesión.");
        // Redirigir al login si el token no está disponible
        this.$router.push("/login");
        return;
      }

      axios.delete(`http://127.0.0.1:8000/api/actividades/${id}/`, {
        headers: {
          Authorization: `Bearer ${token}`  // Agregamos el token en las cabeceras
        }
      })
        .then(() => {
          this.actividades = this.actividades.filter(act => act.id !== id);
        })
        .catch(error => {
          console.error("Error al eliminar actividad:", error);
        });
    },
  },
  mounted() {
    this.obtenerActividades();
  },
};
</script>

<style scoped>
.actividad-component {
  max-width: 600px;
  margin: 0 auto;
}
form {
  display: flex;
  flex-direction: column;
  margin-bottom: 20px;
}
input,
textarea {
  margin-bottom: 10px;
  padding: 8px;
  font-size: 16px;
}
button {
  padding: 8px;
  background-color: #007bff;
  color: white;
  border: none;
  cursor: pointer;
}
button:hover {
  background-color: #0056b3;
}
</style>
