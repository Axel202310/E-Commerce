<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.CarritoBD" %>
<%@ page import="modelo.Usuarios" %>

<%
    // Recuperar los datos del formulario de registro
    String apellidos = request.getParameter("txtapellidos");
    String nombres = request.getParameter("txtnombres");
    String direccion = request.getParameter("txtdireccion");
    String fechaNacimiento = request.getParameter("txtfecha");
    char sexo = request.getParameter("txtsexo").charAt(0);
    String correo = request.getParameter("txtcorreo");
    String password = request.getParameter("txtpass");
    
    // El tipo de usuario será siempre 'USER' al registrarse
    String tipoUsuario = "USER";

    // Crear un objeto de tipo Usuarios con los datos del formulario (sin IdUsuario)
    Usuarios nuevoUsuario = new Usuarios(nombres, apellidos, direccion, fechaNacimiento, sexo, correo, password, tipoUsuario);
    
    // Crear una instancia de CarritoBD para acceder a la base de datos
    CarritoBD carritoBD = new CarritoBD();
    
    // Intentar registrar el nuevo usuario en la base de datos
    boolean registroExitoso = carritoBD.registrarUsuario(nuevoUsuario);
    
 // Redireccionar según el resultado del registro
    if (registroExitoso) {

        // Obtener el IdUsuario del usuario recién registrado
        int idUsuario = carritoBD.obtenerIdUsuarioPorCorreo(correo);
        // Guardar el correo en la sesión
        session.setAttribute("IdUsuario", idUsuario);
        session.setAttribute("CorreoCliente", correo);


        response.sendRedirect("VerificarUsuario.jsp"); // Redireccionar al login si el registro fue exitoso
    } else {
        // Si el registro falla, mostrar un mensaje de error y redirigir de vuelta a la página de registro
        request.setAttribute("errorMessage", "Error al registrar. Por favor, intente de nuevo.");
        request.getRequestDispatcher("registro.jsp").forward(request, response);
    }

    
%>
