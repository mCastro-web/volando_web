package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import DataTypes.DtUsuario;
import sistema.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String user = request.getParameter("user");
        String pass = request.getParameter("pass");

        try {
            DtUsuario usuario = s.iniciarSesionUsuario(user, pass);
            request.getSession().setAttribute("usuario", usuario);
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
