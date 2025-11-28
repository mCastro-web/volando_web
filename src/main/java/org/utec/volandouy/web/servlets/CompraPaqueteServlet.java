package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;
import publicadores.DtPaqueteVuelo;

@WebServlet("/CompraPaqueteServlet")
public class CompraPaqueteServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ControladorSistemaPublish port = getPort();
        List<String> paquetes = port.listarNombresPaquetesConRutas();

        if (paquetes == null) {
            System.out.println("Error: La lista de paquetes es nula.");
            paquetes = java.util.Collections.emptyList();
        }

        request.setAttribute("paquetes", paquetes);

        // Obtener paquete seleccionado (si existe)
        String seleccionado = request.getParameter("paquete_seleccionado");
        if (seleccionado != null && !seleccionado.isEmpty()) {
            DtPaqueteVuelo dto = port.obtenerDtPaquetePorNombre(seleccionado);
            request.setAttribute("paqueteSeleccionado", dto);
        }

        // 🔧 Leer mensajes de la sesión (enviados desde el POST)
        HttpSession session = request.getSession(false);
        if (session != null) {
            String success = (String) session.getAttribute("notyf_success");
            String error = (String) session.getAttribute("notyf_error");

            if (success != null) {
                request.setAttribute("notyf_success", success);
                session.removeAttribute("notyf_success");
            }
            if (error != null) {
                request.setAttribute("notyf_error", error);
                session.removeAttribute("notyf_error");
            }
        }

        request.getRequestDispatcher("/WEB-INF/compraPaquete.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombrePaquete = request.getParameter("paquete_seleccionado");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        Object usuario = session.getAttribute("usuario");
        String nickNameCliente = "";

        try {
            java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
            Object tipoObj = getNickname.invoke(usuario);
            if (tipoObj != null)
                nickNameCliente = tipoObj.toString();
        } catch (Exception e) {
            System.out.println("Error obteniendo nickname de usuario: " + e.getMessage());
            session.setAttribute("notyf_error", "Error al obtener datos del usuario");
            response.sendRedirect(request.getContextPath() + "/CompraPaqueteServlet?paquete_seleccionado=" + nombrePaquete);
            return;
        }

        ControladorSistemaPublish port = getPort();

        if (nombrePaquete != null && !nombrePaquete.isEmpty()) {
            try {
                DtPaqueteVuelo paquete = port.obtenerDtPaquetePorNombre(nombrePaquete);

                if (paquete == null) {
                    session.setAttribute("notyf_error", "Paquete no encontrado");
                    response.sendRedirect(request.getContextPath() + "/CompraPaqueteServlet");
                    return;
                }

                // Intentar comprar el paquete
                LocalDate hoy = LocalDate.now();
                port.comprarPaquete(nickNameCliente, paquete.getNombre(), hoy.toString());

                // ✅ ÉXITO - Guardar mensaje en sesión
                session.setAttribute("notyf_success",
                        "¡Paquete '" + paquete.getNombre() + "' comprado exitosamente!");

            } catch (IllegalStateException e) {
                // Cliente ya compró este paquete
                System.err.println("Cliente ya compró el paquete: " + e.getMessage());
                session.setAttribute("notyf_error",
                        "Ya compraste este paquete anteriormente");

            } catch (IllegalArgumentException e) {
                // Cliente no encontrado u otro argumento inválido
                System.err.println("Argumento inválido: " + e.getMessage());
                session.setAttribute("notyf_error",
                        "Error: Cliente no encontrado. Por favor, inicia sesión nuevamente");

            } catch (Exception e) {
                // Cualquier otro error
                System.err.println("Error inesperado al comprar paquete: " + e.getMessage());
                e.printStackTrace();
                session.setAttribute("notyf_error",
                        "Ocurrió un error al procesar tu compra. Intenta nuevamente");
            }
        } else {
            session.setAttribute("notyf_error", "Debes seleccionar un paquete");
        }

        // 🔧 REDIRECT en lugar de forward (patrón POST-REDIRECT-GET)
        response.sendRedirect(request.getContextPath() + "/CompraPaqueteServlet?paquete_seleccionado=" + nombrePaquete);
    }
}