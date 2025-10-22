package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sistema.ISistema;
import sistema.Sistema;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import DataTypes.DtRutaVuelo;

@WebServlet("/ConsultaReservaVueloServlet")
public class ConsultaReservaVueloServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String aerolineaSeleccionada = request.getParameter("aerolinea");
            List<String> aerolineas = s.listarNicknamesAerolineas();
            String rutaId = request.getParameter("rutaId");
            String vueloId = request.getParameter("vueloId");
            String reservaIndexStr = request.getParameter("reservaIndex");

            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("usuario") == null) {
                response.sendRedirect("login");
                return;
            }

            Object usuario = session.getAttribute("usuario");

            String nickNameAero = "";
            try {
                java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
                Object nicknameObj = getNickname.invoke(usuario);
                if (nicknameObj != null) {
                    nickNameAero = nicknameObj.toString().toUpperCase();
                }
            } catch (Exception e) {
                System.out.println("Error obteniendo nickname de la aerolínea: " + e.getMessage());
            }

            request.setAttribute("nickNameAero", nickNameAero);

            if (aerolineas == null || aerolineas.isEmpty()) {
                request.setAttribute("mensaje", "No hay aerolíneas disponibles");
            }
            request.setAttribute("aerolineas", aerolineas);
            request.setAttribute("aerolineaSeleccionada", aerolineaSeleccionada); // para mantener selected en JSP

            // Si hay una aerolínea seleccionada, obtener sus rutas
            if (aerolineaSeleccionada != null && !aerolineaSeleccionada.isEmpty()) {
                List<?> rutas = s.listarRutasConfirmadasAerolinea(aerolineaSeleccionada);
                request.setAttribute("rutas", rutas);

                List<DtRutaVuelo> rutasDt = new ArrayList<>();
                if (rutas != null) {
                    for (Object r : rutas) {
                        try {
                            String nombreRuta = (r != null) ? r.toString() : null;
                            if (nombreRuta != null && !nombreRuta.isBlank()) {
                                DtRutaVuelo dt = s.obtenerDtRutaPorNombre(nombreRuta);
                                if (dt != null) rutasDt.add(dt);
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
                List<?> vuelos = s.listarNombresVuelosPorRuta(rutaId);
                request.setAttribute("vuelos", vuelos);
                request.setAttribute("rutaIdSeleccionada", rutaId);
            }

            // Si se seleccionó un vuelo, obtener las reservas del vuelo
            List<String> reservas = null;
            if (vueloId != null && !vueloId.isEmpty()) {
                request.setAttribute("vueloIdSeleccionado", vueloId);

                try {
                    // Intentamos invocar listarReservasDeVuelo(String) o listarReservasDevuelo(String)
                    try {
                        java.lang.reflect.Method m = s.getClass().getMethod("listarReservasDeVuelo", String.class);
                        Object res = m.invoke(s, vueloId);
                        if (res instanceof List) {
                            reservas = (List<String>) res;
                        }
                    } catch (NoSuchMethodException ns) {
                        try {
                            java.lang.reflect.Method m2 = s.getClass().getMethod("listarReservasDevuelo", String.class);
                            Object res2 = m2.invoke(s, vueloId);
                            if (res2 instanceof List) {
                                reservas = (List<String>) res2;
                            }
                        } catch (NoSuchMethodException ns2) {
                            throw new NoSuchMethodException("No se encontró método listarReservasDeVuelo/listarReservasDevuelo en ISistema");
                        }
                    }

                    if (reservas != null && !reservas.isEmpty()) {
                        request.setAttribute("reservasVuelo", reservas);
                    } else {
                        request.setAttribute("mensajeReservas", "No hay reservas registradas para este vuelo.");
                    }
                } catch (Exception ex) {
                    request.setAttribute("mensajeReservas", "Error al listar reservas: " + ex.getMessage());
                }
            }

            // Si se pidió ver una reserva específica (reservaIndex), buscamos y seteamos reservaSeleccionada
            if (reservaIndexStr != null && !reservaIndexStr.isBlank()) {
                // aseguramos que tenemos la lista (si no, la pedimos)
                if (reservas == null && vueloId != null && !vueloId.isEmpty()) {
                    try {
                        // reusar el mismo mecanismo de reflexión
                        try {
                            java.lang.reflect.Method m = s.getClass().getMethod("listarReservasDeVuelo", String.class);
                            Object res = m.invoke(s, vueloId);
                            if (res instanceof List) {
                                reservas = (List<String>) res;
                            }
                        } catch (NoSuchMethodException ns) {
                            try {
                                java.lang.reflect.Method m2 = s.getClass().getMethod("listarReservasDevuelo", String.class);
                                Object res2 = m2.invoke(s, vueloId);
                                if (res2 instanceof List) {
                                    reservas = (List<String>) res2;
                                }
                            } catch (NoSuchMethodException ns2) {
                                // no hay método
                                reservas = null;
                            }
                        }
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
                            List<String> pasajes = s.listarPasajesReservasDeVuelo(numero);
                            request.setAttribute("pasajes", pasajes);
                        } catch (Exception e) {
                            request.setAttribute("mensajePasajes", "Error al listar pasajes: " + e.getMessage());
                        }
                    }

            }
            
            if (rutaId != null && !rutaId.isEmpty()) {
                DtRutaVuelo rv = s.obtenerDtRutaPorNombre(rutaId);
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