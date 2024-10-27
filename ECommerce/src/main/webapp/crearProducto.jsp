<%@page import="javax.servlet.http.Part"%>
<%@page import="java.io.IOException"%>
<%@page import="controller.CarritoBD" %>
<%@page import="modelo.Productos" %>
<%@page import="modelo.Categorias" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Crear Producto</title>
   <!-- Bootstrap CSS -->
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
<div class="container mt-5">
<%
   CarritoBD objBD = new CarritoBD();
   String nuevoIdProducto = objBD.generarNuevoIdProducto(); // Llamar al método para obtener el nuevo ID
%>
   <h2>Crear Nuevo Producto</h2>
   <!-- Formulario para crear el producto -->
<form method="post" action="crearProducto.jsp" enctype="multipart/form-data" class="needs-validation" novalidate>
   <div class="row mb-3">
       <div class="col">
           <label for="idProducto" class="form-label">ID Producto</label>
           <input type="text" class="form-control" id="idProducto" name="idProducto" maxlength="8" value="<%= nuevoIdProducto %>" readonly>
           <div class="invalid-feedback">ID Producto es requerido.</div>
       </div>
           <div class="col">
               <label for="idCategoria" class="form-label">Categoría</label>
               <select class="form-select" id="idCategoria" name="idCategoria" required>
                   <option value="">Seleccione una categoría</option>
                   <%
                       List<Categorias> categorias = objBD.ListarCategorias(); // Método para obtener todas las categorías
                       for (Categorias cat : categorias) {
                   %>
                   <option value="<%=cat.getIdCategoria()%>"><%=cat.getDescripcion()%></option>
                   <%
                       }
                   %>
               </select>
               <div class="invalid-feedback">ID Categoría es requerido.</div>
           </div>
       </div>
       <div class="mb-3">
           <label for="marca" class="form-label">Marca</label>
           <input type="text" class="form-control" id="marca" name="marca" maxlength="100" required>
           <div class="invalid-feedback">Marca es requerida.</div>
       </div>
       <div class="mb-3">
           <label for="descripcion" class="form-label">Descripción</label>
           <input type="text" class="form-control" id="descripcion" name="descripcion" maxlength="150" required>
           <div class="invalid-feedback">Descripción es requerida.</div>
       </div>
       <div class="mb-3">
    <label for="precioUnidad" class="form-label">Precio por Unidad</label>
    <input type="text" class="form-control" id="precioUnidad" name="precioUnidad" required>
    <div class="invalid-feedback" id="errorPrecioUnidad">Precio es requerido.</div>
      </div>
       <div class="mb-3">
           <label for="stock" class="form-label">Stock</label>
           <input type="text" class="form-control" id="stock" name="stock"  required>
       </div>
       <div class="mb-3">
           <label for="imagen" class="form-label">Imagen</label>
           <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*" required>
           <div class="invalid-feedback">La imagen es requerida.</div>
       </div>
       <div class="mb-3">
    <label for="estado" class="form-label">Estado</label>
    <select class="form-select" id="estado" name="estado" required>
        <option value="" disabled selected>Seleccionar estado</option>
        <option value="1">Activo</option>
        <option value="0">Inactivo</option>
    </select>
    <div class="invalid-feedback">El estado es requerido.</div>
