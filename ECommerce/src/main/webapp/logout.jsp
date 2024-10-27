<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*" %>
<%
    HttpSession sessionToInvalidate = request.getSession();
    // Invalidar la sesión
    sessionToInvalidate.invalidate();
    // Redirigir al usuario a la página de inicio de sesión
    response.sendRedirect("login.jsp");
%>
