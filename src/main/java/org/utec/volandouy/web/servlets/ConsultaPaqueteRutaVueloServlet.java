package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import publicadores.DtPaqueteVuelo;
// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

@WebServlet("/ConsultaPaqueteRutaVueloServlet")
public class ConsultaPaqueteRutaVueloServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ControladorSistemaPublish port = getPort();
            String paqueteSeleccionado = request.getParameter("paquete");
            List<String> paquetes = port.listarNombresPaquetes();

            HttpSession session = request.getSession(false);
            Object usuario = null;
            if (session != null) {
                usuario = session.getAttribute("usuario");
            }

            // No hacer redirect a login
            request.setAttribute("usuario", usuario);

            // El resto del código sigue igual

            request.setAttribute("paquetes", paquetes);
            request.setAttribute("paqueteSeleccionado", paqueteSeleccionado);

            // Si se seleccionó un paquete, obtenemos las rutas asociadas
            if (paqueteSeleccionado != null && !paqueteSeleccionado.isBlank()) {
                DtPaqueteVuelo paquete = port.obtenerDtPaquetePorNombre(paqueteSeleccionado);
                request.setAttribute("paqueteDt", paquete);

                // ✅ Obtener los nombres de las rutas del paquete
                List<String> nombresRutas = port.obtenerListaNombresRutasPorPaquete(paqueteSeleccionado);

                if (nombresRutas == null || nombresRutas.isEmpty()) {
                    request.setAttribute("mensaje", "El paquete no contiene rutas asociadas.");
                } else {
                    request.setAttribute("rutas", nombresRutas);
                }
            }

            // Renderizar JSP
            request.getRequestDispatcher("/WEB-INF/consultaPaqueteRutaVuelo.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar los paquetes: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
