package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sistema.ISistema;
import sistema.Sistema;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import data_types.DtRutaVuelo;
import data_types.DtVuelo;

@WebServlet("/ConsultaRutaVueloServlet")
public class ConsultaRutaVueloServlet extends HttpServlet {

    private final ISistema s = Sistema.getInstance();

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

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("usuario") == null) {
                response.sendRedirect("login");
                return;
            }

            String action = request.getParameter("action"); // listarCategorias | listarAerolineas | listarRutas
            String categoriaSeleccionada = request.getParameter("categoria");
            String aerolineaSeleccionada = request.getParameter("aerolinea");
            String rutaId = request.getParameter("rutaId");

            try {
                List<String> aerolineas = s.listarNicknamesAerolineas();
                request.setAttribute("aerolineas", aerolineas);
            } catch (Exception ex) {
                request.setAttribute("aerolineas", new ArrayList<String>());
            }


            if ("listarCategorias".equalsIgnoreCase(action)) {
                try {
                    java.lang.reflect.Method m = s.getClass().getMethod("listarNombresCategorias");
                    Object res = m.invoke(s);
                    if (res instanceof List) {
                        request.setAttribute("categorias", (List<?>) res);
                    }
                } catch (NoSuchMethodException ns) {
                    request.setAttribute("categorias", new ArrayList<String>());
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
                        java.lang.reflect.Method m = s.getClass().getMethod("listarRutasPorCategoria", String.class);
                        Object res = m.invoke(s, categoriaSeleccionada);
                        if (res instanceof List<?>) rutas = (List<?>) res;
                        request.setAttribute("filtroUsado", "categoria");
                    } catch (Exception ex) {
                        request.setAttribute("mensaje", "Error listando rutas por categoría.");
                    }
                }

                else if (aerolineaSeleccionada != null && !aerolineaSeleccionada.isBlank()) {
                    try {
                        java.lang.reflect.Method m = s.getClass().getMethod("listarRutasPorAerolinea", String.class);
                        Object res = m.invoke(s, aerolineaSeleccionada);
                        if (res instanceof List<?>) rutas = (List<?>) res;
                        request.setAttribute("filtroUsado", "aerolinea");
                    } catch (Exception ex) {
                        request.setAttribute("mensaje", "Error listando rutas por aerolínea.");
                    }
                } else {
                    request.setAttribute("mensaje", "Seleccioná una categoría o una aerolínea antes de listar rutas.");
                }

                if (rutas != null) {
                    for (Object r : rutas) {
                        try {
                            String nombreRuta = (r != null) ? r.toString() : null;
                            if (nombreRuta != null && !nombreRuta.isBlank()) {
                                DtRutaVuelo dt = s.obtenerDtRutaPorNombre(nombreRuta);
                                if (dt != null) rutasDt.add(dt);
                            }
                        } catch (Exception ignored) {}
                    }
                }

                request.setAttribute("rutasDt", rutasDt);
            }

            if (rutaId != null && !rutaId.isBlank()) {
                DtRutaVuelo rutaSeleccionada = s.obtenerDtRutaPorNombre(rutaId);
                request.setAttribute("ruta", rutaSeleccionada);
                request.setAttribute("rutaIdSeleccionada", rutaId); // 🔹 guardar solo el nombre como String

                List<DtVuelo> listaDtVuelo = new ArrayList<>();
                if (rutaSeleccionada != null && rutaSeleccionada.getVuelos() != null) {
                    for (String nombreVuelo : rutaSeleccionada.getVuelos()) {
                        try {
                            DtVuelo dt = s.obtenerDtVueloPorNombre(nombreVuelo);
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
