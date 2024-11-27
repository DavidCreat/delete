<template>
  <div class="actividades-container">
    <header>
      <h1>Gestión de Actividades</h1>
      <button @click="logout" class="logout-btn">Cerrar Sesión</button>
    </header>
    <section>
      <form @submit.prevent="addActivity" class="activity-form">
        <input v-model="newActivity" placeholder="Nueva actividad" />
        <button type="submit" class="add-btn">Agregar</button>
      </form>
      <ul class="activity-list">
        <li v-for="(activity, index) in activities" :key="index">
          <span class="activity-item">{{ activity }}</span>
          <div class="actions">
            <button @click="editActivity(index)" class="edit-btn">Editar</button>
            <button @click="deleteActivity(index)" class="delete-btn">Eliminar</button>
          </div>
        </li>
      </ul>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      activities: ["Correr 5 km  30 Minutos", "Bicicleta  45 Minutos", "Flexiones 20 Repeticiones"],
      newActivity: "",
    };
  },
  methods: {
    addActivity() {
      if (this.newActivity) {
        this.activities.push(this.newActivity);
        this.newActivity = "";
      }
    },
    editActivity(index) {
      const updatedActivity = prompt(
        "Editar actividad:",
        this.activities[index]
      );
      if (updatedActivity) {
        this.activities[index] = updatedActivity;
      }
    },
    deleteActivity(index) {
      this.activities.splice(index, 1);
    },
    logout() {
      localStorage.removeItem("token");
      this.$router.push("/login");
    },
  },
};
</script>

<style scoped>



.actividades-container {
  max-width: 900px;
  margin: auto;
  text-align: center;
  padding: 40px;
  background: linear-gradient(135deg, #f9f9f9, #ece9e6);
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  font-family: 'Roboto', sans-serif;
}

header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 40px;
}

h1 {
  font-size: 2.5rem;
  color: #34495e;
}

.logout-btn {
  background-color: #e74c3c;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.logout-btn:hover {
  background-color: #c0392b;
}

.activity-form {
  display: flex;
  gap: 20px;
  margin-bottom: 30px;
}

input {
  flex: 1;
  padding: 15px;
  font-size: 1.2rem;
  border: 2px solid #ddd;
  border-radius: 5px;
  transition: border-color 0.3s ease;
}

input:focus {
  border-color: #3498db;
  outline: none;
}

.add-btn {
  background-color: #2ecc71;
  color: white;
  padding: 15px 25px;
  border: none;
  border-radius: 5px;
  font-size: 1.2rem;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

.add-btn:hover {
  background-color: #27ae60;
  transform: translateY(-2px);
}

.activity-list {
  list-style: none;
  padding: 0;
}

li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: white;
  padding: 15px 20px;
  margin-bottom: 15px;
  border-radius: 10px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s ease;
}

li:hover {
  transform: translateY(-3px);
}

.activity-item {
  font-size: 1.2rem;
  color: #2c3e50;
}

.actions {
  display: flex;
  gap: 10px;
}

button {
  padding: 10px 15px;
  font-size: 1rem;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

.edit-btn {
  background-color: #3498db;
  color: white;
}

.edit-btn:hover {
  background-color: #2980b9;
}

.delete-btn {
  background-color: #e74c3c;
  color: white;
}

.delete-btn:hover {
  background-color: #c0392b;
}
</style>
