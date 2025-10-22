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

            // Parámetros de control
            String action = request.getParameter("action"); // listarCategorias | listarAerolineas | listarRutas
            String categoriaSeleccionada = request.getParameter("categoria");
            String aerolineaSeleccionada = request.getParameter("aerolinea");
            String rutaId = request.getParameter("rutaId");

            // Siempre enviar lista de aerolineas (para el caso de que se quiera listar)
            try {
                List<String> aerolineas = s.listarNicknamesAerolineas();
                request.setAttribute("aerolineas", aerolineas);
            } catch (Exception ex) {
                request.setAttribute("aerolineas", new ArrayList<String>());
            }
            
            // Si el action pide listar categorías -> obtener categorías del servicio
            if ("listarCategorias".equalsIgnoreCase(action)) {
                try {
                    // Asumo un método listarCategorias() que devuelve List<String>
                    java.lang.reflect.Method m = s.getClass().getMethod("listarNombresCategorias");
                    Object res = m.invoke(s);
                    if (res instanceof List) {
                        request.setAttribute("categorias", (List<?>) res);
                    }
                } catch (NoSuchMethodException ns) {
                    // Si no existe, intentar otro nombre o setear vacío
                    request.setAttribute("categorias", new ArrayList<String>());
                } catch (Exception ex) {
                    request.setAttribute("categorias", new ArrayList<String>());
                }
                // indicar en la vista que se mostraron categorías
                request.setAttribute("mostrando", "categorias");
            }

            // Si el action pide listar aerolineas -> (en realidad ya las cargamos)
            if ("listarAerolineas".equalsIgnoreCase(action)) {
                request.setAttribute("mostrando", "aerolineas");
            }

            // Si presionaron "Listar rutas confirmadas", determinamos por dónde viene:
            if ("listarRutas".equalsIgnoreCase(action)) {
                List<?> rutas = null;
                List<DtRutaVuelo> rutasDt = new ArrayList<>();

                if (categoriaSeleccionada != null && !categoriaSeleccionada.isBlank()) {
                    // listar por categoría
                    try {
                        java.lang.reflect.Method m = s.getClass().getMethod("listarRutasPorCategoria", String.class);
                        Object res = m.invoke(s, categoriaSeleccionada);
                        if (res instanceof List) rutas = (List<?>) res;
                        request.setAttribute("filtroUsado", "categoria");
                    } catch (NoSuchMethodException ns) {
                        // método no existe
                        request.setAttribute("mensaje", "Función listarRutasPorCategoria no encontrada en ISistema.");
                    }
                } else if (aerolineaSeleccionada != null && !aerolineaSeleccionada.isBlank()) {
                    // listar por aerolínea
                    try {
                        java.lang.reflect.Method m = s.getClass().getMethod("listarRutasPorAerolinea", String.class);
                        Object res = m.invoke(s, aerolineaSeleccionada);
                        if (res instanceof List) rutas = (List<?>) res;
                        request.setAttribute("filtroUsado", "aerolinea");
                    } catch (NoSuchMethodException ns) {
                        request.setAttribute("mensaje", "Función listarRutasPorAerolinea no encontrada en ISistema.");
                    }
                } else {
                    request.setAttribute("mensaje", "Seleccioná una categoría o una aerolínea antes de listar rutas.");
                }

                // Convertir nombres a DtRutaVuelo
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

            // Si se seleccionó una ruta (botón que envía rutaId), obtener DtRutaVuelo para mostrar detalles
            if (rutaId != null && !rutaId.isBlank()) {
                DtRutaVuelo rv = s.obtenerDtRutaPorNombre(rutaId);
                request.setAttribute("ruta", rv);
                // para que quede claro en la UI de dónde vino la consulta
                request.setAttribute("rutaIdSeleccionada", rutaId);
            }

            // Mantener en la vista las selecciones actuales (si las hay)
            request.setAttribute("categoriaSeleccionada", categoriaSeleccionada);
            request.setAttribute("aerolineaSeleccionada", aerolineaSeleccionada);

            // Forward al JSP solicitado
            request.getRequestDispatcher("/WEB-INF/consultaRutaVuelo.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error cargando datos: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}