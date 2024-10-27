<!DOCTYPE html> 
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrarse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <style>
        body {
            background-color: rgba(240, 233, 231, 0.61); 
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: rgba(242, 242, 242, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
        }

        h1 {
            font-family: 'Times New Roman', Times, serif;
            font-size: 36px;
            font-weight: bold;
            color: #080f16cc;
            text-align: center;
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #ff885d;
            border: none;
            border-radius: 5px;
            padding: 10px;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #ff6b39;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .link {
            color: #007bff;
        }

        .link:hover {
            text-decoration: underline;
        }

        .password-requirements {
            margin-top: 10px;
            font-size: 14px;
        }

        .password-requirements span {
            display: block;
        }

        .strength-indicator {
            display: flex;
            align-items: center;
            margin-top: 5px;
        }

        .strength-bar {
            width: 100%;
            height: 8px;
            border-radius: 5px;
            margin-right: 10px;
        }

        .strength-text {
            font-size: 14px;
            margin-left: 10px;
        }

        .text-weak {
            color: #dc3545; /* Rojo */
        }

        .text-medium {
            color: #ffc107; /* Amarillo */
        }

        .text-strong {
            color: #28a745; /* Verde */
        }
    </style>
</head>
<body>

    <div class="container">
    <!-- Verificar si hay un mensaje de éxito y redirigir al login -->
        <script>
            // Verifica si el parámetro "registro=exito" está en la URL
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('registro') === 'exito') {
                // Muestra el mensaje de éxito
                alert('Registro Exitoso');

                // Redirige al usuario a login.jsp después de 2 segundos
                setTimeout(() => {
                    window.location.href = 'login.jsp';
                }, ); // 2000 milisegundos = 2 segundos
            }
        </script>
        <h1>Registrarse</h1>
        <form action="registrarUsuario.jsp" method="post" id="registrationForm">
            <div class="row mb-3">
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="txtnombres" class="form-label">Nombres</label>
                    <input type="text" id="txtnombres" name="txtnombres" class="form-control" required>
                  </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtapellidos" class="form-label">Apellidos</label>
                        <input type="text" id="txtapellidos" name="txtapellidos" class="form-control" required>
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtdireccion" class="form-label">Dirección</label>
                        <input type="text" id="txtdireccion" name="txtdireccion" class="form-control" required>                  
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtfecha" class="form-label">Fecha de Nacimiento</label>
                        <input type="date" id="txtfecha" name="txtfecha" class="form-control" required>
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtsexo" class="form-label">Sexo</label>
                        <select id="txtsexo" name="txtsexo" class="form-select" required>
                            <option value="" disabled selected>Seleccione una opción</option>
                            <option value="M">Masculino</option>
                            <option value="F">Femenino</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtcorreo" class="form-label">Correo</label>
                        <input type="email" id="txtcorreo" name="txtcorreo" class="form-control" required>
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtpass" class="form-label">Password</label>
                        <input type="password" id="txtpass" name="txtpass" class="form-control" required>
                        <div class="strength-indicator">
                            <div id="strengthBar" class="strength-bar bg-danger"></div>
                            <span id="strengthText" class="strength-text text-weak" style="display: none;">Débil</span>
                        </div>
                        <div id="passwordRequirements" class="password-requirements">
                            <span id="upperCase" class="text-danger">- Una letra mayúscula</span>
                            <span id="number" class="text-danger">- Un número</span>
                            <span id="specialChar" class="text-danger">- Un carácter especial</span>
                            <span id="minLength" class="text-danger">- Mínimo 8 caracteres</span>
                            <span id="maxLength" class="text-danger">- Máximo 16 caracteres</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group mb-3 d-grid gap-2">
                <button type="submit" class="btn btn-primary" id="submitBtn" disabled>Registrarse</button>
                <button type="reset" class="btn btn-secondary">Limpiar</button>
            </div>
            <div class="text-center">
                <a href="login.jsp" class="link">Ya tienes cuenta (Inicia sesión)</a>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script>
        const passwordInput = document.getElementById('txtpass');
        const submitBtn = document.getElementById('submitBtn');

        // Requisitos individuales
        const upperCaseReq = document.getElementById('upperCase');
        const numberReq = document.getElementById('number');
        const specialCharReq = document.getElementById('specialChar');
        const minLengthReq = document.getElementById('minLength');
        const maxLengthReq = document.getElementById('maxLength');
        const passwordRequirements = document.getElementById('passwordRequirements');

        // Indicadores de fuerza de la contraseña
        const strengthBar = document.getElementById('strengthBar');
        const strengthText = document.getElementById('strengthText');

        // Inicialmente oculta las restricciones y el texto de fuerza
        passwordRequirements.style.display = 'none';
        strengthBar.style.display = 'none'; // Ocultar barra inicialmente
        strengthText.style.display = 'none'; // Ocultar texto inicialmente

        // Muestra las restricciones y la barra cuando el campo está enfocado
        passwordInput.addEventListener('focus', function () {
            passwordRequirements.style.display = 'block'; // Mostrar requisitos
            strengthBar.style.display = 'block'; // Mostrar barra de fuerza
            strengthText.style.display = 'block'; // Mostrar texto de fuerza
        });

        // Oculta las restricciones, la barra y el texto si se pierde el foco y el campo está vacío
        passwordInput.addEventListener('blur', function () {
            if (passwordInput.value === '') {
                passwordRequirements.style.display = 'none'; // Oculta requisitos
                strengthBar.style.display = 'none'; // Oculta la barra de fuerza
                strengthText.style.display = 'none'; // Ocultar el texto de fuerza
            }
        });

        passwordInput.addEventListener('input', function () {
            const password = passwordInput.value;
            const hasUpperCase = /[A-Z]/.test(password);
            const hasNumber = /\d/.test(password);
            const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
            const isValidLength = password.length >= 8;
            const isValidLength1 = password.length <= 16;


            // Cambiar color según si el requisito está cumplido
            upperCaseReq.className = hasUpperCase ? 'text-success' : 'text-danger';
            numberReq.className = hasNumber ? 'text-success' : 'text-danger';
            specialCharReq.className = hasSpecialChar ? 'text-success' : 'text-danger';
            minLengthReq.className = isValidLength ? 'text-success' : 'text-danger';
            maxLengthReq.className = isValidLength1 ? 'text-success' : 'text-danger';
            
            // Comprobar si todos los requisitos están cumplidos
            const allRequirementsMet = hasUpperCase && hasNumber && hasSpecialChar && isValidLength && isValidLength1 ;

            // Habilitar o deshabilitar el botón según los requisitos
            submitBtn.disabled = !allRequirementsMet;

            // Calcular la fuerza de la contraseña
            let strength = 0;
            if (hasUpperCase) strength++;
            if (hasNumber) strength++;
            if (hasSpecialChar) strength++;
            if (isValidLength) strength++;
            if (isValidLength1) strength++;
            
            // Actualizar la barra de fuerza y el texto
            switch (strength) {
                case 0:
                case 1:
                    strengthBar.style.width = '15%';
                    strengthBar.className = 'strength-bar bg-danger';
                    strengthText.innerText = 'Débil';
                    strengthText.className = 'strength-text text-weak';
                    break;
                case 2:
                    strengthBar.style.width = '30%';
                    strengthBar.className = 'strength-bar bg-warning';
                    strengthText.innerText = 'Media';
                    strengthText.className = 'strength-text text-medium';
                    break;
                case 3:
                case 4:
                    strengthBar.style.width = '100%';
                    strengthBar.className = 'strength-bar bg-success';
                    strengthText.innerText = 'Fuerte';
                    strengthText.className = 'strength-text text-strong';
                    break;
            }
        });
        
        const nombresInput = document.getElementById('txtnombres');
        
        nombresInput.addEventListener('input', function () {
            const nombres = nombresInput.value;
            const nombresRegex = /^[A-Za-z]{2,20}$/; // Solo letras, entre 2 y 20 caracteres
            
            if (!nombresRegex.test(nombres)) {
                nombresInput.setCustomValidity("Solo se permiten letras y debe tener entre 2 y 20 caracteres.");
            } else {
                nombresInput.setCustomValidity(""); // Limpiar mensaje de error si es válido
            }
        });


    </script>
        
