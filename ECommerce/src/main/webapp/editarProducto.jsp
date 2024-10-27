<%@page import="java.io.IOException"%>
<%@page import="controller.CarritoBD" %>
<%@page import="modelo.*" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.nio.file.Files" %>
<%@page import="java.io.File" %>
<%@page import="javax.servlet.http.Part" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 30px;
        }
        h2 {
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: bold;
        }
        .alert {
            margin-top: 20px;
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
    <script>
        function actualizarCampoImagen(input) {
            var fileName = input.files[0].name;
            document.getElementById("imagenURL").value = fileName;
        }
    </script>
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
    
    <div class="container">
        <h2>Editar Producto</h2>
        <%
            String baseUrl = "https://raw.githubusercontent.com/MirellaYu/Imagenes/main/img/";
            CarritoBD objBD = new CarritoBD();
            String idProducto = request.getParameter("idProducto");
            Productos producto = objBD.InfoProducto(idProducto);

            if (producto == null) {
                out.println("<div class='alert alert-danger' role='alert'>Error: Producto no encontrado.</div>");
                return;
            }

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                Part idCategoriaPart = request.getPart("idCategoria");
                Part marcaPart = request.getPart("marca");
                Part descripcionPart = request.getPart("descripcion");
                Part precioUnidadPart = request.getPart("precioUnidad");
                Part stockPart = request.getPart("stock");
                Part estadoPart = request.getPart("estado");

                String idCategoria = new String(idCategoriaPart.getInputStream().readAllBytes(), "UTF-8").trim();
                String marca = new String(marcaPart.getInputStream().readAllBytes(), "UTF-8").trim();
                String descripcion = new String(descripcionPart.getInputStream().readAllBytes(), "UTF-8").trim();
                String precioUnidadStr = new String(precioUnidadPart.getInputStream().readAllBytes(), "UTF-8").trim();
                String stockStr = new String(stockPart.getInputStream().readAllBytes(), "UTF-8").trim();
                String estadoStr = new String(estadoPart.getInputStream().readAllBytes(), "UTF-8").trim();

                double precioUnidad = 0.0;
                int stock = 0;
                char estado = '1';

                try {
                    if (!precioUnidadStr.isEmpty()) {
                        precioUnidad = Double.parseDouble(precioUnidadStr);
                    } else {
                        out.println("<div class='alert alert-danger'>Error: El campo Precio Unidad es requerido.</div>");
                        return;
                    }

                    if (!stockStr.isEmpty()) {
                        stock = Integer.parseInt(stockStr);
                    } else {
                        out.println("<div class='alert alert-danger'>Error: El campo Stock es requerido.</div>");
                        return;
                    }

                    if (!estadoStr.isEmpty()) {
                        estado = estadoStr.charAt(0);
                    } else {
                        out.println("<div class='alert alert-danger'>Error: El campo Estado es requerido.</div>");
                        return;
                    }
                } catch (NumberFormatException e) {
                    out.println("<div class='alert alert-danger'>Error: Formato numérico inválido.</div>");
                    return;
                }

                String imagen = null;
                Part filePart = request.getPart("imagenFile");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = filePart.getSubmittedFileName();
                    if (!fileName.toLowerCase().endsWith(".png") && !fileName.toLowerCase().endsWith(".jpg") && !fileName.toLowerCase().endsWith(".jpeg")) {
                        out.println("<div class='alert alert-danger'>Error: Solo se permiten archivos de imagen (.png, .jpg, .jpeg).</div>");
                        return;
                    }
                    imagen = baseUrl + fileName;
                } else {
                    imagen = request.getParameter("imagenURL");
                }

                Productos productoActualizado = new Productos(idProducto, idCategoria, marca, descripcion, precioUnidad, stock, imagen, estado);
                boolean actualizado = objBD.actualizarProducto(productoActualizado);
                if (actualizado) {
                    response.sendRedirect("consultaStock.jsp?mensaje=Producto actualizado correctamente.");
                } else {
                    out.println("<div class='alert alert-danger'>Error al actualizar producto.</div>");
                }
            }
        %>

        <form method="POST" action="editarProducto.jsp?idProducto=<%=producto.getIdProducto()%>" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="idProducto" class="form-label">ID Producto:</label>
                <input type="text" class="form-control" id="idProducto" name="idProducto" value="<%=producto.getIdProducto()%>" readonly>
            </div>

            <div class="mb-3">
                <label for="idCategoria" class="form-label">Categoría:</label>
                <select class="form-select" id="idCategoria" name="idCategoria" required>
                    <option value="">Seleccione una categoría</option>
                    <%
                        List<Categorias> categorias = objBD.ListarCategorias(); 
                        for (Categorias cat : categorias) {
                            String selected = producto.getIdCategoria().equals(cat.getIdCategoria()) ? "selected" : "";
                    %>
                        <option value="<%=cat.getIdCategoria()%>" <%= selected %>><%=cat.getDescripcion()%></option>
                    <%
                        }
                    %>
                </select>
                <div class="invalid-feedback">Categoría es requerida.</div>
            </div>

            <div class="mb-3">
                <label for="marca" class="form-label">Marca:</label>
                <input type="text" class="form-control" id="marca" name="marca" value="<%=producto.getMarca()%>" required>
            </div>

            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción:</label>
                <textarea class="form-control" id="descripcion" name="descripcion" required><%=producto.getDescripcion()%></textarea>
            </div>

            <div class="mb-3">
                <label for="precioUnidad" class="form-label">Precio Unidad:</label>
                <input type="number" step="0.01" class="form-control" id="precioUnidad" name="precioUnidad" value="<%=producto.getPrecioUnidad()%>" required>
            </div>

            <div class="mb-3">
                <label for="stock" class="form-label">Stock:</label>
                <input type="number" class="form-control" id="stock" name="stock" value="<%=producto.getStock()%>" required>
            </div>

            <div class="mb-3">
                <label for="estado" class="form-label">Estado:</label>
                <select class="form-select" id="estado" name="estado" required>
                    <option value="1" <%= producto.getEstado() == '1' ? "selected" : "" %>>Activo</option>
                    <option value="0" <%= producto.getEstado() == '0' ? "selected" : "" %>>Inactivo</option>
                </select>
            </div>

            <div class="form-group mb-3">
            <label for="imagenURL">Imagen (URL o desde dispositivo):</label>
            <input type="text" class="form-control mb-2" id="imagenURL" name="imagenURL" placeholder="Ingresar URL de la imagen" value="<%=producto.getImagen()%>">
            <input type="file" class="form-control" id="imagenFile" name="imagenFile" accept="image/*" onchange="actualizarCampoImagen(this)">
            <small class="form-text text-muted">Puedes ingresar una URL o seleccionar una imagen desde tu dispositivo. La imagen seleccionada sobrescribirá la URL.</small>
        </div>

            <button type="submit" class="btn btn-success">Actualizar Producto</button>
            <a href="consultaStock.jsp" class="btn btn-secondary">Cancelar</a>
        </form>
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