<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="controller.CarritoBD" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<%
    String idProducto = request.getParameter("idProducto");
    String estadoActual = request.getParameter("estadoActual");

    // Cambiar el estado: '1' significa habilitado, '0' significa deshabilitado
    String nuevoEstado = estadoActual.equals("1") ? "0" : "1";

    CarritoBD carritoBD = new CarritoBD();
    boolean exito = carritoBD.cambiarEstadoProducto(idProducto, nuevoEstado);

    if (exito) {
        response.sendRedirect("consultaStock.jsp");
    } else {
        out.println("<p class='text-danger'>Error al cambiar el estado del producto.</p>");
    }
%>
</body>
</html>