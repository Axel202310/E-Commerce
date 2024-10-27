<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Detalle" %>
<%@ page import="controller.CarritoBD" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado de Detalle de Venta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            display: flex;
            align-items: center;
        }
        .sidebar h4 i {
            margin-right: 10px;
            cursor: pointer;
        }
        .nav-item {
            margin-top: 20px;
        }
        .nav-link {
            padding: 15px;
        }
        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.2);
            color: #ffffff;
        }
        .nav-link.active {
            background-color: #0056b3;
            color: #ffffff;
        }
        /* Inicialmente ocultamos las opciones del menú */
        .nav-options {
            display: none;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar bg-primary text-white">
        <h4 onclick="toggleMenu()">
            <i class="fas fa-bars"></i> Panel de Administrador
        </h4>
        <ul class="nav flex-column nav-options" id="navOptions">
            <li class="nav-item">
                <a class="nav-link text-white" href="consultaCliente.jsp">
                    <i class="fas fa-users"></i> Consultar Clientes
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="gestionCategoria.jsp">
                    <i class="fas fa-tags"></i> Consultar Categorías
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="consultaStock.jsp">
                    <i class="fas fa-box"></i> Consultar Productos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="listadoDetalleVenta.jsp">
                    <i class="fas fa-list"></i> Listado de Detalle
                </a>
            </li>
             <li class="nav-item">
                    <a class="nav-link text-white" href="reportes.jsp"><i class="fas fa-shopping-cart"></i> Dashboard</a>
              </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="consultaVentas.jsp">
                    <i class="fas fa-shopping-cart"></i> Consultar Ventas
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="logout.jsp">
                    <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                </a>
            </li>
        </ul>
    </div>

    <div class="main-content container">
        <h1 class="mt-5 mb-4">Listado de Detalle de Venta</h1>
        
        <div class="row">
            <div class="col-md-6">
                <form method="post">
                    <div class="mb-3">
                        <label for="idDetalle" class="form-label">Ingrese el ID de la Venta:</label>
                        <input type="text" class="form-control" id="idDetalle" name="idDetalle" placeholder="Ej. DTA0000001">
                    </div>
                    <button type="submit" class="btn btn-primary">Buscar Detalle</button>
                </form>
            </div>
        </div>

        <% 
            if (request.getMethod().equalsIgnoreCase("post")) {
                String idDetalle = request.getParameter("idDetalle");
                
                if (idDetalle != null && idDetalle.matches("DTA[0-9]{7}")) {
                    try {
                        CarritoBD carritoBD = new CarritoBD();
                        List<Detalle> detalleVenta = carritoBD.obtenerIdDetalle(idDetalle);
                        
                        if (!detalleVenta.isEmpty()) {
        %>

        <div class="row mt-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Detalle de la Venta</h5>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Id Detalle</th>
                                    <th>ID Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio Unitario</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    for (Detalle detalle : detalleVenta) {
                                %>
                                    <tr>
                                        <td><%= detalle.getIdDetalle() %></td>
                                        <td><%= detalle.getIdProducto() %></td>
                                        <td><%= detalle.getCantidad() %></td>
                                        <td><%= detalle.getPrecioUnidad() %></td>
                                        <td><%= detalle.getCantidad() * detalle.getPrecioUnidad() %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <% 
                        } else {
        %>
        <div class="alert alert-warning mt-4" role="alert">
            No se encontraron detalles para la venta ID <%= idDetalle %>.
        </div>
        <% 
                        }
                    } catch (Exception e) {
        %>
        <div class="alert alert-danger mt-4" role="alert">
            Error al obtener el detalle de la venta. Por favor, inténtelo de nuevo más tarde.
        </div>
        <% 
                    }
                } else {
        %>
        <div class="alert alert-danger mt-4" role="alert">
            Formato de ID de venta no válido.
        </div>
        <% 
                }
            }
        %>
    </div>

    <!-- Scripts de Bootstrap y JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleMenu() {
            const navOptions = document.getElementById('navOptions');
            if (navOptions.style.display === 'none' || navOptions.style.display === '') {
                navOptions.style.display = 'block';
            } else {
                navOptions.style.display = 'none';
            }
        }
    </script>
</body>
</html>
