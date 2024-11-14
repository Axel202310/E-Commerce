<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.CarritoBD" %>
<%@ page import="modelo.Categorias" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Categoría</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            max-width: 1200px;
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
        <h2>Editar Categoría</h2>
        <%
            String idCategoria = request.getParameter("idCategoria");
            CarritoBD carritoBD = new CarritoBD();
            Categorias categoria = carritoBD.getCategoriaById(idCategoria);
            if (categoria != null) {
        %>
        <form action="editarCategoria.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="idCategoria" value="<%= categoria.getIdCategoria() %>">
            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <input type="text" class="form-control" id="descripcion" name="descripcion" value="<%= categoria.getDescripcion() %>" required>
            </div>

            <div class="mb-3">
                <label for="imagenURL" class="form-label">Imagen (URL o desde dispositivo):</label>
                <input type="text" class="form-control mb-2" id="imagenURL" name="imagenURL" placeholder="Ingresar URL de la imagen" value="<%= categoria.getImagen() %>">
                <input type="file" class="form-control" id="imagenFile" name="imagenFile" accept="image/*" onchange="actualizarCampoImagen(this)">
                <small class="form-text text-muted">Puedes ingresar una URL o seleccionar una imagen desde tu dispositivo. La imagen seleccionada sobrescribirá la URL.</small>
                
            </div>

          <div class="mb-3">
           <label for="estado" class="form-label">Estado</label>
           <select class="form-select" id="estado" name="estado" required>
               <option value="">Seleccionar estado...</option>
               <option value="1">Activo</option>
               <option value="0">Inactivo</option>
           </select>
           <div class="invalid-feedback">El estado es requerido.</div>
       </div>

            <button type="submit" class="btn btn-primary">Actualizar Categoría</button>
            <a href="gestionCategoria.jsp" class="btn btn-secondary">Cancelar</a>
        </form>

        <%
            } else {
        %>
            <div class="alert alert-danger mt-3" role="alert">
                Categoría no encontrada.
            </div>
        <%
            }

            if (request.getMethod().equalsIgnoreCase("POST")) {
                String descripcion = request.getParameter("descripcion");
                String imagen = null;

                Part filePart = request.getPart("imagenFile");
                if (filePart != null && filePart.getSize() > 0) {
                    String contentDisposition = filePart.getHeader("content-disposition");
                    String fileName = contentDisposition.substring(contentDisposition.indexOf("filename=") + 10, contentDisposition.length() - 1);
                    String imagePath = "" + fileName;
                    imagen = imagePath;

                    File uploads = new File(application.getRealPath("/") + "uploads");
                    if (!uploads.exists()) {
                        uploads.mkdirs();
                    }
                    File file = new File(uploads, fileName);
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, file.toPath());
                    } catch (IOException e) {
                        out.println("<div class='alert alert-danger mt-3'>Error al subir la imagen.</div>");
                    }
                } else {
                    imagen = request.getParameter("imagenURL");
                }

                char estado = request.getParameter("estado").charAt(0);
                Categorias categoriaActualizada = new Categorias(idCategoria, descripcion, imagen, estado);
                boolean exito = carritoBD.actualizarCategoria(categoriaActualizada);

                if (exito) {
                    response.sendRedirect("gestionCategoria.jsp?mensaje=Categoría actualizada correctamente.");
                } else {
                    out.println("<div class='alert alert-danger mt-3' role='alert'>Ocurrió un error al actualizar la categoría.</div>");
                }
            }
        %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
// Validación para el campo de descripción
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
    // Validar si contiene tanto números como letras
    else if (/\d/.test(descripcion) && /[a-zA-Z]/.test(descripcion)) {
        descripcionInput.setCustomValidity('Error: No se permite números en la descripción.');
    }
    // Validar longitud mínima
    else if (descripcion.length < 2) {
        descripcionInput.setCustomValidity('Error: Longitud mínima de 2 y máximo de 12 caracteres.');
    }
    // Validar longitud máxima
    else if (descripcion.length > 12) {
        descripcionInput.setCustomValidity('Error: Longitud mínima de 2 y máximo de 12 caracteres.');
    }
    // Validar caracteres especiales no permitidos
    else if (/[{}[\]@#$%^&*<>]/.test(descripcion)) { 
        descripcionInput.setCustomValidity('Error: La descripción tiene caracteres especiales no permitidos');
    }

    descripcionInput.reportValidity();
});
</script>


<script>
    const imagenInput = document.getElementById('imagen');
    const stockInput = document.getElementById('stock');
    const form = document.querySelector('form');

    // Validación de imagen
    imagenInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        imagenInput.setCustomValidity("");

        if (file) {
            const fileName = file.name.toLowerCase();
            
            // Validación del formato y del tamaño del nombre de archivo
            if (!fileName.endsWith('.jpg') && !fileName.endsWith('.jpeg') && !fileName.endsWith('.png')) {
                imagenInput.setCustomValidity('Solo se permite formato .jpg, .jpeg o .png');
            } else if (fileName.length < 6 || fileName.length > 50) {
                imagenInput.setCustomValidity('El nombre de la imagen debe tener entre 6 y 50 caracteres.');
            } else {
                imagenInput.setCustomValidity("");
            }
        } else {
            imagenInput.setCustomValidity('Falta rellenar el campo.');
        }

        imagenInput.reportValidity();
    });


    form.addEventListener('submit', function(event) {
        const file = imagenInput.files[0];
        const stockValue = stockInput.value.trim(); // Eliminar espacios en blanco
        const parsedStockValue = parseInt(stockValue); // Convertir a número entero

        // Validación de imagen al enviar el formulario
        if (!file) {
            event.preventDefault();
            imagenInput.setCustomValidity('Falta rellenar el campo.');
            imagenInput.reportValidity();
        } else if (!file.name.toLowerCase().endsWith('.jpg') && !file.name.toLowerCase().endsWith('.jpeg') && !file.name.toLowerCase().endsWith('.png')) {
            event.preventDefault();
            imagenInput.setCustomValidity('Solo se permite formato .jpg, .jpeg o .png');
            imagenInput.reportValidity();
        } else if (file.name.length < 6 || file.name.length > 50) {
            event.preventDefault();
            imagenInput.setCustomValidity('El nombre de la imagen debe tener entre 6 y 50 caracteres.');
            imagenInput.reportValidity();
        }

        
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
    document.addEventListener('DOMContentLoaded', function() {
        const imagenFileInput = document.getElementById('imagenFile');
        const imagenURLInput = document.getElementById('imagenURL');
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
            } else {
                imagenFileInput.setCustomValidity('');
            }
            imagenFileInput.reportValidity();
        }

        // Validar imagen en el evento de cambio y al enviar el formulario
        imagenFileInput.addEventListener('change', validateImageInput);
        imagenURLInput.addEventListener('input', validateImageInput);

        form.addEventListener('submit', function(event) {
            validateImageInput(); // Llamar a la validación al enviar el formulario
            if (!form.checkValidity()) {
                event.preventDefault(); // Prevenir el envío si hay errores
            }
        });
    });
</script>



</body>
</html>
