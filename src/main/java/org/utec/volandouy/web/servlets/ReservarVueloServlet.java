package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sistema.ISistema;
import sistema.Sistema;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import data_types.DtDatosVueloR;
import data_types.DtItemPaquete;
import data_types.DtPaqueteVuelo;
import data_types.DtReserva;
import data_types.DtVuelo;
import data_types.TipoAsiento;
import model.ItemPaquete;

@WebServlet("/ReservarVueloServlet")
public class ReservarVueloServlet extends HttpServlet {

    private final ISistema s = Sistema.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        Object usuario = session.getAttribute("usuario");
        String nicknameCliente = "";

        try {
            java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
            Object tipoObj = getNickname.invoke(usuario);
            nicknameCliente = (String) tipoObj;
        } catch (Exception e) {
            e.printStackTrace();
        }

        String aerolineaSeleccionada = request.getParameter("aerolinea_seleccionada");
        String rutaSeleccionada = request.getParameter("ruta_seleccionada");
        String vueloSeleccionado = request.getParameter("vuelo_seleccionado");
        String tipo_asiento = request.getParameter("tipo_asiento");
        String metodoPago = request.getParameter("metodo_pago");
        String paqueteSeleccionado = request.getParameter("paquete_seleccionado");

        Long paqueteSeleccionadoLong = null;
        if (paqueteSeleccionado != null && !paqueteSeleccionado.isEmpty()) {
            try {
                paqueteSeleccionadoLong = Long.valueOf(paqueteSeleccionado);
            } catch (NumberFormatException ignored) {}
        }

        List<DtItemPaquete> itemsPaquete = null;
        if (paqueteSeleccionadoLong != null) {
            itemsPaquete = s.listarItemsDePaquete(paqueteSeleccionadoLong);
            request.setAttribute("itemsPaquete", itemsPaquete);
            System.out.println("Items del paquete seleccionado: " + itemsPaquete);
        }

        boolean rutaEnPaquete = false;
        TipoAsiento tipoDeAsiento = null;
        Integer cantidadPasajeros = 1;
        String nombreRutaItem = null;
        if (itemsPaquete != null) {
            for (DtItemPaquete item : itemsPaquete) {
                nombreRutaItem = item.getNombreRuta();
                System.out.println("Item de paquete - Ruta: " + nombreRutaItem);

                List<DtDatosVueloR> vuelos = s.listarVuelosDeRuta(nombreRutaItem);
                for (DtDatosVueloR vuelo : vuelos) {
                    if (vuelo.getNombre().equalsIgnoreCase(vueloSeleccionado)) {
                        rutaEnPaquete = true;
                        tipoDeAsiento = item.getTipoAsiento();
                        cantidadPasajeros = item.getCant();
                        break;
                    }
                    System.out.println("  Vuelo en ruta del paquete: " + vuelo.getNombre());
                }
            }
        }

        request.setAttribute("rutaEnPaquete", rutaEnPaquete);
        request.setAttribute("tipoDeAsiento", tipoDeAsiento);
        request.setAttribute("cantidadPasajerosPaquete", cantidadPasajeros);

        TipoAsiento tipoAsiento = null;
        if (tipo_asiento != null && !tipo_asiento.isEmpty()) {
            switch (tipo_asiento.trim().toLowerCase()) {
                case "turista" -> tipoAsiento = TipoAsiento.TURISTA;
                case "ejecutiva" -> tipoAsiento = TipoAsiento.EJECUTIVO;
            }
        }

        request.setAttribute("tipoAsiento", tipoAsiento);

        Integer equipaje_extra = 0;
        try {
            equipaje_extra = Integer.parseInt(request.getParameter("equipaje_extra"));
        } catch (NumberFormatException ignored) {}
        request.setAttribute("equipaje_extra", equipaje_extra);

        Integer cantPasajeros = 1;
        try {
            String param = request.getParameter("cantidad_pasajes");
            if (param != null && !param.isEmpty()) {
                cantPasajeros = Math.max(1, Integer.parseInt(param));
            }
        } catch (NumberFormatException ignored) {}
        request.setAttribute("cantPasajeros", cantPasajeros);

        LocalDate fecha = LocalDate.now();

        List<String> aerolineas = s.listarNicknamesAerolineas();
        request.setAttribute("aerolineas", aerolineas);

        if (aerolineaSeleccionada != null && !aerolineaSeleccionada.isEmpty()) {
            request.setAttribute("aerolineaSeleccionada", aerolineaSeleccionada);
            List<String> rutas = s.listarRutasConfirmadasAerolinea(aerolineaSeleccionada);
            request.setAttribute("rutas", rutas);
        }

