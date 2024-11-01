<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="modelo.carrito" %>

<%
    // Obtener los parámetros enviados desde el formulario
    String productoId = request.getParameter("productoId");
    String nuevaCantidadStr = request.getParameter("nuevaCantidad");

    // Validar que los parámetros no sean nulos ni vacíos
    if (productoId != null && nuevaCantidadStr != null && !nuevaCantidadStr.trim().isEmpty()) {
        int nuevaCantidad = Integer.parseInt(nuevaCantidadStr);

        // Recuperar el carrito de la sesión
        ArrayList<carrito> listaProductos = (ArrayList<carrito>) session.getAttribute("cesto");

        if (listaProductos != null) {
            // Actualizar la cantidad en el carrito de la sesión
            for (carrito item : listaProductos) {
                if (item.getIdProducto().equals(productoId)) {
                    item.setCantidad(nuevaCantidad);
                    break;
                }
            }
            session.setAttribute("cesto", listaProductos);
        }
    }

    // Redirigir a carrito.jsp para actualizar la vista
    response.sendRedirect("carrito.jsp");
%>