<script>
document.getElementById("txtdireccion").addEventListener("input", function(event) {
    const nombreInput = event.target.value;
    const direccionInput = document.getElementById("txtdireccion");

    // Resetear el mensaje de error en el input
    direccionInput.setCustomValidity(""); // Limpia los mensajes de error

    // Validaciones
    if (! nombreInput) {
        direccionInput.setCustomValidity('Falta rellenar el campo');
    } else if (/^\d+$/.test(nombreInput)) { // Verificar si contiene solo números
        direccionInput.setCustomValidity("No se permite ingresar solo números");
    } else if (/^\s+$/.test(nombreInput)) { // Verificar si contiene solo espacios en blanco
        direccionInput.setCustomValidity("No se permite ingresar solo con espacio en blanco");
    } else if (/^[^a-zA-Z]/.test(nombreInput)) { // Verificar si NO comienza con una letra
        direccionInput.setCustomValidity("Debe iniciar con una letra.");
    } else if (/[^a-zA-ZáéíóúÁÉÍÓÚ0-9\s.,;]/.test(nombreInput)) { // Verificar si contiene caracteres especiales que no son permitidos
        direccionInput.setCustomValidity("Solo se permite caracteres especiales . , ; y letras con tilde");
    } else if (nombreInput.length < 9 || nombreInput.length > 110) { // Verificar si tiene entre 9 y 110 caracteres
        direccionInput.setCustomValidity("Texto de 9 y 110 caracteres");
    } else {
        direccionInput.setCustomValidity(""); // Sin errores, limpiar los mensajes
    }

    // Si hay un error, mostrar el mensaje inmediatamente
    direccionInput.reportValidity();
});
</script>

