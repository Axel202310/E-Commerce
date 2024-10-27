<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%
    // Invalidar la sesión actual
    session.invalidate();
    // Redirigir al usuario a la página de inicio de sesión o a la página principal
    response.sendRedirect("index.jsp"); // O redirige a "login.jsp" si prefieres mostrar la página de inicio de sesión
%>


