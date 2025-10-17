package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import sistema.ISistema;
import sistema.Sistema;
import java.util.List;

import DataTypes.DtUsuario;

@WebServlet("/AltaRutaVueloServlet")
@MultipartConfig
public class AltaRutaVueloServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
        List<String> categorias = s.listarNombresCategorias();
        List<String> ciudades = s.listarNombresCiudades();

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
            String nombre = request.getParameter("nombre");
            String descripcionCorta = request.getParameter("descripcionCorta");
            String descripcion = request.getParameter("descripcion");
            String costoTuristaStr = request.getParameter("costoTurista");
            String costoEjecutivoStr = request.getParameter("costoEjecutivo");
            String costoEquipajeExtraStr = request.getParameter("costoEquipajeExtra");
            String ciudadOrigen = request.getParameter("ciudadOrigen");
            String ciudadDestino = request.getParameter("ciudadDestino");
            String categoria = request.getParameter("categorias");

            Part imagen = request.getPart("imagen");
            String nombreArchivo = null;
            if (imagen != null && imagen.getSize() > 0) {
                nombreArchivo = imagen.getSubmittedFileName();
                // Aquí podrías guardar el archivo si lo deseas
            }

            float costoTurista = Float.parseFloat(costoTuristaStr);
            float costoEjecutivo = Float.parseFloat(costoEjecutivoStr);
            float costoEquipajeExtra = Float.parseFloat(costoEquipajeExtraStr);
            LocalDate fechaAlta = LocalDate.now();
            DtUsuario usuario = (DtUsuario) request.getSession().getAttribute("usuario");
            String nickAerolinea = usuario.getNickname(); // o el método correcto


            s.altaRutaVuelo(nombre, descripcion, fechaAlta, costoTurista, costoEjecutivo,
                    costoEquipajeExtra, nickAerolinea, ciudadOrigen, ciudadDestino, categoria, nombreArchivo, descripcionCorta);

            request.setAttribute("successMessage", "¡Ruta de vuelo creada exitosamente!");
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("altaRutaVuelo").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error interno del sistema.");
            request.getRequestDispatcher("altaRutaVuelo").forward(request, response);
        }
    }
}