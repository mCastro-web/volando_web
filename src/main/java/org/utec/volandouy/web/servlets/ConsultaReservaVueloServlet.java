package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import publicadores.DtRutaVuelo;
// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;
import publicadores.DtUsuario;

@WebServlet("/ConsultaReservaVueloServlet")
public class ConsultaReservaVueloServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ControladorSistemaPublish port = getPort();

            String aerolineaSeleccionada = request.getParameter("aerolinea");
            List<String> aerolineas = port.listarNicknamesAerolineas();
            String rutaId = request.getParameter("rutaId");
            String vueloId = request.getParameter("vueloId");
            String reservaIndexStr = request.getParameter("reservaIndex");

            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("usuario") == null) {
                response.sendRedirect("login");
                return;
            }

            Object usuarioObj = session.getAttribute("usuario");
            String nickNameAero = "";

            if (usuarioObj instanceof DtUsuario) {
                DtUsuario usuario = (DtUsuario) usuarioObj;
                if (usuario.getNickname() != null) {
                    nickNameAero = usuario.getNickname().toUpperCase();
                }
            }

            request.setAttribute("nickNameAero", nickNameAero);

            if (aerolineas == null || aerolineas.isEmpty()) {
                request.setAttribute("mensaje", "No hay aerolíneas disponibles");
            }
            request.setAttribute("aerolineas", aerolineas);
            request.setAttribute("aerolineaSeleccionada", aerolineaSeleccionada); // para mantener selected en JSP

            // Si hay una aerolínea seleccionada, obtener sus rutas
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
                            // log si querés
                        }
                    }
                }
                request.setAttribute("rutasDt", rutasDt);
            }

            // Si se seleccionó una ruta, listar los vuelos asociados
            if (rutaId != null && !rutaId.isEmpty()) {
                List<String> vuelos = port.listarNombresVuelosPorRuta(rutaId);
                request.setAttribute("vuelos", vuelos);
                request.setAttribute("rutaIdSeleccionada", rutaId);
            }

            // Si se seleccionó un vuelo, obtener las reservas del vuelo
            List<String> reservas = null;
            if (vueloId != null && !vueloId.isEmpty()) {
                request.setAttribute("vueloIdSeleccionado", vueloId);

                try {
                    reservas = port.listarReservasDeVuelo(vueloId);

                    if (reservas != null && !reservas.isEmpty()) {
                        request.setAttribute("reservasVuelo", reservas);
                    } else {
                        request.setAttribute("mensajeReservas", "No hay reservas registradas para este vuelo.");
                    }
                } catch (Exception ex) {
                    request.setAttribute("mensajeReservas", "Error al listar reservas: " + ex.getMessage());
                }
            }

            // Si se pidió ver una reserva específica (reservaIndex), buscamos y seteamos
            // reservaSeleccionada
            if (reservaIndexStr != null && !reservaIndexStr.isBlank()) {
                // aseguramos que tenemos la lista (si no, la pedimos)
                if (reservas == null && vueloId != null && !vueloId.isEmpty()) {
                    try {
                        reservas = port.listarReservasDeVuelo(vueloId);
                    } catch (Exception ex) {
                        // deja que reservas quede como estaba (null) y setea mensaje
                        request.setAttribute("mensajeReservas", "Error al recuperar reservas: " + ex.getMessage());
                    }
                }

                if (reservas != null && !reservas.isEmpty()) {
                    try {
                        int idx = Integer.parseInt(reservaIndexStr);
                        if (idx >= 1 && idx <= reservas.size()) {
                            String reservaSeleccionada = reservas.get(idx - 1); // índice humano 1 -> lista 0
                            request.setAttribute("reservaSeleccionada", reservaSeleccionada);
                        } else {
                            request.setAttribute("mensajeReservas", "Índice de reserva inválido.");
                        }
                    } catch (NumberFormatException nfe) {
                        request.setAttribute("mensajeReservas", "Índice de reserva inválido.");
                    }
                } else {
                    // no hay reservas para buscar
                    request.setAttribute("mensajeReservas", "No hay reservas para el vuelo seleccionado.");
                }

                if (request.getAttribute("reservaSeleccionada") != null) {
                    String texto = (String) request.getAttribute("reservaSeleccionada");

                    // Extraemos el número de reserva del texto
                    String numero = texto.split(" -")[0].replace("Reserva Nro: ", "").trim();

                    try {
                        List<String> pasajes = port.listarPasajesReservasDeVuelo(numero);
                        request.setAttribute("pasajes", pasajes);
                    } catch (Exception e) {
                        request.setAttribute("mensajePasajes", "Error al listar pasajes: " + e.getMessage());
                    }
                }

            }

            if (rutaId != null && !rutaId.isEmpty()) {
                DtRutaVuelo rv = port.obtenerDtRutaPorNombre(rutaId);
                request.setAttribute("ruta", rv);
            }

            request.getRequestDispatcher("/WEB-INF/consultaReservaVuelo.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar las aerolíneas: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}