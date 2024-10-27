<%@ page import="com.itextpdf.text.*" %>
<%@ page import="com.itextpdf.text.pdf.PdfWriter" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="application/pdf" %>
<%@ page import="modelo.*" %>
<%@ page import="controller.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="com.itextpdf.text.Image" %>
<%@ page import="com.itextpdf.text.pdf.PdfPTable" %>
<%@ page import="com.itextpdf.text.pdf.PdfPCell" %>
<%@ page import="com.itextpdf.text.pdf.BaseFont" %>

<%
try {
    CarritoBD ObjBD = new CarritoBD();
    HttpSession MiSesion = request.getSession();
    Integer idCliente = (Integer) MiSesion.getAttribute("IdCliente");

    Usuarios cliente = ObjBD.InfoUsuario(idCliente);
    List<Ventas> listaVentas = ObjBD.listarVentas(idCliente); // Pasar idCliente aquí

    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=\"ReporteVentas.pdf\"");

    Document document = new Document();
    try {
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();
        
        
        // Definir estilos de fuente
        Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA, 24, BaseColor.GRAY);
        Font fontSubtitulo = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.GRAY);
        Font fontCorreo = FontFactory.getFont(FontFactory.HELVETICA, 11, Font.UNDERLINE, BaseColor.BLUE);
        Font fontTexto = FontFactory.getFont(FontFactory.HELVETICA, 11, BaseColor.BLACK);
        Font fontProducto = FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD, BaseColor.BLACK);
        Font fontProductoDescripcion = FontFactory.getFont(FontFactory.HELVETICA, 11, BaseColor.BLACK);
        Font fontTotal = FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD, BaseColor.BLACK);
        Font fontAdicional = FontFactory.getFont(FontFactory.HELVETICA, 9, BaseColor.BLACK);
        Font fontSubrayado = FontFactory.getFont(FontFactory.HELVETICA, 9, BaseColor.BLUE);
        
        // Crear y agregar el título
        Paragraph titulo = new Paragraph("Recibo", fontTitulo);
        titulo.setAlignment(Element.ALIGN_LEFT);
        titulo.setSpacingAfter(10);
        document.add(titulo);
        
        // Crear una tabla con dos columnas
        PdfPTable table = new PdfPTable(2); // 2 columnas
        table.setWidthPercentage(100); 
        
        // Establecer el color de fondo
        BaseColor backgroundColor = new BaseColor(250, 250, 250); 

        // Celda izquierda
        PdfPCell leftCell = new PdfPCell();
        leftCell.setBorder(Rectangle.NO_BORDER);
        
        leftCell.setBackgroundColor(backgroundColor);
        leftCell.addElement(new Paragraph("CORREO:", fontSubtitulo));       
        leftCell.addElement(new Paragraph(cliente != null ? cliente.getCorreo() : "Correo no disponible", fontCorreo));
        
        if (!listaVentas.isEmpty()) {
        	Ventas ventaReciente = listaVentas.stream()
        			.filter(venta -> venta.getIdCliente() == idCliente)  // Comparar correctamente como Integer
        		    .max(Comparator.comparing(Ventas::getIdVenta))
        		    .orElse(null);

            if (ventaReciente != null) {
                leftCell.addElement(new Paragraph("FECHA DEL RECIBO:", fontSubtitulo));
                leftCell.addElement(new Paragraph(ventaReciente.getFechaVenta(), fontTexto));
                leftCell.addElement(new Paragraph("ID DEL PEDIDO:", fontSubtitulo));
                leftCell.addElement(new Paragraph(ventaReciente.getIdVenta(), fontTexto));                  
            }
        } else {
            leftCell.addElement(new Paragraph("No hay ventas registradas para este cliente.", fontTexto));
        }
        

        // Celda derecha con fondo gris claro
        PdfPCell rightCell = new PdfPCell();
        rightCell.setBorder(Rectangle.NO_BORDER);       
        rightCell.setBackgroundColor(backgroundColor);

        // Añadir detalles del cliente a la celda derecha
        rightCell.addElement(new Paragraph("FACTURADO A:", fontSubtitulo));
        rightCell.addElement(new Paragraph(cliente != null ? cliente.getNombres() : "Nombre no disponible", fontTexto));
        rightCell.addElement(new Paragraph(cliente != null ? cliente.getApellidos() : "Apellido no disponible", fontTexto));
        rightCell.addElement(new Paragraph(cliente != null ? cliente.getDireccion() : "Dirección no disponible", fontTexto));
        table.addCell(leftCell);
        table.addCell(rightCell);
        document.add(table);
        
        // Agregar detalles de productos
        if (!listaVentas.isEmpty()) {
            Ventas ventaReciente = listaVentas.stream()
            	.filter(venta -> venta.getIdCliente() == idCliente)
                .max(Comparator.comparing(Ventas::getIdVenta))
                .orElse(null);

            if (ventaReciente != null) {
                List<Detalle> detallesVenta = ObjBD.obtenerDetalleVenta(ventaReciente.getIdVenta());

                if (!detallesVenta.isEmpty()) {
                    
                    document.add(new Paragraph("\nPRODUCTOS", fontSubtitulo));

                    // Crear tabla para los detalles de productos
                    PdfPTable productosTable = new PdfPTable(4); // 4 columnas
                    productosTable.setWidthPercentage(100);
                    productosTable.setSpacingBefore(10);

                    // Definir el ancho de las columnas
                    productosTable.setWidths(new float[]{1.2f, 3, 1, 1}); 

                    // Crear un color gris para los bordes
                    BaseColor grisColor = new BaseColor(192, 192, 192);

                    // Grosor de la línea
                    float grosorLinea = 0.3f; 

                    for (Detalle detalle : detallesVenta) {
                        Productos producto = ObjBD.InfoProducto(detalle.getIdProducto());

                        // Celda para la imagen
                        PdfPCell imageCell = new PdfPCell();
                        try {
                            // Cargar y ajustar la imagen
                            Image imagenProducto = Image.getInstance(request.getServletContext().getRealPath("/") + "img/" + producto.getImagen());
                            imagenProducto.scaleToFit(100, 100); // Ajusta la imagen a 100x100
                            imageCell.addElement(imagenProducto);
                        } catch (IOException e) {
                            imageCell.addElement(new Phrase("Error al cargar la imagen del producto.", fontTexto));
                        }
                        imageCell.setBorder(Rectangle.NO_BORDER);
                        imageCell.setFixedHeight(100); // Establecer altura fija para la celda
                        imageCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        imageCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                        productosTable.addCell(imageCell);

                        // Celda combinada para marca y descripción
                        PdfPCell marcaDescCell = new PdfPCell();
                        marcaDescCell.addElement(new Phrase(producto.getMarca(), fontProducto));
                        marcaDescCell.addElement(new Phrase(producto.getDescripcion(), fontProductoDescripcion));
                        marcaDescCell.setBorder(Rectangle.NO_BORDER);
                        marcaDescCell.setFixedHeight(100); // Establecer altura fija para que coincida con la imagen
                        marcaDescCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        marcaDescCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                        productosTable.addCell(marcaDescCell);

                        // Celda para la cantidad
                        PdfPCell cantidadCell = new PdfPCell(new Phrase(String.valueOf(detalle.getCantidad()) + " Uni.", fontProductoDescripcion));
                        cantidadCell.setBorder(Rectangle.NO_BORDER);
                        cantidadCell.setFixedHeight(100); // Establecer altura fija para la celda de cantidad
                        cantidadCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cantidadCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                        productosTable.addCell(cantidadCell);

                        // Celda para el precio
                        PdfPCell precioCell = new PdfPCell(new Phrase(String.valueOf("S/. " + detalle.getPrecioUnidad()), fontProducto));
                        precioCell.setBorder(Rectangle.NO_BORDER);
                        precioCell.setFixedHeight(100); // Establecer altura fija para la celda del precio
                        precioCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        precioCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                        productosTable.addCell(precioCell);

                        // Crear una celda vacía para añadir el borde
                        PdfPCell emptyCell = new PdfPCell();
                        emptyCell.setBorderWidthTop(grosorLinea);
                        emptyCell.setBorderWidthBottom(grosorLinea);
                        emptyCell.setBorderColor(grisColor);
                        emptyCell.setColspan(4); // Hace que ocupe todas las columnas
                        productosTable.addCell(emptyCell);
                    }

                    document.add(productosTable);


                    // Mover el monto total al final después de los productos
                    String montoTotal = ventaReciente != null ? "S/. " + String.valueOf(ventaReciente.getMontoTotal()) : "Monto no disponible";
                    Paragraph totalParagraph = new Paragraph("\nTOTAL: " + montoTotal, fontTotal);
                    totalParagraph.setIndentationLeft(375);
                    document.add(totalParagraph);
                    
                    
                    // Agregar espacio en blanco para empujar los párrafos hacia abajo
                    Paragraph espacio = new Paragraph("\n\n\n\n\n\n", fontAdicional); 
                    document.add(espacio);
                    
                    // Crear y centrar el primer párrafo                  
                    Chunk chunkNormal = new Chunk("Obtén ayuda con suscripciones y compras. ", fontAdicional);
                    Chunk chunkSubrayado = new Chunk("Visita la página de Soporte técnico de EcomStore", fontSubrayado);
                    Chunk chunkNormal2 = new Chunk(". Obtén detalles sobre cómo", fontAdicional);
                    Phrase phrase = new Phrase();
                    phrase.add(chunkNormal);
                    phrase.add(chunkSubrayado);
                    phrase.add(chunkNormal2);
                    Paragraph parrafo1 = new Paragraph(phrase);
                    parrafo1.setAlignment(Element.ALIGN_CENTER);
                    document.add(parrafo1);

                    // Crear y centrar el segundo párrafo
                    Chunk chunkBefore = new Chunk("administrar las preferencias de tu contraseña", fontSubrayado);                  
                    Chunk chunkAfter = new Chunk(" para las compras hechas en la página web de EcomStore", fontAdicional);
                    Phrase phrase2 = new Phrase();
                    phrase2.add(chunkBefore);
                    phrase2.add(chunkAfter);
                    Paragraph parrafo2 = new Paragraph(phrase2);
                    parrafo2.setAlignment(Element.ALIGN_CENTER);
                    document.add(parrafo2);
                    
                } else {
                    document.add(new Paragraph("No hay detalles de productos para esta venta.", fontTexto));
                }
            }
        }
           
        document.close();
        
    } catch (DocumentException | IOException e) {
        response.sendError(500, "Error al generar el documento PDF: " + e.getMessage());
    }
} catch (Exception e) {
    response.sendError(500, "Error en la generación del documento: " + e.getMessage());
}
%>