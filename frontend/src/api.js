import axios from "axios";

const api = axios.create({
  baseURL: process.env.VUE_APP_API_URL || 'http://193.180.209.112/:8001',
});

api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem("accessToken");
    if (token) {
      config.headers["Authorization"] = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default api;