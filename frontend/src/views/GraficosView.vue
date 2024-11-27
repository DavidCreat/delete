<template>
  <div class="graficos-container">
    <h1>Tus Gráficos</h1>
    <div class="grafico">
      <h2>Progreso semanal</h2>
      <canvas id="graficoProgreso"></canvas>
    </div>
    <div class="grafico">
      <h2>Metas cumplidas</h2>
      <canvas id="graficoMetas"></canvas>
    </div>

    <div class="export-section">
      <h2>Generar Reportes</h2>
      <p>Descarga un reporte en PDF o Excel con tus actividades, metas y gráficos.</p>
      <button @click="generarPDF" class="btn-report">Generar PDF</button>
      <button @click="generarExcel" class="btn-report">Generar Excel</button>
    </div>
    <button @click="cerrarSesion" class="btn-cerrar-sesion">Cerrar Sesión</button>
  </div>
</template>

<script>
import Chart from "chart.js/auto";
import { useRouter } from "vue-router";

import jsPDF from "jspdf";
import "jspdf-autotable";
import * as XLSX from "xlsx";

export default {
  name: "GraficosView",
  setup() {
    const router = useRouter();

    const cerrarSesion = () => {
      localStorage.removeItem("accessToken");
      router.push("/login");
    };

    if (!localStorage.getItem("accessToken")) {
      router.push("/login");
    }

    const generarPDF = () => {
      const doc = new jsPDF();
      doc.setFont("helvetica", "bold");
      doc.setFontSize(18);
      doc.text("Reporte de Actividad Física", 20, 20);
      doc.addImage(document.getElementById("graficoProgreso").toDataURL(), "PNG", 20, 30, 180, 100);
      doc.addImage(document.getElementById("graficoMetas").toDataURL(), "PNG", 20, 140, 180, 100);

      doc.setFontSize(12);
      doc.text("Metas Cumplidas", 20, 250);
      doc.autoTable({
        startY: 260,
        head: [["Meta", "Descripción", "Estado"]],
        body: [
          ["Meta 1", "Correr 10 km en un mes", "Cumplida"],
          ["Meta 2", "Bajar 5 kg en dos meses", "Pendiente"],
          ["Meta 3", "Hacer 30 minutos de ejercicio diario", "Cumplida"],
          ["Meta 4", "Correr todo el malecon", "Cumplida"],
          ["Meta 5", "Nuevo record de flexiones de pecho (25)", "Cumplida"],
        ],
      });

      doc.text("Actividades Realizadas", 20, doc.lastAutoTable.finalY + 10);
      doc.autoTable({
        startY: doc.lastAutoTable.finalY + 20,
        head: [["Actividad", "Duración", "Fecha"]],
        body: [
          ["Correr 5 km", "30 minutos", "2024-11-20"],
          ["Bicicleta", "45 minutos", "2024-11-21"],
          ["Flexiones", "20 repeticiones", "2024-11-22"],
        ],
      });

      doc.save("reporte_actividad_fisica.pdf");
    };

    const generarExcel = () => {
      const workbook = XLSX.utils.book_new();

  
      const metasData = [
        ["Meta", "Descripción", "Estado"],
        ["Meta 1", "Correr 10 km en un mes", "Cumplida"],
        ["Meta 2", "Bajar 5 kg en dos meses", "Pendiente"],
        ["Meta 3", "Hacer 30 minutos de ejercicio diario", "Cumplida"],
        ["Meta 4", "Correr todo el malecon", "Cumplida"],
        ["Meta 5", "Nuevo record de flexiones de pecho (25)", "Cumplida"],
      ];


      const actividadesData = [
        ["Actividad", "Duración", "Fecha"],
        ["Correr 5 km", "30 minutos", "2024-11-20"],
        ["Bicicleta", "45 minutos", "2024-11-21"],
        ["Flexiones", "20 repeticiones", "2024-11-22"],
      ];


      const metasSheet = XLSX.utils.aoa_to_sheet(metasData);
      const actividadesSheet = XLSX.utils.aoa_to_sheet(actividadesData);

  
      console.log("Datos de actividades", actividadesData);

      XLSX.utils.book_append_sheet(workbook, metasSheet, "Metas");
      XLSX.utils.book_append_sheet(workbook, actividadesSheet, "Actividades");

  
      XLSX.writeFile(workbook, "reporte_actividad_fisica.xlsx");
    };

    return {
      cerrarSesion,
      generarPDF,
      generarExcel,
    };
  },
  mounted() {
    const ctxProgreso = document.getElementById("graficoProgreso");
    new Chart(ctxProgreso, {
      type: "line",
      data: {
        labels: ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"],
        datasets: [
          {
            label: "Progreso semanal",
            data: [5, 7, 3, 8, 6, 9, 10],
            borderColor: "rgba(75, 192, 192, 1)",
            borderWidth: 2,
            tension: 0.4,
            pointRadius: 5,
            pointBackgroundColor: "rgba(75, 192, 192, 1)",
          },
        ],
      },
    });

    const ctxMetas = document.getElementById("graficoMetas");
    new Chart(ctxMetas, {
      type: "bar",
      data: {
        labels: ["Meta 1", "Meta 2", "Meta 3", "Meta 4"],
        datasets: [
          {
            label: "Metas cumplidas",
            data: [3, 2, 4, 1],
            backgroundColor: [
              "rgba(255, 99, 132, 0.8)",
              "rgba(54, 162, 235, 0.8)",
              "rgba(255, 205, 86, 0.8)",
              "rgba(75, 192, 192, 0.8)",
            ],
            hoverBackgroundColor: [
              "rgba(255, 99, 132, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(255, 205, 86, 1)",
              "rgba(75, 192, 192, 1)",
            ],
          },
        ],
      },
    });
  },
};
</script>

<style scoped>
.graficos-container {
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
  text-align: center;
  background: linear-gradient(135deg, #f9f9f9, #e8e8e8);
  border-radius: 15px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
  animation: fadeIn 1s ease-in-out;
}

h1 {
  font-size: 2.5rem;
  margin-bottom: 20px;
  background: linear-gradient(90deg, #007cf0, #00dfd8);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.export-section {
  background-color: #f3f4f6;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  margin-top: 40px;
}

.export-section h2 {
  font-size: 1.8rem;
  margin-bottom: 10px;
}

.btn-report {
  background: linear-gradient(45deg, #28a745, #218838);
  color: white;
  padding: 12px 25px;
  border: none;
  border-radius: 25px;
  font-size: 1rem;
  font-weight: bold;
  text-transform: uppercase;
  cursor: pointer;
  margin: 5px;
  transition: all 0.3s ease;
}

.btn-report:hover {
  background: linear-gradient(45deg, #218838, #28a745);
  transform: scale(1.05);
}

.btn-cerrar-sesion {
  display: inline-block;
  background: linear-gradient(45deg, #ff6a00, #ee0979);
  color: white;
  padding: 12px 25px;
  border: none;
  border-radius: 25px;
  font-size: 1rem;
  font-weight: bold;
  text-transform: uppercase;
  cursor: pointer;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease;
}

.btn-cerrar-sesion:hover {
  background: linear-gradient(45deg, #ee0979, #ff6a00);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
  transform: scale(1.05);
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
