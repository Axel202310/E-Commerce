<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="modelo.*" %>
<%@ page import="controller.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.io.IOException" %>

<%

    //Obtener datos para el mensaje
    CarritoBD ObjBD = new CarritoBD();
    HttpSession MiSesion = request.getSession();
    Integer idCliente = (Integer) MiSesion.getAttribute("IdCliente"); 
    Usuarios cliente = ObjBD.InfoUsuario(idCliente);
    List<Ventas> listaVentas = ObjBD.listarVentas(idCliente); // Pasar idCliente aquí
    
    // Configuración del servidor SMTP de Gmail
    String host = "smtp.gmail.com";
    String port = "587";
    String user = "ecomstore.internet@gmail.com";
    String pass = "gspj ahqy dqie vevr"; // Usa una contraseña de aplicación si tienes autenticación en dos pasos habilitada

    // Parámetros del correo
    String to = cliente.getCorreo(); // Dirección del destinatario
    String subject = "El pedido ha sido generado";

    // Configurar las propiedades
    Properties props = new Properties();
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", port);
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");

    // Autenticación
    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(user, pass);
        }
    });

    try {
        

       

        StringBuilder messageText = new StringBuilder();
        messageText.append("<html><body style='font-family: Arial, sans-serif; color: #333;'>");

        // Título con estilo
        messageText.append("<h2 style='font-size: 24px; font-weight: 400; text-align: center; margin-top: 60px;'>")
           .append("Tu pedido ha sido")
           .append("<span style='font-weight: bold; color: #1c42ee;'> Aprobado</span>")
           .append("</h2>");
        
        messageText.append("<h2 style='font-size: 16px; font-weight: 400; text-align: center;'>")
           .append("En este momento estamos procediendo a validar")
           .append(" la disponibilidad de stock para poder despachar")
           .append(" tu pedido.")
           .append("</h2>");
        
        messageText.append("<h2 style='font-size: 16px; font-weight: 400; text-align: center;'>")
           .append("Gracias por comprar en")
           .append("<span style='font-weight: bold; color: #1c42ee;'> EcomStore</span>")
           .append("</h2>");
        
        messageText.append("<h1 style='font-family: Helvetica, Arial, sans-serif; font-size: 24px; color: gray; margin-top: 60px;'>Recibo</h1>");
        
        
        // Contenedor principal con tabla
        messageText.append("<table style='width: 100%; border-collapse: collapse;'>");

        // Fila para los detalles de venta y cliente
        messageText.append("<tr>");
        messageText.append("<td style='width: 50%; vertical-align: top;'>");
        messageText.append("<div style='background-color: #f0f0f0; padding: 10px;'>");
        messageText.append("<h2 style='font-size: 16px;  margin-top: 0; margin-bottom: 0;'>CORREO</h2>");
        messageText.append("<h3 style='font-size: 15px;  margin-top: 0; margin-bottom: 0;'>").append(cliente.getCorreo()).append("</h3>");
        if (!listaVentas.isEmpty()) {
            Ventas ventaReciente = listaVentas.stream()
                    .filter(venta -> venta.getIdCliente() == idCliente)
                    .max(Comparator.comparing(Ventas::getIdVenta))
                    .orElse(null);

            if (ventaReciente != null) {
            	messageText.append("<h2 style='font-size: 16px; margin-bottom: 0;'>FECHA DEL RECIBO:</h2>");
            	messageText.append("<h3 style='font-size: 15px; font-weight: 400; margin-top: 0; margin-bottom: 0;'>").append(ventaReciente.getFechaVenta()).append("</h3>");
            	messageText.append("<h2 style='font-size: 16px; margin-bottom: 0;'>ID DEL PEDIDO: </h2>");
                messageText.append("<h3 style='font-size: 15px; font-weight: 400; margin-top: 0; margin-bottom: 0;'>").append(ventaReciente.getIdVenta()).append("</h3>");
                
            }
        } else {
            messageText.append("<p>No hay ventas registradas para este cliente.</p>");
        }

        messageText.append("</div>");
        messageText.append("</td>");
        
        messageText.append("<td style='width: 50%; vertical-align: top;'>");
        messageText.append("<div style='background-color: #f0f0f0; padding: 10px;'>");
        messageText.append("<h2 style='font-size: 16px;'>FACTURADO A: </h2>");
        if (cliente != null) {
            messageText.append("<h3 style='font-size: 15px; font-weight: 400; margin-top: 0; margin-bottom: 0;'>").append(cliente.getNombres()).append("</h3>");
            messageText.append("<h3 style='font-size: 15px; font-weight: 400; margin-top: 0; margin-bottom: 0;'>").append(cliente.getApellidos()).append("</h3>");
            messageText.append("<h3 style='font-size: 15px; font-weight: 400; margin-top: 0; margin-bottom: 0;'>").append(cliente.getDireccion()).append("</h3>");
            messageText.append("<br>");
            messageText.append("<br>");
            
        }
        messageText.append("</div>");
        messageText.append("</td>");
        messageText.append("</tr>");

        messageText.append("</table>");

        // Productos debajo de la tabla principal
        messageText.append("<h2 style='font-size: 18px; margin-top: 60px;'>Productos</h2>");
        
        
        
        
        if (!listaVentas.isEmpty()) {
            Ventas ventaReciente = listaVentas.stream()
                    .filter(venta -> venta.getIdCliente() == idCliente)
                    .max(Comparator.comparing(Ventas::getIdVenta))
                    .orElse(null);

            if (ventaReciente != null) {
                List<Detalle> detallesVenta = ObjBD.obtenerDetalleVenta(ventaReciente.getIdVenta());

                if (!detallesVenta.isEmpty()) {
                    messageText.append("<table style='width: 100%; border-collapse: collapse;'>");

                    for (Detalle detalle : detallesVenta) {
                        Productos producto = ObjBD.InfoProducto(detalle.getIdProducto());

                        
                        // Parte fija de la URL de la imagen GITHUB
                        String baseUrl = "https://raw.githubusercontent.com/MirellaYu/Imagenes/main/img/";  // URL base fija

                        // Obtener el nombre de la imagen desde el producto (por ejemplo, "consola6.jpg")
                        String imagenNombre = producto.getImagen();

                        // Concatenar la URL completa
                        String imagenUrl = baseUrl + imagenNombre;

                        // Crear una fila en la tabla
                        messageText.append("<tr>");

                        // Mostrar la imagen utilizando la URL generada
                        messageText.append("<td style='width: 10%; padding: 5px; height: 30px; border-bottom: 1px solid gray; border-top: 1px solid gray;'>");
                        messageText.append("<img src='")
                                   .append(imagenUrl)
                                   .append("' alt='")
                                   .append(producto.getMarca())  // Usamos el atributo marca como texto alternativo
                                   .append("' style='width: 100px; height: 100px;' />");
                        messageText.append("</td>");

                      
                        
                                                
                        // Marca y Descripción
                        messageText.append("<td style='width: 45%; padding: 5px; height: 30px; border-bottom: 1px solid gray; border-top: 1px solid gray;'>");
                        messageText.append("<h3 style='font-size: 15px; font-weight: bold; margin-top: 0; margin-bottom: 0;'>").append(producto.getMarca()).append("</h3>");
                        messageText.append("<h3 style='font-size: 15px; font-weight: 400; margin-top: 0;'>").append(producto.getDescripcion()).append("</h3>");
                        messageText.append("</td>");

                        // Cantidad
                        messageText.append("<td style='width: 15%; padding: 5px; height: 30px; border-bottom: 1px solid gray; border-top: 1px solid gray;'>");
                        messageText.append("<h3 style='font-size: 15px; font-weight: 400;'>").append(detalle.getCantidad()).append(" Uni.</h3>");
                        messageText.append("</td>");

                        // Precio
                        messageText.append("<td style='width: 15%; padding: 5px; height: 30px; border-bottom: 1px solid gray; border-top: 1px solid gray;'>");
                        messageText.append("<h3 style='font-size: 15px; font-weight: 400;'>S/. ").append(detalle.getPrecioUnidad()).append("</h3>");
                        messageText.append("</td>");

                        messageText.append("</tr>");
                    }

                    String montoTotal = "S/. " + String.valueOf(ventaReciente.getMontoTotal());
                    messageText.append("<tr><td colspan='4' style='text-align: right; padding: 20px; font-size: 20px; font-weight: bold;'><strong style='font-size: 20px; font-weight: bold;'>Total:</strong> ").append(montoTotal).append("</td></tr>");
                    messageText.append("</table>");
                } else {
                    messageText.append("<p>No hay detalles de productos para esta venta.</p>");
                }
            }
        }
        
        

        messageText.append("<p style='text-align: center;'>")
             .append("Obtén ayuda con suscripciones y compras. ")
             .append("Visita la página de Soporte técnico de EcomStore. ")
             .append("Obtén detalles sobre cómo administrar las preferencias de tu contraseña ")
             .append("para las compras hechas en la página web de EcomStore.")
             .append("</p>");

        messageText.append("</body></html>");

        // Crear mensaje
        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(user));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject);
        message.setContent(messageText.toString(), "text/html");

        // Enviar correo
        Transport.send(message);
        
        // Usar JavaScript para abrir Gmail en una nueva pestaña y redirigir a la página anterior
        out.println("<script type='text/javascript'>");
        out.println("window.open('https://mail.google.com', '_blank');"); // Abre Gmail en una nueva pestaña
        out.println("window.history.back();"); // Redirige a la página anterior
        out.println("</script>");
        
    
        
    } catch (MessagingException e) {
        e.printStackTrace();
        out.println("Error al enviar el correo: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error en la generación del contenido del correo: " + e.getMessage());
    }


%>