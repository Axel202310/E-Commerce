<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="modelo.*" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
            margin: 0;
            padding: 0;
        }
        .d-flex {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background-color: #00000;
        }
        
        
        /*TABLA DEL CARRITO*/
        .content-container {
            display: flex; 
            justify-content: space-between; 
            margin-top: 20px; 
            padding: 0 45px;
        }

        .products-section {
            flex: 5; 
            margin-right: 20px; 
            height: 600px; 
            overflow-y: auto; 
        }

        .total-section {
            flex: 2; 
            height: 100px; 
        }
        .table-container {
           background-color: white;
           border-radius: 15px;
           border: 1px solid rgba(0, 0, 0, 0.1); 
           box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); 
           padding: 20px;   
           overflow-x: auto; 
        }

        .table {
          width: 100%;
          border-collapse: collapse; 
        }

        .table th {
          padding: 12px;
          border-left: 1px solid white;
          border-right: 1px solid white;
          border-top: 1px solid white; 
          border-bottom: 1px solid #d3d3d3;
   
        }
        
        .table td{
          padding: 12px;
          border-left: 1px solid white; 
          border-right: 1px solid white; 
          border-top: 1px solid white;
          border-bottom: 1px solid #d3d3d3;
        }
        
        table {
            width: 80%;
            margin: 0 auto;
            margin-top: 20px;
            margin-bottom: 20px;
            background-color: #fff; 
            border: 1px solid #ccc; 
            border-radius: 5px; 
            padding: 20px; 
        }
        
        
        /*ICONO DE ELIMINAR*/
        .delete-icon {
           color: gray; /* Color rojo del icono */
           text-decoration: none; /* Sin subrayado */
           font-size: 18px; /* Tamaño del icono */
           transition: color 0.3s; /* Transición suave para el color */
        }

        .delete-icon:hover {
           color: gray; /* Cambia a un rojo más oscuro cuando se pasa el mouse */
           cursor: pointer; /* Cambia el cursor al pasar sobre el icono */
        }
        
        /* Añadir una clase para la separación de las filas */
        .table tr.product-row {
            border-bottom: 2px solid #add8e6; 
        }

        table th, table td {
            padding: 10px;         
            
            border-bottom: 1px solid black;
        }

        table th {
            background-color: #f0ad4e; 
            color: #fff; 
        }

         .table-total td, .table-total th {
             border-left: 1px solid white; 
             border-right: 1px solid white; 
             border-top: 1px solid white;
             border-bottom: 1px solid white;
         }
         
        input[type="submit"] {
            background-color: #5cb85c; 
            color: #fff; 
            border: none; 
            border-radius: 5px; 
            padding: 10px 20px; 
            cursor: pointer; /
            transition: background-color 0.3s; 
        }

        input[type="submit"]:hover {
            background-color: #4cae4c; 
        }

        a {
            color: #007bff; 
            text-decoration: none; 
            transition: color 0.3s; 
        }

        a:hover {
            color: #0056b3;
        }

        /* Estilo para los enlaces dentro del contenedor */
        .button-link {
            display: inline-block;
            padding: 10px 60px; /* Espaciado interno del contenedor */
            background-color: #343e48; /* Color de fondo gris */
            border-radius: 25px; /* Bordes redondeados */
            text-decoration: none; /* Eliminar el subrayado de los enlaces */
            color: #ffffff; /* Color del texto */
            font-size: 18px; /* Tamaño de fuente opcional */
            font-family: Arial; 
            font-weight: 600;
         }

         .button-link:hover {
            background-color: #343e48; /* Color de fondo gris más oscuro al pasar el mouse */
            color: #ffffff;
         }     
         
         .seguir{
            font-size: 14px; 
            font-family: Arial; 
            font-weight: bold;
            text-decoration: underline;
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
        
         /* Estilos de los Botones de Cantidad */
        .quantity-container {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .quantity-input {
            text-align: center;
            border: none;
            width: 50px;
            font-size: 16px;
            outline: none;
        }
        .quantity-button {
            background-color: #f0ad4e;
            color: white;
            border: none;
            border-radius: 4px;
            width: 30px;
            height: 30px;
            font-size: 18px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        .quantity-button:disabled {
            background-color: #d3d3d3;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<%
    // Objeto para recuperar la sesión actual
    HttpSession sesion = request.getSession();
    try {
        // Enlaces del carrito
        String enlace1 = "<a href='index.jsp' class='seguir'>Seguir Comprando</a>";
        String enlace2 = "<a href='cancelar.jsp' class='cancelar' style='text-decoration: underline; padding-top: 0px;'>Cancelar Compra</a>";
        String enlace3 = "<a href='detallePagar.jsp' class='button-link'>Finalizar compra</a>";

        // Variable de la clase BD
        CarritoBD ObjBD = new CarritoBD();    
        // Recuperando los valores del formulario (si existen)
        String IdPro = request.getParameter("txtid");
        String cantStr = request.getParameter("txtcan");
        
        // Inicializar Cant con un valor por defecto, por ejemplo 0
        int Cant = 0;
        
        // Si cantStr no es nulo y se puede convertir, actualizar el valor de Cant
        if (cantStr != null && !cantStr.isEmpty()) {
            Cant = Integer.parseInt(cantStr);
        }
        
     // Si IdPro es nulo, significa que se está agregando un producto al carrito
        if (IdPro != null && Cant > 0) {
            // Obtener el producto desde la base de datos
            Productos ObjP = ObjBD.InfoProducto(IdPro);

            // Verificar si hay suficiente stock disponible
            if (ObjP.getStock() >= Cant) {
                // Actualizar el stock restando la cantidad solicitada
                ObjBD.actualizarStock(IdPro, Cant);  // Método para restar el stock

                // Agregar los valores del formulario a un objeto de tipo carrito
                carrito ObjC = new carrito(IdPro, Cant);

                // Continuar con el código para manejar el carrito...
            } else {
                // Si no hay suficiente stock, mostrar un mensaje de error
                out.println("<p>No hay suficiente stock disponible para este producto.</p>");
            }
        }
     
    
        // Agregar los valores del formulario a un objeto de tipo carrito
        carrito ObjC = new carrito(IdPro, Cant);

        // Variable para acceder a la sesión del proyecto web
        HttpSession MiSesion = request.getSession();

        // Declarar un ArrayList de tipo carrito
        ArrayList<carrito> Lista = null;

        // Recuperando los elementos almacenados en la sesión
        Lista = (ArrayList<carrito>) MiSesion.getAttribute("cesto");
        
        
        // Obtener el parámetro 'vaciar' del request
        String vaciar = request.getParameter("vaciar");
        
        // Si el parámetro 'vaciar' es true, vaciar el carrito
        if ("true".equals(vaciar)) {
            // Vaciar la lista de productos del carrito
            MiSesion.setAttribute("cesto", null);
            // Opcional: también puedes poner a 0 los valores de artículos y total
            MiSesion.setAttribute("numarticulos", 0);
            MiSesion.setAttribute("total", 0.0);
        }
        
        // Verificar si logró recuperar valores de la sesión
        if(Lista == null) {
            Lista = new ArrayList<carrito>();
            Lista.add(ObjC);
        } else {
            // Si ya existen elementos en la lista
            boolean encontrado = false;
            for(int i = 0; i < Lista.size(); i++) {
                carrito Obj = Lista.get(i);
                if(Obj.getIdProducto().equalsIgnoreCase(IdPro)) {
                    encontrado = true;
                    Obj.setCantidad(Obj.getCantidad() + Cant);
                    Lista.set(i, Obj);
                    break;
                }
            }
            // Si no encontró el producto, añadirlo al cesto
            if(!encontrado && Cant != 0) {
                Lista.add(ObjC);
            }
        }

        // Actualizar el valor de la sesión
        if(Cant != 0) MiSesion.setAttribute("cesto", Lista);
    
     // Construir la tabla de productos
        String tablaProductos = "<div class='table-container'>";
        tablaProductos += "<form action='cambiarStock.jsp' method='post'>"; // Abre el formulario
        tablaProductos += "<table class='table'>";
        tablaProductos += "<tr class='header-row'>";
            tablaProductos += "<th>Imagen</th>";
            tablaProductos += "<th>Descripcion</th>";
            tablaProductos += "<th>Precio</th>";
            tablaProductos += "<th>Cantidad</th>";
            tablaProductos += "<th>Sub-Total</th>";
            tablaProductos += "<th>Opciones</th>";
        tablaProductos += "</tr >";

        double Total = 0;
        int totalCantidadProductos = 0;
        
     // Recorrer todos los productos de Lista
        for (int i = 0; i < Lista.size(); i++) {
            Productos Obj = ObjBD.InfoProducto(Lista.get(i).getIdProducto());
            
            if (Obj != null){
            	String enlace = "suprimir.jsp?id=" + Obj.getIdProducto();
                double Precio = Obj.getPrecioUnidad();
                int Cantidad = Lista.get(i).getCantidad();
                double SubTotal = Precio * Cantidad;
                Total += SubTotal;
                totalCantidadProductos += Cantidad;
                int maxAgregar = Cantidad + Obj.getStock();

                tablaProductos += "<tr>";
                tablaProductos += "<td><img src='img/" + Obj.getImagen() + "' width='100' height='100' alt='Producto'></td>";
                tablaProductos += "<td style='text-align: left; vertical-align: middle;'><span style='font-weight: bold;font-size: 12px;'>" + Obj.getMarca() + "</span><br><span style='font-size: 17px;'>" + Obj.getDescripcion() + "</span></td>";
                tablaProductos += "<td style='text-align: left; vertical-align: middle; font-size: 17px;'> S/" + String.format("%.2f", Precio) + "</td>";

                // Contenedor de cantidad con botones + y -
                tablaProductos += "<td style='text-align: left; vertical-align: middle; font-size: 17px;'>";
                tablaProductos += "<div class='quantity-container'>";
                tablaProductos += "<button type='button' class='quantity-button' onclick='cambiarCantidad(\"" + Obj.getIdProducto() + "\", -1, " + Precio + ", " + maxAgregar + ")'>-</button>";
                tablaProductos += "<input type='text' class='quantity-input' id='cantidad_" + Obj.getIdProducto() + "' value='" + Cantidad + "' readonly data-max='" + maxAgregar + "'>";
                tablaProductos += "<button type='button' class='quantity-button' onclick='cambiarCantidad(\"" + Obj.getIdProducto() + "\", 1, " + Precio + ", " + maxAgregar + ")'>+</button>";
                tablaProductos += "</div>";
                tablaProductos += "</td>";

                // Subtotal y opciones de eliminación
                tablaProductos += "<td style='text-align: left; vertical-align: middle; font-size: 17px;' id='subtotal_" + Obj.getIdProducto() + "'>S/" + String.format("%.2f", SubTotal) + "</td>";
                tablaProductos += "<td style='text-align: center; vertical-align: middle;'><a href='" + enlace + "' class='delete-icon' title='Eliminar'><i class='fas fa-trash'></i></a></td>";
            tablaProductos += "</tr>";
        } else {
            System.out.println("Producto no encontrado: " + Lista.get(i).getIdProducto());
        }
    }
     
        tablaProductos += "</table>";
        tablaProductos += "</form>"; // Cierra el formulario
        tablaProductos += "</div>";
        
        // Construir la tabla de total y botones
        String tablaTotal = "<div class='table-container'>";
            tablaTotal += "<table class='table table-total'>";
            tablaTotal += "<tr class='total-row'><th colspan='6' style='font-size: 20px;'>Total:</th><th id='totalTotal' style='font-size: 20px; font-family: Arial; font-weight: normal; text-align: right;'>S/ " + Total + "</th><th></th></tr>";
            tablaTotal += "</tr>";
            tablaTotal += "<tr><td colspan='8' align='center'>" + enlace3 + "</td></tr>";              
            tablaTotal += "<tr><td colspan='8' align='center'>" + enlace2 + "</td></tr>";       
            tablaTotal += "</table>";
        tablaTotal += "</div>";

        // Mostrar "Carro" en negrita y la cantidad de productos en estilo normal
        out.print("<h1 style='font-family: Arial; font-size: 24px; font-weight: bold; margin-left: 45px; margin-top: 120px;'>"
        + " Carro <span style='font-size: 18px; font-weight: normal;'>(" + totalCantidadProductos + " productos)</span>"
        + "<span style='display: inline-block; margin-left: 734px;'>Resumen</span>"
        + "<span style='margin-left: 110px;'>" + enlace1 + "</span>"
        + "</h1>");
        
        out.print("<div class='content-container'>");
            out.print("<div class='products-section'>" + tablaProductos + "</div>");
            out.print("<div class='total-section'>" + tablaTotal + "</div>");
        out.print("</div>");

        // Guardar valores en sesión
        MiSesion.setAttribute("numarticulos", Lista.size());
        MiSesion.setAttribute("total", Total);
    } finally {            
        //out.close();
    }
    
    // Verificar si existe la sesión
    if (sesion.getAttribute("numarticulos") == null) {
        sesion.setAttribute("numarticulos", 0);
        sesion.setAttribute("total", 0.0);
    }

    // Recuperar los valores de numarticulos y total de la sesión
    int nroarticulos = (int) sesion.getAttribute("numarticulos");
    double total = (double) sesion.getAttribute("total");

    // Inicializar el total de cantidades de productos
    int cantidadTotalProductos = 0;

    // Recuperar la lista de productos del carrito desde la sesión
    ArrayList<carrito> listaProductos = (ArrayList<carrito>) sesion.getAttribute("cesto");

    // Si la lista de productos no es nula, sumar las cantidades de cada producto
    if (listaProductos != null) {
    	for (carrito item : listaProductos) {
            cantidadTotalProductos += item.getCantidad();
        }
    }

    // Guardar el valor de columnas (suma total de productos) en la sesión
    sesion.setAttribute("numarticulos", cantidadTotalProductos);

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
        <span id="error-title" style="font-size: 16px;">Busqueda vacia</span>
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
                <li><a class="dropdown-item" href="cerrarsesion.jsp">Cerrar Sesion</a></li>
            </ul>
            <% } else { %>
            <button class="btn btn-simple " type="button" id="dropdownMenuButton" aria-expanded="false" style="border: none; outline: none; box-shadow: none; font-weight: bold; font-size: 18px;">
                Ingresar
                <i class="fas fa-chevron-down" style="margin-left: 10px; color: #6c757d;"></i>
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li><a class="dropdown-item" href="login.jsp">Iniciar Sesion</a></li>
                <li><a class="dropdown-item" href="registro.jsp">Regístrate</a></li>
            </ul>
            <% } %>
        </div>
       
       <!-- Icono de Carrito -->
       <a href="carrito.jsp" class="ml-3" style="margin-right: 70px; text-decoration: none;">
         <i class="fas fa-shopping-cart" style= "font-size: 24px; color: black;"></i>
         <span style="color: black;">(<%= cantidadTotalProductos %>) </span> 
       </a>
    </div>
          
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

	<script>
	function cambiarCantidad(idProducto, cambio, precio, maxAgregar) {
	    var cantidadInput = document.getElementById('cantidad_' + idProducto);
	    var cantidadActual = parseInt(cantidadInput.value, 10);
	    var nuevaCantidad = cantidadActual + cambio;

	    // Validar que la nueva cantidad no exceda el límite dinámico de maxAgregar
	    if (nuevaCantidad > maxAgregar) {
	        alert("El valor debe ser menor o igual a la cantidad maxima disponible: " + maxAgregar);
	        nuevaCantidad = maxAgregar;
	    } else if (nuevaCantidad < 1) {
	        nuevaCantidad = 1;
	    }

	    // Actualizar el valor del input y el subtotal
	    cantidadInput.value = nuevaCantidad;
	    actualizarSubtotal(idProducto, nuevaCantidad, precio);
	    actualizarCarrito(idProducto, nuevaCantidad);
	}
	

    function actualizarSubtotal(idProducto, cantidad, precio) {
        var nuevoSubtotal = cantidad * precio;
        document.getElementById('subtotal_' + idProducto).innerText = 'S/' + nuevoSubtotal.toFixed(2);
        actualizarTotal();
        actualizarContador();
    }

    function actualizarTotal() {
        var total = 0;
        var subtotales = document.querySelectorAll('[id^="subtotal_"]');
        subtotales.forEach(function(subtotal) {
            var valorSubtotal = parseFloat(subtotal.innerText.replace('S/', '').trim());
            total += valorSubtotal;
        });
        document.getElementById('totalTotal').innerText = 'S/' + total.toFixed(2);
    }

    function actualizarContador() {
        var totalCantidadProductos = 0;
        var inputsCantidad = document.querySelectorAll('.quantity-input');
        inputsCantidad.forEach(function(input) {
            totalCantidadProductos += parseInt(input.value, 10);
        });
        document.querySelector('.fas.fa-shopping-cart + span').innerText = '(' + totalCantidadProductos + ')';
    }

    function actualizarCarrito(idProducto, nuevaCantidad) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = 'actualizarCarrito.jsp';

        var inputId = document.createElement('input');
        inputId.type = 'hidden';
        inputId.name = 'productoId';
        inputId.value = idProducto;
        form.appendChild(inputId);

        var inputCantidad = document.createElement('input');
        inputCantidad.type = 'hidden';
        inputCantidad.name = 'nuevaCantidad';
        inputCantidad.value = nuevaCantidad;
        form.appendChild(inputCantidad);

        document.body.appendChild(form);
        form.submit();
    }
</script>
	


</body>
</html>