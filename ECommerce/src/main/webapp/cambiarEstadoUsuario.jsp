<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.io.IOException" %>

<%
    try {
        // Recuperar el correo del usuario y el nuevo estado desde los parámetros del formulario
        String correoUsuario = request.getParameter("correoUsuario");
        String nuevoEstadoParam = request.getParameter("nuevoEstado");

        // Verificación de que los parámetros sean válidos
        if (correoUsuario != null && nuevoEstadoParam != null && (nuevoEstadoParam.equals("0") || nuevoEstadoParam.equals("1"))) {
            char nuevoEstado = nuevoEstadoParam.charAt(0);

            // Línea de depuración para verificar los valores
            System.out.println("Correo de usuario: " + correoUsuario + ", Nuevo estado: " + nuevoEstado);

            // Instancia de CarritoBD para llamar al método cambiarEstadoUsuario
            CarritoBD carritoBD = new CarritoBD();

            // Llamada al método y resultado de la operación
            boolean estadoCambiado = carritoBD.cambiarEstadoUsuario(correoUsuario, nuevoEstado);

            // Redirigir con mensaje dependiendo del resultado
            String mensaje = estadoCambiado ? "Estado actualizado exitosamente para el usuario con correo: " + correoUsuario : "Error: No se pudo actualizar el estado.";
            response.sendRedirect("consultaCliente.jsp?mensaje=" + mensaje);
        } else {
            response.sendRedirect("consultaCliente.jsp?mensaje=Error: Parámetros inválidos o estado incorrecto");
        }

    } catch (Exception e) {
        response.sendRedirect("consultaCliente.jsp?mensaje=Error inesperado: " + e.getMessage());
    }
%>