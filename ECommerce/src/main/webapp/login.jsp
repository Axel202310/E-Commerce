<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        /* Tus estilos existentes */
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
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 450px;
        }

        h1 {
            font-family: 'Times New Roman', Times, serif;
            font-size: 36px;
            font-weight: bold;
            color: #080f16cc;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-control {
            border-radius: 5px;
        }

        .btn-primary {
            background-color: #ff885d;
            border: none;
        }

        .btn-primary:hover {
            background-color: #e76f4c;
        }

        .btn-secondary {
            background-color: #f8f9fa;
            color: #495057;
        }

        .btn-secondary:hover {
            background-color: #e2e6ea;
        }

        .text-center {
            text-align: center;
        }

        .link {
            text-decoration: none;
            color: #007bff;
        }

        .link:hover {
            text-decoration: underline;
        }

        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Iniciar Sesión</h1>

        <!-- Bloque para mostrar el mensaje de error -->
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) { 
        %>
            <div class="error">
                <%= errorMessage %>
            </div>
        <% 
            } 
        %>

        <!-- Modificado para usar correo en lugar de Id Usuario -->
        <form action="verificar.jsp" method="post">
            <div class="mb-3">
                <label for="txtcorreo" class="form-label">Correo Electrónico</label>
                <input type="email" id="txtcorreo" name="txtcorreo" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="txtpass" class="form-label">Contraseña</label>
                <input type="password" id="txtpass" name="txtpass" class="form-control" required>
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
                <button type="reset" class="btn btn-secondary">Limpiar</button>
            </div>
            <div class="text-center mt-3">
                <a href="registro.jsp" class="link">Usuario Nuevo (Registrarse)</a>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"></script>
</body>
</html>
