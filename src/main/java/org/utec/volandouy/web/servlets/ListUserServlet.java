package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;
// Import types from the new publisher package
import publicadores.DtCliente;
import publicadores.Aerolinea;


@WebServlet("/ListUserServlet")
public class ListUserServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ControladorSistemaPublish port = getPort();

            // Nickname del usuario logueado (si existe)
            HttpSession session = request.getSession(false);
            String nicknameLogueado = null;
            if (session != null) {
                nicknameLogueado = (String) session.getAttribute("nickname");
            }

            // ======= LISTADO DE USUARIOS (clientes + aerolíneas) =======
            List<String> nicknames = port.listarNicknames();

            Map<String, publicadores.DtUsuarioExtendido> usuarios = new HashMap<>();

            for (String nick : nicknames) {
                try {
                    publicadores.DtUsuarioExtendido dto =
                            port.consultaUsuarioExtendido(nick, nicknameLogueado);

                    usuarios.put(nick, dto);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // ======= ENVIAR AL JSP =======
            request.setAttribute("usuarios", usuarios);
            request.setAttribute("nicknameLogueado", nicknameLogueado);

            request.getRequestDispatcher("/WEB-INF/listUser.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error",
                    "Error obteniendo datos desde los WS: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/listUser.jsp").forward(request, response);
        }
    }
}
