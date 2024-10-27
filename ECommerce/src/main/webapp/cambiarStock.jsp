<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="modelo.*" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.Enumeration" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Actualizar Carrito</title>
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    CarritoBD ObjBD = new CarritoBD();

    // Recuperar la lista de productos en el carrito desde la sesión
    ArrayList<carrito> Lista = (ArrayList<carrito>) sesion.getAttribute("cesto");
    if (Lista == null) {
        Lista = new ArrayList<>();
    }

    // Recorrer los parámetros enviados por el formulario
    Enumeration<String> parametros = request.getParameterNames();

    // Vamos a usar un bucle separado para construir un mapa de las cantidades a actualizar.
    // Esto evita que haya un conflicto de actualización.
    while (parametros.hasMoreElements()) {
        String nombreParametro = parametros.nextElement();
        
        // Verificar si el parámetro es de tipo nuevoStock_
        if (nombreParametro.startsWith("nuevoStock_")) {
            String idProducto = nombreParametro.substring(11); // Obtener el ID del producto
            String cantidadStr = request.getParameter(nombreParametro);
            int nuevaCantidad = Integer.parseInt(cantidadStr);

            // Verificar el producto en el carrito
            for (carrito obj : Lista) {
                if (obj.getIdProducto().equalsIgnoreCase(idProducto)) {
                    int cantidadAnterior = obj.getCantidad();
                    int diferenciaStock = nuevaCantidad - cantidadAnterior;

                    // Obtener la información actual del producto desde la BD
                    Productos ObjP = ObjBD.InfoProducto(idProducto); 

                    // Comprobar si hay suficiente stock
                    if (ObjP.getStock() >= diferenciaStock) {
                        // Actualizar stock y carrito
                        ObjBD.actualizarStock(idProducto, diferenciaStock); 
                        obj.setCantidad(nuevaCantidad);
                    } else {
                        // Si no hay suficiente stock, restaurar cantidad anterior
                        out.println("<p>No hay suficiente stock disponible para el producto " + ObjP.getDescripcion() + ".</p>");
                    }
                    break; // Romper el bucle una vez actualizado
                }
            }
        }
    }

    // Actualizar la sesión con la nueva lista
    sesion.setAttribute("cesto", Lista);

    // Redirigir de vuelta al carrito
    response.sendRedirect("carrito.jsp");
%>
</body>
</html>

