<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="modelo.*" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Carrito de Compras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .logo {
            font-family: Arial, sans-serif;
            font-weight: bold;
            font-size: 28px;
        }
        body {
            background-color: #f3f4f6; /* Color de fondo */
            color: #333; /* Color del texto */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .btn-no-fill {
            background: none;
            border: none;
            color: grey;
            font-size: 16px;
            text-decoration: underline;
            padding: 0;
            margin-left: 10px; 
            cursor: pointer;
        }
        .btn-no-fill:hover {
           color: #555; 
           text-decoration: underline;
        }
        /*DETALLE DEL PRODUCTO*/
        .bg-white {
           background-color: white; /* Fondo blanco */
           padding: 20px; /* Añade espacio interior */
           margin-top: 30px; /* Margen superior de 15px */
           margin-bottom: 50px; 
           border-radius: 8px; /* Bordes redondeados opcionales */
           box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Sombra suave */
        }

        .marca {
           font-family: Calibri, sans-serif;
           font-size: 18px;
           color: #4d4d4d;
           font-weight: 600;
        }
        .codigo {
           font-family: Calibri, sans-serif;
           font-size: 12px;
           color: #4d4d4d;
           margin-left: 32px;
        }
        .descripcion {
           font-family: Calibri, sans-serif;
           color: #4d4d4d;
           font-size: 24px;
           font-weight: 300;
        }
        
        .linea-gris {
            width: 100%;
            height: 1px; /* Grosor de la línea */
            background-color: #f3f4f6; 
            margin-top: 10px; /* Espacio superior */
            margin-bottom: 10px; /* Espacio inferior */
        }
        
        .precio {
           color: #eb0029;
           font-family: Montserrat, sans-serif;
           font-size: 28px;
           font-weight: bold;
        }
        
        /*BOTON CANTIDAD*/
        /* Contenedor del input para alinear los botones y el campo de entrada */
        .input-container {
           display: flex;
           align-items: center;
           width: fit-content;
        }

        /* Estilo para el input numérico */
        .input-container input[type="number"] {
           border: none; /* Sin borde */
           border-radius: 0; /* Sin bordes redondeados */
           padding: 10px; /* Espaciado interno */
           text-align: center; /* Centrar el texto dentro del campo */
           width: 60px; /* Ancho del campo igual al ancho de los botones */
           margin: 0; /* Sin márgenes */
           box-sizing: border-box; /* Incluir borde en el ancho */
           outline: none;
           box-shadow: none; 
        }
        
        /* Botones personalizados */
        .input-container .btn-custom {
           background-color: #eb0029; /* Color de fondo rojo */
           color: #fff; /* Texto blanco */
           border: none; /* Sin borde */
           border-radius: 0; /* Sin bordes redondeados */
           width: 30px; /* Ancho del botón */
           height: 30px; /* Alto del botón */
           font-size: 20px; /* Tamaño del texto */
           cursor: pointer; /* Cambiar cursor al pasar sobre el botón */
           display: flex; /* Flex para centrar el texto */
           align-items: center; /* Centrar verticalmente */
           justify-content: center; /* Centrar horizontalmente */
        }
        /* Estilo específico para el botón de incremento */
        .input-container .btn-increment {
            border-radius: 0 5px 5px 0; /* Esquinas redondeadas a la derecha */
        }

        /* Estilo específico para el botón de decremento */
        .input-container .btn-decrement {
            border-radius: 5px 0 0 5px; /* Esquinas redondeadas a la izquierda */
        }
        
        
        .agregar {
           background-color: #6c757d; /* Color de fondo gris */
           color: #ffffff; /* Color del texto blanco */
           border: 2px solid #6c757d; /* Borde gris del botón, igual al color de fondo */
           border-radius: 35px; /* Bordes redondeados */
           padding: 13px 60px; /* Espaciado interno */
           font-size: 20px; 
           font-weight: 500;
        }
        
        
        /* Estilo para el cuadro de búsqueda */
        .search-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex: 1; /* Ocupa el espacio disponible */
        }
        .search-box {
            display: flex;
            max-width: 600px;
            width: 100%;
        }
        .search-input {
            flex: 1;
            padding: 10px 15px;
            border-radius: 25px 0 0 25px;
            border: 1px solid #ced4da;
            font-size: 16px;
            border-right: none;
            outline: none;
        }
        .search-button {
            padding: 10px 20px;
            border-radius: 0 25px 25px 0;
            border: 1px solid #ced4da;
            background-color: #9bd501;
            color: white;
            cursor: pointer;
            border-left: none;
            font-size: 16px;
        }
        .search-button i {
            font-size: 18px;
        }
    </style>
    
