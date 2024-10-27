<%@page import="java.util.ArrayList" %>
<%@page import="modelo.*"%>
<%@page import="controller.CarritoBD"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalle de Pago</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .logo {
            font-family: Arial, sans-serif;
            font-weight: bold;
            font-size: 28px;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            color: #333;
            margin: 0;
            padding: 0;
        }
        
        h1{
            font-size: 22px; 
            font-weight: bold;
            margin-top: 20px;
            
        }

        .d-flex, .container-right {
            background-color: #fff;
            border: none;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            padding: 12px;
            border-left: 1px solid white; 
            border-right: 1px solid white; 
            border-top: 1px solid #d3d3d3;
            border-bottom: 1px solid #d3d3d3;
        }
        
        .product-section {
            margin-top: 10px;
            display: none; /* Ocultar por defecto */
        }

        .product-details {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .product-image {
            width: 50px;
            height: 50px;
            margin-right: 10px;
        }

        .product-info {
            display: flex;
            flex-direction: column;
        }

        .product-info .price {
            font-weight: bold;
            margin-top: 2px;
        }

        .product-header {
            font-weight: bold;
            margin-bottom: 10px;
            cursor: pointer; /* Mostrar que es clickeable */
        }
            
        /*MODO DE PAGO*/
        .button {
            display: inline-block;
            padding: 10px 150px; /* Espaciado interno del contenedor */
            background-color: #1962c1; /* Color de fondo gris */
            border-radius: 10px; /* Bordes redondeados */
            text-decoration: none; /* Eliminar el subrayado de los enlaces */
            color: #ffffff; /* Color del texto */
            font-size: 18px; /* Tamaño de fuente opcional */
            font-family: Arial; 
            font-weight: 600;
            border: none;
        }
        
        .input-custom-borders {
           width: 100%;
           padding: 5px;
           border-left: 1px solid white;
           border-right: 1px solid white;
           border-top: 1px solid white;
           border-bottom: 1px solid #000;
           outline: none;
           font-size: 20px; /* Tamaño de fuente uniforme */
           box-sizing: border-box; /* Asegura que el padding no afecte el tamaño */
           margin-top: 10px;
        }
        
        .multicolor-icon {
    
            background: linear-gradient(45deg, #ff6f61, #6b5b95, #88b04b, #f9c74f);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        /* Estilo general para todas las etiquetas de opciones de pago */
        .payment-option-1, .payment-option-2, .payment-option-3 {
            border: 1px solid #d1d1d1; /* Borde gris */
            border-radius: 10px; /* Radio de 5px */
            padding: 3px 9px; /* Espaciado interno */
            align-items: center; /* Alinear íconos y texto verticalmente */
            gap: 10px; /* Espacio entre el texto y el ícono */
            margin: 5px 0; /* Espaciado vertical entre etiquetas */
            width: 220px;
            box-sizing: border-box;
        }
           
    </style>
</head>
<body>
<%
    if (session.getAttribute("IdCliente") == null) {
        response.sendRedirect("login.jsp?error=Por favor inicie sesión para continuar con la compra");
        return;
    }
%>
<%

    CarritoBD ObjBD = new CarritoBD();
    HttpSession MiSesion = request.getSession();
    ArrayList<carrito> Lista = (ArrayList<carrito>) MiSesion.getAttribute("cesto");
    double Total = 0;

    // Obtener el idCliente de la sesión como Integer
    Integer idCliente = (Integer) MiSesion.getAttribute("IdCliente");

    // Verificar si idCliente no es null
    if (idCliente != null) {
        // Obtener la información del usuario mediante su ID
        Usuarios cliente = ObjBD.InfoUsuario(idCliente);
    } else {
        out.println("Error: No se encontró el ID del cliente en la sesión.");
    }
%>

<!-- HEADER -->
<div class="d-flex justify-content-between align-items-center mb-0" style="background-color: #fafafa; padding: 10px 0;">
    <h2 class="logo" style="margin-left: 40px;">
        <a href="index.jsp" style="text-decoration: none; color: inherit;">EcomStore</a>
    </h2>
</div>

<div class="container" style="margin-top:30px">
    <div class="row">
        <!-- Sección de Realizar Pago -->
        <div class="col-md-8">
            <h3 style="font-family: Arial; font-size: 24px; font-weight: bold; margin: 20px 0;">Realizar pago</h3>
            <div class="d-flex">
                <div class="flex-container">
                    <form id="payment-form" action="registrarMetodoPago.jsp" method="post">
                        <!-- Contenedor con opciones de pago -->
                        <div class="payment-options" style="margin-left:30px;">
                            <h1>Selecciona un método de pago</h1>

                            <!-- Opción: Tarjeta de Crédito -->
                            <label class="payment-option-1">
                                <input type="radio" name="descripcion" value="Tarjeta de Crédito" required onclick="updateVisibility()">
                                Tarjeta 
                                <img src="img/tarjeta1.png" style="width: 30px; height: 30px; margin-left:20px;">
                                <img src="img/tarjeta2.png" style="width: 30px; height: 30px;">
                                <img src="img/tarjeta3.png" style="width: 40px; height: 40px;">
                            </label>
                            <br>

                            <!-- Opción: Pago Efectivo -->
                            <label class="payment-option-2">
                                <input type="radio" name="descripcion" value="Pago Efectivo" onclick="updateVisibility()" >
                                Pago Efectivo
                                <img src="img/efectivo.png" style="width: 30px; height: 30px; margin-left:20px;">
                            </label>
                        </div>

                        <!-- Formulario: Tarjeta de Crédito -->
                        <div id="tarjeta-credito" style="display: none; margin-top:30px; align-items: center; margin-left:30px;">
                             <div>
                                 <label for="nombre" style="font-size: 20px;">Titular de la tarjeta</label><br>
                                 <input type="text" id="nombre" name="nombre" class="input-custom-borders" required>
                             </div>

                             <div style="margin-top: 20px;">
                                 <label for="numero" style="font-size: 20px;">Número de la tarjeta</label><br>
                                 <input type="text" id="numero" name="numero" class="input-custom-borders" 
                                        placeholder="0000 0000 0000 0000" oninput="validateNumber(this)" required>
                             <div id="card-message" style="font-size: 18px; color: green;"></div>
                        </div>

                        <div style="display: flex; gap: 30px; margin-top: 20px;">
                             <div style="flex: 1;">
                                  <label for="expiracion" style="font-size: 20px;">Fecha de expiración</label><br>
                                  <input type="text" id="expiracion" name="expiracion" class="input-custom-borders"
                                         placeholder="MM/YY" maxlength="5" pattern="\d{2}/\d{2}"
                                         title="Ingrese en formato MM/YY" oninput="formatDate(this)" required>
                             </div>
        

                             <div style="flex: 1;">
                                  <label for="codigo" style="font-size: 20px;">Código de seguridad</label><br>
                                  <input type="text" id="codigo" name="codigo" class="input-custom-borders"
                                         placeholder="CVV" required>
                             </div>
                        </div>
                   </div>

                        <!-- Formulario: Pago Efectivo -->
                        <div id="Pago-efectivo" style="display: none; margin-top:30px; margin-left:30px;">
                            <div>
                                <label style="font-size: 28px; font-weight: bold;">¡Estás a punto de finalizar tu compra en EcomStore!</label><br>
                            </div>
                            <div style="background-color: #f0f0f0; padding: 20px; text-align: center; margin-top:30px;">
                                <label style="font-size: 25px;">Código de pago (CIP)</label><br>
                                <label id="cip-number" style="font-size: 36px; font-weight: bold;"></label>
                            </div>
                            <div style="font-size: 20px;text-align: center; margin-top: 20px;">
                                <label><i class="fas fa-clock"></i> Págalo antes del <b>Domingo 11:59 PM</b></label>
                            </div>
                        </div>

                        <div style="text-align: center; margin-top: 30px;">
                            <button type="submit" class="button">Pagar ahora</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Sección de Resumen de la Compra -->
        <div class="col-md-4">
            <h3 style="font-family: Arial; font-size: 24px; font-weight: bold; margin: 20px 0;">Resumen de la compra</h3>
            <div class="container-right">
                <table class="table">
                    <tr>
                        <td>
                            <div class="product-header" id="toggleProducts">
                                Productos
                                <i class="fas fa-chevron-down" style="font-size: 18px; margin-left: 190px; color: gray;"></i>
                            </div>
                            <% 
                                if (Lista != null && !Lista.isEmpty()) {
                            %>
                            <div class="product-section" id="productSection">
                                <%
                                    for (int i = 0; i < Lista.size(); i++) { 
                                        Productos ObjP = ObjBD.InfoProducto(Lista.get(i).getIdProducto());
                                        int Cantidad = Lista.get(i).getCantidad();
                                        double Precio = ObjP.getPrecioUnidad();
                                        double SubTotal = Cantidad * Precio;
                                        Total += SubTotal;

                                        int NuevoStock = ObjP.getStock() ;

                                        if (NuevoStock >= 0) {
                                           
                                        } else {
                                            out.println("<div style='color:red;'>Error: No hay suficiente stock para el producto: " + ObjP.getDescripcion() + "</div>");
                                            return;
                                        }
                                %>
                                <div class="product-details">
                                    <div style="font-family: Arial; font-size: 14px;"><%= Cantidad %> Uni.</div>
                                    <img src="<%= "img/" + ObjP.getImagen() %>" class="product-image">
                                    <div class="product-info">
                                        <div style="font-family: Arial; font-size: 14px;"><%= ObjP.getDescripcion() %></div>
                                        <div class="price" style="font-family: Arial; font-size: 14px;">S/ <%= ObjP.getPrecioUnidad() %></div>
                                    </div>
                                </div>
                                <% 
                                    } 
                                %>
                            </div>
                            <% 
                                } else {
                                    out.println("<div>El carrito está vacío.</div>");
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; font-weight: bold;">
                            <div style="display: flex; justify-content: space-between;">
                                <span>Total</span>
                                <span>S/ <%= Total %></span>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
 


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"  integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous"></script>
<script>
    document.getElementById("toggleProducts").onclick = function() {
        var productSection = document.getElementById("productSection");
        if (productSection.style.display === "none") {
            productSection.style.display = "block";
        } else {
            productSection.style.display = "none";
        }
    };
   
</script>



<script>
// Función para formatear y validar la fecha de expiración
function formatDate(input) {
    let value = input.value.replace(/\D/g, ''); // Remueve todos los caracteres no numéricos
    let errorMessage = ""; // Inicializa el mensaje de error
    
    if (value.length >= 2) {
        let month = value.slice(0, 2); // Extrae el valor del mes
        input.value = value.slice(0, 2); // Actualiza el valor mientras el usuario escribe

        // Si ya tiene 2 dígitos, agrega la barra "/"
        if (value.length >= 3) {
            let year = value.slice(2, 4);  // Extrae el valor del año
            input.value = value.slice(0, 2) + '/' + value.slice(2, 4); // Actualiza el valor con la barra

            // Verifica si el mes es válido (01-12) y si el año es mayor o igual a 24
            if (parseInt(month) < 1 || parseInt(month) > 12 || parseInt(year) < 24) {
                errorMessage = "Fecha incorrecta."; // Mensaje general de error
            }
        }
    }

    input.setCustomValidity(errorMessage); // Establece el mensaje de error si lo hay
    input.reportValidity(); // Muestra el mensaje de error si existe
}
</script>



<script>
function generateRandomNumber() {
    const min = 100000000; 
    const max = 999999999; 
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Asigna el número aleatorio al label al cargar la página
window.onload = function() {
    document.getElementById('cip-number').textContent = generateRandomNumber();
};
</script>



<script>
// Alterna entre los formularios de tarjeta de crédito y pago en efectivo
document.addEventListener('DOMContentLoaded', function () {
    const tarjetaCreditoOption = document.querySelector('input[name="descripcion"][value="Tarjeta de Crédito"]');
    const pagoEfectivoOption = document.querySelector('input[name="descripcion"][value="Pago Efectivo"]');
    const tarjetaCreditoDiv = document.getElementById('tarjeta-credito');
    const pagoEfectivoDiv = document.getElementById('Pago-efectivo');

    function updateVisibility() {
        if (tarjetaCreditoOption.checked) {
            tarjetaCreditoDiv.style.display = 'block';
            pagoEfectivoDiv.style.display = 'none';

            // Hacer los campos de tarjeta requeridos
            document.getElementById('nombre').setAttribute('required', true);
            document.getElementById('numero').setAttribute('required', true);
            document.getElementById('expiracion').setAttribute('required', true);
            document.getElementById('codigo').setAttribute('required', true);
        } else if (pagoEfectivoOption.checked) {
            tarjetaCreditoDiv.style.display = 'none';
            pagoEfectivoDiv.style.display = 'block';

            // Eliminar el atributo 'required' de los campos de tarjeta
            document.getElementById('nombre').removeAttribute('required');
            document.getElementById('numero').removeAttribute('required');
            document.getElementById('expiracion').removeAttribute('required');
            document.getElementById('codigo').removeAttribute('required');
        }
    }

    // Agregar eventos para cambiar entre opciones
    tarjetaCreditoOption.addEventListener('change', updateVisibility);
    pagoEfectivoOption.addEventListener('change', updateVisibility);

    // Ejecutar la función al cargar la página
    updateVisibility();
});
</script>


<script>
const numeroInput = document.getElementById('numero');

numeroInput.addEventListener('input', function(event) {
    const numero = event.target.value;

    // Resetear el mensaje de error en el input
    numeroInput.setCustomValidity(""); // Limpia los mensajes de error

    // Validar el número de la tarjeta
    if (!numero) {
        numeroInput.setCustomValidity('Falta rellenar el campo');
    } else if (numero.trim().length === 0) { // Verificar si el campo contiene solo espacios en blanco
        numeroInput.setCustomValidity('No se permite ingresar solo espacio en blanco');
    } else if (/\s/.test(numero)) {
        numeroInput.setCustomValidity('No se permite ingresar entre espacios');
    } else if (/[a-zA-Z]/.test(numero)) {
        numeroInput.setCustomValidity('No se permiten letras');
    } else if (/[^0-9]/.test(numero)) {
        numeroInput.setCustomValidity('No se permiten caracteres especiales');
    } else if (numero.length !== 16) {
        numeroInput.setCustomValidity('Solo se permiten 16 caracteres');
    } else {
        numeroInput.setCustomValidity(''); // Limpiar cualquier mensaje de error si todo es correcto
    }

    // Si hay un error, mostrar el mensaje inmediatamente
    numeroInput.reportValidity();
});

// Mostrar el mensaje del tipo de tarjeta cuando el número es válido
numeroInput.addEventListener('input', function(event) {
    const value = event.target.value.replace(/\D/g, ''); // Mantiene solo los dígitos
    const cardMessage = document.getElementById('card-message');

    if (value.length === 16) { // Verifica que el número tenga 16 dígitos
        const firstDigit = value.charAt(0);
        switch (firstDigit) {
            case '4':
                cardMessage.textContent = "Su tarjeta es de VISA";
                cardMessage.style.color = "green";
                break;
            case '5':
                cardMessage.textContent = "Su tarjeta es de Mastercard";
                cardMessage.style.color = "green";
                break;
            case '3':
                cardMessage.textContent = "Su tarjeta es de American Express";
                cardMessage.style.color = "green";
                break;
            default:
                cardMessage.textContent = "Su tarjeta no pertenece a las opciones disponibles";
                cardMessage.style.color = "red";
                break;
        }
    } else {
        cardMessage.textContent = ""; // Limpiar el mensaje si no se ha ingresado el número completo
    }
});

// Verifica el formulario antes de enviarlo
document.querySelector('form').addEventListener('submit', function(event) {
    const cardMessage = document.getElementById('card-message').textContent;
    if (cardMessage === "Su tarjeta no pertenece a las opciones disponibles") {
        event.preventDefault(); // Evita que el formulario se envíe
        alert("Por favor, ingrese una tarjeta válida."); // Mensaje para el usuario
    }
});
</script>

<script> 
const titularInput = document.getElementById('nombre');

titularInput.addEventListener('input', function(event) {
    const titular = event.target.value;

    // Resetear el mensaje de error en el input
    titularInput.setCustomValidity(""); // Limpia los mensajes de error

    // Validar el nombre del titular: no vacío, sin números ni caracteres especiales
    if (!titular) {
        titularInput.setCustomValidity('Falta rellenar el campo');
    } else if (titular.trim().length === 0) { // Verificar si el campo contiene solo espacios en blanco
        titularInput.setCustomValidity('No se permite ingresar solo espacio en blanco');
    } else if (/\d/.test(titular)) {
        titularInput.setCustomValidity('No se permiten números.');
    } else if (/[^a-zA-Z\s]/.test(titular)) {
        titularInput.setCustomValidity('No se permiten caracteres especiales.');
    } else if (titular.length < 2 || titular.length > 40) {
        titularInput.setCustomValidity('Texto de 2 y 40 caracteres.');
    }

    // Si hay un error, mostrar el mensaje inmediatamente
    titularInput.reportValidity();
});
</script>

<script>
const codigoInput = document.getElementById('codigo');

codigoInput.addEventListener('input', function(event) {
    const codigo = event.target.value;

    // Resetear el mensaje de error en el input
    codigoInput.setCustomValidity(""); // Limpia los mensajes de error

    // Validar el código de seguridad
    if (!codigo) {
        codigoInput.setCustomValidity('falta rellenar el campo');
    } else if (codigo.trim().length === 0) { // Verificar si el campo contiene solo espacios en blanco
        codigoInput.setCustomValidity('No se permite ingresar solo espacio en blanco');
    } else if (/\s/.test(codigo)) {
        codigoInput.setCustomValidity('No se permite ingresar entre espacios');
    } else if (/[a-zA-Z]/.test(codigo)) {
        codigoInput.setCustomValidity('No se permiten letras');
    } else if (/[^0-9]/.test(codigo)) {
        codigoInput.setCustomValidity('No se permiten caracteres especiales');
    } else if (codigo.length !== 3) {
        codigoInput.setCustomValidity('Solo se permiten 3 caracteres');
    } else {
        codigoInput.setCustomValidity(''); // Si pasa todas las validaciones, limpiar el error
    }

    // Si hay un error, mostrar el mensaje inmediatamente
    codigoInput.reportValidity();
});
</script>
</body>
</html>