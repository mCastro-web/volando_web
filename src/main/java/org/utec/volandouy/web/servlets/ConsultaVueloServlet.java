package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import publicadores.DtReserva;
import publicadores.DtRutaVuelo;
import publicadores.DtVuelo;
// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

@WebServlet("/ConsultaVueloServlet")
public class ConsultaVueloServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ControladorSistemaPublish port = getPort();

            String aerolineaSeleccionada = request.getParameter("aerolinea");
            String rutaId = request.getParameter("rutaId");
            String vueloId = request.getParameter("vueloId");

            HttpSession session = request.getSession(false);
            Object usuarioObj = session.getAttribute("usuario");
            String nickNameAero = "";
            String tipoUsuario = "";
            String nickNameCliente = "";

            if (usuarioObj instanceof publicadores.DtUsuario) {
                publicadores.DtUsuario usuario = (publicadores.DtUsuario) usuarioObj;
                if (usuario.getNickname() != null) {
                    nickNameCliente = usuario.getNickname();
                    nickNameAero = usuario.getNickname().toUpperCase();
                }
                if (usuario.getTipo() != null) {
                    tipoUsuario = usuario.getTipo().toUpperCase();
                }
            }

            request.setAttribute("nickNameAero", nickNameAero);

            // Siempre cargar aerolíneas para mantener el selector funcional
            List<String> aerolineas = port.listarNicknamesAerolineas();
            request.setAttribute("aerolineas", aerolineas);
            request.setAttribute("aerolineaSeleccionada", aerolineaSeleccionada);

            if (aerolineaSeleccionada != null && !aerolineaSeleccionada.isEmpty()) {
                List<String> rutas = port.listarRutasConfirmadasAerolinea(aerolineaSeleccionada);
                request.setAttribute("rutas", rutas);

                List<DtRutaVuelo> rutasDt = new ArrayList<>();
                if (rutas != null) {
                    for (String nombreRuta : rutas) {
                        try {
                            if (nombreRuta != null && !nombreRuta.isBlank()) {
                                DtRutaVuelo dt = port.obtenerDtRutaPorNombre(nombreRuta);
                                if (dt != null)
                                    rutasDt.add(dt);
                            }
                        } catch (Exception ex) {
                        }
                    }
                }
                request.setAttribute("rutasDt", rutasDt);
            }

            if (rutaId != null && !rutaId.isEmpty()) {
                List<String> vuelos = port.listarNombresVuelosPorRuta(rutaId);
                request.setAttribute("vuelos", vuelos);
                request.setAttribute("rutaIdSeleccionada", rutaId);
            }

            if (vueloId != null && !vueloId.isEmpty()) {
                DtVuelo dtVuelo = port.obtenerDtVueloPorNombre(vueloId);
                request.setAttribute("dtVuelo", dtVuelo);
                request.setAttribute("vueloIdSeleccionado", vueloId);

                boolean esCliente = "CLIENTE".equalsIgnoreCase(tipoUsuario);

                if (esCliente) {
                    // Obtener lista de reservas resumidas (ID o descripción)
                    List<String> reservasCliente = port.obtenerReservasPorClienteVuelo(nickNameCliente, vueloId);
                    request.setAttribute("reservasCliente", reservasCliente);
                }

                if ("AEROLINEA".equalsIgnoreCase(tipoUsuario)) {
                    try {
                        List<DtReserva> reservasVuelo = port.listarDtReservasDeVuelo(vueloId);
                        request.setAttribute("reservasVuelo", reservasVuelo);
                    } catch (Exception ex) {
                        System.out.println("Error al listar reservas del vuelo: " + ex.getMessage());
                    }
                }
            }

            if (rutaId != null && !rutaId.isEmpty()) {
                DtRutaVuelo rv = port.obtenerDtRutaPorNombre(rutaId);
                request.setAttribute("ruta", rv);
            }

            request.getRequestDispatcher("/WEB-INF/consultaVuelo.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar las aerolíneas: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
