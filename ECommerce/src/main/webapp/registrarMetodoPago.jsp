<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.CarritoBD" %>
<%@ page import="modelo.*" %>

<%
    // Recuperar los datos enviados desde el formulario
    String descripcion = request.getParameter("descripcion");
    String nombre = request.getParameter("nombre");
    String numero = request.getParameter("numero");
    String expiracion = request.getParameter("expiracion");
    String codigo = request.getParameter("codigo");

    // Validar que 'descripcion' no sea nulo o vacío
    if (descripcion == null || descripcion.isEmpty()) {
        out.println("<p>Error: Debe seleccionar un método de pago.</p>");
        return;
    }

    // Crear un objeto MetodoPago con los datos capturados
    MetodoPago nuevoMetodoPago = new MetodoPago(0, descripcion, nombre, numero, expiracion, codigo);

    // Crear una instancia de CarritoBD y registrar el método de pago
    CarritoBD carritoBD = new CarritoBD();
    boolean registroExitoso = carritoBD.registrarMetodoPago(nuevoMetodoPago);

    // Redireccionar según el resultado del registro
    if (registroExitoso) {
        response.sendRedirect("pagarCompra.jsp");
    } else {
        out.println("<p>Error al registrar el método de pago. Por favor, intente de nuevo.</p>");
    }
%>