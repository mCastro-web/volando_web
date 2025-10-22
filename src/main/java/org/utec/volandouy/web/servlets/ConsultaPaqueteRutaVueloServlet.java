package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sistema.ISistema;
import sistema.Sistema;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import data_types.*;
import data_types.DtPaqueteVuelo;
import data_types.DtRutaVuelo;

@WebServlet("/ConsultaPaqueteRutaVueloServlet")
public class ConsultaPaqueteRutaVueloServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String paqueteSeleccionado = request.getParameter("paquete");
            List<String> paquetes = s.listarNombresPaquetes();
            //String rutaId = request.getParameter("rutaId");
            //String vueloId = request.getParameter("vueloId");
            //String reservaIndexStr = request.getParameter("reservaIndex");

            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("usuario") == null) {
                response.sendRedirect("login");
                return;
            }

            Object usuario = session.getAttribute("usuario");

          
            if (paquetes == null || paquetes.isEmpty()) {
                request.setAttribute("mensaje", "No hay paquetes disponibles");
            }
            request.setAttribute("paquetes", paquetes);
            request.setAttribute("paqueteSeleccionado", paqueteSeleccionado); // para mantener selected en JSP

            // Si hay una aerolínea seleccionada, obtener sus rutas
            if (paqueteSeleccionado != null && !paqueteSeleccionado.isEmpty()) {
                DtPaqueteVuelo paquete = s.obtenerDtPaquetePorNombre(paqueteSeleccionado);
                request.setAttribute("paquete", paquete);

            
                if (paquete != null) {
                    
                        
                    
                }
               request.setAttribute("paqueteDt", paquete);
            }

            // Si se seleccionó una ruta, listar los vuelos asociados
            /*if (rutaId != null && !rutaId.isEmpty()) {
                List<?> vuelos = s.listarNombresVuelosPorRuta(rutaId);
                request.setAttribute("vuelos", vuelos);
                request.setAttribute("rutaIdSeleccionada", rutaId);
            }*/

            // Si se seleccionó un vuelo, obtener las reservas del vuelo
            /*List<String> reservas = null;
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
            }*/

            // Si se pidió ver una reserva específica (reservaIndex), buscamos y seteamos reservaSeleccionada
            /*if (reservaIndexStr != null && !reservaIndexStr.isBlank()) {
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
            }*/

            
            // Sólo pedir objeto ruta si rutaId no es nulo
            /*if (rutaId != null && !rutaId.isEmpty()) {
                DtRutaVuelo rv = s.obtenerDtRutaPorNombre(rutaId);
                request.setAttribute("ruta", rv);
            } */

            request.getRequestDispatcher("/WEB-INF/consultaPaqueteRutaVuelo.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar las aerolíneas: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}