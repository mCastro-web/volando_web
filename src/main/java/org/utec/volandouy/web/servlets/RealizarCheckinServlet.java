package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import publicadores.DtUsuario;
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

@WebServlet("/CheckinServlet")
public class RealizarCheckinServlet extends HttpServlet {

    private final ControladorSistemaPublish port =
            new ControladorSistemaPublishService().getControladorSistemaPublishPort();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recuperamos usuario de sesión
        HttpSession session = request.getSession(false);
        DtUsuario usuario = (session != null) ? (DtUsuario) session.getAttribute("usuario") : null;

        // Validamos que haya sesión y que el usuario sea cliente
        if (usuario == null || !"cliente".equalsIgnoreCase(usuario.getTipo())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Traemos las reservas pendientes de check-in para el cliente usando el sistema
            List<Long> reservas = port.listarReservasPendientesCheckin(usuario.getNickname());
            request.setAttribute("reservas", reservas);

            // Forward al JSP
            request.getRequestDispatcher("/WEB-INF/realizarCheckin.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notyf_error_checkin", "Error al obtener reservas pendientes.");
            request.getRequestDispatcher("/WEB-INF/realizarCheckin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);
        DtUsuario usuario = (session != null) ? (DtUsuario) session.getAttribute("usuario") : null;

        if (usuario == null || !"cliente".equalsIgnoreCase(usuario.getTipo())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String idReservaStr = request.getParameter("idReserva");
            if (idReservaStr == null || idReservaStr.isEmpty()) {
                throw new IllegalArgumentException("Debe seleccionar una reserva.");
            }

            Long idReserva = Long.parseLong(idReservaStr);

            // Realizamos check-in directamente con el sistema
            port.realizarCheckin(idReserva);

            // Mensaje de éxito
            request.setAttribute("notyf_success_checkin", "Check-in realizado correctamente.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("notyf_error_checkin", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notyf_error_checkin", "Error interno del sistema.");
        }

        // Recargamos lista de reservas pendientes
        doGet(request, response);
    }
}
