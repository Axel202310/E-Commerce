<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="modelo.carrito" %>

<%
    // Obtener los par�metros enviados desde el formulario
    String productoId = request.getParameter("productoId");
    String nuevaCantidadStr = request.getParameter("nuevaCantidad");

    // Validar que los par�metros no sean nulos ni vac�os
    if (productoId != null && nuevaCantidadStr != null && !nuevaCantidadStr.trim().isEmpty()) {
        int nuevaCantidad = Integer.parseInt(nuevaCantidadStr);

        // Recuperar el carrito de la sesi�n
        ArrayList<carrito> listaProductos = (ArrayList<carrito>) session.getAttribute("cesto");

        if (listaProductos != null) {
            // Actualizar la cantidad en el carrito de la sesi�n
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