        if (rutaSeleccionada != null && !rutaSeleccionada.isEmpty()) {
            request.setAttribute("rutaSeleccionada", rutaSeleccionada);
            List<?> vuelos = s.listarVuelosDeRuta(rutaSeleccionada);
            request.setAttribute("vuelos", vuelos);
        }

        String nombreVuelo = "";
        if (vueloSeleccionado != null && !vueloSeleccionado.isEmpty()) {
            DtVuelo vuelo = s.obtenerDtVueloPorNombre(vueloSeleccionado);
            if (vuelo != null) {
                nombreVuelo = vuelo.getNombre();
                request.setAttribute("dtVuelo", vuelo);
                request.setAttribute("vueloSeleccionado", vueloSeleccionado);
            }
        }

        List<String> pasajerosNombres = new ArrayList<>();
        List<String> pasajerosApellidos = new ArrayList<>();
        for (int i = 1; i <= cantPasajeros; i++) {
            String nombre = request.getParameter("nombre" + i);
            String apellido = request.getParameter("apellido" + i);
            if (nombre != null && !nombre.isEmpty() && apellido != null && !apellido.isEmpty()) {
                pasajerosNombres.add(nombre);
                pasajerosApellidos.add(apellido);
            }
        }
        request.setAttribute("pasajerosNombres", pasajerosNombres);
        request.setAttribute("pasajerosApellidos", pasajerosApellidos);

        List<String> paquetes = s.listarPaquetesDeCliente(nicknameCliente);
        System.out.println("Paquetes del cliente: " + paquetes);
        request.setAttribute("paquetesCliente", paquetes);

        String confirmar = request.getParameter("confirmar");
        if (confirmar == null || confirmar.isEmpty()) {
            request.getRequestDispatcher("/WEB-INF/reservarVuelo.jsp").forward(request, response);
            return;
        }

        if (nombreVuelo == null || nombreVuelo.isEmpty()
                || tipoAsiento == null
                || cantPasajeros == null || cantPasajeros <= 0
                || pasajerosNombres.isEmpty() || pasajerosApellidos.isEmpty()) {
            request.setAttribute("notyf_error", "Completa todos los campos antes de confirmar la reserva.");
            request.getRequestDispatcher("/WEB-INF/reservarVuelo.jsp").forward(request, response);
            return;
        }

        try {
            if ("paquete_comprado".equalsIgnoreCase(metodoPago)
                    && paqueteSeleccionado != null && !paqueteSeleccionado.isEmpty()) {

                String rutaCoincidente = null;
                if (itemsPaquete != null && !itemsPaquete.isEmpty()) {
                    for (DtItemPaquete item : itemsPaquete) {
                        String rutaItem = item.getNombreRuta();
                        if (rutaItem != null && rutaSeleccionada != null &&
                            rutaItem.equalsIgnoreCase(rutaSeleccionada)) {
                            rutaCoincidente = rutaItem;
                            break;
                        }
                    }
                }

                if (rutaCoincidente == null) {
                    request.setAttribute("notyf_error",
                        "El paquete seleccionado no incluye la ruta del vuelo elegido (" + rutaSeleccionada + ").");
                    request.getRequestDispatcher("/WEB-INF/reservarVuelo.jsp").forward(request, response);
                    return;
                }

                request.setAttribute("rutaCoincidente", rutaCoincidente);
                System.out.println("Ruta coincidente encontrada en el paquete: " + rutaCoincidente);

                s.reservarVuelo(nicknameCliente, nombreVuelo, tipoAsiento, equipaje_extra,
                        fecha, cantPasajeros, pasajerosNombres, pasajerosApellidos);

                s.comprarPaquete(nicknameCliente, paqueteSeleccionado, LocalDate.now());
                request.setAttribute("notyf_success",
                        "Reserva realizada utilizando el paquete '" + paqueteSeleccionado +
                        "' (Ruta: " + rutaCoincidente + ").");

            } else {
                s.reservarVuelo(nicknameCliente, nombreVuelo, tipoAsiento, equipaje_extra,
                        fecha, cantPasajeros, pasajerosNombres, pasajerosApellidos);
                request.setAttribute("notyf_success", "Reserva creada correctamente.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notyf_error", "Error al realizar la reserva: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/reservarVuelo.jsp").forward(request, response);
            return;
        }

        List<DtReserva> reservas = s.listarPaquetesCompradosPorCliente(nicknameCliente);
        request.setAttribute("reservas", reservas);
        request.getRequestDispatcher("/WEB-INF/reservarVuelo.jsp").forward(request, response);
    }
}
