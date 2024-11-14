<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="modelo.Usuarios" %>
<%@ page import="controller.CarritoBD" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Mi Perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .logo {
            font-family: Arial, sans-serif;
            font-weight: bold;
            font-size: 28px;
        }
        .search-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex: 1;
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
        .centered-title {
            text-align: center;
            margin-bottom: 30px; 
        }
        .profile-info {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            max-width: 800px;
        }
        
        .profile-info .text-center i {
    color: #6c757d;
}
        
        .edit-button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            display: flex;
            align-items: center;
            margin-top: -22px;
            margin-right: -20px;
        }
        .edit-button i {
            margin-right: 8px;
        }
        .edit-button:hover {
            background-color: #c82333;
        }
        footer {
            background-color: #f8f9fa;
            padding: 20px 0;
            text-align: center;
            font-family: Arial, sans-serif;
            color: #495057;
        }
    </style>
</head>
<body>

<!-- HEADER -->
<div class="header d-flex justify-content-between align-items-center mb-0" style="background-color: #fafafa; padding: 15px 0;">
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
    
    <div class="dropdown" style="margin-left: auto; margin-right: 70px;">
        <% if (session.getAttribute("cliente") != null) { %>
        <button class="btn btn-simple" type="button" id="dropdownMenuButton" aria-expanded="false" style="border: none; outline: none; box-shadow: none; font-weight: bold; font-size: 18px;">
            Hola, <%= ((Usuarios) session.getAttribute("cliente")).getNombres() %>
            <i class="fas fa-chevron-down" style="margin-left: 10px; color: #6c757d;"></i>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <li><a class="dropdown-item" href="verperfil.jsp">Mi perfil</a></li>
            <li><a class="dropdown-item" href="cerrarsesion.jsp">Cerrar Sesión</a></li>
        </ul>
        <% } else { %>
        <button class="btn btn-simple" type="button" id="dropdownMenuButton" aria-expanded="false" style="border: none; outline: none; box-shadow: none; font-weight: bold; font-size: 18px;">
            Ingresar
            <i class="fas fa-chevron-down" style="margin-left: 10px; color: #6c757d;"></i>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <li><a class="dropdown-item" href="login.jsp">Iniciar Sesión</a></li>
            <li><a class="dropdown-item" href="registro.jsp">Regístrate</a></li>
        </ul>
        <% } %>
    </div>
    <a href="carrito.jsp" id="carrito-icono" class="ml-3" style="text-decoration: none; margin-right: 70px;">
        <i class="fas fa-shopping-cart" style="font-size: 24px; color: black;"></i>
        <span id="articulos-cantidad" style="color: black;">(<%= session.getAttribute("numarticulos") %>)</span>
    </a>
    
    <!-- Contenedor para el mensaje de alerta con triángulo -->
<div id="mensaje-carrito" style="display: none; position: absolute; top: 60px; left: 90%; transform: translateX(-50%); background-color: white; padding: 10px; z-index: 1000; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);">
    <!-- Triángulo en la parte superior -->
    <div style="position: absolute; top: -10px; left: 80%; transform: translateX(-50%); width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-bottom: 10px solid white;"></div>
    <!-- Mensaje de alerta -->
    <p style="color: black; margin: 0; font-size: 12px;">No hay productos en el carrito.</p>
</div>

</div>

<div class="profile-info">
    <h2 class="centered-title">Mi Perfil</h2>
    <!-- Imagen circular con icono de usuario -->
    <div class="text-center mb-4">
        <div style="width: 120px; height: 120px; border-radius: 50%; background-color: #e0e0e0; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
            <i class="fas fa-user" style="font-size: 60px; color: #6c757d;"></i>
        </div>
    </div>

    <%
        try {
            Usuarios usuario = (Usuarios) session.getAttribute("cliente");
            if (usuario != null) {
                CarritoBD carritoBD = new CarritoBD();
                Usuarios usuarioInfo = carritoBD.InfoUsuario(usuario.getIdUsuario());
                if (usuarioInfo != null) {
    %>
    <!-- Información del usuario con iconos -->
<div class="text-center">
    <p><i class="fas fa-user" style="margin-right: 8px; color: #6c757d;"></i><strong>Nombre:</strong> <%= usuarioInfo.getNombres() %> <%= usuarioInfo.getApellidos() %></p>
    <p><i class="fas fa-envelope" style="margin-right: 8px; color: #6c757d;"></i><strong>Correo Electrónico:</strong> <%= usuarioInfo.getCorreo() %></p>
    <p><i class="fas fa-venus-mars" style="margin-right: 8px; color: #6c757d;"></i><strong>Sexo:</strong> <%= usuarioInfo.getSexo() %></p>
    <p><i class="fas fa-map-marker-alt" style="margin-right: 8px; color: #6c757d;"></i><strong>Dirección:</strong> <%= usuarioInfo.getDireccion() %></p>
    <p><i class="fas fa-calendar-alt" style="margin-right: 8px; color: #6c757d;"></i><strong>Fecha de Nacimiento:</strong> <%= usuarioInfo.getFechaNacimiento() %></p>
</div>
    
    <a href="actualizarPerfil.jsp" class="edit-button" style="float: right;">
        <i class="fas fa-edit"></i> Editar Perfil
    </a>
    <%
                } else {
                    out.println("<p class='text-danger'>No se encontró información del usuario.</p>");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error inesperado: " + e.getMessage() + "</p>");
        }
    %>
</div>


<!-- FOOTER -->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-12 mb-3">
                <p style="margin: 0;">© 2024 EcomStore. Todos los derechos reservados.</p>
            </div>
            <div class="col-12">
                <ul style="list-style: none; padding: 0; margin: 0; font-size: 14px;">
                    <li><a href="https://wa.me/51985042747" target="_blank" style="text-decoration: none; color: #007bff;">Contacto</a></li>
                    <li><a href="sobre-nosotros.jsp" style="text-decoration: none; color: #007bff;">Sobre Nosotros</a></li>
                    <li><a href="politica-privacidad.jsp" style="text-decoration: none; color: #007bff;">Política de Privacidad</a></li>
                    <li><a href="terminos-condiciones.jsp" style="text-decoration: none; color: #007bff;">Términos y Condiciones</a></li>
                </ul>
            </div>
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
                <a href="https://www.linkedin.com" target="_blank" style="text-decoration: none; color: #0077b5; margin: 0 10px; font-size: 20px;">
                    <i class="fab fa-linkedin-in"></i>
                </a>
            </div>
        </div>
    </div>
</footer>

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
<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO7rdI8H2z2pQf8M0U8ER5QABiLwQ1jWxg9MVeQXwNf7Ko4AGa5j9" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-oBqDVmMz4fnFO7rdI8H2z2pQf8M0U8ER5QABiLwQ1jWxg9MVeQXwNf7Ko4AGa5j9" crossorigin="anonymous"></script>
</body>
</html>
