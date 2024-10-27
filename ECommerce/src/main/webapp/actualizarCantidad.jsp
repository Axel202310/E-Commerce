<%@page import="controller.CarritoBD"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Obtener los parámetros enviados desde el formulario
    String idProducto = request.getParameter("idProducto");
    double nuevoPrecio = Double.parseDouble(request.getParameter("nuevoPrecio"));
    
    // Instanciar la clase CarritoBD
    CarritoBD carritoBD = new CarritoBD();
    
    // Actualizar el precio del producto
    carritoBD.actualizarPrecioVenta(idProducto, nuevoPrecio);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Actualización de Precio</title>
</head>
<body>
    <h2>Precio actualizado correctamente</h2>
    <p><a href="consultaStock.jsp">Volver a la consulta de stock</a></p>
</body>
</html>
