<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="modelo.Categorias" %>
<%@ page import="controller.CarritoBD" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <title>Gestión de Categorías</title>
   <!-- Bootstrap CSS -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
   <!-- Font Awesome CSS -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
   <style>
       body {
           background-color: #f8f9fa;
           color: #343a40;
           font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
       }
       th {
           background-color: #007bff;
           color: #ffffff;
       }
       .table-striped tbody tr:nth-of-type(odd) {
           background-color: rgba(0, 123, 255, 0.05);
       }
       .btn-action {
           margin-right: 5px;
       }
       .search-section {
           margin-bottom: 20px;
       }
       .container {
            max-width: 1200px;
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
    </div>
   <div class="container mt-4">
       <h2 class="mb-4">Gestión de Categorías</h2>
       <a href="crearCategoria.jsp" class="btn btn-success mb-3">
           <i class="fas fa-plus"></i> Añadir Nueva Categoría
       </a>

       <!-- Sección de búsqueda por ID -->
       <div class="mb-3">
           <label for="searchInput" class="form-label">Buscar por ID de Categoría:</label>
           <input type="text" class="form-control" id="searchInput" onkeyup="filterTable()" placeholder="Ingrese el ID de la categoría">
       </div>
       
     <table class="table table-striped">
    <thead>
        <tr>
            <th class="text-center align-middle">ID Categoría</th>
            <th class="text-center align-middle">Descripción</th>
            <th class="text-center align-middle">Imagen</th>
            <th class="text-center align-middle">Estado</th>
            <th class="text-center align-middle">Acciones</th>
        </tr>
    </thead>
    <tbody id="categoryTableBody">
        <%
            CarritoBD carritoBD = new CarritoBD();
            List<Categorias> listaCategorias = carritoBD.ListarCategorias();
            if (listaCategorias.isEmpty()) {
        %>
        <tr>
            <td colspan="5" class="text-center">No se encontraron categorías.</td>
        </tr>
        <%
            } else {
                for (Categorias categoria : listaCategorias) {
        %>
        <tr>
            <td class="text-center align-middle"><%= categoria.getIdCategoria() %></td>
            <td class="text-center align-middle"><%= categoria.getDescripcion() %></td>
            <td class="text-center align-middle">
                <img src="img/<%= categoria.getImagen() %>" 
                     alt="Imagen de <%= categoria.getDescripcion() %>" 
                     width="100" height="100">
            </td>
            <td class="text-center align-middle"><%= categoria.getEstado() == '1' ? "Activo" : "Inactivo" %></td>
            <td class="text-center align-middle">
                <div class="d-flex justify-content-center">
                    <a href="editarCategoria.jsp?idCategoria=<%= categoria.getIdCategoria() %>" 
                       class="btn btn-warning btn-sm me-2 d-flex align-items-center">
                        <i class="fas fa-edit me-1"></i> Editar
                    </a>
                    <form action="eliminarCategoria.jsp" method="post" class="d-inline">
                        <input type="hidden" name="idCategoria" value="<%= categoria.getIdCategoria() %>">
                        <button type="submit" class="btn btn-danger btn-sm d-flex align-items-center" 
                                onclick="return confirm('¿Estás seguro de eliminar esta categoría?');">
                            <i class="fas fa-trash-alt me-1"></i> Eliminar
                        </button>
                    </form>
                </div>
            </td>
        </tr>
        <%
                }
            }
        %>
    </tbody>
</table>
     
   </div>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"></script>

   <!-- Script para filtrar la tabla por ID de Categoría -->
   <script>
        function filterTable() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("categoryTableBody");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }       
            }
        }
    </script>
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