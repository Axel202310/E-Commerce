<%@page import="controller.CarritoBD" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String idCategoria = request.getParameter("idCategoria");

    if (idCategoria != null && !idCategoria.isEmpty()) {
        CarritoBD carritoBD = new CarritoBD();
        boolean exito = carritoBD.eliminarCategoria(idCategoria);

        if (exito) {
            // Redirigir a la página de gestión de categorías después de eliminar exitosamente
            response.sendRedirect("gestionCategoria.jsp?mensaje=Categoria eliminada exitosamente");
        } else {
            // Redirigir con un mensaje de error si no se pudo eliminar la categoría
            response.sendRedirect("gestionCategoria.jsp?error=Error al eliminar la categoria");
        }
    } else {
        // Redirigir con un mensaje de error si el ID de categoría es inválido
        response.sendRedirect("gestionCategoria.jsp?error=ID de categoria no valido");
    }
%>
