<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="modelo.Usuarios" %>
<%@ page import="modelo.Categorias" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Carrito de Compras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .logo {
            font-family: Arial, sans-serif;
            font-weight: bold;
            font-size: 28px;
        }
        
        body {
            background-color: white; 
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .cliente-info {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: bold;
        }   
        
        /*EFECTO CATEGORIA*/
        .categoria {
            display: block;
            text-align: center;
            margin-bottom: 10px;
            transition: transform 0.3s;
        }
        
        .categoria:hover a {
            text-decoration: underline; /* Subrayado del texto */
        }
        .categoria:hover img {
            filter: brightness(80%); /* Ajusta el valor según el efecto deseado */
        }
        .categoria:hover {
            transform: translateY(-5px);
        }
        /*PARTE  IMAGEN CIRCULO*/
        .categoria img {
            width: 150px;
            height: 150px;
            margin-bottom: 10px;
            border-radius: 50%;
            background-color: #eeeeee;
            transition: filter 0.3s;
        }
        /*PARTE  LETRA*/
        .categoria a {
            text-decoration: none;
            color: #000;
            display: block;
            padding: 10px 20px;
            background-color: transparent;
            font-size: 18px;
            border: none;
            outline: none;
            box-shadow: none; 
            -webkit-tap-highlight-color: transparent;
        }
        
        .categoria a:focus,
        .categoria a:active {
            outline: none;
            box-shadow: none;
            border: none;
        }
        .categoria a:hover {
            text-decoration: underline; /* Subrayado al pasar el mouse */
        }
        /*PARTE DEL CARRUSEL CATEGORIA*/
        .carousel-item {
            white-space: nowrap;
        }
       .carousel-item .col-md-2 {
           display: inline-block;           
        }
        .carousel-item::-webkit-scrollbar {
           display: none; 
        }
        .custom-carousel-container {
           margin-top: 25px;
           margin-left: 140px;
           margin-right: 140px;
        }
        
        
        /*EFECTO DE LAS OFERTAS*/
        .btn-square {
            display: flex;
            align-items: center; 
            justify-content: center; 
            width: 530px; 
            height: auto; 
            border-radius: 20px; 
            box-sizing: border-box; 
            overflow: hidden; 
            border: none; 
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); 
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-square img {
            width: 100%;
            height: 100%; 
            object-fit: cover; 
        }
        .btn-square:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }
        
        .btn-oferta2 {
            display: flex;
            align-items: center; 
            justify-content: center; 
            width: auto; 
            height: auto; 
            border-radius: 20px; 
            box-sizing: border-box; 
            overflow: hidden; 
            border: none; 
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-oferta2 img {
            width: 100%;
            height: 100%; 
            object-fit: cover; 
        }
        .btn-oferta2:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);     
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
    try {
        // Declaracion de objeto para recuperar valores de la sesion
        HttpSession sesion = request.getSession();
        // Verificar si existe la sesion
        if(sesion.getAttribute("numarticulos") == null){
            sesion.setAttribute("numarticulos", 0);
            sesion.setAttribute("total", 0.0);
        }
        // Recuperando de la sesion los valores de numarticulos y total
        int nroarticulos = (int)(sesion.getAttribute("numarticulos"));
        double total = (double)(sesion.getAttribute("total"));
        // Objeto para recuperar los procesos del proyectos
        CarritoBD ObjBD = new CarritoBD();
        List<Categorias> Lista = ObjBD.ListarCategorias();
        int columnas = 0;

        // Declaración del objeto para los datos del cliente
        Usuarios ObjC = (Usuarios) sesion.getAttribute("cliente");
%>

     <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-0" style="background-color: #fafafa; padding: 15px 0;">
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
    
<!-- CARRUSEL -->
<div id="carouselExampleIndicators" class="carousel carousel-fade slide" data-ride="carousel" data-bs-interval="3000">
    <!-- Indicadores del Carrusel -->
    <ol class="carousel-indicators">
        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
    </ol>
    <!-- Contenido del Carrusel -->
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="img/banner5.jpg" class="d-block w-100" alt="Imagen 1" style="background-color: #f3f3f3;">
        </div>
        <div class="carousel-item">
            <img src="img/banner4.jpg" class="d-block w-100" alt="Imagen 2" style="background-color: #f3f3f3;">
        </div>
        <div class="carousel-item">
            <img src="img/banner6.jpg" class="d-block w-100" alt="Imagen 3" style="background-color: #f3f3f3;">
        </div>
    </div>
    <!-- Controles de Navegación -->
    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>  
    </a>
    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>  
    </a>
</div>

   
<div class="catalogo" style="background-color: white;">
    <!-- Título de las Categorías -->
<h2 style="text-align: center; font-family: Poppins, sans-serif; font-size: 24px; font-weight: bold; margin-top: 50px;">
    Nuestras Categorías
</h2>

<!-- Carrusel de Categorías -->
<div id="carouselCategorias" class="carousel carousel-dark slide custom-carousel-container" data-bs-interval="false">
    <!-- Indicadores del Carrusel -->
    <ol class="carousel-indicators">
        <% for (int i = 0; i < (Lista.size() + 5) / 6; i++) { %>
            <li data-target="#carouselCategorias" data-slide-to="<%= i %>" class="<%= i == 0 ? "active" : "" %>"></li>
        <% } %>
    </ol>
    <div class="carousel-inner">
        <% 
        int count = 0; 
        boolean first = true; 
        for (Categorias c : Lista) { 
            if (c.getEstado() == '1') { // Solo mostrar categorías activas
                if (count % 6 == 0) { 
                    if (!first) { %>
                        </div> <!-- Cierra el slide anterior -->
                    <% } %>
                    <div class="carousel-item <%= first ? "active" : "" %>">
                        <% first = false; 
                } %>
                 <div class="col-md-2 mb-4" style="margin-top: 15px;">
                    <div class="categoria">
                        <!-- Enlazar la imagen a la página de productos por categoría -->
                        <a href="verproductos.jsp?id=<%= c.getIdCategoria() %>">
                            <img src="img/<%= c.getImagen() %>" alt="<%= c.getDescripcion() %>">
                        </a>
                        <!-- Enlazar también el nombre de la categoría -->
                        <a href="verproductos.jsp?id=<%= c.getIdCategoria() %>"><%= c.getDescripcion() %></a>
                    </div>
                </div>
                
                <% count++; 
            }
        } %>
        </div> <!-- Cierra el último slide -->
    </div>
    <!-- Controles de Navegación -->
    <a class="carousel-control-prev" href="#carouselCategorias" role="button" data-slide="prev" style="left: -150px;"> <!-- Aumento aquí -->
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>  
    </a>
    <a class="carousel-control-next" href="#carouselCategorias" role="button" data-slide="next" style="right: -150px;"> <!-- Aumento aquí -->
        <span class="carousel-control-next-icon" aria-hidden="true"></span>  
    </a>
</div>




   
 
    
    <!-- OFERTAS -->
  <div class="oferta">
       <h2 style="text-align: center; font-family: Poppins, sans-serif; font-size: 24px; font-weight: bold; margin-top: 50px;">
         Beneficios destacados
       </h2>
    <div class="row" style="margin-top: 25px; margin-left: 80px; margin-right: 80px;">
        <div class="col-md-4 mb-4">
            <a href="verproductos.jsp?id=CAT001" class="btn-square">
                <img src="img/oferta1.jpg" alt="Oferta 1">
            </a>
        </div>
        <div class="col-md-4 mb-4">
            <a href="verproductos.jsp?id=CAT007" class="btn-square">
                <img src="img/oferta2.jpg" alt="Oferta 2">
            </a>
        </div>
        <div class="col-md-4 mb-4">
            <a href="verproductos.jsp?id=CAT004" class="btn-square">
                <img src="img/oferta3.jpg" alt="Oferta 3">
            </a>
        </div>
    </div>
  </div>
  <div class="oferta2" style="margin-left: 80px; margin-right: 65px;">
      <div class="col-md-12 mb-4">
          <a href="verproductos.jsp?id=CAT002" class="btn-oferta2">
              <img src="img/oferta4.jpg" alt="Oferta 4">
          </a>
      </div>
  </div>
    
 
<% } catch (NullPointerException e) {
        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
    } catch (Exception e) {
        out.println("<p class='text-danger'>Error inesperado 1: " + e.getMessage() + "</p>");
    }
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-oBqDVmMz4fnFO9ytQJFs6k5aaEMeG0dm1aV6T4OoE4eSCu09elT+J6F4E4I28kPp" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>

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


 <!-- Agregar el aviso de derechos reservados al final del código -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-oBqDVmMz4fnFO9ytQJFs6k5aaEMeG0dm1aV6T4OoE4eSCu09elT+J6F4E4I28kPp" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

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
