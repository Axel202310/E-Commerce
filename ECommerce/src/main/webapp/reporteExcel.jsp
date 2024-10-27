<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
<%@ page import="org.apache.poi.ss.usermodel.*" %>
<%@ page import="java.io.*" %>
<%@ page import="modelo.*" %>
<%@ page import="controller.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Obtener parámetros de fechas desde el formulario en formato yyyy-MM-dd (formato del input type="date")
    String startDateStr = request.getParameter("startDate");
    String endDateStr = request.getParameter("endDate");

    // Definir formato de fecha de entrada (formato que llega desde el input "date")
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    // Convertir las fechas del formulario al formato Date
    Date startDate = null;
    Date endDate = null;

    if (startDateStr != null && endDateStr != null) {
        try {
            startDate = dateFormat.parse(startDateStr);
            endDate = dateFormat.parse(endDateStr);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Crear una instancia de CarritoBD para obtener todas las ventas
    CarritoBD carritoBD = new CarritoBD();
    List<Ventas> listaVentas = carritoBD.listarVentas1(); // Obtener todas las ventas

    // Filtrar ventas según el rango de fechas
    List<Ventas> ventasFiltradas = new ArrayList<>();
    for (Ventas venta : listaVentas) {
        try {
            // Obtener la fecha de la venta y convertirla a Date (ya viene en formato yyyy-MM-dd)
            Date fechaVenta = dateFormat.parse(venta.getFechaVenta());

            // Comparar la fecha de venta con el rango ingresado
            if ((startDate == null || !fechaVenta.before(startDate)) &&
                (endDate == null || !fechaVenta.after(endDate))) {
                ventasFiltradas.add(venta); // Agregar las ventas que cumplen con el rango de fechas
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Configurar el tipo de respuesta para archivo Excel
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "attachment; filename=\"ReporteVentas.xls\"");

    // Crear un libro de Excel
    Workbook workbook = new HSSFWorkbook();
    Sheet sheet = workbook.createSheet("Listado de Ventas");

    // Crear estilos para las celdas de encabezado
    CellStyle headerStyle = workbook.createCellStyle();
    Font headerFont = workbook.createFont();
    headerFont.setBold(true);
    headerFont.setColor(IndexedColors.WHITE.getIndex()); // Color de letra blanco
    headerStyle.setFont(headerFont);

    // Establecer el color de fondo celeste
    headerStyle.setFillForegroundColor(IndexedColors.SKY_BLUE.getIndex());
    headerStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
    
    // Crear fila de encabezado
    Row headerRow = sheet.createRow(0);
    String[] headers = { "ID Venta", "Cliente", "Producto", "Cantidad", "Precio Unitario", "Método Pago", "Monto Total", "Fecha" };

    for (int i = 0; i < headers.length; i++) {
        Cell cell = headerRow.createCell(i);
        cell.setCellValue(headers[i]);
        cell.setCellStyle(headerStyle);
    }

    // Llenar los datos de ventas filtradas
    int rowNum = 1;
    for (Ventas venta : ventasFiltradas) {
        Usuarios cliente = carritoBD.InfoUsuario(venta.getIdCliente());
        List<Detalle> detallesVenta = carritoBD.obtenerDetalleVenta(venta.getIdVenta());

        for (Detalle detalle : detallesVenta) {
            Productos producto = carritoBD.InfoProducto(detalle.getIdProducto());

            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(venta.getIdVenta());
            row.createCell(1).setCellValue(cliente.getNombres() + " " + cliente.getApellidos());
            row.createCell(2).setCellValue(producto.getDescripcion());
            row.createCell(3).setCellValue(detalle.getCantidad());
            row.createCell(4).setCellValue(detalle.getPrecioUnidad());
            row.createCell(5).setCellValue(carritoBD.obtenerMetodoPago(venta.getIdMetodoPago()));
            row.createCell(6).setCellValue(venta.getMontoTotal());
            row.createCell(7).setCellValue(venta.getFechaVenta());
        }
    }

    // Ajustar el ancho de las columnas automáticamente
    for (int i = 0; i < headers.length; i++) {
        sheet.autoSizeColumn(i);
    }

    // Escribir el archivo Excel en la respuesta
    OutputStream outputStream = response.getOutputStream();
    workbook.write(outputStream);
    workbook.close();
    outputStream.close();
%>