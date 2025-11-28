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
            // ============ SEGUIDORES Y SEGUIDOS ============
            Map<String, List<String>> seguidoresPorUsuario = new HashMap<>();
            Map<String, List<String>> seguidosPorUsuario = new HashMap<>();

            // Clientes
            for (DtCliente c : clientes) {
                List<String> seguidores = port.listarSeguidores(c.getNickname());
                List<String> seguidos = port.listarSeguidos(c.getNickname());
                seguidoresPorUsuario.put(c.getNickname(), seguidores);
                seguidosPorUsuario.put(c.getNickname(), seguidos);
            }

            // Aerolíneas
            for (Aerolinea a : aerolineas) {
                List<String> seguidores = port.listarSeguidores(a.getNickname());
                List<String> seguidos = port.listarSeguidos(a.getNickname());
                seguidoresPorUsuario.put(a.getNickname(), seguidores);
                seguidosPorUsuario.put(a.getNickname(), seguidos);
            }

            // ============ SETEAR ATRIBUTOS ============
            request.setAttribute("clientes", clientes);
            request.setAttribute("aerolineas", aerolineas);
            request.setAttribute("rutasPorAerolinea", rutasConfirmadas);
            request.setAttribute("rutasPorAerolineaAll", rutasAll);
            request.setAttribute("seguidoresPorUsuario", seguidoresPorUsuario);
            request.setAttribute("seguidosPorUsuario", seguidosPorUsuario);

            // ============ SETEAR ATRIBUTOS PREVIOS ============
            request.setAttribute("clientes", clientes);
            request.setAttribute("aerolineas", aerolineas);
            request.setAttribute("rutasPorAerolinea", rutasConfirmadas);
            request.setAttribute("rutasPorAerolineaAll", rutasAll);

            // =====================================================================
            // 🔥 CORRECCIÓN: SI ES UNA AEROLÍNEA LOGUEADA, MOSTRAR TODAS SUS RUTAS 🔥
            // =====================================================================
            HttpSession session = request.getSession(false);
            if (session != null) {
                Object u = session.getAttribute("usuario");

                if (u instanceof publicadores.DtUsuario usuario &&
                        "AEROLINEA".equalsIgnoreCase(usuario.getTipo())) {

                    // Obtener TODAS las rutas de su propia aerolínea
                    List<String> misRutas = rutasAll.get(usuario.getNickname());

                    // Sobrescribir SOLO su parte en rutasPorAerolinea
                    // Así el JSP usa esta versión ampliada
                    request.setAttribute(
                            "rutasPorAerolinea",
                            Map.of(usuario.getNickname(), misRutas)
                    );
                }
                else if (u instanceof publicadores.DtUsuario usuario &&
                        "CLIENTE".equalsIgnoreCase(usuario.getTipo())) {

                    // Buscar el cliente correspondiente
                    DtCliente clienteLogueado = null;
                    for (DtCliente c : clientes) {
                        if (c.getNickname().equals(usuario.getNickname())) {
                            clienteLogueado = c;
                            break;
                        }
                    }

                    if (clienteLogueado != null) {
                        // Llamar a los métodos que ya tienes para obtener reservas y paquetes
                        List<String> misReservas = port.listarReservasDeCliente(clienteLogueado.getNickname());
                        List<String> misPaquetes = port.listarPaquetesDeCliente(clienteLogueado.getNickname());

                        // Guardarlos en atributos para el JSP
                        request.setAttribute("misReservas", misReservas);
                        request.setAttribute("misPaquetes", misPaquetes);
                    }
                }

            }
            // =====================================================================

            request.getRequestDispatcher("/WEB-INF/listUser.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error obteniendo datos desde los WS: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/listUser.jsp").forward(request, response);
        }
    }
}
