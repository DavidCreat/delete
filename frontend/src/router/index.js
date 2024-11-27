import { createRouter, createWebHistory } from "vue-router";
import LoginComponent from "@/components/LoginComponent.vue";
import RegisterComponent from "@/components/RegisterComponent.vue";
import DashboardView from "@/views/DashboardView.vue";
import ActividadesView from "@/views/ActividadesView.vue";
import MetasView from "@/views/MetasView.vue";
import GraficosView from "@/views/GraficosView.vue";

const routes = [
  { path: "/", redirect: "/login" },
  { path: "/login", name: "Login", component: LoginComponent },
  { path: "/register", name: "Register", component: RegisterComponent },
  { 
    path: "/dashboard", 
    name: "Dashboard", 
    component: DashboardView, 
    meta: { requiresAuth: true }, 
  },
  { 
    path: "/actividades", 
    name: "Actividades", 
    component: ActividadesView, 
    meta: { requiresAuth: true }, 
  },
  { 
    path: "/metas", 
    name: "Metas", 
    component: MetasView, 
    meta: { requiresAuth: true },
  },
  { 
    path: "/graficos", 
    name: "Graficos", 
    component: GraficosView, 
    meta: { requiresAuth: true }, 
  },
  { path: "/:pathMatch(.*)*", redirect: "/login" },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});


router.beforeEach((to, from, next) => {
  const isAuthenticated = localStorage.getItem("accessToken");
  if (to.matched.some(record => record.meta.requiresAuth) && !isAuthenticated) {
    next("/login");
  } else {
    next(); 
  }
});

export default router;
