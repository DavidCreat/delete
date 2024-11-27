<template>
  <div class="metas-container">
    <header>
      <h1>Mis Metas</h1>
      <button @click="logout" class="logout-btn">Cerrar Sesión</button>
    </header>
    <section class="goals-section">
      <form @submit.prevent="addGoal" class="goal-form">
        <input
          v-model="newGoal"
          class="goal-input"
          placeholder="Escribe tu meta aquí..."
        />
        <button type="submit" class="add-btn">Agregar Meta</button>
      </form>
      <ul class="goal-list">
        <li v-for="(goal, index) in goals" :key="index" class="goal-item">
          <span class="goal-text">{{ goal }}</span>
          <div class="actions">
            <button @click="editGoal(index)" class="edit-btn">Editar</button>
            <button @click="deleteGoal(index)" class="delete-btn">Eliminar</button>
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
      goals: [
        "Correr 10 km en un mes",
        "Bajar 5 kg en dos meses",
        "Hacer 30 minutos de ejercicio diario",
        "Correr todo el malecon ",
        "Nuevo record de flexiones de pecho (25)",
      ],
      newGoal: "",
    };
  },
  methods: {
    addGoal() {
      if (this.newGoal.trim()) {
        this.goals.push(this.newGoal.trim());
        this.newGoal = "";
      }
    },
    editGoal(index) {
      const updatedGoal = prompt("Editar meta:", this.goals[index]);
      if (updatedGoal) {
        this.goals[index] = updatedGoal.trim();
      }
    },
    deleteGoal(index) {
      this.goals.splice(index, 1);
    },
    logout() {
      localStorage.removeItem("accessToken");
      this.$router.push("/login");
    },
    verifyToken() {
      const token = localStorage.getItem("accessToken");
      if (!token) {
        this.$router.push("/login");
      }
    },
  },
  mounted() {
    this.verifyToken();
  },
};
</script>

<style scoped>
.metas-container {
  max-width: 800px;
  margin: 40px auto;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  background: linear-gradient(135deg, #e0f7fa, #ffffff);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

header h1 {
  font-size: 1.8rem;
  color: #00796b;
  font-weight: bold;
}

.logout-btn {
  background-color: #f44336;
  border: none;
  padding: 10px 20px;
  color: white;
  border-radius: 8px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.logout-btn:hover {
  background-color: #d32f2f;
}

.goal-form {
  display: flex;
  margin-bottom: 20px;
}

.goal-input {
  flex: 1;
  padding: 12px;
  border: 2px solid #00796b;
  border-radius: 8px;
  font-size: 1rem;
  outline: none;
}

.goal-input:focus {
  border-color: #004d40;
  box-shadow: 0 0 5px rgba(0, 128, 128, 0.5);
}

.add-btn {
  padding: 12px 20px;
  margin-left: 10px;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.add-btn:hover {
  background-color: #388e3c;
}

.goal-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.goal-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px;
  margin-bottom: 10px;
  background-color: #ffffff;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s ease;
}

.goal-item:hover {
  transform: translateY(-3px);
}

.goal-text {
  font-size: 1.1rem;
  color: #333;
  flex: 1;
}

.actions {
  display: flex;
  gap: 10px;
}

.edit-btn,
.delete-btn {
  padding: 8px 12px;
  font-size: 0.9rem;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.edit-btn {
  background-color: #ffc107;
  color: white;
}

.edit-btn:hover {
  background-color: #ffb300;
}

.delete-btn {
  background-color: #f44336;
  color: white;
}

.delete-btn:hover {
  background-color: #d32f2f;
}

@media (max-width: 600px) {
  .goal-form {
    flex-direction: column;
  }

  .goal-input {
    margin-bottom: 10px;
    width: 100%;
  }

  .add-btn {
    width: 100%;
  }

  .goal-item {
    flex-direction: column;
    align-items: flex-start;
  }

  .actions {
    width: 100%;
    justify-content: flex-end;
    gap: 5px;
  }
}
</style>