</head>
<body>
    <%
    HttpSession sesion = request.getSession();
    String IdPro = request.getParameter("id");
    String IdCat = request.getParameter("idCat");
    
    // Verificar si el parámetro "id" no es nulo
    if (IdPro != null) {
        CarritoBD ObjBD = new CarritoBD();
        Productos ObjP = ObjBD.InfoProducto(IdPro);
    int columnas = 0;
    // Verificar si existe la sesion
       if(sesion.getAttribute("numarticulos") == null){
           sesion.setAttribute("numarticulos", 0);
           sesion.setAttribute("total", 0.0);
       }
       // Recuperando de la sesion los valores de numarticulos y total
       int nroarticulos = (int)(sesion.getAttribute("numarticulos"));
       double total = (double)(sesion.getAttribute("total"));
    // Declaración del objeto para los datos del cliente
    Usuarios ObjC = (Usuarios) sesion.getAttribute("cliente");
                    
%>
  
      <!-- HEADER -->
     <div class="d-flex justify-content-between align-items-center mb-0" style="background-color: #fafafa; padding: 10px 0;">
       <h2 class="logo" style="margin-left: 40px;">
           <a href="index.jsp" style="text-decoration: none; color: inherit;">EcomStore</a>
        </h2>
        <div class="search-container" style="position: relative;">
           <form class="search-box" action="buscarproductos.jsp" method="get" onsubmit="return validateSearch()">
               <input type="text" name="query" class="search-input" placeholder="Buscar en EcomStore" id="searchInput">
               <button type="submit" class="search-button">
                 <i class="fas fa-search"></i>
               </button>
        <!-- Contenedor para el mensaje de error -->
         <div id="error-container" style="display: none; position: absolute; top: 100%; left: 50%; transform: translateX(-50%); width: 50%; text-align: center; z-index: 1000;">
    <p id="error-message" style="color: black; background-color: white; font-size: 12px; margin: 0; padding: 5px; border: 1px solid black; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); position: relative; display: inline-block;">
        <span id="error-title" style="font-size: 16px;">Búsqueda vacía</span>
        <br>
        <span id="error-details">INGRESA LA MARCA,PRODUCTO DE LO QUE QUIERES BUSCAR</span>
        <span id="close-error" style="position: absolute; top: 5px; right: 10px; cursor: pointer; font-weight: bold;">&times;</span>
    </p>
</div>
    </form>
    </div>
       <!-- Icono de Login -->
        <div class="dropdown" style="margin-left: auto; margin-right: 70px;">
            <% if (ObjC != null && ObjC.getNombres() != null && !ObjC.getNombres().isEmpty()) { %>
            <button class="btn btn-simple " type="button" id="dropdownMenuButton" aria-expanded="false" style="border: none; outline: none; box-shadow: none;font-weight: bold;font-size: 18px;">
                Hola, <%= ObjC.getNombres() %>
                <i class="fas fa-chevron-down" style="margin-left: 10px; color: #6c757d;"></i>
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li><a class="dropdown-item" href="verperfil.jsp">Mi perfil</a></li>
                <li><a class="dropdown-item" href="cerrarsesion.jsp">Cerrar Sesión</a></li>
            </ul>
            <% } else { %>
            <button class="btn btn-simple " type="button" id="dropdownMenuButton" aria-expanded="false" style="border: none; outline: none; box-shadow: none; font-weight: bold; font-size: 18px;">
                Ingresar
                <i class="fas fa-chevron-down" style="margin-left: 10px; color: #6c757d;"></i>
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li><a class="dropdown-item" href="login.jsp">Iniciar Sesión</a></li>
                <li><a class="dropdown-item" href="registro.jsp">Regístrate</a></li>
            </ul>
            <% } %>
        </div>
       <!-- Icono de Carrito -->
       <!-- Enlace del carrito con identificador -->
<a href="carrito.jsp" id="carrito-icono" class="ml-3" style="text-decoration: none; margin-right: 70px;">
    <i class="fas fa-shopping-cart" style="font-size: 24px; color: black;"></i>
    <span id="articulos-cantidad" style="color: black;">(<%=nroarticulos%>)</span>
</a>

<!-- Contenedor para el mensaje de alerta con triángulo -->
<div id="mensaje-carrito" style="display: none; position: absolute; top: 60px; left: 90%; transform: translateX(-50%); background-color: white; padding: 10px; z-index: 1000; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);">
    <!-- Triángulo en la parte superior -->
    <div style="position: absolute; top: -10px; left: 80%; transform: translateX(-50%); width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-bottom: 10px solid white;"></div>
    <!-- Mensaje de alerta -->
    <p style="color: black; margin: 0; font-size: 12px;">No hay productos en el carrito.</p>
</div>
     </div>
     
     <!-- Icono home -->
     <div>  
    <i class="fas fa-arrow-left" style="font-size: 18px; color: grey;margin-top: 25px; margin-left: 35px;"></i>     
    <a href="index.jsp" class="btn-no-fill" style="font-size: 20px;">EcomStore</a> 
    <i class="fas fa-chevron-left" style="font-size: 12px; color: grey;"></i>
    <a href="verproductos.jsp?idCat=<%= ObjP.getIdCategoria() %>" class="btn-no-fill" style="font-size: 20px;"><%= ObjBD.getCategoriaById(ObjP.getIdCategoria()).getDescripcion() %></a>
    <i class="fas fa-chevron-left" style="font-size: 12px; color: grey;"></i>
    <a class="btn-no-fill" style="font-size: 20px;"><%= ObjP.getDescripcion() %></a>
    </div>
     
     
     <!-- DETALLE DEL PRODUCTO -->
  <div class="container bg-white">
    <form action="carrito.jsp">
        <table class="table">
            <tr>
                <td>IdProducto</td>
                <td><input name="txtid" value="<%=ObjP.getIdProducto()%>" readonly /></td>
            </tr>
            <tr>
                <td>Descripcion</td>
                <td><%=ObjP.getDescripcion()%></td>
            </tr>
            <tr>
                <td>Precio</td>
                <td><%=ObjP.getPrecioUnidad()%></td>
            </tr>
            <tr>
                <td>Stock</td>
                <td><%=ObjP.getStock()%></td>
            </tr>
            <tr>
                <td>Imagen</td>
                <td><img src="img/<%=ObjP.getImagen()%>" width="100" height="100"></td>
            </tr>
            <tr>
                <td>Cantidad</td>
                <td><input type="number" name="txtcan" id="txtcan" min="1" max="<%= ObjP.getStock() %>" value="1" required /></td>
                <td><span id="errorCantidad" style="color:red;"></span></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Añadir Carrito" /></td>
            </tr>
        </table>
    </form>
    <a href="javascript:history.back()">Seleccionar Otro Producto</a>
    </div>
    <% } else {
        out.println("<p>Error 3: El parámetro 'id' es nulo</p>");
    } %>
    
    
