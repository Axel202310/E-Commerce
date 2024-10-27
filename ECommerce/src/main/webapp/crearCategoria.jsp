<%@page import="javax.servlet.http.Part"%>
<%@page import="java.io.IOException"%>
<%@page import="controller.CarritoBD" %>
<%@page import="modelo.Categorias" %>
<%@page import="java.nio.file.Paths" %>
<%@page import="java.io.File" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.nio.file.Files" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Crear Categoría</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
    CarritoBD objBD = new CarritoBD();
    String nuevoIdCategoria = objBD.generarNuevoIdCategoria(); // Llamar al método para obtener el nuevo ID
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
    
<div class="container mt-5">
   <h2 class="mb-4">Crear Nueva Categoría</h2>
   <form method="post" action="crearCategoria.jsp" enctype="multipart/form-data" class="needs-validation" novalidate>
       <div class="mb-3">
           <label for="idCategoria" class="form-label">ID Categoría</label>
           <input type="text" class="form-control" id="idCategoria" name="idCategoria" maxlength="6" value="<%= nuevoIdCategoria %>" required>
           <div class="invalid-feedback">ID Categoría es requerido.</div>
       </div>
       <div class="mb-3">
           <label for="descripcion" class="form-label">Descripción</label>
           <input type="text" class="form-control" id="descripcion" name="descripcion" maxlength="150" required>
           <div class="invalid-feedback">Descripción es requerida.</div>
       </div>
       <div class="mb-3">
           <label for="imagen" class="form-label">Imagen</label>
           <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*" required>
           <div class="invalid-feedback">La imagen es requerida.</div>
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
       <button type="submit" class="btn btn-success">Crear Categoría</button>
       <a href="gestionCategoria.jsp" class="btn btn-secondary">Cancelar</a>
   </form>

<%
    

   if (request.getMethod().equalsIgnoreCase("POST")) {
       Part idCategoriaPart = request.getPart("idCategoria");
       Part descripcionPart = request.getPart("descripcion");
       Part estadoPart = request.getPart("estado");
       Part filePart = request.getPart("imagen");

       String idCategoria = new String(idCategoriaPart.getInputStream().readAllBytes(), "UTF-8").trim();
       String descripcion = new String(descripcionPart.getInputStream().readAllBytes(), "UTF-8").trim();
       String estadoStr = new String(estadoPart.getInputStream().readAllBytes(), "UTF-8").trim();
       
       char estado = '1';
       String imagen = "";  // Solo el nombre del archivo se guardará en la variable imagen

       try {
           if (!estadoStr.isEmpty()) {
               estado = estadoStr.charAt(0);
           } else {
               out.println("<div class='alert alert-danger'>Error: El campo Estado es requerido.</div>");
               return;
           }

         // Procesar la imagen solo si el filePart no es nulo y tiene contenido
           if (filePart != null && filePart.getSize() > 0) {
               String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // Obtener solo el nombre del archivo
                          
               // Definir la ruta de almacenamiento en una carpeta específica
               File uploads = new File(application.getRealPath("/"));
               if (!uploads.exists()) {
                   uploads.mkdirs(); // Crear los directorios si no existen
               }
               File file = new File(uploads, fileName);

               try (InputStream input = filePart.getInputStream()) {
                   Files.copy(input, file.toPath());
                   imagen = fileName;  // Guarda la ruta de la imagen correctamente
               } catch (IOException e) {
                   out.println("<div class='alert alert-danger mt-3'>Error al subir la imagen: " + e.getMessage() + "</div>");
                   return;
               }
           } else {
               out.println("<div class='alert alert-danger'>Error: La imagen es requerida.</div>");
               return;
           }

       } catch (IOException e) {
           out.println("<div class='alert alert-danger mt-3'>Error al subir la imagen: " + e.getMessage() + "</div>");
           return;
       }

       // Crear nueva categoría
       Categorias nuevaCategoria = new Categorias(idCategoria, descripcion, imagen, estado); // Aquí imagen contiene solo el nombre del archivo
       
       // Registrar la categoría
       boolean registrada = objBD.registrarCategoria(nuevaCategoria);

       if (registrada) {
           response.sendRedirect("gestionCategoria.jsp");
       } else {
           out.println("<div class='alert alert-danger mt-3'>Error al crear categoría.</div>");
       }
   }
%>


</div>

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
</body>
</html>
