package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import publicadores.ControladorSistemaPublishService;
import publicadores.ControladorSistemaPublish;
import publicadores.DtUsuario;

@WebServlet("/AltaRutaVueloServlet")
@MultipartConfig
public class AltaRutaVueloServlet extends HttpServlet {

    // Creamos el port del WS
    ControladorSistemaPublishService service = new ControladorSistemaPublishService();
    ControladorSistemaPublish port = service.getControladorSistemaPublishPort();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> categorias = port.listarNombresCategorias();
        List<String> ciudades = port.listarNombresCiudades();

        request.setAttribute("categorias", categorias);
        request.setAttribute("ciudades", ciudades);

        request.getRequestDispatcher("/WEB-INF/altaRutaVuelo.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            // === Capturar parámetros del formulario ===
            String nombre = request.getParameter("nombreRuta");
            String descripcionCorta = request.getParameter("descripcionCorta");
            String descripcion = request.getParameter("descripcion");
            String costoTuristaStr = request.getParameter("costoTurista");
            String costoEjecutivoStr = request.getParameter("costoEjecutivo");
            String costoEquipajeExtraStr = request.getParameter("costoEquipajeExtra");
            String ciudadOrigen = request.getParameter("ciudadOrigen");
            String ciudadDestino = request.getParameter("ciudadDestino");
            String categoria = request.getParameter("categorias");

            Part imagen = request.getPart("fotoRepresentativa");
            String nombreArchivo = null;
            if (imagen != null && imagen.getSize() > 0) {
                nombreArchivo = imagen.getSubmittedFileName();
            }

            String urlVideo = request.getParameter("urlVideo");

            // === Convertir tipos ===
            float costoTurista = Float.parseFloat(costoTuristaStr);
            float costoEjecutivo = Float.parseFloat(costoEjecutivoStr);
            float costoEquipajeExtra = Float.parseFloat(costoEquipajeExtraStr);
            String fechaAlta = LocalDate.now().toString();

            DtUsuario usuario = (DtUsuario) request.getSession().getAttribute("usuario");
            String nickAerolinea = usuario.getNickname();

            // === Llamada al WS ===
            port.altaRutaVuelo(nombre, descripcion, fechaAlta, costoTurista, costoEjecutivo,
                    costoEquipajeExtra, nickAerolinea, ciudadOrigen, ciudadDestino, categoria,
                    nombreArchivo, urlVideo, descripcionCorta);

            // === Forward con mensaje de éxito ===
            request.setAttribute("notyf_success_ARV", "Ruta de vuelo creada correctamente");
            request.getRequestDispatcher("/WEB-INF/altaRutaVuelo.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("notyf_error_ARV", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/altaRutaVuelo.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notyf_error_ARV", "Error interno del sistema.");
            request.getRequestDispatcher("/WEB-INF/altaRutaVuelo.jsp").forward(request, response);
        }
    }
}