<script>
document.getElementById("txtfecha").addEventListener("input", function(event) {
    const fechaInput = event.target;
    const fechaValue = fechaInput.value;
    const fechaActual = new Date();  // Fecha actual del sistema
    const fechaSeleccionada = new Date(fechaValue);

    // Verificar si el campo está incompleto (fecha en formato incorrecto o incompleto)
    if (!fechaValue || fechaValue.length < 10) {  // yyyy-mm-dd tiene 10 caracteres
        fechaInput.setCustomValidity("El campo está incompleto.");
    } else {
        // Obtener el año, mes y día de la fecha seleccionada
        const year = fechaSeleccionada.getFullYear();
        const month = fechaSeleccionada.getMonth();
        const day = fechaSeleccionada.getDate();

        // Verificar si la fecha seleccionada está en el futuro
        if (fechaSeleccionada > fechaActual) {
            fechaInput.setCustomValidity("Error: mínimo 18 y máximo 85 años.");
        } else {
            // Calcular la edad exacta
            let edad = fechaActual.getFullYear() - year;

            // Comprobación más precisa de la edad basada en el mes y el día
            const cumpleEnEsteAno = new Date(fechaActual.getFullYear(), month, day); // Fecha de cumpleaños de este año

            if (fechaActual < cumpleEnEsteAno) {
                edad--; // Restar si aún no ha cumplido años este año
            }

            // Validar la edad mínima de 18 años y máxima de 85 años
            if (edad < 18 || edad > 85) {
                fechaInput.setCustomValidity("Error: mínimo 18 y máximo 85 años.");
            } else {
                fechaInput.setCustomValidity(""); // Limpiar cualquier mensaje de error
            }
        }
    }

    // Si hay un error, mostrar el mensaje inmediatamente
    fechaInput.reportValidity();
});
</script>


