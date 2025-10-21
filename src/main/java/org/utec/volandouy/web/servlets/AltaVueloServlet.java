package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalTime;

import sistema.*;

@WebServlet("/AltaVueloServlet")
@MultipartConfig
public class AltaVueloServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        Object usuario = session.getAttribute("usuario");
        String nomAero = "";
        try {
            java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
            Object tipoObj = getNickname.invoke(usuario);
            if (tipoObj != null) nomAero = tipoObj.toString().toUpperCase();
        } catch (Exception e) {
            System.out.println("Error obteniendo tipo de usuario: " + e.getMessage());
        }

        // Gracias por existir tio gpt.
        java.util.function.Function<String, String> getText = (name) -> {
            try {
                Part p = request.getPart(name);
                if (p == null) return null;
                String value = new String(p.getInputStream().readAllBytes(), StandardCharsets.UTF_8).trim();
                return value.isEmpty() ? null : value;
            } catch (Exception e) {
                System.out.println("Error leyendo campo: " + name + " -> " + e.getMessage());
                return null;
            }
        };

        String nombreVuelo = getText.apply("nombreVuelo");
        String fechaVueloStr = getText.apply("fechaVuelo");
        String duracionStr = getText.apply("duracion");
        String asientosTuristaStr = getText.apply("asientosTurista");
        String asientosEjecutivoStr = getText.apply("asientosEjecutivo");
        String nombreRuta = getText.apply("ruta"); // viene del select

        LocalDate fechaVuelo = null;
        if (fechaVueloStr != null) {
            try {
                fechaVuelo = LocalDate.parse(fechaVueloStr);
            } catch (Exception e) {
                System.out.println("Fecha de vuelo inválida: " + fechaVueloStr);
            }
        }

        LocalTime duracion = null;
        if (duracionStr != null && !duracionStr.isEmpty()) {
            try {
                int minutos = Integer.parseInt(duracionStr);
                duracion = LocalTime.of(minutos / 60, minutos % 60);
            } catch (Exception e) {
                System.out.println("Duración inválida: " + duracionStr);
            }
        }

        Integer asientosTurista = null;
        if (asientosTuristaStr != null) {
            try {
                asientosTurista = Integer.valueOf(asientosTuristaStr);
            } catch (NumberFormatException e) {
                System.out.println("asientosTurista no numérico: " + asientosTuristaStr);
            }
        }

        Integer asientosEjecutivo = null;
        if (asientosEjecutivoStr != null) {
            try {
                asientosEjecutivo = Integer.valueOf(asientosEjecutivoStr);
            } catch (NumberFormatException e) {
                System.out.println("asientosEjecutivo no numérico: " + asientosEjecutivoStr);
            }
        }

        LocalDate fechaAlta = LocalDate.now();

        String imagenVuelo = null;
        try {
            Part filePart = request.getPart("file");
            if (filePart != null && filePart.getSize() > 0) {
                imagenVuelo = s.subirImagen(filePart, "vuy_vuelos");
                System.out.println("Imagen subida correctamente: " + imagenVuelo);
            } else {
                System.out.println("No se recibió archivo de imagen");
            }
        } catch (Exception e) {
            System.out.println("Error subiendo imagen: " + e.getMessage());
        }

        if (nombreVuelo == null || fechaVuelo == null || duracion == null ||
            asientosTurista == null || asientosEjecutivo == null || nombreRuta == null) {
            System.out.println("Faltan datos obligatorios en el formulario de vuelo");
            response.sendRedirect("error.jsp?message=Faltan+campos+obligatorios");
            return;
        }

        try {
            s.altaVuelo(
                nombreVuelo,
                fechaVuelo,
                duracion,
                asientosTurista,
                asientosEjecutivo,
                fechaAlta,
                nombreRuta,
                imagenVuelo
            );

            request.setAttribute("notyf_success", "Vuelo creado correctamente");
            request.getRequestDispatcher("/WEB-INF/altavuelo.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" +
                java.net.URLEncoder.encode("Error al registrar vuelo: " + e.getMessage(), "UTF-8"));
        }
    }
}
