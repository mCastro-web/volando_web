<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Test RegisterServlet</title>
</head>
<body style="font-family: sans-serif; margin: 30px;">

    <h2>Formulario de Prueba - RegisterServlet</h2>
    <p>Completá los campos y presioná enviar. El servlet debería imprimir los datos en consola y registrar el usuario.</p>

    <form action="RegisterServlet" method="post" >

        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <label>Confirmar Email:</label><br>
        <input type="email" name="emailcheck" required><br><br>

        <label>Usuario (nickname):</label><br>
        <input type="text" name="user" required><br><br>

        <label>Contraseña:</label><br>
        <input type="password" name="pass" required><br><br>

        <label>Confirmar Contraseña:</label><br>
        <input type="password" name="passcheck" required><br><br>

        <label>Nombre:</label><br>
        <input type="text" name="name" required><br><br>

        <label>Apellido:</label><br>
        <input type="text" name="apellido" required><br><br>

        <label>Nacionalidad:</label><br>
        <input type="text" name="nacionalidad" required><br><br>

        <label>Número de Documento:</label><br>
        <input type="text" name="numeroDoc" required><br><br>

        <label>Tipo de Documento:</label><br>
        <select name="tipoDoc" required>
            <option value="" disabled selected>-- Seleccionar --</option>
            <option value="CI">CI</option>
            <option value="Pasaporte">Pasaporte</option>
        </select>
        <br><br>

        <label>Fecha de Nacimiento:</label><br>
        <input type="date" name="bdate" required><br><br>

        <label>Archivo (opcional):</label><br>
        <input type="file" name="file"><br><br>

        <button type="submit">Enviar al Servlet</button>

    </form>

</body>
</html>
