package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

@WebServlet("/RegisterAServlet")
@MultipartConfig
public class RegisterAServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nicknameAerolinea = request.getParameter("nicknameAerolinea");
        String nombre = request.getParameter("nombreAerolinea");
        String email = request.getParameter("emailAerolinea");
        String descripcion = request.getParameter("descripcionAerolinea");
        String sitioWeb = request.getParameter("sitioWebAerolinea");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("error.jsp?message=Las contraseñas no coinciden.");
            return;
        }

        Part filePart = request.getPart("file");
        System.out.println("Archivo recibido: " + filePart.getSubmittedFileName());
        System.out.println("Tamaño: " + filePart.getSize());

        ControladorSistemaPublish port = getPort();
        String url = null;
        if (filePart != null && filePart.getSize() > 0) {
            byte[] imageBytes = filePart.getInputStream().readAllBytes();
            String fileName = filePart.getSubmittedFileName();
            String contentType = filePart.getContentType();
            url = port.subirImagen(imageBytes, fileName, contentType, nicknameAerolinea);
        }
        System.out.println("URL generada: " + url);

        if (url == null || url.isEmpty()) {
            response.sendRedirect("error.jsp?message=Error al subir imagen");
            return;
        }

        try {
            port.altaAerolinea(nicknameAerolinea, nombre, email, password, url, descripcion, sitioWeb);
            response.sendRedirect(request.getContextPath() + "/");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }
}
