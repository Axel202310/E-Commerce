<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%
    // Invalidar la sesi�n actual
    session.invalidate();
    // Redirigir al usuario a la p�gina de inicio de sesi�n o a la p�gina principal
    response.sendRedirect("index.jsp"); // O redirige a "login.jsp" si prefieres mostrar la p�gina de inicio de sesi�n
%>


