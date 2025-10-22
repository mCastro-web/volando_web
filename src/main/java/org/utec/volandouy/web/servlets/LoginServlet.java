package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import data_types.DtUsuario;
import sistema.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

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
            DtUsuario usuario = s.iniciarSesionUsuario(user, pass);

            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            if ("AEROLINEA".equalsIgnoreCase(usuario.getTipo())) {
                List<String> rutas = s.listarRutasConfirmadasAerolinea(usuario.getNickname());
                session.setAttribute("rutas", rutas);
            }

            response.sendRedirect(request.getContextPath() + "/");

        } catch (IllegalArgumentException e) {

            String mensaje = e.getMessage().toLowerCase();

            if (mensaje.contains("usuario")) {
                request.setAttribute("errorUser", e.getMessage());
            } else if (mensaje.contains("contraseña")) {
                request.setAttribute("errorPass", e.getMessage());
            } else {
                request.setAttribute("errorGeneral", e.getMessage());
            }

            request.getRequestDispatcher("login").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorPass", "Error interno del sistema.");
            request.getRequestDispatcher("login").forward(request, response);
        }
    }
}
