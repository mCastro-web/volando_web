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
            List<String> aerolineas = port.listarNicknamesAerolineas();
            String rutaId = request.getParameter("rutaId");
            String vueloId = request.getParameter("vueloId");

            HttpSession session = request.getSession(false);

            Object usuarioObj = session.getAttribute("usuario");
            String nickNameAero = "";
            String tipoUsuario = "";

            if (usuarioObj instanceof publicadores.DtUsuario) {
                publicadores.DtUsuario usuario = (publicadores.DtUsuario) usuarioObj;
                if (usuario.getNickname() != null) {
                    nickNameAero = usuario.getNickname().toUpperCase();
                }
                if (usuario.getTipo() != null) {
                    tipoUsuario = usuario.getTipo().toUpperCase();
                }
            }

            request.setAttribute("nickNameAero", nickNameAero);

            if (aerolineas == null || aerolineas.isEmpty()) {
                request.setAttribute("mensaje", "No hay aerolíneas disponibles");
            }
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
                            // log opcional
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
                DtVuelo dtVuelo = null;
                try {
                    dtVuelo = port.obtenerDtVueloPorNombre(vueloId);
                } catch (Exception ex) {
                }
                request.setAttribute("dtVuelo", dtVuelo);
                request.setAttribute("vueloIdSeleccionado", vueloId);

                boolean esCliente = "CLIENTE".equalsIgnoreCase(tipoUsuario);

                if (esCliente) {
                    System.out.println("Es cliente, intentando obtener DtReserva...");
                    String nickNameCliente = nickNameAero; // Reusing the nickname obtained earlier

                    DtReserva dtReserva = null;
                    if (nickNameCliente != null && !nickNameCliente.isBlank()) {
                        try {
                            dtReserva = port.obtenerDtReservaPorClienteVuelo(nickNameCliente.toLowerCase(), vueloId);
                            System.out.println(
                                    "DtReserva obtenida para cliente " + nickNameCliente + " y vuelo " + vueloId + ":");
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

                    request.setAttribute("nickNameCliente", nickNameCliente);
                    request.setAttribute("dtReservaExists", dtReserva != null);

                }

                if ("AEROLINEA".equalsIgnoreCase(tipoUsuario)) {
                    try {
                        System.out.println("Es aerolínea, listando reservas del vuelo " + vueloId);
                        List<DtReserva> reservasVuelo = port.listarDtReservasDeVuelo(vueloId);
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
