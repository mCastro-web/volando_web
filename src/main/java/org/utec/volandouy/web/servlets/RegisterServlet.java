package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import DataTypes.DtUsuario;
import DataTypes.TipoDoc;
import sistema.*;

@WebServlet("/RegisterServlet")
@MultipartConfig 
public class RegisterServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String email = new String(request.getPart("emailCliente").getInputStream().readAllBytes(), "UTF-8");
        String user = new String(request.getPart("nicknameCliente").getInputStream().readAllBytes(), "UTF-8");
        String pass = new String(request.getPart("password").getInputStream().readAllBytes(), "UTF-8");
        String passcheck = new String(request.getPart("confirmPassword").getInputStream().readAllBytes(), "UTF-8");
        String name = new String(request.getPart("nombreCliente").getInputStream().readAllBytes(), "UTF-8");
        String apellido = new String(request.getPart("apellidoCliente").getInputStream().readAllBytes(), "UTF-8");
        String nacionalidad = new String(request.getPart("nacionalidadCliente").getInputStream().readAllBytes(), "UTF-8");
        String numeroDoc = new String(request.getPart("documentoCliente").getInputStream().readAllBytes(), "UTF-8");

        String tipoDocStr = null;
        for (Part part : request.getParts()) {
            if (part.getName().equals("tipoDocumento")) {
                tipoDocStr = new String(part.getInputStream().readAllBytes(), "UTF-8");
                break;
            }
        }

        TipoDoc tipoDoc = TipoDoc.valueOf(tipoDocStr);


        String bdateStr = request.getParameter("fechaNacimientoCliente");
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

        Part filePart = request.getPart("fotoPerfil");
        String url = s.subirImagen(filePart, "vuy_clientes");
        
        try {

            s.altaCliente(user, name, email, pass, url, apellido, bdate, nacionalidad, tipoDoc, numeroDoc);

            request.setAttribute("mensaje", "Registro exitoso");
            request.setAttribute("tipo", "success"); 
            response.sendRedirect(request.getContextPath() + "/");


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