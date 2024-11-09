<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="modelo.carrito" %>
<%@ page import="controller.CarritoBD" %>

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
        	// Instanciar el objeto CarritoBD
            CarritoBD ObjBD = new CarritoBD();
        	
            
        	
            // Actualizar la cantidad en el carrito de la sesión
            for (carrito item : listaProductos) {
                if (item.getIdProducto().equals(productoId)) {
                    int cantidadAnterior = item.getCantidad(); // Obtener la cantidad anterior
                    item.setCantidad(nuevaCantidad); // Actualizar la cantidad en el carrito

                    // Calcular la diferencia de cantidad
                    int diferenciaCantidad = nuevaCantidad - cantidadAnterior;

                    // Actualizar el stock en la base de datos con la diferencia
                    ObjBD.actualizarStock(productoId, +diferenciaCantidad);

                    break;
                }
            }
            session.setAttribute("cesto", listaProductos);
        }
    }

    // Redirigir a carrito.jsp para actualizar la vista
    response.sendRedirect("carrito.jsp");
%>