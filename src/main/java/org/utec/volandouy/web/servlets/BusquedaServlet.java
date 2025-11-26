package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;
import publicadores.DtRutaVuelo;
import publicadores.DtPaqueteVuelo;

@WebServlet("/BusquedaServlet")
public class BusquedaServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String queryBusqueda = request.getParameter("queryBusqueda");

        if (queryBusqueda == null) {
            queryBusqueda = "";
        }

        try {
            ControladorSistemaPublish port = getPort();
            List<DtRutaVuelo> rutas = port.buscarRutas(queryBusqueda);
            List<DtPaqueteVuelo> paquetes = port.buscarPaquetes(queryBusqueda);

            request.setAttribute("rutas", rutas);
            request.setAttribute("paquetes", paquetes);
            request.setAttribute("query", queryBusqueda);

            request.getRequestDispatcher("/WEB-INF/busqueda.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error en la búsqueda: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
