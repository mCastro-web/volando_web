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

import DataTypes.DtReserva;
import DataTypes.DtRutaVuelo;
import DataTypes.DtVuelo;
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
    // Usamos reflexión para obtener el método getNickname
    java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
    Object nicknameObj = getNickname.invoke(usuario);
    if (nicknameObj != null) {
        nickNameAero = nicknameObj.toString().toUpperCase(); // Mayúscula si querés
    }
} catch (Exception e) {
    System.out.println("Error obteniendo nickname de la aerolínea: " + e.getMessage());
}

// Enviamos al JSP
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
                            java.lang.reflect.Method getTipo = usuario.getClass().getMethod("getTipo");
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
                    // obtener nickname/identificador del cliente por reflexión (por compatibilidad)
                    System.out.println("Es cliente, intentando obtener DtReserva...");
                    String nickNameCliente = "";
                    try {
                        java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
                        Object tipoObj = getNickname.invoke(usuario);
                        if (tipoObj != null) nickNameCliente = tipoObj.toString().toUpperCase();
                    } catch (Exception e) {
                        System.out.println("Error obteniendo tipo de usuario: " + e.getMessage());
                    }

                    DtReserva dtReserva = null;
                    if (nickNameCliente != null && !nickNameCliente.isBlank()) {
                        try {
                            // Llamada al método que dijiste que existe en ISistema:
                            // Ajustá el nombre si es distinto en tu implementación real.
                            dtReserva = s.obtenerDtReservaPorCliVue(nickNameCliente.toLowerCase(), vueloId);
                            System.out.println("DtReserva obtenida para cliente " + nickNameCliente + " y vuelo " + vueloId + ":");
                            System.out.println(dtReserva);
                        } catch (Exception ex) {
                            // si no existe o falla, dtReserva queda null
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
                } // end esCliente
            } // end vueloId

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