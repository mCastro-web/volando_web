package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.PaqueteVuelo;
import sistema.ISistema;
import sistema.Sistema;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/CompraPaqueteServlet")
public class CompraPaqueteServlet extends HttpServlet {

    private final ISistema s = Sistema.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<PaqueteVuelo> paquetes = s.listarPaquetes();

        if (paquetes == null) {
            System.out.println("Error: La lista de paquetes es nula.");
            paquetes = java.util.Collections.emptyList();
        }

        request.setAttribute("paquetes", paquetes);
        request.getRequestDispatcher("/WEB-INF/compraPaquete.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombrePaquete = request.getParameter("paquete_seleccionado");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        Object usuario = session.getAttribute("usuario");

        String nickNameCliente = "";
        try {
            java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
            Object tipoObj = getNickname.invoke(usuario);
            if (tipoObj != null) nickNameCliente = tipoObj.toString().toUpperCase();
        } catch (Exception e) {
            System.out.println("Error obteniendo tipo de usuario: " + e.getMessage());
        }

        if (nombrePaquete != null && !nombrePaquete.isEmpty()) {
            PaqueteVuelo paquete = s.buscarPaqueteVuelo(nombrePaquete);
            request.setAttribute("paqueteSeleccionado", paquete);

            if (paquete != null) {
                LocalDate hoy = LocalDate.now();
                try {
                    s.comprarPaquete(nickNameCliente.toLowerCase(), paquete.getNombre(), hoy);
                    request.setAttribute("notyf_success", "Paquete '" + paquete.getNombre() + "' comprado correctamente.");
                } catch (Exception e) {
                    request.setAttribute("errorMsg", e.getMessage());
                }
            }
        }

        List<PaqueteVuelo> paquetes = s.listarPaquetes();
        request.setAttribute("paquetes", paquetes);

        request.getRequestDispatcher("/WEB-INF/compraPaquete.jsp").forward(request, response);
    }
}
