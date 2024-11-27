// proyecto2024/frontend/src/main.js

import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import axios from 'axios';

// Configuración global de axios
axios.defaults.baseURL = 'http://127.0.0.1:8000';  // Base URL del backend

createApp(App)
  .use(router)
  .mount('#app');