<script>
  function validarFormulario() {
    const cantidad = document.getElementById('txtcan').value;
    const errorCantidad = document.getElementById('errorCantidad');

    if (!cantidad || cantidad <= 0) {
      errorCantidad.textContent = "Debe ingresar una cantidad válida.";
      return false;
    }

    errorCantidad.textContent = "";
    return true;
  }
</script>
    
    
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var dropdownButton = document.getElementById('dropdownMenuButton');
        var dropdownMenu = document.querySelector('.dropdown-menu');
        
        dropdownButton.addEventListener('click', function () {
            dropdownMenu.classList.toggle('show');
        });
        
        // Opcional: cerrar el menú si se hace clic fuera de él
        document.addEventListener('click', function (event) {
            if (!dropdownButton.contains(event.target) && !dropdownMenu.contains(event.target)) {
                dropdownMenu.classList.remove('show');
            }
        });
    });
</script>

<!-- Footer -->
<footer style="background-color: #f8f9fa; padding: 20px 0; text-align: center; font-family: Arial, sans-serif; color: #495057;">
    <div class="container">
        <div class="row">
            <!-- Derechos Reservados -->
            <div class="col-12 mb-3">
                <p style="margin: 0;">© 2024 EcomStore. Todos los derechos reservados.</p>
            </div>
            <!-- Enlaces de Contacto y Redes Sociales -->
            <div class="col-12">
                <ul style="list-style: none; padding: 0; margin: 0; font-size: 14px;">
                    <li><a href="https://wa.me/51985042747" target="_blank" style="text-decoration: none; color: #007bff;">Contacto</a></li>
                    <li><a href="sobre-nosotros.jsp" style="text-decoration: none; color: #007bff;">Sobre Nosotros</a></li>
                    <li><a href="politica-privacidad.jsp" style="text-decoration: none; color: #007bff;">Política de Privacidad</a></li>
                    <li><a href="terminos-condiciones.jsp" style="text-decoration: none; color: #007bff;">Términos y Condiciones</a></li>
                </ul>
            </div>
            <!-- Redes Sociales -->
            <div class="col-12 mt-3">
                <a href="https://www.facebook.com" target="_blank" style="text-decoration: none; color: #4267B2; margin: 0 10px; font-size: 20px;">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="https://www.twitter.com" target="_blank" style="text-decoration: none; color: #1DA1F2; margin: 0 10px; font-size: 20px;">
                    <i class="fab fa-twitter"></i>
                </a>
                <a href="https://www.instagram.com" target="_blank" style="text-decoration: none; color: #C13584; margin: 0 10px; font-size: 20px;">
                    <i class="fab fa-instagram"></i>
                </a>
                <a href="https://www.linkedin.com" target="_blank" style="text-decoration: none; color: #0077B5; margin: 0 10px; font-size: 20px;">
                    <i class="fab fa-linkedin-in"></i>
                </a>
            </div>
        </div>
    </div>
