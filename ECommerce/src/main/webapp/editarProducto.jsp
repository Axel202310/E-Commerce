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
        String baseUrl = "";
        CarritoBD objBD = new CarritoBD();
        String idProducto = request.getParameter("idProducto");
        Productos producto = objBD.InfoProducto(idProducto);

        if (producto == null) {
            out.println("<div class='alert alert-danger' role='alert'>Error: Producto no encontrado.</div>");
            return;
        }

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            try {
                // Obtener valores de campos de formulario
                String idCategoria = request.getParameter("idCategoria").trim();
                String marca = request.getParameter("marca").trim();
                String descripcion = request.getParameter("descripcion").trim();
                double precioUnidad = Double.parseDouble(request.getParameter("precioUnidad").trim());
                int stock = Integer.parseInt(request.getParameter("stock").trim());
                char estado = request.getParameter("estado").charAt(0);

                // Procesar la imagen
                String imagen;
                Part filePart = request.getPart("imagenFile");
                if (filePart != null && filePart.getSize() > 0) {
                    // Extraer el nombre de archivo
                    String contentDisposition = filePart.getHeader("content-disposition");
                    String fileName = contentDisposition.substring(contentDisposition.indexOf("filename=") + 10, contentDisposition.length() - 1);
                    
                    // Guardar el archivo en el servidor en la carpeta "uploads"
                    File uploads = new File(application.getRealPath("/") + "");
                    if (!uploads.exists()) {
                        uploads.mkdirs();
                    }
                    File file = new File(uploads, fileName);
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, file.toPath());
                    } catch (IOException e) {
                        out.println("<div class='alert alert-danger mt-3'>Error al subir la imagen.</div>");
                    }
                    
                    // Construir la ruta de la imagen para almacenar en la base de datos
                    imagen = "/" + fileName;
                } else {
                    imagen = request.getParameter("imagenURL").trim();
                }

                // Crear el objeto producto actualizado
                Productos productoActualizado = new Productos(idProducto, idCategoria, marca, descripcion, precioUnidad, stock, imagen, estado);
                
                // Actualizar en la base de datos
                boolean actualizado = objBD.actualizarProducto(productoActualizado);
                if (actualizado) {
                    response.sendRedirect("consultaStock.jsp?mensaje=Producto actualizado correctamente.");
                    return;
                } else {
                    out.println("<div class='alert alert-danger'>Error al actualizar producto.</div>");
                }
            } catch (NumberFormatException e) {
                out.println("<div class='alert alert-danger'>Error: Formato numérico inválido.</div>");
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
   (function () {
       'use strict'
       var forms = document.querySelectorAll('.needs-validation')
       Array.prototype.slice.call(forms).forEach(function (form) {
           form.addEventListener('submit', function (event) {
               if (!form.checkValidity()) {
                   event.preventDefault()
                   event.stopPropagation()
               }
               form.classList.add('was-validated')
           }, false)
       })
   })()

   const marcaInput = document.getElementById('marca');

   marcaInput.addEventListener('input', function(event) {
       const marca = event.target.value;

       marcaInput.setCustomValidity("");

       if (!marca) {
           marcaInput.setCustomValidity('El campo de marca no puede estar vacío.');
       } else if (marca.trim().length === 0) {
           marcaInput.setCustomValidity('No puede ser solo espacios en blanco.');
       } else if (/\d/.test(marca)) {
           marcaInput.setCustomValidity('La marca no debe contener números.');
       } else if (/[^a-zA-Z\s]/.test(marca)) {
           marcaInput.setCustomValidity('La marca no debe contener caracteres especiales.');
       } else if (marca.length < 2 || marca.length > 28) {
           marcaInput.setCustomValidity('La marca debe tener entre 2 y 29 caracteres.');
       }

       marcaInput.reportValidity();
   });
</script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const imagenFileInput = document.getElementById('imagenFile');
        const imagenURLInput = document.getElementById('imagenURL');
        const stockInput = document.getElementById('stock');
        const form = document.querySelector('form');

        // Función para validar el campo de imagen
        function validateImageInput() {
            const file = imagenFileInput.files[0];
            const fileName = file ? file.name.toLowerCase() : '';

            // Verificar que exista un archivo o URL
            if (!file && imagenURLInput.value.trim() === "") {
                imagenFileInput.setCustomValidity('Falta rellenar el campo. Selecciona un archivo o ingresa una URL.');
            }
            // Verificar que el archivo tenga una extensión válida
            else if (file && !fileName.endsWith('.jpg') && !fileName.endsWith('.jpeg') && !fileName.endsWith('.png')) {
                imagenFileInput.setCustomValidity('Solo se permite formato .jpg, .jpeg o .png');
            }
            // Verificar la longitud del nombre del archivo
            else if (file && (fileName.length < 6 || fileName.length > 50)) {
                imagenFileInput.setCustomValidity('El nombre de la imagen debe tener entre 6 y 50 caracteres.');
            } else {
                imagenFileInput.setCustomValidity('');
            }
            imagenFileInput.reportValidity();
        }

        // Función para validar el campo de stock
        function validateStockInput() {
            const stockValue = stockInput.value.trim();
            const parsedStockValue = parseInt(stockValue, 10);

            if (/^\s+$/.test(stockValue)) {
                stockInput.setCustomValidity('No se permite ingresar solo espacio en blanco.');
            } 
            else if (stockValue === '') {
                stockInput.setCustomValidity('Falta rellenar el campo.');
            }
            else if (/\d\s+\d/.test(stockValue)) {
                stockInput.setCustomValidity('No se permite ingresar entre espacios.');
            }
            else if (/[a-zA-Z]/.test(stockValue)) {
                stockInput.setCustomValidity('No se permite ingresar letras.');
            }
            else if (/[^0-9\s]/.test(stockValue)) {
                stockInput.setCustomValidity('No se permiten caracteres especiales.');
            }
            else if (parsedStockValue < 1 || parsedStockValue > 10) {
                stockInput.setCustomValidity('Stock de 1 a 10 unidades.');
            } else {
                stockInput.setCustomValidity('');
            }
            stockInput.reportValidity();
        }

        // Validar imagen y stock en los eventos de cambio y al enviar el formulario
        imagenFileInput.addEventListener('change', validateImageInput);
        imagenURLInput.addEventListener('input', validateImageInput);
        stockInput.addEventListener('input', validateStockInput);

        form.addEventListener('submit', function(event) {
            validateImageInput();
            validateStockInput();
            if (!form.checkValidity()) {
                event.preventDefault(); // Prevenir el envío si hay errores
            }
        });
    });
