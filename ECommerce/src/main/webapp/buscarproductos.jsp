<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="modelo.Productos, modelo.Categorias, controller.CarritoBD, modelo.Usuarios" %>
<%@ page import="java.util.List, java.util.Set, java.util.HashSet, java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buscar Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
   
        .oculto {
            display: none;
        }
        .mostrar {
            display: block;
        }
     
        }
        
        .logo {
           font-family: Arial, sans-serif;
           font-weight: bold;
           font-size: 28px;
        }
        
        body {
            background-color: #f1f1f1; /* Color de fondo */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
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
        
        .btn-no-fill1{
            color: #000;
            font-size: 16px;
            text-decoration: underline;
            padding: 0;
            margin-left: 10px; 
            cursor: pointer;
        }
        
        /*PRODUCTOS*/
        .marca {
           font-family: Calibri, sans-serif;
           font-size: 18px;
           color: #4d4d4d;
           font-weight: 500;
        }
        .descripcion {
           font-family: Calibri, sans-serif;
           font-weight: bold;
           font-size: 19px;
        }
        .precio{
           font-family: Calibri, sans-serif;
           font-weight: 600;
           font-size: 22px;
           text-align: right;
           margin-bottom: 0;
           color: #eb0029;
        }
        .precioexclusivo{
           font-family: Calibri, sans-serif;
           font-weight: 500;
           font-size: 14px;
           text-align: right;
           color: #eb0029;
        }
        
        }
        .card-img-top {
           max-width: 250px; 
           max-height: 250px; 
           width: auto;       
           height: auto;      
           object-fit: cover;
           margin-top: 15px;
        }
        .card {
           border: 1px solid #ffff; 
           border-radius: 8px; 
           overflow: hidden; 
           box-shadow: 0 4px 8px rgba(0,0,0,0.1); 
           width: 260px;           
       }
       
       .btn-custom {
           background-color: #6c757d; /* Color de fondo gris */
           color: #ffffff; /* Color del texto blanco */
           border: 2px solid #6c757d; /* Borde gris del botón, igual al color de fondo */
           border-radius: 25px; /* Bordes redondeados */
           padding: 3px 60px; /* Espaciado interno */
           text-align: center; /* Centra el texto dentro del botón */
           visibility: hidden;
           text-decoration: none; /* Quita el subrayado del enlace */
           font-family: Calibri, sans-serif;
           font-weight: bold;
           font-size: 19px; /* Tamaño de la fuente */
           transition: visibility 0.3s ease, opacity 0.3s ease;
           opacity: 0;
       }
       
       .btn-custom:hover {
           background-color: #6c757d; 
           color: #ffffff; 
           border-color: #6c757d; 
           opacity: 1;
       }

       .card:hover .btn-custom {
           visibility: visible; 
           opacity: 1;
       }

       .text-center {
           color: grey;
           font-size: 32px;
           padding-bottom: 25px;
           font-weight: 300;
       }
       
       /*EFECTO DEL FILTRO*/
       .oculto {
           display: none;
           opacity: 0;
           transition: opacity 0.5s ease;
       }

       .mostrar {
           display: block;
           opacity: 1;
       }
       
       .contenedor-adicional {
        width: 830px;
       }
       
       .select-con-borde {
        width: 340px;
        border: none;
        outline: none;
        box-shadow: none;
        border-bottom: 1px solid gray; /* Línea en la parte inferior */
        margin-bottom: 0; /* Reducir el margen inferior si es necesario */
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
    String query = request.getParameter("query");
    String[] marcasSeleccionadas = request.getParameterValues("marca");

    // Instanciar el objeto de la base de datos
    CarritoBD ObjBD = new CarritoBD();
    List<Productos> Lista = new ArrayList<>();
    List<Categorias> listaCategorias = new ArrayList<>();
    try {
        // Obtener lista de productos y categorías
        Lista = ObjBD.buscarProductosPorMarca(query);
        listaCategorias = ObjBD.ListarCategorias();
    } catch (Exception e) {
        e.printStackTrace();
        // Manejo de error, podrías redirigir a una página de error si es necesario
        out.println("<p>Error al obtener productos. Intenta de nuevo más tarde.</p>");
    }

    // Crear un conjunto de marcas únicas
    Set<String> marcasUnicas = new HashSet<>();
    if (Lista != null) {
        for (Productos producto : Lista) {
            if (producto.getMarca() != null) {
                marcasUnicas.add(producto.getMarca());
            }
        }
    }

    // Verificar y configurar sesión
    if (sesion.getAttribute("numarticulos") == null) {
        sesion.setAttribute("numarticulos", 0);
        sesion.setAttribute("total", 0.0);
    }
    int nroarticulos = (int) sesion.getAttribute("numarticulos");
    double total = (double) sesion.getAttribute("total");
    Usuarios ObjC = (Usuarios) sesion.getAttribute("cliente");

    // Filtrar productos por marcas seleccionadas
    if (marcasSeleccionadas != null && marcasSeleccionadas.length > 0) {
        if (Lista != null) {
            List<Productos> productosFiltrados = new ArrayList<>();
            for (Productos producto : Lista) {
                if (producto.getMarca() != null && java.util.Arrays.asList(marcasSeleccionadas).contains(producto.getMarca())) {
                    productosFiltrados.add(producto);
                }
            }
            Lista = productosFiltrados;
        }
    }
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

<!-- Título -->
<h1 class="text-center">Resultados de búsqueda</h1>

<!-- Contenedor principal -->
<div class="container">
    <div class="row justify-content-center">
        <!-- Columna de productos -->
        <div class="col-md-9">
            <div class="row justify-content-center" id="productos-lista">
                <% if (Lista != null) { %>
                    <% for (Productos c : Lista) { %>
                        <div class="col-md-4 mb-4 producto-item" data-marca="<%= c.getMarca() %>" data-precio="<%= c.getPrecioUnidad() %>">
                            <div class="card h-100">
                                <!-- Imagen del producto -->
                                <img src="img/<%= c.getImagen() %>" class="card-img-top" alt="<%= c.getDescripcion() %>">
                                <div class="card-body d-flex flex-column">
                                    <!-- Marca del producto -->
                                    <h1 class="marca"><%= c.getMarca() %></h1>
                                    <!-- Descripción del producto -->
                                    <h1 class="descripcion"><%= c.getDescripcion() %></h1>
                                    <!-- Precio del producto -->
                                    <h1 class="precio">S/ <%= c.getPrecioUnidad() %></h1>
                                    <!-- Precio exclusivo para la web -->
                                    <h1 class="precioexclusivo">Precio Exclusivo<br> Web</br></h1>
                                    <!-- Botón para ver detalles del producto -->
                                    <div class="text-center mt-auto">
                                        <a href="verdetalle.jsp?id=<%= c.getIdProducto() %>" class="btn btn-custom">Ver Detalle</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var dropdownButton = document.getElementById('dropdownMenuButton');
        var dropdownMenu = document.querySelector('.dropdown-menu');
        
        // Mostrar/ocultar el menú desplegable al hacer clic en el botón
        dropdownButton.addEventListener('click', function () {
            dropdownMenu.classList.toggle('show');
        });
        
        // Ocultar el menú desplegable si se hace clic fuera de él
        document.addEventListener('click', function (event) {
            if (!dropdownButton.contains(event.target) && !dropdownMenu.contains(event.target)) {
                dropdownMenu.classList.remove('show');
            }
        });
    });

    // Filtrar productos por marca seleccionada
    function filtrarPorMarca() {
        const selectedBrands = Array.from(document.querySelectorAll('input[name="marca"]:checked')).map(checkbox => checkbox.value);
        const productos = document.querySelectorAll('.producto-item');

        productos.forEach(producto => {
            const marca = producto.getAttribute('data-marca');
            let mostrar = selectedBrands.length === 0 || selectedBrands.includes(marca);
            producto.style.display = mostrar ? 'block' : 'none';
        });
    }

    // Mostrar/ocultar filtros de marca
    function toggleMarcaFiltros() {
        const marcaFiltros = document.getElementById('marca-filtros');
        marcaFiltros.classList.toggle('mostrar');
        marcaFiltros.classList.toggle('oculto');
    }
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"></script>




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


</body>
</html>