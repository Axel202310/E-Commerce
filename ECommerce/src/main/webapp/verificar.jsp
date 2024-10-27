<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%> 
<%@ page session="true" %>
<%@ page import="modelo.Usuarios" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Obtener la sesi�n
	HttpSession MiSesion = request.getSession();

    // Recuperar valores del formulario de inicio de sesi�n
    String correo = request.getParameter("txtcorreo");
    String password = request.getParameter("txtpass");

    // Objeto para acceder a la base de datos
    CarritoBD carritoBD = new CarritoBD();
    
    // Obtener la informaci�n completa del usuario mediante el correo
    Usuarios usuario = carritoBD.InfoUsuarioPorCorreo(correo);

    if (usuario != null && usuario.getPassword().equals(password)) {
        // Verificar el estado del usuario (habilitado o deshabilitado)
        if (usuario.getEstado() == '1') {
            // Si el usuario est� habilitado
            if (usuario.getTipoUsuario().equals("USER")) {
                // Si es un cliente
                MiSesion.setAttribute("IdCliente", usuario.getIdUsuario());
                MiSesion.setAttribute("cliente", usuario);
                response.sendRedirect("index.jsp"); // Redirigir a la p�gina principal de la tienda
            } else if (usuario.getTipoUsuario().equals("ADMIN")) {
                // Si es un administrador
                System.out.println("Tipo de usuario: " + usuario.getTipoUsuario());
                MiSesion.setAttribute("ADMIN", usuario);
                response.sendRedirect("indexAdmin.jsp"); // Redirigir a la p�gina de administrador
            } else {
                // Si el tipo de usuario no es v�lido
                request.setAttribute("errorMessage", "Tipo de usuario no reconocido.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            // Si el usuario est� deshabilitado
            request.setAttribute("errorMessage", "Su cuenta ha sido deshabilitada. Contacte al soporte para m�s informaci�n.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    } else {
    	// Mensaje de error si las credenciales son incorrectas
        request.setAttribute("errorMessage", "Credenciales incorrectas. Por favor, intente de nuevo.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>