<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
	// Objeto para recuperar la sesion actual
	HttpSession sesion = request.getSession();
	// Reiniciar valores de la sesion
	sesion.setAttribute("numarticulos", 0);
	sesion.setAttribute("total", 0.0);
	sesion.setAttribute("cesto", null);
	// Regresar a la pagina principal
	response.sendRedirect("index.jsp");
%>