<script>
document.getElementById("txtcorreo").addEventListener("input", function(event) {
    const correoInput = event.target;
    const correoValue = correoInput.value;

    // Expresión regular para validar el correo electrónico general
    const emailPattern = /^[a-zA-Z0-9]+([._-][a-zA-Z0-9]+)*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

    // Resetear el mensaje de error en el input
    correoInput.setCustomValidity(""); // Limpia los mensajes de error

    // Validar si el campo está vacío
    if (correoValue.trim() === "") {
        correoInput.setCustomValidity("Falta rellenar el campo");
    } 
    // Validar si el correo tiene solo espacios
    else if (/^\s+$/.test(correoValue)) {
        correoInput.setCustomValidity("No se permite solo espacios en blanco");
    } 
    // Validar si el correo tiene solo números
    else if (/^\d+$/.test(correoValue)) {
        correoInput.setCustomValidity("No se permite solo números");
    } 
    // Validar si el correo tiene solo caracteres especiales
    else if (/^[!@#$%^&*(),.?":{}|<>]+$/.test(correoValue)) {
        correoInput.setCustomValidity("No se permite solo caracteres especiales");
    } 
    // Validar si el correo tiene espacios entre el texto
    else if (/\s/.test(correoValue)) {
        correoInput.setCustomValidity("El correo entre espacios no es válido");
    } 
    // Validar si hay caracteres especiales consecutivos antes del @
    else if (/([._-]){2,}/.test(correoValue)) {
        correoInput.setCustomValidity("No se permiten caracteres especiales consecutivos.");
    }
    // Validar si el correo no empieza con una letra
    else if (!/^[a-zA-Z]/.test(correoValue)) {
        correoInput.setCustomValidity("Debe iniciar con una letra");
    }

    // Validar si el correo contiene caracteres especiales no permitidos
    else if (/[^a-zA-Z0-9._@-]/.test(correoValue)) {
        correoInput.setCustomValidity("Solo se permiten caracteres especiales . - _ @");
    }
    
    // Validar si el correo no contiene el símbolo @
    else if (!/@/.test(correoValue)) {
        correoInput.setCustomValidity("No contiene el símbolo @");
    }
    
    // Validar si el correo no tiene dominio después del @
    else if (/^[^@]+@$/.test(correoValue)) {
        correoInput.setCustomValidity("Falta ingresar el dominio");
    }
    else if ((correoValue.match(/@/g) || []).length > 1) {
        correoInput.setCustomValidity("El correo no debe incluir doble @");
    }
    // Validar la longitud del correo
    else if (correoValue.length < 13 || correoValue.length > 36) {
        correoInput.setCustomValidity("Texto mínimo 13 y máximo 36 caracteres");
    }
    
    // Validar si el correo cumple con la expresión regular general
    else if (!emailPattern.test(correoValue)) {
        correoInput.setCustomValidity("Mala sintaxis");
    } else {
        correoInput.setCustomValidity(""); // Sin errores, limpiar los mensajes
    }

    // Si hay un error, mostrar el mensaje inmediatamente
    correoInput.reportValidity();
});
</script>



<script>
    const nombreInput = document.getElementById('txtnombres');

    nombreInput.addEventListener('input', function(event) {
        const nombres = event.target.value;

        // Resetear el mensaje de error en el input
        nombreInput.setCustomValidity(""); // Limpia los mensajes de error

        // Validar nombres: no debe estar vacío, no debe contener números ni caracteres especiales
        if (!nombres) {
            nombreInput.setCustomValidity('El campo de nombres no puede estar vacío.');
        } else if (nombres.trim().length === 0) { // Verificar si el campo contiene solo espacios en blanco
            nombreInput.setCustomValidity('No pueden ser solo espacios en blanco.');
        } else if (/\d/.test(nombres)) {
            nombreInput.setCustomValidity('Los nombres no deben contener números.');
        } else if (/[^a-zA-Z\s]/.test(nombres)) {
            nombreInput.setCustomValidity('Los nombres no deben contener caracteres especiales.');
        } else if (nombres.length < 2 || nombres.length > 20) {
            nombreInput.setCustomValidity('Los nombres deben tener entre 2 y 20 caracteres.');
        }

        // Si hay un error, mostrar el mensaje inmediatamente
        nombreInput.reportValidity();
    });
</script>
<script>
    const apellidoInput = document.getElementById('txtapellidos');

    apellidoInput.addEventListener('input', function(event) {
        const apellidos = event.target.value;

        // Resetear el mensaje de error en el input
        apellidoInput.setCustomValidity(""); // Limpia los mensajes de error

        // Validar apellidos: no debe estar vacío, no debe contener números ni caracteres especiales
        if (!apellidos) {
            apellidoInput.setCustomValidity('El campo de apellidos no puede estar vacío.');
        } else if (apellidos.trim().length === 0) { // Verificar si el campo contiene solo espacios en blanco
            apellidoInput.setCustomValidity('No pueden ser solo espacios en blanco.');
        } else if (/\d/.test(apellidos)) {
            apellidoInput.setCustomValidity('Los apellidos no deben contener números.');
        } else if (/[^a-zA-Z\s]/.test(apellidos)) {
            apellidoInput.setCustomValidity('Los apellidos no deben contener caracteres especiales.');
        } else if (apellidos.length < 2 || apellidos.length > 36) {
            apellidoInput.setCustomValidity('Los apellidos deben tener entre 2 y 36 caracteres.');
        }

        // Si hay un error, mostrar el mensaje inmediatamente
        apellidoInput.reportValidity();
    });
</script>

<script>
document.getElementById("txtdireccion").addEventListener("input", function(event) {
    const nombreInput = event.target.value;
    const direccionInput = document.getElementById("txtdireccion");

    // Resetear el mensaje de error en el input
    direccionInput.setCustomValidity(""); // Limpia los mensajes de error

    // Validaciones
    if (! nombreInput) {
        direccionInput.setCustomValidity('Falta rellenar el campo');
    } else if (/^\d+$/.test(nombreInput)) { // Verificar si contiene solo números
        direccionInput.setCustomValidity("No se permite ingresar solo números");
    } else if (/^\s+$/.test(nombreInput)) { // Verificar si contiene solo espacios en blanco
        direccionInput.setCustomValidity("No se permite ingresar solo con espacio en blanco");
    } else if (/^[^a-zA-Z]/.test(nombreInput)) { // Verificar si NO comienza con una letra
        direccionInput.setCustomValidity("Debe iniciar con una letra.");
    } else if (/[^a-zA-ZáéíóúÁÉÍÓÚ0-9\s.,;]/.test(nombreInput)) { // Verificar si contiene caracteres especiales que no son permitidos
        direccionInput.setCustomValidity("Solo se permite caracteres especiales . , ; y letras con tilde");
    } else if (nombreInput.length < 9 || nombreInput.length > 110) { // Verificar si tiene entre 9 y 110 caracteres
        direccionInput.setCustomValidity("Texto de 9 y 110 caracteres");
    } else {
        direccionInput.setCustomValidity(""); // Sin errores, limpiar los mensajes
    }

    // Si hay un error, mostrar el mensaje inmediatamente
    direccionInput.reportValidity();
});
</script>

<script>
        // Verificar si la URL tiene el parámetro ?registro=exito
        const urlParams = new URLSearchParams(window.location.search);
        const registroExito = urlParams.get('registro');

        if (registroExito === 'exito') {
            // Mostrar un mensaje emergente de registro exitoso
            alert('Registro Exitoso');
        }
    </script>
</body>
</html>
