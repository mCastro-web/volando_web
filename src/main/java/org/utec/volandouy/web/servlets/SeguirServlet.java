package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;
import publicadores.DtUsuario;


@WebServlet("/SeguirServlet")
public class SeguirServlet extends HttpServlet {

    private final ControladorSistemaPublish port =
            new ControladorSistemaPublishService().getControladorSistemaPublishPort();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        DtUsuario usuario = (session != null) ? (DtUsuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<String> usuarios = port.listarUsuariosPorNick();
            request.setAttribute("usuarios", usuarios);
            request.setAttribute("usuarioActual", usuario.getNickname());
            request.getRequestDispatcher("/WEB-INF/seguir.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notyf_error", "Error al obtener la lista de usuarios.");
            request.getRequestDispatcher("/WEB-INF/seguir.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        DtUsuario usuario = (session != null) ? (DtUsuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String accion = request.getParameter("accion");
        String usuarioSeleccionado = request.getParameter("usuarioSeleccionado");

        if (usuarioSeleccionado == null || usuarioSeleccionado.isEmpty()) {
            request.setAttribute("notyf_error", "Debe seleccionar un usuario.");
            doGet(request, response);
            return;
        }

        try {
            if ("seguir".equals(accion)) {
                if (port.yaSigue(usuario.getNickname(), usuarioSeleccionado)) {
                    request.setAttribute("notyf_error", "Ya sigues a " + usuarioSeleccionado);
                } else {
                    port.guardarSocial(usuario.getNickname(), usuarioSeleccionado);
                    request.setAttribute("notyf_success", "Ahora sigues a " + usuarioSeleccionado);
                }
            } else if ("dejarSeguir".equals(accion)) {
                if (!port.yaSigue(usuario.getNickname(), usuarioSeleccionado)) {
                    request.setAttribute("notyf_error", "No sigues a " + usuarioSeleccionado);
                } else {
                    port.eliminarSocial(usuario.getNickname(), usuarioSeleccionado);
                    request.setAttribute("notyf_success", "Has dejado de seguir a " + usuarioSeleccionado);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notyf_error", e.getMessage());
        }

        doGet(request, response); // refresca la lista y muestra mensajes
    }
}
