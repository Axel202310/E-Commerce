<%@page session="true" %>
<%@page import="java.util.ArrayList" %>
<%@page import="modelo.carrito" %>
<%@page import="controller.CarritoBD" %>
<%@page import="modelo.Productos" %>
<%
    // Crear instancia de la clase CarritoBD para interactuar con la base de datos
    CarritoBD ObjBD = new CarritoBD();
    
    // Recuperar el código del producto desde el parámetro de la solicitud
    String IdPro = request.getParameter("id");

    // Recuperar el carrito de la sesión
    HttpSession MiSesion = request.getSession();
    ArrayList<carrito> Lista = (ArrayList<carrito>) MiSesion.getAttribute("cesto");

    if (Lista != null && IdPro != null) {
        // Recorrer el ArrayList para suprimir el producto seleccionado
        for (int i = 0; i < Lista.size(); i++) {
            if (Lista.get(i).getIdProducto().equalsIgnoreCase(IdPro)) {
                // Obtener la cantidad del producto en el carrito
                int cantidad = Lista.get(i).getCantidad();

                // Restaurar el stock en la base de datos sumando la cantidad eliminada
                ObjBD.actualizarStock(IdPro, -cantidad);  // Método para sumar la cantidad al stock

                // Eliminar el producto del carrito
                Lista.remove(i);
                break;
            }
        }
    }

    // Actualizar el cesto en la sesión
    MiSesion.setAttribute("cesto", Lista);

    // Redireccionar al carrito
    response.sendRedirect("carrito.jsp?txtid=&txtcan=0");
%>