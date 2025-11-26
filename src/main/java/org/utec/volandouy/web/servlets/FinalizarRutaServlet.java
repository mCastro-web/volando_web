package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import publicadores.DtUsuario;
import publicadores.DtRutaVuelo;
import publicadores.DtVuelo;
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

@WebServlet("/FinalizarRutaServlet")
public class FinalizarRutaServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }
    
    ControladorSistemaPublish port = getPort();

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
            List<String> rutas = port.listarRutasConfirmadasAerolinea(usuario.getNickname());
            request.setAttribute("rutas", rutas);
            request.getRequestDispatcher("/WEB-INF/finalizarRuta.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("notyf_error", "Error al obtener rutas.");
            request.getRequestDispatcher("/WEB-INF/finalizarRuta.jsp").forward(request, response);
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

        String rutaSeleccionada = request.getParameter("rutaSeleccionada");
        String action = request.getParameter("action");

        if (rutaSeleccionada == null || rutaSeleccionada.isEmpty()) {
            request.setAttribute("notyf_error", "Debe seleccionar una ruta.");
            doGet(request, response);
            return;
        }

        try {
            if ("mostrarDatos".equals(action)) {
                // Solo obtener y mostrar los datos de la ruta
                DtRutaVuelo ruta = port.obtenerDtRutaPorNombre(rutaSeleccionada);
                request.setAttribute("ruta", ruta);

                List<DtVuelo> listaDtVuelo = new ArrayList<>();
                if (ruta != null && ruta.getVuelos() != null) {
                    for (String nombreVuelo : ruta.getVuelos()) {
                        DtVuelo dt = port.obtenerDtVueloPorNombre(nombreVuelo);
                        if (dt != null) listaDtVuelo.add(dt);
                    }
                }
                request.setAttribute("ListaDtVuelo", listaDtVuelo);

            } else if ("finalizar".equals(action)) {
                // Finalizamos la ruta
                port.finalizarRutaDeVuelo(rutaSeleccionada);
                request.setAttribute("notyf_success",
                        "La ruta \"" + rutaSeleccionada + "\" ha sido finalizada correctamente.");
            }
        } catch (Exception e) {
            request.setAttribute("notyf_error", e.getMessage());
        }

        doGet(request, response);
    }
}