</footer>


<script>
    function validateSearch() {
        var query = document.getElementById('searchInput').value;
        var errorContainer = document.getElementById('error-container');
        var errorMessage = document.getElementById('error-message');

        if (query.trim() === '') {
            errorMessage.style.display = 'block'; // Muestra el mensaje de error
            errorContainer.style.display = 'block'; // Asegura que el contenedor del mensaje sea visible
            return false; // Previene el envío del formulario si hay un error
        }
        errorMessage.style.display = 'none'; // Oculta el mensaje de error si el campo tiene texto
        errorContainer.style.display = 'none'; // Oculta el contenedor del mensaje
        return true; // Permite el envío del formulario si no hay errores
    }

    // Función para cerrar el mensaje de error
    document.getElementById('close-error').addEventListener('click', function() {
        var errorContainer = document.getElementById('error-container');
        errorContainer.style.display = 'none'; // Oculta el contenedor del mensaje
    });

    // Función para ocultar el mensaje de error al hacer clic en el campo de búsqueda
    document.getElementById('searchInput').addEventListener('focus', function() {
        var errorContainer = document.getElementById('error-container');
        errorContainer.style.display = 'none'; // Oculta el contenedor del mensaje
    });
</script>


<!-- JavaScript para manejar el clic y mostrar el mensaje -->
<script>
    document.getElementById('carrito-icono').addEventListener('click', function (event) {
        // Obtener la cantidad de artículos del carrito
        const nroarticulos = parseInt(document.getElementById('articulos-cantidad').textContent.replace(/[()]/g, ''));

        // Verificar si el número de artículos es 0
        if (nroarticulos === 0) {
            event.preventDefault(); // Evita redirigir a "carrito.jsp"

            // Mostrar el mensaje de que no hay productos en el carrito
            const mensajeDiv = document.getElementById('mensaje-carrito');
            mensajeDiv.style.display = 'block'; // Muestra el contenedor del mensaje
        }
    });

    // Cerrar el mensaje al hacer clic fuera del mensaje
    document.addEventListener('click', function (event) {
        const mensajeDiv = document.getElementById('mensaje-carrito');
        const carritoIcono = document.getElementById('carrito-icono');
        // Si se hace clic fuera del mensaje y del icono, ocultar el mensaje
        if (!mensajeDiv.contains(event.target) && !carritoIcono.contains(event.target)) {
            mensajeDiv.style.display = 'none';
        }
    });
</script>
</body>
</html>