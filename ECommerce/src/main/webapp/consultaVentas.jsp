<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.*" %>
<%@ page import="controller.CarritoBD" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consulta de Ventas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
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

        /* Borde gris claro para la tabla */
        .table-bordered {
            border: 1px solid #dee2e6;
        }
        .table-bordered th, .table-bordered td {
            border: 1px solid #dee2e6;
        }

        /* Ajustar el contenedor de la tabla */
        .table-container {
            padding: 5px; /* Reducir el padding alrededor del contenedor a 5px */
            overflow-x: auto; /* Permitir el scroll horizontal si es necesario */
            white-space: nowrap; /* Evitar que las celdas se dividan en varias líneas */
            margin: 0 auto; /* Centrar el contenedor de la tabla */
        }

        /* Hacer que la tabla ocupe todo el espacio disponible */
        .table {
            width: 100%;
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
            margin-left: 260px; /* Ajusta el margen según el ancho de la barra lateral */
            padding: 20px;
        }

        /* Ajustar el contenedor blanco */
        .bg-white {
            width: 1500px;
            padding: 5px; /* Reducir el padding dentro del contenedor blanco */
            max-width: 1500px; /* Asegura que no haya sobrepaso en dispositivos móviles */
        }

        /* Estilos para el buscador */
        .search-bar {
            margin-bottom: 20px;
        }
        
        /* Ajustar el ancho de la columna Cliente al tamaño deseado sin truncar */
        .table th:nth-child(2), .table td:nth-child(2) {
            width: 200px; /* Mantiene el ancho fijo */
            max-width: 200px; /* Limita el ancho máximo */
            white-space: normal; /* Permite que el texto se divida en varias líneas */
            overflow-wrap: break-word; /* Ajusta las palabras largas para que no desborden */
        }

        /* Ajustar el ancho de la columna Producto al tamaño deseado sin truncar */
        .table th:nth-child(3), .table td:nth-child(3) {
            width: 300px; /* Mantiene el ancho fijo */
            max-width: 300px; /* Limita el ancho máximo */
            white-space: normal; /* Permite que el texto se divida en varias líneas */
            overflow-wrap: break-word; /* Ajusta las palabras largas para que no desborden */
        }
        
        
        /* Estilos para el contenedor de Exportar Ventas */
        .export-container {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 117%;
        }

        .export-container h3 {
            font-size: 24px;
            color: black;
            margin-bottom: 15px;
        }

        .form-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-download {
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 95px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-download i {
            font-size: 18px;
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
        <div class="main-content container" style="margin-top: 100px;">
           <!-- Contenedor de Exportar Ventas -->
           <div class="export-container">
              <h3>Exportar Ventas</h3>        
               <hr style="border: 1px solid gray; margin-top: 20px; margin-bottom: 30px">
               <form action="reporteExcel.jsp" method="GET">
                <div class="form-group" style="display: flex; align-items: center; gap: 15px;">
           
                 <div>
                   <label for="startDate" style="font-family: Arial; font-weight: 400; font-size: 18px;">Fecha Inicio:</label>
                   <input type="date" id="startDate" name="startDate"  class="form-control" style="width: 400px;" required>
                 </div>

                 <div>
                   <label for="endDate" style="font-family: Arial; font-weight: 400; font-size: 18px;">Fecha Fin:</label>
                   <input type="date" id="endDate" name="endDate" class="form-control" style="width: 400px;" required>
                 </div>

                  <!-- Botón de Descargar -->
                 <div>
                    <button type="submit" class="btn-download" style="margin-top: 25px; ">
                       <i class="fas fa-cloud-download-alt"></i> Descargar
                    </button>
                 </div>
               </div>
             </form>
            
          </div>






            <h2 class="mt-5 mb-4"></h2>
            
            <!-- Contenedor blanco para la tabla -->
            <div class="table-container bg-white p-4 rounded shadow">
                <h3 style="font-family: Arial; font-weight: bold; font-size: 24px;"><i class="fas fa-list"></i> Listado de Ventas</h3>
                <hr style="border: 1px solid gray; margin-top: 20px; margin-bottom: 40px">
                <table class="table table-striped table-bordered">
                
    <thead>
        <tr>
            <th>ID Venta 
                <button onclick="sortTable(0, 'idVenta')" style="background: none; border: none;">
                     <i class="fas fa-sort"></i>
                </button>
            </th>
            <th>Cliente 
                <button onclick="sortTable(1, 'text')" style="background: none; border: none;">
                    <i class="fas fa-sort"></i>
                </button>
            </th>
            <th>Producto
                <button onclick="sortTable(2, 'text')" style="background: none; border: none;">
                    <i class="fas fa-sort"></i>
                </button>
            </th>
            <th>Cantidad 
                <button onclick="sortTable(3, 'number')" style="background: none; border: none;">
                    <i class="fas fa-sort"></i>
                </button>
            </th>
            <th>Precio unitario 
                <button onclick="sortTable(4, 'number')" style="background: none; border: none;">
                    <i class="fas fa-sort"></i>
                </button>
            </th>
            <th>Método Pago</th>
            <th>Monto Total 
                <button onclick="sortTable(6, 'number')" style="background: none; border: none;">
                    <i class="fas fa-sort"></i>
                </button>
            </th>
            <th>Fecha 
                <button onclick="sortTable(7, 'date')" style="background: none; border: none;">
                    <i class="fas fa-sort"></i>
                </button>
            </th>
        </tr>
    </thead>
    <tbody id="ventaTableBody">
        <% 
            // Crear una instancia de CarritoBD
            CarritoBD carritoBD = new CarritoBD();
            // Obtener la lista de ventas
            List<Ventas> ventas = carritoBD.listarVentas1();
            // Verificar si hay ventas
            if (ventas != null && !ventas.isEmpty()) {
                // Iterar sobre la lista de ventas
                for (Ventas venta : ventas) {
                    Usuarios cliente = carritoBD.InfoUsuario(venta.getIdCliente()); // Obtener info del cliente
                    List<Detalle> detallesVenta = carritoBD.obtenerDetalleVenta(venta.getIdVenta()); // Obtener detalles                
                    String metodoPago = carritoBD.obtenerMetodoPago(venta.getIdMetodoPago());

                    // Iterar sobre cada detalle de la venta para mostrar los productos individualmente
                    if (detallesVenta != null && !detallesVenta.isEmpty()) {
                        for (Detalle detalle : detallesVenta) {
                            Productos producto = carritoBD.InfoProducto(detalle.getIdProducto()); // Obtener info del producto
                            double montoTotalProducto = detalle.getCantidad() * detalle.getPrecioUnidad();
        %>
                            <tr>
                                <td><%= venta.getIdVenta() %></td>
                                <td><%= cliente != null ? cliente.getNombres() + " " + cliente.getApellidos() : "Cliente no disponible" %></td> <!-- Nombre del cliente -->
                                <td><%= producto != null ? producto.getDescripcion() : "Producto no disponible" %></td> <!-- Descripción del producto -->
                                <td><%= detalle.getCantidad() %></td> <!-- Cantidad del producto -->
                                <td><%= String.format("%.2f", detalle.getPrecioUnidad()) %></td> <!-- Precio unitario -->
                                <td><%= metodoPago != null ? metodoPago : "Método de pago no disponible" %></td> <!-- Método de pago -->
                                <td><%= String.format("%.2f", montoTotalProducto) %></td> <!-- Monto Total para ese producto -->
                                <td><%= venta.getFechaVenta() %></td>
                            </tr>
        <%
                        } // Fin del bucle de detalles
                    }
                } // Fin del bucle de ventas
            } else {
        %>
            <tr>
                <td colspan="8">No hay ventas registradas.</td>
            </tr>
        <% } // Fin del condicional de ventas %>
    </tbody>
</table>
            </div> <!-- Fin del contenedor blanco -->
            
        </div>
    </div>
    
    
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

<script>

//Función para ordenar la tabla
function sortTable(columnIndex, type) {
    var table = document.querySelector("tbody"); // Obtener el cuerpo de la tabla
    var rows = Array.from(table.rows); // Convertir las filas a un array para poder ordenarlas
    var ascending = table.getAttribute("data-sort-direction") !== "asc"; // Alternar entre ascendente y descendente

    // Ordenar las filas en función del tipo de datos
    rows.sort(function (rowA, rowB) {
        var cellA = rowA.cells[columnIndex].innerText.trim().toLowerCase();
        var cellB = rowB.cells[columnIndex].innerText.trim().toLowerCase();

        if (type === 'number') {
            // Eliminar "S/." y comas, convertir a número para comparar correctamente
            cellA = parseFloat(cellA.replace(/[^0-9.-]+/g,"")) || 0; // Convertir a número
            cellB = parseFloat(cellB.replace(/[^0-9.-]+/g,"")) || 0;
        } else if (type === 'date') {
            cellA = new Date(cellA); // Convertir a fecha
            cellB = new Date(cellB);
        } else if (type === 'idVenta') {
            // Extraer la parte numérica del ID Venta (e.g., VTA0000001 -> 1)
            cellA = parseInt(cellA.replace(/\D/g,''), 10) || 0;
            cellB = parseInt(cellB.replace(/\D/g,''), 10) || 0;
        }

        if (ascending) {
            return cellA > cellB ? 1 : -1;
        } else {
            return cellA < cellB ? 1 : -1;
        }
    });

    // Reordenar las filas en el DOM
    rows.forEach(function (row) {
        table.appendChild(row); // Reinsertar las filas ordenadas
    });

    // Guardar la nueva dirección de orden
    table.setAttribute("data-sort-direction", ascending ? "asc" : "desc");
}
</script>

</body>
</html>
    