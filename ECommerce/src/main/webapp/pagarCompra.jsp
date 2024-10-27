<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page session="true" %>
<%@page import="modelo.*" %>
<%@page import="controller.*" %>
<%@page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmación de Compra</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .img-fluid {
            max-width: 300px;
            height: auto;
        }
        .social-buttons a {
            margin: 5px;
        }
    </style>
</head>
<body>



<%
    // Recuperar valores de la sesión actual
    HttpSession miSesion = request.getSession();
    Integer idCliente = (Integer) miSesion.getAttribute("IdCliente");

    // Verificar si idCliente es nulo
    if (idCliente == null) {
        out.println("<div class='alert alert-danger' role='alert'>Error: No se encontró el IdCliente en la sesión.</div>");
        return; // Detener la ejecución si no se encuentra el idCliente
    }

    // Generar ID para el método de pago automáticamente
    CarritoBD objBD = new CarritoBD();
    int idMetodoPago = 0;
    
    try {
        int filasMetodoPago = objBD.NumeroFilas("metodopago");
        idMetodoPago = filasMetodoPago; // Genera un nuevo ID simple
    } catch (Exception e) {
        out.println("<div class='alert alert-danger' role='alert'>Error al obtener las filas del método de pago: " + e.getMessage() + "</div>");
        return;
    }

    // Obtener la fecha actual
    LocalDate fechaActual = LocalDate.now();
    DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String fechaVenta = fechaActual.format(formato);

    // Recuperar el monto total de la sesión
    Double montoTotalObj = (Double) miSesion.getAttribute("total");
    double montoTotal = 0.0;
    
    if (montoTotalObj == null) {
        out.println("<div class='alert alert-danger' role='alert'>Error: No se encontró el monto total en la sesión.</div>");
    } else {
        montoTotal = montoTotalObj;
    }

    // Recuperar el carrito de la sesión
    @SuppressWarnings("unchecked")
    ArrayList<carrito> lista = (ArrayList<carrito>) miSesion.getAttribute("cesto");

    if (lista == null || lista.isEmpty()) {
        out.println("<div class='alert alert-danger' role='alert'>Error: El carrito de compras está vacío o no se encontró.</div>");
        return;
    }

    // Generar ID para la venta
    String idVenta = "";
    try {
        int filas = objBD.NumeroFilas("ventas");
        if (filas == 0) {
            idVenta = "VTA0000001";
        } else {
            idVenta = "VTA" + String.format("%07d", filas + 1);
        }
    } catch (Exception e) {
        out.println("<div class='alert alert-danger' role='alert'>Error al obtener las filas de ventas: " + e.getMessage() + "</div>");
        return;
    }

    // Crear objeto de ventas
    Ventas objV = new Ventas(idVenta, idCliente, idMetodoPago, fechaVenta, montoTotal, '1');

    // Insertar la venta en la base de datos
    try {
        objBD.InsertarVenta(objV);
    } catch (Exception e) {
        out.println("<div class='alert alert-danger' role='alert'>Error al insertar la venta: " + e.getMessage() + "</div>");
        return;
    }

    // Procesar los detalles de la venta
    int contadorDetalles = 0;
    try {
        int filasDetalles = objBD.NumeroFilas("detalle");
        contadorDetalles = filasDetalles;
    } catch (Exception e) {
        out.println("<div class='alert alert-danger' role='alert'>Error al obtener las filas de detalles: " + e.getMessage() + "</div>");
        return;
    }

    for (carrito item : lista) {
        String idPro = item.getIdProducto();
        Productos objP = null;

        try {
            objP = objBD.InfoProducto(idPro);
        } catch (Exception e) {
            out.println("<div class='alert alert-danger' role='alert'>Error al obtener información del producto: " + e.getMessage() + "</div>");
            continue; // Saltar este producto si hay un error
        }

        // Generar ID para el detalle
        String idDetalle = "DTA" + String.format("%07d", ++contadorDetalles);

        // Crear objeto de detalle
        Detalle objD = new Detalle(idDetalle, idVenta, idPro, item.getCantidad(), objP.getPrecioUnidad());

        // Insertar el detalle en la base de datos
        try {
            objBD.InsertarDetalle(objD);
        } catch (Exception e) {
            out.println("<div class='alert alert-danger' role='alert'>Error al insertar detalle: " + e.getMessage() + "</div>");
        }
    }

    // Limpiar el carrito y los valores de la sesión
    miSesion.removeAttribute("cesto");
    miSesion.setAttribute("numarticulos", 0);
    miSesion.setAttribute("total", 0.0);
%>
    <div class="container">
        <div class="row">
            <div class="col text-center">
                <h1 class="display-4 mb-4">¡Gracias! Hasta pronto...</h1>
                <div class="mb-4">
                    <img src="img/sonrisa.jpg" class="img-fluid" alt="Sonrisa">
                </div>
                <a href="index.jsp" class="btn btn-primary btn-lg mb-4">Ir a la Página Principal</a>
                <a href="reporte.jsp" class="btn btn-danger btn-lg mb-4">Reporte PDF</a>
                <a href="EnvioCorreo.jsp" class="btn btn-danger btn-lg mb-4">Envio Correo</a>
                <div class="social-buttons">
                    <h3>Síguenos en redes sociales:</h3>
                    <a href="https://www.facebook.com/tucuenta" class="btn btn-outline-primary btn-lg me-2" target="_blank">Facebook</a>
                    <a href="https://www.instagram.com/tucuenta" class="btn btn-outline-primary btn-lg me-2" target="_blank">Instagram</a>
                    <a href="https://twitter.com/tucuenta" class="btn btn-outline-primary btn-lg" target="_blank">Twitter</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"></script>
</body>
</html>
