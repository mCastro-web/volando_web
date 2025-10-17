package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.RutaVuelo;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import sistema.*;

@WebServlet("/AltaVueloServlet")
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
        


    String nombreVuelo = request.getParameter("nombreVuelo");

    String fechaVueloStr = request.getParameter("fechaVuelo");
    LocalDate fechaVuelo = null;
    if (fechaVueloStr != null && !fechaVueloStr.isEmpty()) {
        fechaVuelo = LocalDate.parse(fechaVueloStr);
    }
    
    String duracionStr = request.getParameter("duracion");
    LocalTime duracion = null;
    if (duracionStr != null && !duracionStr.isEmpty()) {
        duracion = LocalTime.parse(duracionStr);
    }

    Integer asientosTurista = Integer.valueOf(request.getParameter("asientosTurista"));
    Integer asientosEjecutivo = Integer.valueOf(request.getParameter("asientosEjecutivo"));
    String imagenVuelo = request.getParameter("imagenVuelo");
    LocalDate fechaAlta = LocalDate.now();
    String nombreRuta = "Asia Fantastico"; //request.getParameter("nombreRuta");

    s.altaVuelo(nombreVuelo, fechaVuelo, duracion, asientosTurista, asientosEjecutivo, fechaAlta, nombreRuta, imagenVuelo);

    request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);

    }
}
