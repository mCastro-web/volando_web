package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

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

            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            if (usuario.getTipo().equalsIgnoreCase("AEROLINEA")) {
                List<String> rutas = s.listarRutasConfirmadasAerolinea(usuario.getNombre());
                session.setAttribute("rutas", rutas);
            }

            response.sendRedirect(request.getContextPath() + "/");

        } catch (IllegalArgumentException e) {

            String mensaje = e.getMessage();
                if (mensaje.contains("usuario")) {
                    request.setAttribute("errorUser", mensaje);
                } else if (mensaje.contains("contraseña") || mensaje.contains("password")) {
                    request.setAttribute("errorPass", mensaje);
                } else {
                    request.setAttribute("errorGeneral", mensaje);
                }

                request.getRequestDispatcher("login").forward(request, response);

        } catch (Exception e) {
            
            e.printStackTrace();
            request.setAttribute("errorPass", "Error interno del sistema.");
            request.getRequestDispatcher("login").forward(request, response);
        }

    }
}