</script>

<script>
//Validación para el campo de descripción
const descripcionInput = document.getElementById('descripcion');

descripcionInput.addEventListener('input', function(event) {
    const descripcion = event.target.value;
    descripcionInput.setCustomValidity("");

    // Validar descripción vacía
    if (descripcion.trim() === "") {
        descripcionInput.setCustomValidity('Error: Falta rellenar el campo.');
    } 
    // Validar descripción con solo números
    else if (/^\d+$/.test(descripcion)) {
        descripcionInput.setCustomValidity('Error: Descripción no puede contener solo números.');
    }
    // Validar descripción con solo caracteres especiales
    else if (/^[!\"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]+$/.test(descripcion)) {
        descripcionInput.setCustomValidity('Error: Descripción no puede contener solo caracteres especiales.');
    }
    // Validar que no comience con un número o carácter especial
    else if (/^[\d!\"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]/.test(descripcion)) {
        descripcionInput.setCustomValidity('Error: La descripción no puede comenzar con un número o un carácter especial.');
    }
    // Validar longitud mínima
    else if (descripcion.length < 9) {
        descripcionInput.setCustomValidity('Error: Longitud mínima de 9 y máximo de 124 caracteres.');
    }
    // Validar longitud máxima
    else if (descripcion.length > 124) {
        descripcionInput.setCustomValidity('Error: Longitud mínima de 9 y máximo de 124 caracteres.');
    }
 // Validar caracteres especiales no permitidos
    else if (/[{}[\]@#$%^&*<>]/.test(descripcion)) { 
        descripcionInput.setCustomValidity('Error: La descripcion tiene caracteres especiales no permitidos como @, #, $, %, *, {}, [], < >, ^, &');
    }

    descripcionInput.reportValidity();
   });

</script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const precioUnidadInput = document.getElementById('precioUnidad');

        precioUnidadInput.addEventListener('input', function () {
            let precioUnidadValue = precioUnidadInput.value.trim();
            let regexDecimal = /^\d+(\.\d{1,2})?$/; // Expresión regular para 2 decimales
            let regexEspacios = /\s/; // Expresión regular para detectar cualquier espacio

            // Reiniciar el mensaje de error
            precioUnidadInput.setCustomValidity("");

            // Validación: campo vacío
            if (precioUnidadValue === "") {
                precioUnidadInput.setCustomValidity("Error: El campo no puede estar vacío.");
            }
            // Validación: contiene espacios en blanco
            else if (regexEspacios.test(precioUnidadValue)) {
                precioUnidadInput.setCustomValidity("Error: No se permiten espacios en blanco.");
            }
            // Validación: no es un número
            else if (isNaN(precioUnidadValue)) {
                precioUnidadInput.setCustomValidity("Error: Debe ser un número válido.");
            }
            // Validación: número negativo o cero
            else if (parseFloat(precioUnidadValue) <= 0.99) {
                precioUnidadInput.setCustomValidity("Error: El precio debe ser mayor que cero.");
            }
            // Validación: número mayor a 30,000
            else if (parseFloat(precioUnidadValue) > 30000) {
                precioUnidadInput.setCustomValidity("Error: El precio no puede exceder los 30.000.");
            }
            // Validación: formato incorrecto (más de 2 decimales)
            else if (!regexDecimal.test(precioUnidadValue)) {
                precioUnidadInput.setCustomValidity("Error: El formato debe tener hasta 2 decimales.");
            }
            // Validación: caracteres especiales o letras
            else if (/[^0-9.]/.test(precioUnidadValue)) {
                precioUnidadInput.setCustomValidity("Error: Solo se permiten números y el punto decimal.");
            }

            // Actualiza el estado de validación visualmente
            precioUnidadInput.reportValidity();
        });
    });
</script>
<script>
    document.getElementById('estado').addEventListener('change', function() {
        if (this.value === "") {
            this.setCustomValidity("Por favor, selecciona un estado.");
        } else {
            this.setCustomValidity("");
        }
    });
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