</div>
       <button type="submit" class="btn btn-success">Crear Producto</button>
       <a href="consultaStock.jsp" class="btn btn-secondary">Cancelar</a>
       
   </form>

   <%
       if (request.getMethod().equalsIgnoreCase("POST")) {
           Part idProductoPart = request.getPart("idProducto");
           Part idCategoriaPart = request.getPart("idCategoria");
           Part marcaPart = request.getPart("marca");
           Part descripcionPart = request.getPart("descripcion");
           Part precioUnidadPart = request.getPart("precioUnidad");
           Part stockPart = request.getPart("stock");
           Part estadoPart = request.getPart("estado");

           String idProducto = new String(idProductoPart.getInputStream().readAllBytes(), "UTF-8").trim();
           String idCategoria = new String(idCategoriaPart.getInputStream().readAllBytes(), "UTF-8").trim();
           String marca = new String(marcaPart.getInputStream().readAllBytes(), "UTF-8").trim();
           String descripcion = new String(descripcionPart.getInputStream().readAllBytes(), "UTF-8").trim();
           String precioUnidadStr = new String(precioUnidadPart.getInputStream().readAllBytes(), "UTF-8").trim();
           String stockStr = new String(stockPart.getInputStream().readAllBytes(), "UTF-8").trim();
           String estadoStr = new String(estadoPart.getInputStream().readAllBytes(), "UTF-8").trim();

           double precioUnidad = 0.0;
           int stock = 0;
           String imagen = "";
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

               Part filePart = request.getPart("imagen");
               if (filePart != null && filePart.getSize() > 0) {
                   String contentDisposition = filePart.getHeader("content-disposition");
                   String fileName = contentDisposition.substring(contentDisposition.indexOf("filename=") + 10, contentDisposition.length() - 1);

                   String imagePath = "/" + fileName;
                   imagen = imagePath;

                   File uploads = new File(application.getRealPath("/"));
                   if (!uploads.exists()) {
                       uploads.mkdirs();
                   }
                   File file = new File(uploads, fileName);
                   try (InputStream input = filePart.getInputStream()) {
                       Files.copy(input, file.toPath());
                   }
               }

           } catch (NumberFormatException e) {
               out.println("<div class='alert alert-danger mt-3'>Error: Formato de número inválido.</div>");
           } catch (IOException e) {
               out.println("<div class='alert alert-danger mt-3'>Error al subir la imagen.</div>");
           }

           Productos nuevoProducto = new Productos(idProducto, idCategoria, marca, descripcion, precioUnidad, stock, imagen, estado);
           boolean registrado = objBD.registrarProducto(nuevoProducto);

           if (registrado) {
               response.sendRedirect("consultaStock.jsp");
           } else {
               out.println("<div class='alert alert-danger mt-3'>Error al crear producto.</div>");
           }
       }
   %>
</div>

<!-- Scripts de Bootstrap -->
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

    // Validación de stock
    stockInput.addEventListener('input', function(event) {
        const stockValue = stockInput.value;

        // Limpiar cualquier mensaje de error anterior
        stockInput.setCustomValidity("");

        // Verificar si solo hay espacios en blanco
        if (/^\s+$/.test(stockValue)) {
            stockInput.setCustomValidity('No se permite ingresar solo espacio en blanco.');
        }
        // Validar si el campo está vacío
        else if (stockValue.trim() === '') {
            stockInput.setCustomValidity('Falta rellenar el campo.');
        }
        // Verificar si hay un espacio " " entre números
        else if (/\d\s+\d/.test(stockValue)) {
            stockInput.setCustomValidity('No se permite ingresar entre espacios.');
        }
        // Verificar si contiene letras (mayúsculas o minúsculas)
        else if (/[a-zA-Z]/.test(stockValue)) {
            stockInput.setCustomValidity('No se permite ingresar letras.');
        }
        // Verificar si contiene otros caracteres especiales
        else if (/[^0-9\s]/.test(stockValue)) {
            stockInput.setCustomValidity('No se permiten caracteres especiales.');
        }
        // Validar si el número está fuera del rango permitido (debe ser entre 1 y 10)
        else if (parseInt(stockValue.trim()) < 1 || parseInt(stockValue.trim()) > 10) {
            stockInput.setCustomValidity('Stock de 1 a 10 unidades.');
        }

        stockInput.reportValidity();
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

        // Validación de stock al enviar el formulario
        if (/^\s+$/.test(stockValue)) {
            event.preventDefault();
            stockInput.setCustomValidity('No se permite ingresar solo espacio en blanco.');
            stockInput.reportValidity();
        } 
        else if (stockValue === '') {
            event.preventDefault();
            stockInput.setCustomValidity('Falta rellenar el campo.');
            stockInput.reportValidity();
        }
        else if (/\d\s+\d/.test(stockValue)) {
            event.preventDefault();
            stockInput.setCustomValidity('No se permite ingresar entre espacios.');
            stockInput.reportValidity();
        }
        else if (/[a-zA-Z]/.test(stockValue)) {
            event.preventDefault();
            stockInput.setCustomValidity('No se permite ingresar letras.');
            stockInput.reportValidity();
        }
        else if (/[^0-9\s]/.test(stockValue)) {
            event.preventDefault();
            stockInput.setCustomValidity('No se permiten caracteres especiales.');
            stockInput.reportValidity();
        }
        else if (parsedStockValue < 1 || parsedStockValue > 10) {
            event.preventDefault();
            stockInput.setCustomValidity('Stock de 1 a 10 unidades.');
            stockInput.reportValidity();
        }
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
