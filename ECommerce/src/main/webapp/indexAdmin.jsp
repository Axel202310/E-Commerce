<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="modelo.Usuarios" %>
<%@ page import="controller.CarritoBD" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel de Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        body {
            background-color: #f1f4f8; /* Fondo de la página */
            color: #333; /* Color de texto */
        }
        .navbar {
            margin-bottom: 20px; /* Espacio debajo de la navbar */
        }
        .card {
            border-radius: 10px; /* Borde redondeado de las tarjetas */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Sombra sutil */
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* Transiciones suaves */
        }
        .card:hover {
            transform: translateY(-5px); /* Efecto de elevación al pasar el mouse */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Sombra más pronunciada al pasar el mouse */
        }
        .btn-primary {
            background-color: #007bff; /* Color de fondo del botón */
            border-color: #007bff; /* Color del borde del botón */
        }
        .btn-primary:hover {
            background-color: #0056b3; /* Color de fondo del botón al pasar el mouse */
            border-color: #0056b3; /* Color del borde del botón al pasar el mouse */
        }
        .btn-primary:focus {
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.5); /* Sombra del botón al enfocarse */
        }
        .alert {
            border-radius: 0.25rem; /* Borde redondeado de las alertas */
        }
        .container {
            max-width: 1200px; /* Ancho máximo de la página */
        }
         .sidebar {
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            padding-top: 20px;
            background-color: #007bff;
        }
        .main-content {
            margin-left: 260px;
        }
        .sidebar h4 {
            margin-left: 15px;
            font-size: 1.25rem;
            font-weight: bold;
        }
        .nav-item {
           margin-top: 30px; /* Aumentar el espacio entre los elementos del menú */
        }

        .nav-link {
           padding: 15px; /* Mantener el padding para más espacio alrededor del texto */
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
    <%
        // Inicializar la sesión
        HttpSession sesion = request.getSession();
        
        // Obtener los datos del administrador de la sesión
        Usuarios admin = (Usuarios) sesion.getAttribute("ADMIN");
    %>
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
    </div>
    
<div class="main-content">
        <div class="container">
        <h1 class="mb-4">Panel de Administrador</h1>
        
        <% if(admin != null) { %>
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Datos del Administrador</h5>
                <p class="card-text"><strong>ID:</strong> <%= admin.getIdUsuario() %></p>
                <p class="card-text"><strong>Apellidos:</strong> <%= admin.getApellidos() %></p>
                <p class="card-text"><strong>Nombres:</strong> <%= admin.getNombres() %></p>
            </div>
        </div>
        <% } else { %>
        <div class="alert alert-danger" role="alert">
            Acceso no autorizado. Por favor, inicie sesión como administrador.
        </div>
        <% } %>
        
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Consultar Clientes</h5>
                        <p class="card-text">Ver la lista de clientes registrados en la tienda.</p>
                        <a href="consultaCliente.jsp" class="btn btn-primary">Ir a Consulta Clientes</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
               <div class="card">
                   <div class="card-body">
                       <h5 class="card-title">Consultar Categorias</h5>
                       <p class="card-text">Gestionar y modificar las categorias existentes.</p>
                       <a href="gestionCategoria.jsp" class="btn btn-primary">Ir a Consulta Categorias</a>
                   </div>
               </div>
           </div>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Consultar Productos</h5>
                        <p class="card-text">Gestionar y modificar los productos en la tienda.</p>
                        <a href="consultaStock.jsp" class="btn btn-primary">Ir a Consulta Productos</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Dashboard</h5>
                        <p class="card-text">Ver el detalle de una venta específica.</p>
                        <a href="reportes.jsp" class="btn btn-primary">Ir a Dashboard de Productos</a>
                    </div>
                </div>
            </div> 
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Reportes</h5>
                        <p class="card-text">Ver las ventas realizadas en la tienda.</p>
                        <a href="consultaVentas.jsp" class="btn btn-primary">Ir a Consulta Ventas</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-sbS2JTH7Y0h5Bs5Lty9iN4z9Kc3t8RoHZhZlH9C4tKq2w/eeGz8sA8b7aFZob6S" crossorigin="anonymous"></script>
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