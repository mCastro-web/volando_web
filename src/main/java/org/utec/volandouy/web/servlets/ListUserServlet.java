package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sistema.ISistema;
import sistema.Sistema;
import model.Aerolinea;
import model.Cliente;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ListUserServlet")
public class ListUserServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            List<Cliente> c = s.listarClientes();

            List<Aerolinea> aerolineas = s.listarAerolineas();
            Map<String, List<String>> rutasPorAerolineaConfirmadas = new HashMap<>();

            for (Aerolinea a : aerolineas) {
                List<String> rutas = s.listarRutasConfirmadasAerolinea(a.getNickname());
                rutasPorAerolineaConfirmadas.put(a.getNickname(), rutas);
            }

            Map<String, List<String>> rutasPorAerolinea = new HashMap<>();
            for (Aerolinea a : aerolineas) {
                List<String> rutas = s.listarRutasPorAerolinea(a.getNickname());
                rutasPorAerolinea.put(a.getNickname(), rutas);
            }

            request.setAttribute("rutasPorAerolineaAll", rutasPorAerolinea);
            request.setAttribute("rutasPorAerolinea", rutasPorAerolineaConfirmadas);
            request.setAttribute("clientes", c);
            request.setAttribute("aerolineas", aerolineas);
            request.getRequestDispatcher("/WEB-INF/listUser.jsp").forward(request, response);
    }
}
