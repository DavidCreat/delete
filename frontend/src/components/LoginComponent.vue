<template>
  <div class="login-container">
    <div class="form-container">
      <br>
      <h1>¡Bienvenido a FitFusion!</h1>
      <h2>Inicia sesión para continuar</h2>
      <br>
      <br>

      <form @submit.prevent="handleSubmit">
        <div class="input-group">
          <label for="username">Usuario</label>
          <input type="text" id="username" v-model="username" required />
        </div>
        <br>
        <div class="input-group">
          <label for="password">Contraseña</label>
          <input type="password" id="password" v-model="password" required />
        </div>

        <button type="submit">Iniciar sesión</button>
      </form>

      <div v-if="errorMessage" class="error-message">
        <p>{{ errorMessage }}</p>
      </div>

      <div class="register-link">
        <p>¿No tienes cuenta? <router-link to="/register">Regístrate aquí</router-link></p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: '',
      password: '',
      errorMessage: ''
    };
  },
  methods: {
    async handleSubmit() {
      try {
        const response = await fetch("http://127.0.0.1:8000/api/login/", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            username: this.username,
            password: this.password
          })
        });

        if (response.ok) {
          const data = await response.json();
          localStorage.setItem("accessToken", data.access);
          localStorage.setItem("refreshToken", data.refresh);

          // Espera un momento antes de redirigir (previene errores en la redirección)
          setTimeout(() => {
            this.$router.push("/dashboard");
          }, 500);
        } else {
          const errorData = await response.json();
          this.errorMessage = errorData.error || "Credenciales inválidas";
        }
      } catch (error) {
        this.errorMessage = "Error en la conexión";
        console.error(error);
      }
    }
  }
};
</script>


<style scoped>
body {
  margin: 0;
  font-family: 'Arial', sans-serif;
  background: linear-gradient(135deg, #6a11cb, #2575fc);
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  color: #fff;
  overflow: hidden;
}

.login-container {
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

p {
  font-size: 16px;
  color: #777;
  margin-bottom: 30px;
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

.register-link {
  margin-top: 25px;
  font-size: 14px;
  color: #777;
}

.register-link a {
  color: #00c6ff;
  font-weight: bold;
  text-decoration: none;
  transition: color 0.3s ease;
}

.register-link a:hover {
  color: #0072ff;
}

.error-message {
  color: red;
  font-size: 14px;
  margin-top: 15px;
}


</style>