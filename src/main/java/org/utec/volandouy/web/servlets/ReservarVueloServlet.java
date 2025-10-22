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
import data_types.DtVuelo;
import data_types.TipoAsiento;

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
        TipoAsiento tipoAsiento = null;

        if (tipo_asiento != null) {
            String valor = tipo_asiento.trim().toLowerCase();
            if (valor.equals("turista")) {
                tipoAsiento = TipoAsiento.TURISTA;
            } else if (valor.equals("ejecutiva")) {
                tipoAsiento = TipoAsiento.EJECUTIVO;
            }
        } else {
            tipoAsiento = TipoAsiento.TURISTA; 
            System.out.println("tipo_asiento no recibido en el formulario");
        }


        Integer equipaje_extra = null;
        try {
            equipaje_extra = Integer.parseInt(request.getParameter("equipaje_extra"));
            request.setAttribute("equipaje_extra", equipaje_extra);
        } catch (NumberFormatException e) {
            equipaje_extra = 0;
        }

        LocalDate fecha = LocalDate.now();

        Integer cantPasajeros = 1;
        try {
            String param = request.getParameter("cantidad_pasajes");
            if (param != null && !param.isEmpty()) {
                cantPasajeros = Integer.parseInt(param);
            }
        } catch (NumberFormatException e) {
            cantPasajeros = 1;
        }

        request.setAttribute("cantPasajeros", cantPasajeros);


        List<String> aerolineas = s.listarNicknamesAerolineas();
        request.setAttribute("aerolineas", aerolineas);

        if (aerolineaSeleccionada != null && !aerolineaSeleccionada.isEmpty()) {
            List<String> rutas = s.listarRutasConfirmadasAerolinea(aerolineaSeleccionada);
            request.setAttribute("rutas", rutas);
            request.setAttribute("aerolineaSeleccionada", aerolineaSeleccionada);
        }

        if (rutaSeleccionada != null && !rutaSeleccionada.isEmpty()) {
            List<?> vuelos = s.listarVuelosDeRuta(rutaSeleccionada);
            request.setAttribute("vuelos", vuelos);
            request.setAttribute("rutaSeleccionada", rutaSeleccionada);
        }

        String nombreVuelo = "";
        if (vueloSeleccionado != null && !vueloSeleccionado.isEmpty()) {
            DtVuelo vuelo = s.obtenerDtVueloPorNombre(vueloSeleccionado);
            request.setAttribute("dtVuelo", vuelo);
            request.setAttribute("vueloSeleccionado", vueloSeleccionado);
            nombreVuelo = vuelo.getNombre();
        }

        
        List <String> pasajerosNombres = null;
        List <String> pasajerosApellidos = null;

        for (int i = 1; i <= cantPasajeros; i++) {
           
            String nombre = request.getParameter("nombre" + i);
            String apellido = request.getParameter("apellido" + i);
        
            if (pasajerosNombres == null) {
                pasajerosNombres = new ArrayList<>();
            }
            if (pasajerosApellidos == null) {
                pasajerosApellidos = new ArrayList<>();
            }

            pasajerosNombres.add(nombre);
            pasajerosApellidos.add(apellido);
        
            request.setAttribute("pasajerosNombres", pasajerosNombres);
            request.setAttribute("pasajerosApellidos", pasajerosApellidos);
        }

        try {
            s.reservarVuelo(nicknameCliente, nombreVuelo, tipoAsiento, equipaje_extra, fecha, cantPasajeros, pasajerosNombres, pasajerosApellidos);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al realizar la reserva");
            request.getRequestDispatcher("/WEB-INF/reservarVuelo.jsp").forward(request, response);
            return;
        }

        request.setAttribute("notyf_success", "Reserva creada correctamente");
        request.getRequestDispatcher("/WEB-INF/reservarVuelo.jsp").forward(request, response);
    }
}
