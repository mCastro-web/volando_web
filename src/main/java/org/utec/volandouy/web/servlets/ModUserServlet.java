package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import org.mindrot.jbcrypt.BCrypt;
import data_types.TipoDoc;
import java.lang.reflect.Method;
import java.util.Objects;
// WS SISTEMA
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

@WebServlet("/ModUserServlet")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class ModUserServlet extends HttpServlet {

    private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        Object usuario = session.getAttribute("usuario");

        String tipoUsuario = "";
        String nickNameCliente = "";
        String userEmail = "";

        try {
            Method getTipo = usuario.getClass().getMethod("getTipo");
            tipoUsuario = Objects.toString(getTipo.invoke(usuario), "").toUpperCase();

            Method getNickname = usuario.getClass().getMethod("getNickname");
            nickNameCliente = Objects.toString(getNickname.invoke(usuario), "").toLowerCase();

            Method getEmail = usuario.getClass().getMethod("getEmail");
            userEmail = Objects.toString(getEmail.invoke(usuario), "").toLowerCase();

        } catch (Exception e) {
            System.out.println("Error obteniendo atributos del usuario: " + e.getMessage());
        }

        ControladorSistemaPublish port = getPort();

        if ("CLIENTE".equals(tipoUsuario)) {

            String nombreUser = request.getParameter("nombreUser");
            String apellido = request.getParameter("apellido");
            String nacionalidad = request.getParameter("nacionalidad");
            String tipoDocParam = request.getParameter("tipoDoc");
            String confirmPassword = request.getParameter("confirmPassword");
            TipoDoc tipoDoc = null;

            if (tipoDocParam != null && !tipoDocParam.isEmpty()) {
                try {
                    tipoDoc = TipoDoc.valueOf(tipoDocParam.toUpperCase());
                } catch (IllegalArgumentException e) {
                    System.out.println("Tipo de documento inválido: " + tipoDocParam);
                }
            }

            String numDoc = request.getParameter("numDoc");
            String password = request.getParameter("password");
            if (password != null && !password.isEmpty() && password.equals(confirmPassword)) {
                password = BCrypt.hashpw(password, BCrypt.gensalt());
            } else {
                password = null;
            }

            Part fotoPerfilC = request.getPart("fotoPerfilMod");
            String url = null;

            if (fotoPerfilC != null && fotoPerfilC.getSize() > 0) {
                // WS adaptation: Just get the filename, upload not supported via WS yet
                url = fotoPerfilC.getSubmittedFileName();
            } else {
                try {
                    Method getUrlImagen = usuario.getClass().getMethod("getUrlImagen");
                    url = Objects.toString(getUrlImagen.invoke(usuario), "");
                } catch (Exception ignored) {
                }
            }

            String bdateParam = request.getParameter("bdate");
            LocalDate bdate = null;
            if (bdateParam != null && !bdateParam.isEmpty()) {
                try {
                    bdate = LocalDate.parse(bdateParam);
                } catch (Exception e) {
                    System.out.println("Fecha inválida: " + bdateParam);
                }
            }

            port.modificarCliente(
                    nickNameCliente, nombreUser, userEmail, password, url, apellido,
                    bdate != null ? bdate.toString() : null, nacionalidad, tipoDoc != null ? tipoDoc.toString() : null,
                    numDoc, nickNameCliente);

            // Update session object
            publicadores.DtUsuario usuarioActualizadoWS = port.buscarPorNick(nickNameCliente);
            session.setAttribute("usuario", usuarioActualizadoWS);
        }

        else if ("AEROLINEA".equals(tipoUsuario)) {
            String nombreA = request.getParameter("nombreUser");
            String descripcion = request.getParameter("descripcion");
            String web = request.getParameter("web");
            String passwordA = request.getParameter("passwordA");
            String confirmPasswordA = request.getParameter("confirmPasswordA");

            if (passwordA != null && !passwordA.isEmpty() && passwordA.equals(confirmPasswordA)) {
                passwordA = BCrypt.hashpw(passwordA, BCrypt.gensalt());
            } else {
                passwordA = null;
            }

            Part fotoPerfilA = request.getPart("fotoPerfilA");
            String urlFoto = null;

            if (fotoPerfilA != null && fotoPerfilA.getSize() > 0) {
                // WS adaptation: Just get the filename
                urlFoto = fotoPerfilA.getSubmittedFileName();
            } else {
                try {
                    Method getUrlImagen = usuario.getClass().getMethod("getUrlImagen");
                    urlFoto = Objects.toString(getUrlImagen.invoke(usuario), "");
                } catch (Exception ignored) {
                }
            }

            port.modificarAerolinea(
                    nickNameCliente, nombreA, userEmail, passwordA,
                    urlFoto, descripcion, web, nickNameCliente);

            publicadores.DtUsuario usuarioActualizadoWS = port.buscarPorNick(nickNameCliente);
            session.setAttribute("usuario", usuarioActualizadoWS);
        }

        else {
            System.out.println("Tipo de usuario desconocido: " + tipoUsuario);
        }

        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }
}
