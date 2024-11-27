<template>
  <div class="register-container">
    <div class="form-container">
      <h1>Únete a FitFusion</h1>
      <h2>Regístrate y comienza a alcanzar tus metas</h2>

      <div v-if="successMessage" class="alert success-alert">
        {{ successMessage }}
      </div>

      <div v-if="errorMessage" class="alert error-alert">
        {{ errorMessage }}
      </div>

      <form @submit.prevent="handleRegister">
        <div class="input-group">
          <label for="username">Usuario</label>
          <input type="text" id="username" v-model="username" required />
        </div>

        <div class="input-group">
          <label for="email">Correo electrónico</label>
          <input type="email" id="email" v-model="email" required />
        </div>

        <div class="input-group">
          <label for="password">Contraseña</label>
          <input type="password" id="password" v-model="password" required />
        </div>

        <div class="input-group">
          <label for="confirmPassword">Confirmar contraseña</label>
          <input type="password" id="confirmPassword" v-model="confirmPassword" required />
        </div>

        <button type="submit" :disabled="isFormInvalid">Registrarse</button>
      </form>

      <div class="login-link">
        <p>¿Ya tienes cuenta? <router-link to="/login">Inicia sesión aquí</router-link></p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: "",
      email: "",
      password: "",
      confirmPassword: "",
      errorMessage: "",
      successMessage: "",
    };
  },
  computed: {
    isFormInvalid() {
      return (
        !this.username ||
        !this.email ||
        !this.password ||
        this.password !== this.confirmPassword
      );
    },
  },
  methods: {
    async handleRegister() {
      this.errorMessage = "";
      this.successMessage = "";
      try {
        const response = await fetch("http://127.0.0.1:8000/api/register/", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            username: this.username,
            email: this.email,
            password: this.password,
          }),
        });

        if (response.ok) {
          const data = await response.json();
          console.log("Registro exitoso", data);
          this.successMessage = "¡Usuario creado correctamente!";
          setTimeout(() => {
            this.$router.push("/login");
          }, 2000);
        } else {
          const errorData = await response.json();
          if (errorData.username) {
            this.errorMessage = `Error: ${errorData.username[0]}`;
          } else if (errorData.email) {
            this.errorMessage = `Error: ${errorData.email[0]}`;
          } else {
            this.errorMessage = "Error en el registro. Inténtalo de nuevo.";
          }
        }
      } catch (error) {
        this.errorMessage = "Error en la conexión. Verifica tu servidor.";
        console.error(error);
      }
    },
  },
};
</script>

<style scoped>
/* Estilos para alertas */
.alert {
  padding: 15px;
  margin-bottom: 20px;
  border-radius: 8px;
  font-size: 14px;
  text-align: center;
}

.success-alert {
  background-color: #e0ffe0;
  color: #007200;
  border: 1px solid #00c600;
}

.error-alert {
  background-color: #ffe0e0;
  color: #a10000;
  border: 1px solid #ff0000;
}

/* Mantener los demás estilos intactos */
body {
  margin: 0;
  font-family: 'Arial', sans-serif;
  background: linear-gradient(to right, #00c6ff, #0072ff);
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  color: #fff;
}

.register-container {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
}

.form-container {
  width: 100%;
  max-width: 380px;
  background: #fff;
  border-radius: 15px;
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
  padding: 40px 30px;
  text-align: center;
}

h1 {
  font-size: 34px;
  font-weight: bold;
  color: #333;
  margin-bottom: 20px;
}

.input-group {
  margin-bottom: 25px;
  position: relative;
}

label {
  font-size: 14px;
  font-weight: 600;
  color: #333;
  position: absolute;
  top: -18px;
  left: 12px;
  background-color: #fff;
  padding: 0 5px;
  border-radius: 5px;
}

input {
  width: 100%;
  padding: 15px;
  border: 2px solid #ccc;
  border-radius: 8px;
  font-size: 16px;
  box-sizing: border-box;
  transition: border-color 0.3s ease;
}

input:focus {
  border-color: #0072ff;
  outline: none;
}

button {
  width: 100%;
  padding: 15px;
  background-color: #00c6ff;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 18px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin-top: 15px;
}

button:hover {
  background-color: #0072ff;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.login-link {
  margin-top: 25px;
  font-size: 14px;
  color: #777;
}

.login-link a {
  color: #00c6ff;
  font-weight: bold;
  text-decoration: none;
  transition: color 0.3s ease;
}

.login-link a:hover {
  color: #0072ff;
}
</style>
