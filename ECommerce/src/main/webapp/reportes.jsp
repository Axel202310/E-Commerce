<%@page import="java.util.List"%>
<%@ page import="controller.CarritoBD" %>
<%@ page import="modelo.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Administrativo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            background-color: #f8f9fa;
            color: #343a40;
        }
        th {
            background-color: #007bff;
            color: #ffffff;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 123, 255, 0.05);
        }
        img {
            width: 100px;
            height: 100px;
            object-fit: cover;
        }
        .flex-container {
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #007bff;
            padding-top: 20px;
            position: fixed;
            top: 0;
            left: 0;
            color: white;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
            margin-left: 260px;
        }
        .sidebar h4 {
            margin-left: 15px;
            font-size: 1.25rem;
            font-weight: bold;
        }
        .nav-item {
            margin-top: 30px;
        }
        .nav-link {
            padding: 15px;
            transition: background-color 0.3s;
        }
        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.2);
            color: #ffffff;
        }
        .nav-link.active {
            background-color: #0056b3;
            color: #ffffff;
        }
    </style>
</head>
<body>
     <!-- Determinar si estamos en la página 'consultaVentas.jsp' -->
    <%
        // Variable que indicará si estamos en la página consultaVentas.jsp
        String currentPage = request.getRequestURI();
        boolean isConsultaVentasPage = currentPage.contains("consultaVentas.jsp");
    %>

    <!-- Flex container for sidebar and main content -->
    <div class="flex-container">
        <!-- Sidebar -->
        <div class="sidebar bg-primary text-white">
            <h4><a href="indexAdmin.jsp" class="text-white" style="text-decoration: none;">Panel de Administrador</a></h4>
            <ul class="nav flex-column">
                <li class="nav-item" style="margin-top: 60px;">
                    <a class="nav-link text-white" href="consultaCliente.jsp">
                        <i class="fas fa-users"></i> Consultar Clientes
                    </a>
                </li>
                <li class="nav-item" style="margin-top: 20px;">
                    <a class="nav-link text-white" href="gestionCategoria.jsp">
                        <i class="fas fa-tags"></i> Consultar Categorías
                    </a>
                </li>
                <li class="nav-item" style="margin-top: 20px;">
                    <a class="nav-link text-white" href="consultaStock.jsp">
                        <i class="fas fa-box"></i> Consultar Productos
                    </a>
                </li>
                 <li class="nav-item"style="margin-top: 20px;">
                    <a class="nav-link text-white" href="reportes.jsp"><i class="fas fa-chart-line"></i> Dashboard</a>
                </li>
                <!-- Opción de Reportes con submenú -->
                <li class="nav-item" style="margin-top: 20px;">
                    <a class="nav-link text-white" href="#" onclick="toggleSubMenu('reportesSubMenu')">
                        <i class="fas fa-chart-bar"></i> Reportes
                    </a>
                    <!-- Submenú para Reportes -->
                    <ul id="reportesSubMenu" class="nav flex-column" style="display: <%= isConsultaVentasPage ? "block" : "none" %>; margin-left: 20px;">
                        <li class="nav-item" style="margin-top: 10px;">
                            <a class="nav-link text-white" href="consultaVentas.jsp">
                                <i class="fas fa-shopping-cart"></i> Consultar Ventas
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item" style="margin-top: 20px;">
                    <a class="nav-link text-white" href="logout.jsp">
                        <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                    </a>
                </li>
            </ul>
        </div>
    

        <!-- Main Content -->
        <div class="main-content">
            <% CarritoBD carritoBD = new CarritoBD(); %>
            <h1 class="mb-4">Dashboard de Productos</h1>

            <!-- Metrics -->
            <div class="row mb-5">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <h5 class="card-title">Total de Productos</h5>
                            <p class="card-text">
                                <% List<Productos> listaProductos = carritoBD.listarProductos(); %>
                                <%= listaProductos.size() %>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <h5 class="card-title">Total de Categorías</h5>
                            <p class="card-text">
                                <% List<Categorias> listaCategorias = carritoBD.ListarCategorias(); %>
                                <%= listaCategorias.size() %>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <h5 class="card-title">Stock Total</h5>
                            <p class="card-text">
                                <%
                                    int totalStock = 0;
                                    for (Productos producto : listaProductos) {
                                        totalStock += producto.getStock();
                                    }
                                %>
                                <%= totalStock %>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts -->
            <div class="row">
                <!-- Productos por Categoría -->
                <div class="col-lg-6 mb-4">
                    <canvas id="productosPorCategoriaChart"></canvas>
                </div>

                <!-- Stock por Categoría -->
                <div class="col-lg-6 mb-4">
                    <canvas id="stockPorCategoriaChart"></canvas>
                </div>

                <!-- Ventas Totales -->
                <div class="col-lg-6 mb-4">
                    <canvas id="ventasChart"></canvas>
                </div>

                <!-- Productos por Marca -->
                <div class="col-lg-6 mb-4">
                    <canvas id="productosPorMarcaChart"></canvas>
                </div>
            </div>

            <!-- JavaScript para gráficos -->
            <script>
                // Productos por Categoría
                const ctx1 = document.getElementById('productosPorCategoriaChart').getContext('2d');
                const productosPorCategoriaChart = new Chart(ctx1, {
                    type: 'bar',
                    data: {
                        labels: [
                            <% for (Categorias categoria : listaCategorias) { %>
                                '<%= categoria.getDescripcion() %>',
                            <% } %>
                        ],
                        datasets: [{
                            label: 'Cantidad de productos',
                            data: [
                                <% for (Categorias categoria : listaCategorias) { 
                                    int count = 0;
                                    for (Productos producto : listaProductos) {
                                        if (producto.getIdCategoria().equals(categoria.getIdCategoria())) {
                                            count++;
                                        }
                                    }
                                %>
                                    <%= count %>,
                                <% } %>
                            ],
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });

                // Stock por Categoría
                const ctx2 = document.getElementById('stockPorCategoriaChart').getContext('2d');
                const stockPorCategoriaChart = new Chart(ctx2, {
                    type: 'bar',
                    data: {
                        labels: [
                            <% for (Categorias categoria : listaCategorias) { %>
                                '<%= categoria.getDescripcion() %>',
                            <% } %>
                        ],
                        datasets: [{
                            label: 'Stock por Categoría',
                            data: [
                                <% for (Categorias categoria : listaCategorias) {
                                    int stockCategoria = 0;
                                    for (Productos producto : listaProductos) {
                                        if (producto.getIdCategoria().equals(categoria.getIdCategoria())) {
                                            stockCategoria += producto.getStock();
                                        }
                                    }
                                %>
                                    <%= stockCategoria %>,
                                <% } %>
                            ],
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });

                // Ventas Totales
                const ctx3 = document.getElementById('ventasChart').getContext('2d');
                const ventasData = [
                    <% 
                        List<Ventas> ventas = carritoBD.listarVentas1();
                        for (Ventas venta : ventas) { 
                    %>
                        {
                            fecha: '<%= venta.getFechaVenta() %>',
                            monto: <%= venta.getMontoTotal() %>
                        },
                    <% } %>
                ];
                const labelsVentas = ventasData.map(v => v.fecha);
                const dataVentas = ventasData.map(v => v.monto);
                const ventasChart = new Chart(ctx3, {
                    type: 'bar',
                    data: {
                        labels: labelsVentas,
                        datasets: [{
                            label: 'Monto Total de Ventas',
                            data: dataVentas,
                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });

                // Productos por Marca
                const ctx4 = document.getElementById('productosPorMarcaChart').getContext('2d');
                const productosPorMarcaData = listaProductos.reduce((acc, producto) => {
                    acc[producto.getMarca()] = (acc[producto.getMarca()] || 0) + 1;
                    return acc;
                }, {});
                const productosPorMarcaChart = new Chart(ctx4, {
                    type: 'pie',
                    data: {
                        labels: Object.keys(productosPorMarcaData),
                        datasets: [{
                            label: 'Cantidad de productos por Marca',
                            data: Object.values(productosPorMarcaData),
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.6)',
                                'rgba(54, 162, 235, 0.6)',
                                'rgba(255, 206, 86, 0.6)',
                                'rgba(75, 192, 192, 0.6)',
                                'rgba(153, 102, 255, 0.6)',
                                'rgba(255, 159, 64, 0.6)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true
                    }
                });
            </script>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
      <!-- JavaScript para mostrar/ocultar el submenú -->
<script>
    function toggleSubMenu(id) {
        var subMenu = document.getElementById(id);
        if (subMenu.style.display === "none" || subMenu.style.display === "") {
            subMenu.style.display = "block";
        } else {
            subMenu.style.display = "none";
        }
    }
</script>
</body>
</html>