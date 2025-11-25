package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import publicadores.DtVuelo;
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;
import publicadores.DtRutaVuelo;


@WebServlet("/ConsultaRutaVueloServlet")
public class ConsultaRutaVueloServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        ControladorSistemaPublishService service = new ControladorSistemaPublishService();
        return service.getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesar(request, response);
    }

    private void procesar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ControladorSistemaPublish port = getPort();

        try {
            String action = request.getParameter("action"); // listarCategorias | listarAerolineas | listarRutas
            String categoriaSeleccionada = request.getParameter("categoria");
            String aerolineaSeleccionada = request.getParameter("aerolinea");
            String rutaId = request.getParameter("rutaId");

            try {
                List<String> aerolineas = port.listarNicknamesAerolineas();
                request.setAttribute("aerolineas", aerolineas);
            } catch (Exception ex) {
                request.setAttribute("aerolineas", new ArrayList<String>());
            }


            if ("listarCategorias".equalsIgnoreCase(action)) {
                try {
                    List<String> categorias = port.listarNombresCategorias();
                    request.setAttribute("categorias", categorias);
                } catch (Exception ex) {
                    request.setAttribute("categorias", new ArrayList<String>());
                }
                request.setAttribute("mostrando", "categorias");
                }


            if ("listarAerolineas".equalsIgnoreCase(action)) {
                request.setAttribute("mostrando", "aerolineas");
            }


            if ("listarRutas".equalsIgnoreCase(action)) {

                List<?> rutas = null;
                List<DtRutaVuelo> rutasDt = new ArrayList<>();

                if (categoriaSeleccionada != null && !categoriaSeleccionada.isBlank()) {
                    try {
                        java.lang.reflect.Method m = port.getClass().getMethod("listarRutasPorCategoria", String.class);
                        Object res = m.invoke(port, categoriaSeleccionada);
                        if (res instanceof List<?>) rutas = (List<?>) res;
                        request.setAttribute("filtroUsado", "categoria");
                    } catch (Exception ex) {
                        request.setAttribute("mensaje", "Error listando rutas por categoría.");
                    }
                } else if (aerolineaSeleccionada != null && !aerolineaSeleccionada.isBlank()) {
                    try {
                        rutas = port.listarRutasConfirmadasAerolinea(aerolineaSeleccionada);
                        request.setAttribute("filtroUsado", "aerolinea");
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        request.setAttribute("mensaje", "Error listando rutas por aerolínea.");
                    }
                } else {
                    request.setAttribute("mensaje", "Seleccioná una categoría o una aerolínea antes de listar rutas.");
                }

                if (rutas != null) {
                    for (Object objRuta : rutas) {  // usar Object en vez de String
                        try {
                            String nombreRuta = (String) objRuta;  // casteo explícito
                            DtRutaVuelo dt = port.obtenerDtRutaPorNombre(nombreRuta);
                            if (dt != null) rutasDt.add(dt);
                        } catch (Exception ignored) {}
                    }
                }

                request.setAttribute("rutasDt", rutasDt);
            }


            if (rutaId != null && !rutaId.isBlank()) {
                DtRutaVuelo rutaSeleccionada = port.obtenerDtRutaPorNombre(rutaId);
                request.setAttribute("ruta", rutaSeleccionada);
                request.setAttribute("rutaIdSeleccionada", rutaId);

                List<String> nombresVuelos = null;
                List<DtVuelo> listaDtVuelo = new ArrayList<>();

                if (rutaSeleccionada != null) {
                    nombresVuelos = port.listarNombresVuelosPorRuta(rutaId);
                    request.setAttribute("ListaNombresVuelos", nombresVuelos);
                }

                if (nombresVuelos != null) {
                    for (String nombreVuelo : nombresVuelos) {
                        try {
                            DtVuelo dt = port.obtenerDtVueloPorNombre(nombreVuelo);
                            if (dt != null) listaDtVuelo.add(dt);
                        } catch (Exception ex) {
                            System.out.println("Error cargando vuelo: " + ex.getMessage());
                        }
                    }
                }

                request.setAttribute("ListaDtVuelo", listaDtVuelo);

            }

            request.setAttribute("categoriaSeleccionada", categoriaSeleccionada);
            request.setAttribute("aerolineaSeleccionada", aerolineaSeleccionada);
            request.getRequestDispatcher("/WEB-INF/consultaRutaVuelo.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error cargando datos: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
