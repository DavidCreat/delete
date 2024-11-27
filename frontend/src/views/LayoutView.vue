<template>
    <div>
      <header>
        <h1>Plataforma de Actividad Física</h1>
        <nav>
          <ul>
            <li><router-link to="/dashboard">Dashboard</router-link></li>
            <li><router-link to="/actividades">Actividades</router-link></li>
            <li><router-link to="/progreso">Progreso</router-link></li>
            <li><router-link to="/metas">Metas</router-link></li>
            <li><button @click="logout">Cerrar Sesión</button></li>
          </ul>
        </nav>
      </header>
      <main>
        <router-view />
      </main>
    </div>
  </template>
  
  <script>
  export default {
    methods: {
      logout() {
        localStorage.removeItem("token");
        this.$router.push("/login");
      },
    },
  };
  </script>
  
  <style>
  header {
    background-color: #f5f5f5;
    padding: 15px;
    text-align: center;
  }
  nav ul {
    list-style: none;
    padding: 0;
  }
  nav ul li {
    display: inline;
    margin: 0 10px;
  }
  </style>
  