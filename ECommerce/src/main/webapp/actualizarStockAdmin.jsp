<%@page import="controller.CarritoBD"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Obtener los parámetros enviados desde el formulario
    String idProducto = request.getParameter("idProducto");
    int nuevoStock = Integer.parseInt(request.getParameter("nuevoStock"));
    
    // Instanciar la clase CarritoBD
    CarritoBD carritoBD = new CarritoBD();
    
    // Actualizar el stock del producto
    carritoBD.actualizarStockAdmin(idProducto, nuevoStock);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Actualización de Stock </title>
</head>
<body>
    <h2>Stock actualizado correctamente 12334</h2>
    <p><a href="consultaStock.jsp">Volver a la consulta de stock</a></p>
</body>
</html>
