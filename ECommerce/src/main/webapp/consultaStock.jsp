<%@page import="java.util.List"%>
<%@ page import="controller.CarritoBD" %>
<%@ page import="modelo.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consulta de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Color de fondo */
            color: #343a40; /* Color de texto */
        }
        th {
            background-color: #007bff; /* Color de fondo del encabezado de la tabla */
            color: #ffffff; /* Color del texto del encabezado de la tabla */
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 123, 255, 0.05); /* Color de fondo de filas impares */
        }
        img {
            width: 100px; 
            height: 100px; 
            object-fit: cover; /* Para asegurar que la imagen mantenga la proporción */
        }
        /* Flexbox layout */
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
            margin-left: 260px; /* Ajuste para que no se superponga con la barra lateral */
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
    
    

        <!-- Main content -->
        <div class="main-content">
            <%-- Instanciar la clase CarritoBD --%>
            <% CarritoBD carritoBD = new CarritoBD(); %>

            <%-- Manejo de la búsqueda --%>
            <%
                String terminoBusqueda = request.getParameter("terminoBusqueda");
                List<Productos> listaProductos;
                List<Categorias> listaCategorias = carritoBD.ListarCategorias(); // Cargar la lista de categorías

                if (terminoBusqueda != null && !terminoBusqueda.trim().isEmpty()) {
                    listaProductos = carritoBD.buscarProducto(terminoBusqueda.trim());
                } else {
                    listaProductos = carritoBD.listarProductos();
                }
            %>

            <h2 class="mt-5 mb-4">Consulta de Productos</h2>
            <!-- Botón para redirigir a crearProducto.jsp -->
            <a href="crearProducto.jsp" class="btn btn-success mb-3">
                <i class="fas fa-plus"></i> Añadir Nuevo Producto
            </a>

            <!-- Sección de búsqueda -->
            <div class="search-section">
                <form method="get" action="consultaStock.jsp" class="row g-3">
                    <div class="col-md-8">
                        <label for="searchInput" class="form-label">Buscar por ID o descripción:</label>
                        <input type="text" class="form-control" name="terminoBusqueda" placeholder="Ingrese el ID o Descripción del producto" value="<%= (terminoBusqueda != null) ? terminoBusqueda : "" %>" required>
                    </div>
                    <div class="col-md-4 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary me-2"><i class="fas fa-search"></i> Buscar</button>
                        <a href="consultaStock.jsp" class="btn btn-secondary"><i class="fas fa-undo"></i> Resetear</a>
                    </div>
                </form>
            </div>

            <!-- Tabla de productos -->
            <table class="table table-striped mt-4">
                <thead>
                    <tr>
                        <th style="vertical-align: middle; text-align: center;">ID Producto</th>
                        <th style="vertical-align: middle; text-align: center;">Imagen</th>
                        <th style="vertical-align: middle; text-align: center;">Categoría</th>
                        <th style="vertical-align: middle; text-align: center;">Marca</th>
                        <th style="vertical-align: middle; text-align: center;">Descripción</th>
                        <th style="vertical-align: middle; text-align: center;">Precio Unidad</th>
                        <th style="vertical-align: middle; text-align: center;">Stock</th>             
                        <th style="vertical-align: middle; text-align: center;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (listaProductos.isEmpty()) { %>
                        <tr>
                            <td colspan="9" class="text-center">No se encontraron productos.</td>
                        </tr>
                    <% } else { %>
                        <% for (Productos producto : listaProductos) { %>
                            <tr>
                                <td style="height: 70px; vertical-align: middle; text-align: center;"><%= producto.getIdProducto() %></td>
                                <td style="height: 70px; vertical-align: middle; text-align: center;">
                          
                                    <img src="img/<%= producto.getImagen() %>">
                                </td>
                                <td style="height: 70px; vertical-align: middle;">
                                    <% 
                                        String descripcionCategoria = "Sin categoría";
                                        for (Categorias categoria : listaCategorias) {
                                            if (categoria.getIdCategoria().equals(producto.getIdCategoria())) {
                                                descripcionCategoria = categoria.getDescripcion();
                                                break;
                                            }
                                        }
                                    %>
                                    <%= descripcionCategoria %>
                                </td>
                                <td style="height: 70px; vertical-align: middle;"><%= producto.getMarca() %></td>
                                <td style="height: 70px; vertical-align: middle;"><%= producto.getDescripcion() %></td>
                                <td style="height: 70px; vertical-align: middle; text-align: center;">S/ <%= String.format("%.2f", producto.getPrecioUnidad()) %></td>
                                <td style="height: 70px; vertical-align: middle; text-align: center;"><%= producto.getStock() %></td>
                                <td style="vertical-align: middle; text-align: center;">
                                    <div class="d-flex">
                                        <a href="editarProducto.jsp?idProducto=<%= producto.getIdProducto() %>" class="btn btn-warning btn-sm me-2 d-flex align-items-center">
                                            <i class="fas fa-edit me-1"></i>
                                            Editar
                                        </a>
                                        <form method="post" action="eliminarProducto.jsp" class="d-inline">
                                            <input type="hidden" name="idProducto" value="<%= producto.getIdProducto() %>">
                                            <button type="submit" class="btn btn-danger btn-sm d-flex align-items-center" onclick="return confirm('¿Estás seguro de eliminar este producto?');">
                                                <i class="fas fa-trash-alt me-1"></i>
                                                Eliminar
                                            </button>
                                        </form>
                                         <!-- Botón de habilitar/deshabilitar -->
<a href="toggleEstadoProducto.jsp?idProducto=<%= producto.getIdProducto() %>&estadoActual=<%= producto.getEstado() %>" 
    class="btn btn-sm <%= producto.getEstado() == '1' ? "btn-secondary" : "btn-success" %> ms-2 d-flex align-items-center">
    <i class="fas <%= producto.getEstado() == '1' ? "fa-ban" : "fa-check" %> me-1"></i>
    <%= producto.getEstado() == '1' ? "Deshabilitar" : "Habilitar" %>
</a>
                                        
                                        
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Scripts de Bootstrap -->
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