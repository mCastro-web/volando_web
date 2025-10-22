package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sistema.ISistema;
import sistema.Sistema;
import model.Cliente;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import data_types.DtReserva;
import data_types.DtRutaVuelo;
import data_types.DtVuelo;

@WebServlet("/ConsultaVueloServlet")
public class ConsultaVueloServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String aerolineaSeleccionada = request.getParameter("aerolinea");
            List<String> aerolineas = s.listarNicknamesAerolineas();
            String rutaId = request.getParameter("rutaId");
            String vueloId = request.getParameter("vueloId");

            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("usuario") == null) {
                response.sendRedirect("login");
                return;
            }

            Object usuario = session.getAttribute("usuario");

            String nickNameAero = "";
            try {
                Method getNickname = usuario.getClass().getMethod("getNickname");
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
            request.setAttribute("aerolineaSeleccionada", aerolineaSeleccionada);

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
                            // log opcional
                        }
                    }
                }
                request.setAttribute("rutasDt", rutasDt);
            }

            if (rutaId != null && !rutaId.isEmpty()) {
                List<?> vuelos = s.listarNombresVuelosPorRuta(rutaId);
                request.setAttribute("vuelos", vuelos);
                request.setAttribute("rutaIdSeleccionada", rutaId);
            }

            if (vueloId != null && !vueloId.isEmpty()) {
                DtVuelo dtVuelo = null;
                try {
                    dtVuelo = s.obtenerDtVueloPorNombre(vueloId);
                } catch (Exception ex) {
                }
                request.setAttribute("dtVuelo", dtVuelo);
                request.setAttribute("vueloIdSeleccionado", vueloId);

                String tipoUsuario = "";
                try {
                    Method getTipo = usuario.getClass().getMethod("getTipo");
                    Object tipoObj = getTipo.invoke(usuario);
                    if (tipoObj != null) tipoUsuario = tipoObj.toString().toUpperCase();
                } catch (Exception e) {
                    System.out.println("Error obteniendo tipo de usuario: " + e.getMessage());
                }

                boolean esCliente = (usuario instanceof Cliente);
                if (!esCliente && tipoUsuario != null && tipoUsuario.equalsIgnoreCase("CLIENTE")) {
                    esCliente = true;
                }

                if (esCliente) {
                    System.out.println("Es cliente, intentando obtener DtReserva...");
                    String nickNameCliente = "";
                    try {
                        Method getNickname = usuario.getClass().getMethod("getNickname");
                        Object tipoObj = getNickname.invoke(usuario);
                        if (tipoObj != null) nickNameCliente = tipoObj.toString().toUpperCase();
                    } catch (Exception e) {
                        System.out.println("Error obteniendo tipo de usuario: " + e.getMessage());
                    }

                    DtReserva dtReserva = null;
                    if (nickNameCliente != null && !nickNameCliente.isBlank()) {
                        try {
                            dtReserva = s.obtenerDtReservaPorClienteVuelo(nickNameCliente.toLowerCase(), vueloId);
                            System.out.println("DtReserva obtenida para cliente " + nickNameCliente + " y vuelo " + vueloId + ":");
                            System.out.println(dtReserva);
                        } catch (Exception ex) {
                        }
                    }

                    String verReservaParam = request.getParameter("verReserva");

                    if (dtReserva != null) {
                        request.setAttribute("dtReservaExists", true);
                        if ("1".equals(verReservaParam)) {
                            request.setAttribute("dtReserva", dtReserva);
                            System.out.println("DtReserva encontrada y guardada en sesión.");
                        }
                    } else {
                        request.setAttribute("dtReservaExists", false);
                        System.out.println("DtReserva no encontrada.");
                    }
                }


                if ("AEROLINEA".equalsIgnoreCase(tipoUsuario)) {
                    try {
                        System.out.println("Es aerolínea, listando reservas del vuelo " + vueloId);
                        List<DtReserva> reservasVuelo = s.listarDtReservasDeVuelo(vueloId);
                        if (reservasVuelo != null && !reservasVuelo.isEmpty()) {
                            request.setAttribute("reservasVuelo", reservasVuelo);
                            System.out.println("Se encontraron " + reservasVuelo.size() + " reservas para este vuelo.");
                        } else {
                            System.out.println("No hay reservas para el vuelo " + vueloId);
                        }
                    } catch (Exception ex) {
                        System.out.println("Error al listar reservas del vuelo: " + ex.getMessage());
                    }
                }
 
            }

            if (rutaId != null && !rutaId.isEmpty()) {
                DtRutaVuelo rv = s.obtenerDtRutaPorNombre(rutaId);
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
