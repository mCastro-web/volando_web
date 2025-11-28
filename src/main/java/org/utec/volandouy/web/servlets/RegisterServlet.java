package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import publicadores.TipoDoc;
// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

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
        String nacionalidad = new String(request.getPart("nacionalidadCliente").getInputStream().readAllBytes(),
                "UTF-8");
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
                java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter
                        .ofPattern("MM/dd/yyyy");
                bdate = java.time.LocalDate.parse(bdateStr, formatter);
            }
        } else {
            throw new IllegalArgumentException("La fecha de nacimiento es obligatoria");
        }

        Part filePart = request.getPart("fotoPerfil");
        ControladorSistemaPublish port = getPort();
        String url = null;
        if (filePart != null && filePart.getSize() > 0) {
            byte[] imageBytes = filePart.getInputStream().readAllBytes();
            String fileName = filePart.getSubmittedFileName();
            String contentType = filePart.getContentType();
            url = port.subirImagen(imageBytes, fileName, contentType, user);
        }

        try {
            port.altaCliente(user, name, email, pass, url, apellido, bdate.toString(), nacionalidad, tipoDoc.toString(),
                    numeroDoc);

            request.setAttribute("mensaje", "Registro exitoso");
            request.setAttribute("tipo", "success");
            response.sendRedirect(request.getContextPath() + "/");

        } catch (IllegalArgumentException e) {
            handleException(request, response, e);
        } catch (Exception e) {
            handleException(request, response, e);
        }
    }

    private void handleException(HttpServletRequest request, HttpServletResponse response, Exception e)
            throws ServletException, IOException {
        request.setAttribute("errorPass", e.getMessage());
        request.getRequestDispatcher("login").forward(request, response);
    }
}