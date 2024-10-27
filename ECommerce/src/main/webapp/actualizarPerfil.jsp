<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="modelo.Usuarios" %>
<%@ page import="controller.CarritoBD" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Actualizar Perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .btn-update-profile {
            background-color: #9bd501;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 22px;
        }

        .btn-update-profile:hover {
            background-color: #8ab300;
        }

        .error-message {
            color: red;
            display: none;
        }
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
    <h2 class="centered-title">Actualizar Perfil</h2>
    <%
        try {
            Usuarios usuario = (Usuarios) session.getAttribute("cliente");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else {
                CarritoBD carritoBD = new CarritoBD();
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String idUsuario = request.getParameter("idUsuario");
                    String nombres = request.getParameter("nombres");
                    String apellidos = request.getParameter("apellidos");
                    String direccion = request.getParameter("direccion");
                    String fechaNacimiento = request.getParameter("fechaNacimiento");
                    String sexo = request.getParameter("sexo");
                    String correo = request.getParameter("correo");

                    Usuarios usuarioActualizado = new Usuarios();
                    usuarioActualizado.setIdUsuario(Integer.parseInt(idUsuario));
                    usuarioActualizado.setNombres(nombres);
                    usuarioActualizado.setApellidos(apellidos);
                    usuarioActualizado.setDireccion(direccion);
                    usuarioActualizado.setFechaNacimiento(fechaNacimiento);
                    usuarioActualizado.setSexo(sexo.charAt(0));
                    usuarioActualizado.setCorreo(correo);

                    boolean exito = carritoBD.actualizarUsuario(usuarioActualizado);

                    if (exito) {
                        session.setAttribute("cliente", usuarioActualizado); // Actualiza la sesión con los nuevos datos
                        response.sendRedirect("verperfil.jsp"); // Redirige al perfil actualizado
                    } else {
                        out.println("<div class='alert alert-danger'>Error al actualizar perfil.</div>");
                    }
                } else {
                    Usuarios usuarioInfo = carritoBD.InfoUsuario(usuario.getIdUsuario());
                    if (usuarioInfo != null) {
    %>
    <form method="post">
        <input type="hidden" name="idUsuario" value="<%= usuarioInfo.getIdUsuario() %>">

        <!-- Nombre -->
        <div class="mb-3">
            <label for="txtnombres" class="form-label">Nombre:</label>
            <input type="text" class="form-control" id="txtnombres" name="nombres" value="<%= usuarioInfo.getNombres() %>" required>
        </div>

        <!-- Apellidos -->
        <div class="mb-3">
            <label for="txtapellidos" class="form-label">Apellidos:</label>
            <input type="text" class="form-control" id="txtapellidos" name="apellidos" value="<%= usuarioInfo.getApellidos() %>" required>
        </div>

        <!-- Fecha de Nacimiento -->
        <div class="mb-3">
            <label for="txtfecha" class="form-label">Fecha de Nacimiento:</label>
            <input type="date" class="form-control" id="txtfecha" name="fechaNacimiento" value="<%= usuarioInfo.getFechaNacimiento() %>" required>
        </div>

        <!-- Sexo -->
        <div class="mb-3">
            <label for="sexo" class="form-label">Sexo:</label>
            <select class="form-select" id="sexo" name="sexo" required>
                <option value="M" <%= "M".equals(usuarioInfo.getSexo()) ? "selected" : "" %>>Masculino</option>
                <option value="F" <%= "F".equals(usuarioInfo.getSexo()) ? "selected" : "" %>>Femenino</option>
            </select>
        </div>

        <!-- Correo Electrónico -->
        <div class="mb-3">
            <label for="txtcorreo" class="form-label">Correo Electrónico:</label>
            <input type="email" class="form-control" id="txtcorreo" name="correo" value="<%= usuarioInfo.getCorreo() %>" required>
        </div>

        <!-- Dirección -->
        <div class="mb-3">
            <label for="txtdireccion" class="form-label">Dirección:</label>
            <input type="text" class="form-control" id="txtdireccion" name="direccion" value="<%= usuarioInfo.getDireccion() %>" required>
        </div>

        <div class="text-center">
            <button type="submit" class="btn-update-profile">Actualizar Perfil</button>
        </div>
    </form>

    <%
                    } else {
                        out.println("<p class='text-danger'>No se encontró información del usuario.</p>");
                    }
                }
            }
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error inesperado: " + e.getMessage() + "</p>");
        }
    %>
</div>

