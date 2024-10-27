<%@page import="java.util.List"%>
<%@page import="modelo.*" %>
<%@page import="controller.CarritoBD" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    // Obtener el ID del usuario a eliminar desde la solicitud
    String idUsuario = request.getParameter("idUsuario");
    String action = request.getParameter("action");
    
    if ("delete".equals(action)) {
        // Crear una instancia de la clase CarritoBD y eliminar el usuario
        CarritoBD carritoBD = new CarritoBD();
        carritoBD.EliminarUsuario(idUsuario);
        
        // Redirigir a consultaCliente.jsp después de eliminar
        response.sendRedirect("consultaCliente.jsp");
        return; // Asegurarse de que el resto del código no se ejecute
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Confirmar Eliminación</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Estilo para la confirmación de eliminación */
.message-container {
    max-width: 600px;
    margin:  0 auto ;
    padding: 40px;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    position: fixed; /* Cambiar a fixed para superponer sobre el fondo */
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 10; /* Asegurar que esté delante del overlay */
}

/* Estilo para el contenido de fondo con transparencia */
.overlay-container {
    position: relative; /* Mantener relative */
    z-index: 1; /* Menor z-index que el mensaje */
    opacity: 0.5; /* Mantener opacidad */
    
}
        body {
            background-color: #f8f9fa;
        }
        
        h1 {
            color: black; 
            font-family: Poppins, sans-serif; 
            font-size: 24px; 
            font-weight: 550;
        }
        p {
            font-family: Poppins, sans-serif; 
            font-size: 18px;
        }
        .btn-accept {
            background-color: #33b5e7; /* Color verde */
            color: #ffffff; /* Texto blanco */
            border: none;
            padding: 10px 20px; /* Padding de 10px vertical y 20px horizontal */
            font-size: 18px;
            margin-top: 15px;
        }
        .btn-accept:hover {
            background-color: #33b5e7; 
            color: #ffffff;
        }
        .btn-cancel {
            background-color: #454545; 
            color: #ffffff; 
            border: none;
            text-decoration: none; 
            padding: 10px 20px;
            font-size: 18px;
            margin-top: 15px;
        }
        .btn-cancel:hover {
            background-color: #454545; 
            color: #ffffff; 
        }
        .alert-icon {
            font-size: 120px; /* Aumenta el tamaño del icono */
            color: #dc3545; /* Color rojo */
            margin-bottom: 10px; /* Espacio debajo del icono */
        }
    </style>
</head>
<body>
    <!-- Mensaje de confirmación de eliminación -->
    <div class="message-container">
        <i class="fas fa-exclamation-triangle alert-icon"></i>
        <h1 style="margin-top: 20px;">Eliminar usuario</h1>
        <p>A continuación el usuario será ELIMINADO</p>
        <form action="eliminarUsuario.jsp" method="post" style="display:inline;">
            <input type="hidden" name="idUsuario" value="<%= idUsuario %>">
            <input type="hidden" name="action" value="delete">
            <button type="submit" class="btn btn-accept">Aceptar</button>
        </form>
        <a href="consultaCliente.jsp" class="btn btn-cancel">Cancelar</a>
    </div>

    <!-- Contenido de fondo con transparencia -->
    <div class="overlay-container" >
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <a class="navbar-brand">Panel de Administrador</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" >Consultar Clientes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" >Consultar Ventas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" >Consultar Stock</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" >Listado de Detalle</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link">Cerrar Sesión</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Tabla de consulta de usuarios -->
        <div class="container">
            <h1 class="mt-5 mb-4">Consulta de Usuarios</h1>
            <div class="mb-3">
                <label for="searchInput" class="form-label">Buscar por ID:</label>
                <input type="text" class="form-control" id="searchInput" placeholder="Ingrese el ID del usuario">
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Usuario</th>
                        <th>Apellidos</th>
                        <th>Nombres</th>
                        <th>Correo</th>
                        <th>Teléfono</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="clientTableBody">
                    <% 
                        CarritoBD carritoBD = new CarritoBD();
                        List<Usuarios> listaClientes = carritoBD.ListarUsuarios();
                        
                        for (Usuarios cliente : listaClientes) {
                    %>
                        <tr>
                            <td><%= cliente.getIdUsuario() %></td>
                            <td><%= cliente.getNombres() %></td>
                            <td><%= cliente.getApellidos() %></td>
                            <td><%= cliente.getCorreo() %></td>
                            <td><%= cliente.getDireccion() %></td>
                            <td>                               
                               <button type="submit" class="btn btn-danger">Eliminar</button>                           
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>