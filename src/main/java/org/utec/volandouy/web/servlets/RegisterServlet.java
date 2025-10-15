package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import DataTypes.DtUsuario;
import DataTypes.TipoDoc;
import sistema.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String email = request.getParameter("email");
        String emailcheck = request.getParameter("emailcheck");
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String passcheck = request.getParameter("passcheck");
        String file = request.getParameter("file");
        String name = request.getParameter("name");
        String apellido = request.getParameter("apellido");
        String nacionalidad = request.getParameter("nacionalidad");
        String numeroDoc = request.getParameter("numeroDoc");

        String tipoDocStr = request.getParameter("tipoDoc");
        TipoDoc tipoDoc = null;

        if (tipoDocStr != null && !tipoDocStr.trim().isEmpty()) {
            try {
                tipoDoc = TipoDoc.valueOf(tipoDocStr);
            } catch (IllegalArgumentException e) {
                throw new IllegalArgumentException("Tipo de documento no válido");
            }
        } else {
            throw new IllegalArgumentException("El tipo de documento es obligatorio");
        }

        String bdateStr = request.getParameter("bdate");
        java.time.LocalDate bdate = null;
        if (bdateStr != null && !bdateStr.isEmpty()) {
            try {
                bdate = java.time.LocalDate.parse(bdateStr);
            } catch (java.time.format.DateTimeParseException ex) {
                java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("MM/dd/yyyy");
                bdate = java.time.LocalDate.parse(bdateStr, formatter);
            }
        } else {
            throw new IllegalArgumentException("La fecha de nacimiento es obligatoria");
        }

        try {

            s.altaCliente(user, name, email, pass, file, apellido, bdate, nacionalidad, tipoDoc, numeroDoc);
            request.setAttribute("successMessage", "¡Registro exitoso! Ya podés iniciar sesión.");
            request.getRequestDispatcher("/").forward(request, response);


        } catch (IllegalArgumentException e) {

            request.setAttribute("errorPass", e.getMessage());
            request.getRequestDispatcher("login").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorPass", "Error interno del sistema.");
            request.getRequestDispatcher("login").forward(request, response);
        }
    }
}