package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sistema.ISistema;
import sistema.Sistema;
import java.io.IOException;
import java.util.List;

import data_types.DtPaqueteVuelo;

@WebServlet("/ConsultaPaqueteRutaVueloServlet")
public class ConsultaPaqueteRutaVueloServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String paqueteSeleccionado = request.getParameter("paquete");
            List<String> paquetes = s.listarNombresPaquetes();

            // Validación de sesión
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("usuario") == null) {
                response.sendRedirect("login");
                return;
            }

            request.setAttribute("paquetes", paquetes);
            request.setAttribute("paqueteSeleccionado", paqueteSeleccionado);

            // Si se seleccionó un paquete, obtenemos las rutas asociadas
            if (paqueteSeleccionado != null && !paqueteSeleccionado.isBlank()) {
                DtPaqueteVuelo paquete = s.obtenerDtPaquetePorNombre(paqueteSeleccionado);
                request.setAttribute("paqueteDt", paquete);

                // ✅ Obtener los nombres de las rutas del paquete
                List<String> nombresRutas = s.obtenerListaNombresRutasPorPaquete(paqueteSeleccionado);

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
