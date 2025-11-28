package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

@WebServlet("/ValidacionServlet")
public class ValidacionServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String type = request.getParameter("type"); // "nickname" or "email"
        String value = request.getParameter("value");

        boolean exists = false;
        String message = "";

        try {
            ControladorSistemaPublish port = getPort();

            if ("nickname".equals(type)) {
                exists = port.existeNickname(value);
                message = exists ? "El nickname ya está en uso" : "El nickname está disponible";
            } else if ("email".equals(type)) {
                exists = port.existeEmail(value);
                message = exists ? "El email ya está registrado" : "El email está disponible";
            } else if ("login_user".equals(type)) {
                exists = port.existeNickname(value) || port.existeEmail(value);
                message = exists ? "Usuario encontrado" : "Usuario inexistente";
            }

            // JSON manual construction
            PrintWriter out = response.getWriter();
            out.print("{\"exists\": " + exists + ", \"message\": \"" + message + "\"}");
            out.flush();

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}
