<%@page import="controller.CarritoBD" %>
<%
   // Recuperar parámetros del formulario
   String idProducto = request.getParameter("idProducto");
   CarritoBD objBD = new CarritoBD();
   boolean eliminado = objBD.eliminarProducto(idProducto);
   if (eliminado) {
       response.sendRedirect("consultaStock.jsp");
   } else {
       out.println("<div class='alert alert-danger' role='alert'>Error al eliminar producto.</div>");
   }
%>
