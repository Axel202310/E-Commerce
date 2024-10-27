<%@page import="java.util.ArrayList" %>
<%@page import="modelo.*"%>
<%@page import="controller.CarritoBD"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalle de Pago</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            color: #333;
            margin: 0;
            padding: 0;
        }
        
        .button {
            display: inline-block;
            padding: 10px 170px;
            background-color: #eeecef;
            text-decoration: none;
            color: #000000;
            font-size: 18px;
            font-family: Arial; 
            font-weight: 600;
            border: none;
        }

        .error-message {
            color: red;
            font-size: 16px;
            margin-top: 10px;
        }

        .input-error {
            border: 1px solid red;
        }
    </style>
</head>
<body>

<%
    HttpSession MiSesion = request.getSession();
    CarritoBD ObjBD = new CarritoBD();
    
    Integer idCliente = (Integer) MiSesion.getAttribute("IdUsuario");
    String correoCliente = (String) MiSesion.getAttribute("CorreoCliente");
    String mensajeValidacion = "";
    boolean codigoIncorrecto = false;

    if (request.getParameter("verificationCode") != null) {
        String codigoIngresadoStr = request.getParameter("verificationCode");
        Integer codigoGuardado = (Integer) MiSesion.getAttribute("codigoVerificacion");

        try {
            int codigoIngresado = Integer.parseInt(codigoIngresadoStr);
            if (codigoGuardado != null && codigoIngresado == codigoGuardado) {
                // Redirige a la misma página con el parámetro "registro=exito"
                response.sendRedirect("VerificarUsuario.jsp?registro=exito");
            } else {
                mensajeValidacion = "<div class='error-message'>Código incorrecto, intenta de nuevo.</div>";
                codigoIncorrecto = true;
            }
        } catch (NumberFormatException e) {
            mensajeValidacion = "<div class='error-message'>Por favor, ingresa un número válido.</div>";
            codigoIncorrecto = true;
        }
    }
%>

<h1 style="text-align: center; font-weight: bold; font-size: 26px;margin-top:50px; margin-bottom:20px;">Verificar tu cuenta</h1>
<div class="container justify-content-center" style="margin-top:30px; margin-left:450px;">
    <div class="row">
        <div class="col-md-8">
            <div class="identification-container" style="background-color: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
                <h3 style="text-align: center; font-weight: bold; font-size: 30px;margin-top:50px; margin-bottom:-0px;">Introduce tu código de</h3>
                <h3 style="text-align: center; font-weight: bold; font-size: 30px;">verificación</h3>
                <h3 style="text-align: center; font-weight: 500; font-size: 22px; margin-top:20px;">Envíamos el código al correo</h3>
                <h3 class="email" style="text-align: center; font-weight: bold; font-size: 22px;"><%= correoCliente %></h3>

                <form method="POST" action="VerificarUsuario.jsp" style="text-align: center;">
                    <div class="verification-input" style="margin-top: 40px; text-align: center;">
                        <input type="text" id="verificationCode" name="verificationCode" placeholder="Código de verificación" required 
                          style="width: 500px; padding: 15px; font-size: 28px; border-radius: 5px;" 
                          class="<%= codigoIncorrecto ? "input-error" : "" %>">
                    </div>
                    <div style="margin-top: 10px;">
                        <%= mensajeValidacion %>
                    </div>
                    <button type="submit" class="button" style="margin-top:50px; padding: 10px 210px;">
                        Verificar
                    </button>
                </form>

                <div style="text-align:center; margin-top:20px; align-items: center;">                
                    <form action="VerificarCorreo.jsp" method="POST" style="margin: 0;">
                       <button type="submit" class="button" style="text-align: center; margin-bottom:100px;">Reenviar código</button>
                    </form>
                </div>
            </div>
        </div>   
    </div>
</div>

<script>
    // Verifica si el parámetro "registro=exito" está en la URL
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('registro') === 'exito') {
        // Muestra el mensaje de éxito
        alert('Registro Exitoso');

        // Redirige al usuario a login.jsp después de 2 segundos
        setTimeout(() => {
            window.location.href = 'login.jsp';
        },); 
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"  integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous"></script>
</body>
</html>
