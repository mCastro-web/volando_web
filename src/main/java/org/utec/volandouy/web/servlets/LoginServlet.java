package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String user = request.getParameter("user");
        String pass = request.getParameter("pass");

        try {
            ControladorSistemaPublish port = getPort();
            publicadores.DtUsuario usuarioWS = port.iniciarSesionUsuario(user, pass);

            // Store WS DTO directly in session
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuarioWS);

            if ("AEROLINEA".equalsIgnoreCase(usuarioWS.getTipo())) {
                List<String> rutas = port.listarRutasConfirmadasAerolinea(usuarioWS.getNickname());
                session.setAttribute("rutas", rutas);
            }

            response.sendRedirect(request.getContextPath() + "/");

        } catch (IllegalArgumentException e) { // This might need to catch Exception if WS throws generic Exception
            // WS usually throws SOAPFaultException or Exception.
            // But if the generated client throws specific exceptions, we can catch them.
            // For now, let's catch Exception and check message, or keep
            // IllegalArgumentException if we expect it.
            // But WS client methods usually declare 'throws Exception_Exception' or
            // similar.
            // Let's change to catch Exception and parse message.
            handleException(request, response, e);

        } catch (Exception e) {
            handleException(request, response, e);
        }
    }

    private void handleException(HttpServletRequest request, HttpServletResponse response, Exception e)
            throws ServletException, IOException {
        String mensaje = e.getMessage().toLowerCase();

        if (mensaje.contains("usuario")) {
            request.setAttribute("errorUser", e.getMessage());
        } else if (mensaje.contains("contraseña")) {
            request.setAttribute("errorPass", e.getMessage());
        } else {
            request.setAttribute("errorGeneral", e.getMessage());
        }

        request.getRequestDispatcher("login").forward(request, response);
    }
}
