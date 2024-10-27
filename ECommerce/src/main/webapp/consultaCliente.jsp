<%@page import="java.util.List"%>
<%@page import="modelo.*" %>
<%@page import="controller.CarritoBD" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consulta de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
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
        
    </style>
</head>
<body>
    <!-- Sidebar -->
   <div class="sidebar bg-primary text-white">
    <h4><a href="indexAdmin.jsp" class="text-white" style="text-decoration: none;">Panel de Administrador</a></h4>
    <ul class="nav flex-column">
        <li class="nav-item"style="margin-top: 60px;" >
            <a class="nav-link text-white" href="consultaCliente.jsp">
                <i class="fas fa-users"></i> Consultar Clientes
            </a>
        </li>
        <li class="nav-item" style="margin-top: 20px;"> <!-- Increased margin-top -->
            <a class="nav-link text-white" href="gestionCategoria.jsp">
                <i class="fas fa-tags"></i> Consultar Categorías
            </a>
        </li>
        <li class="nav-item" style="margin-top: 20px;"> <!-- Increased margin-top -->
            <a class="nav-link text-white" href="consultaStock.jsp">
                <i class="fas fa-box"></i> Consultar Productos
            </a>
        </li>
        <li class="nav-item" style="margin-top: 20px;"> <!-- Increased margin-top -->
            <a class="nav-link text-white" href="listadoDetalleVenta.jsp">
                <i class="fas fa-list"></i> Listado de Detalle
            </a>
        </li>
        <li class="nav-item" style="margin-top: 20px;"> <!-- Increased margin-top -->
            <a class="nav-link text-white" href="consultaVentas.jsp">
                <i class="fas fa-shopping-cart"></i> Consultar Ventas
            </a>
        </li>
        <li class="nav-item" style="margin-top: 20px;"> <!-- Increased margin-top -->
            <a class="nav-link text-white" href="logout.jsp">
                <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
            </a>
        </li>
    </ul>
</div> 
    <div class="container">
        <h1 class="mt-5 mb-4">Consulta de Usuarios</h1>
        
        <div class="mb-3">
            <label for="searchInput" class="form-label">Buscar por ID:</label>
            <input type="text" class="form-control" id="searchInput" onkeyup="filterTable()" placeholder="Ingrese el ID del usuario">
        </div>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID Usuario</th>
                    <th>Apellidos</th>
                    <th>Nombres</th>
                    <th>Correo</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody id="clientTableBody">
                <% 
                    // Obtener lista de clientes de tipo USER
                    CarritoBD carritoBD = new CarritoBD();
                    List<Usuarios> listaClientes = carritoBD.ListarUsuarios();
                    
                    // Iterar sobre la lista de clientes y mostrar la información en la tabla
                    for (Usuarios cliente : listaClientes) {
                        if ("USER".equals(cliente.getTipoUsuario())) { // Asegura solo clientes
                            String estado = cliente.getEstado() == '1' ? "Habilitado" : "Deshabilitado";
                %>
                    <tr>
                        <td><%= cliente.getIdUsuario() %></td>
                        <td><%= cliente.getApellidos() %></td>
                        <td><%= cliente.getNombres() %></td>
                        <td><%= cliente.getCorreo() %></td>
                        <td><%= estado %></td>
                        <td>
							<form method="post" action="cambiarEstadoUsuario.jsp">
							    <input type="hidden" name="correoUsuario" value="<%= cliente.getCorreo() %>">
							    <input type="hidden" name="nuevoEstado" value="<%= cliente.getEstado() == '1' ? '0' : '1' %>">
							    <button type="submit" class="btn <%= cliente.getEstado() == '1' ? "btn-warning" : "btn-success" %>">
							        <%= cliente.getEstado() == '1' ? "Deshabilitar" : "Habilitar" %>
							    </button>
							</form>

                        </td>
                    </tr>
                <% 
                        }
                    } 
                %>
            </tbody>
        </table>
        
    </div>
    
    <script>
        function filterTable() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("clientTableBody");
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
</body>
</html>