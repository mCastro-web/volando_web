package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;
// Import types from the new publisher package
import publicadores.DtCliente;
import publicadores.Aerolinea;

@WebServlet("/ListUserServlet")
public class ListUserServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ControladorSistemaPublish port = getPort();

            // ============ CLIENTES ============
            List<DtCliente> clientes = port.listarClientes();

            // ============ AEROLINEAS ============
            List<Aerolinea> aerolineas = port.listarAerolineas();

            // ============ RUTAS CONFIRMADAS POR AEROLINEA ============
            Map<String, List<String>> rutasConfirmadas = new HashMap<>();
            for (Aerolinea a : aerolineas) {
                try {
                    List<String> rutas = port.listarRutasConfirmadasAerolinea(a.getNickname());
                    rutasConfirmadas.put(a.getNickname(), rutas);
                } catch (Exception ignored) {
                    rutasConfirmadas.put(a.getNickname(), List.of());
                }
            }

            // ============ TODAS LAS RUTAS POR AEROLINEA ============
            Map<String, List<String>> rutasAll = new HashMap<>();
            for (Aerolinea a : aerolineas) {
                try {
                    List<String> rutas = port.listarRutasPorAerolinea(a.getNickname());
                    rutasAll.put(a.getNickname(), rutas);
                } catch (Exception ignored) {
                    rutasAll.put(a.getNickname(), List.of());
                }
            }

            // ============ SETEAR ATRIBUTOS ============
            request.setAttribute("clientes", clientes);
            request.setAttribute("aerolineas", aerolineas);
            request.setAttribute("rutasPorAerolinea", rutasConfirmadas);
            request.setAttribute("rutasPorAerolineaAll", rutasAll);

            request.getRequestDispatcher("/WEB-INF/listUser.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error obteniendo datos desde los WS: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/listUser.jsp").forward(request, response);
        }
    }
}
