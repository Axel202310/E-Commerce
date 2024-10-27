<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verificaci�n de Correo</title>
</head>
<body>

<%
    // Recuperar el correo del cliente desde la sesi�n
    String correoCliente = (String) session.getAttribute("CorreoCliente");

    // Verificar si el correo est� presente
    if (correoCliente == null || correoCliente.isEmpty()) {
        out.println("<p>Error: No se encontr� el correo del cliente en la sesi�n.</p>");
    } else {
        // Generar un c�digo de verificaci�n de 4 d�gitos usando Math.random()
        int codigoVerificacion = (int)(Math.random() * 9000) + 1000;

        // Guardar el c�digo de verificaci�n en la sesi�n
        session.setAttribute("codigoVerificacion", codigoVerificacion);

        // Configuraci�n del correo
        String host = "smtp.gmail.com";
        String port = "587";
        String user = "ecomstore.internet@gmail.com";
        String pass = "gspj ahqy dqie vevr";

        String to = correoCliente;
        String subject = "C�digo de Verificaci�n";
        String messageText = "Tu c�digo de verificaci�n es: " + codigoVerificacion;

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });

        try {
            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setText(messageText);

            // Enviar el mensaje
            Transport.send(message);
            
            // Redirigir autom�ticamente a VerificarUsuario.jsp despu�s de enviar el correo
            response.sendRedirect("VerificarUsuario.jsp");

        } catch (MessagingException e) {
            out.println("<p>Error al enviar el correo: " + e.getMessage() + "</p>");
        }
    }
%>

</body>
</html>