<!-- Validaciones JavaScript para todos los campos -->
<script>
    // Validar nombre
    document.getElementById("txtnombres").addEventListener("input", function(event) {
        const nombreInput = event.target.value;
        const nombreField = document.getElementById("txtnombres");
        
        nombreField.setCustomValidity("");
        
        if (!nombreInput) {
            nombreField.setCustomValidity("El campo de nombres no puede estar vacío.");
        } else if (nombreInput.trim().length === 0) {
            nombreField.setCustomValidity("No pueden ser solo espacios en blanco.");
        } else if (/\d/.test(nombreInput)) {
            nombreField.setCustomValidity("Los nombres no deben contener números.");
        } else if (/[^a-zA-Z\s]/.test(nombreInput)) {
            nombreField.setCustomValidity("Los nombres no deben contener caracteres especiales.");
        } else if (nombreInput.length < 2 || nombreInput.length > 20) {
            nombreField.setCustomValidity("Los nombres deben tener entre 2 y 20 caracteres.");
        }
        
        nombreField.reportValidity();
    });

    // Validar apellidos
    document.getElementById("txtapellidos").addEventListener("input", function(event) {
        const apellidoInput = event.target.value;
        const apellidoField = document.getElementById("txtapellidos");

        apellidoField.setCustomValidity("");
        
        if (!apellidoInput) {
            apellidoField.setCustomValidity("El campo de apellidos no puede estar vacío.");
        } else if (apellidoInput.trim().length === 0) {
            apellidoField.setCustomValidity("No pueden ser solo espacios en blanco.");
        } else if (/\d/.test(apellidoInput)) {
            apellidoField.setCustomValidity("Los apellidos no deben contener números.");
        } else if (/[^a-zA-Z\s]/.test(apellidoInput)) {
            apellidoField.setCustomValidity("Los apellidos no deben contener caracteres especiales.");
        } else if (apellidoInput.length < 2 || apellidoInput.length > 36) {
            apellidoField.setCustomValidity("Los apellidos deben tener entre 2 y 36 caracteres.");
        }

        apellidoField.reportValidity();
    });

    // Validar fecha de nacimiento
    document.getElementById("txtfecha").addEventListener("input", function(event) {
        const fechaInput = event.target;
        const fechaValue = fechaInput.value;
        const fechaActual = new Date();
        const fechaSeleccionada = new Date(fechaValue);

        fechaInput.setCustomValidity("");

        if (!fechaValue || fechaValue.length < 10) {
            fechaInput.setCustomValidity("El campo está incompleto.");
        } else if (fechaSeleccionada > fechaActual) {
            fechaInput.setCustomValidity("Error: mínimo 18 y máximo 85 años.");
        } else {
            let edad = fechaActual.getFullYear() - fechaSeleccionada.getFullYear();
            const cumpleEnEsteAno = new Date(fechaActual.getFullYear(), fechaSeleccionada.getMonth(), fechaSeleccionada.getDate());

            if (fechaActual < cumpleEnEsteAno) {
                edad--;
            }

            if (edad < 18 || edad > 85) {
                fechaInput.setCustomValidity("Error: mínimo 18 y máximo 85 años.");
            }
        }

        fechaInput.reportValidity();
    });

    // Validar correo
    document.getElementById("txtcorreo").addEventListener("input", function(event) {
        const correoInput = event.target.value;
        const correoField = document.getElementById("txtcorreo");
        const emailPattern = /^[a-zA-Z0-9]+([._-][a-zA-Z0-9]+)*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        const dominiosPermitidos = ['gmail.com', 'outlook.com', 'hotmail.com'];

        correoField.setCustomValidity("");

        if (correoInput.trim() === "") {
            correoField.setCustomValidity("Falta rellenar el campo");
        } else if (/^\s+$/.test(correoInput)) {
            correoField.setCustomValidity("No se permite solo espacios en blanco");
        } else if (/^\d+$/.test(correoInput)) {
            correoField.setCustomValidity("No se permite solo números");
        } else if (/^[!@#$%^&*(),.?":{}|<>]+$/.test(correoInput)) {
            correoField.setCustomValidity("No se permite solo caracteres especiales");
        } else if (/\s/.test(correoInput)) {
            correoField.setCustomValidity("El correo entre espacios no es válido");
        } else if (/([._-]){2,}/.test(correoInput)) {
            correoField.setCustomValidity("No se permiten caracteres especiales consecutivos.");
        } else if (!/^[a-zA-Z]/.test(correoInput)) {
            correoField.setCustomValidity("Debe iniciar con una letra");
        } else if (/[^a-zA-Z0-9._@-]/.test(correoInput)) {
            correoField.setCustomValidity("Solo se permiten caracteres especiales . - _ @");
        } else if (!/@/.test(correoInput)) {
            correoField.setCustomValidity("No contiene el símbolo @");
        } else if (/^[^@]+@$/.test(correoInput)) {
            correoField.setCustomValidity("Falta ingresar el dominio");
        } else if ((correoInput.match(/@/g) || []).length > 1) {
            correoField.setCustomValidity("El correo no debe incluir doble @");
        } else if (correoInput.length < 13 || correoInput.length > 36) {
            correoField.setCustomValidity("Texto mínimo 13 y máximo 36 caracteres");
        } else {
            const dominio = correoInput.split('@')[1];
            if (dominio && !dominiosPermitidos.includes(dominio)) {
                correoField.setCustomValidity("Correo con dominio no válido");
            } else if (!emailPattern.test(correoInput)) {
                correoField.setCustomValidity("Mala sintaxis");
            }
        }

        correoField.reportValidity();
    });

    // Validar dirección
    document.getElementById("txtdireccion").addEventListener("input", function(event) {
        const direccionInput = event.target.value;
        const direccionField = document.getElementById("txtdireccion");

        direccionField.setCustomValidity("");

        if (!direccionInput) {
            direccionField.setCustomValidity("Falta rellenar el campo");
        } else if (/^\d+$/.test(direccionInput)) {
            direccionField.setCustomValidity("No se permite ingresar solo números");
        } else if (/^\s+$/.test(direccionInput)) {
            direccionField.setCustomValidity("No se permite ingresar solo con espacio en blanco");
        } else if (/^[^a-zA-Z]/.test(direccionInput)) {
            direccionField.setCustomValidity("Debe iniciar con una letra.");
        } else if (/[^a-zA-ZáéíóúÁÉÍÓÚ0-9\s.,;]/.test(direccionInput)) {
            direccionField.setCustomValidity("Solo se permite caracteres especiales . , ; y letras con tilde");
        } else if (direccionInput.length < 9 || direccionInput.length > 110) {
            direccionField.setCustomValidity("Texto de 9 y 110 caracteres");
        }

        direccionField.reportValidity();
    });
</script>
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
</body>
</html>
