package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import sistema.*;

@WebServlet("/RegisterAServlet")
@MultipartConfig
public class RegisterAServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- Lectura de campos de texto ---
        String nicknameAerolinea = request.getParameter("nicknameAerolinea");
        String nombre = request.getParameter("nombreAerolinea");
        String email = request.getParameter("emailAerolinea");
        String descripcion = request.getParameter("descripcionAerolinea");
        String sitioWeb = request.getParameter("sitioWebAerolinea");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // --- Validar contraseñas ---
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("error.jsp?message=Las contraseñas no coinciden.");
            return;
        }

        // --- Subir imagen ---
        Part filePart = request.getPart("file");
        System.out.println("📁 Archivo recibido: " + filePart.getSubmittedFileName());
        System.out.println("📏 Tamaño: " + filePart.getSize());

        String url = s.subirImagen(filePart, "vuy_aerolineas");
        System.out.println("➡️ URL devuelta por subirImagen(): " + url);

        if (url == null || url.isEmpty()) {
            response.sendRedirect("error.jsp?message=Error al subir imagen");
            return;
        }

        // --- Alta de aerolínea ---
        try {
            s.altaAerolinea(nicknameAerolinea, nombre, email, password, url, descripcion, sitioWeb);
            response.sendRedirect(request.getContextPath() + "/");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }
}

