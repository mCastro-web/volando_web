package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sistema.ISistema;
import sistema.Sistema;
import java.io.IOException;
import java.time.LocalDate;

import org.mindrot.jbcrypt.BCrypt;

import DataTypes.TipoDoc;

@WebServlet("/ModUserServlet")
public class ModUserServlet extends HttpServlet {

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

        String tipoUsuario = "";
        try {
            java.lang.reflect.Method getTipo = usuario.getClass().getMethod("getTipo");
            Object tipoObj = getTipo.invoke(usuario);
            if (tipoObj != null) tipoUsuario = tipoObj.toString().toUpperCase();
        } catch (Exception e) {
            System.out.println("Error obteniendo tipo de usuario: " + e.getMessage());
        }

        String nickNameCliente = "";
        try {
            java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
            Object tipoObj = getNickname.invoke(usuario);
            if (tipoObj != null) nickNameCliente = tipoObj.toString().toUpperCase();
        } catch (Exception e) {
            System.out.println("Error obteniendo tipo de usuario: " + e.getMessage());
        }

        String userEmail = "";
        try {
            java.lang.reflect.Method getEmail = usuario.getClass().getMethod("getEmail");
            Object tipoObj = getEmail.invoke(usuario);
            if (tipoObj != null) userEmail = tipoObj.toString().toUpperCase();
        } catch (Exception e) {
            System.out.println("Error obteniendo tipo de usuario: " + e.getMessage());
        }


        if (tipoUsuario.equals("CLIENTE")) {

            String nombreUser = request.getParameter("nombreUser");
            String apellido = request.getParameter("apellido");
            String nacionalidad = request.getParameter("nacionalidad");
            
            String tipoDocParam = request.getParameter("tipoDoc");
            TipoDoc tipoDoc = null;

            if (tipoDocParam != null && !tipoDocParam.isEmpty()) {
                try {
                    tipoDoc = TipoDoc.valueOf(tipoDocParam.toUpperCase());
                } catch (IllegalArgumentException e) {
                    System.out.println("Tipo de documento inválido: " + tipoDocParam);
                }
            }

            String numDoc = request.getParameter("numDoc");
            String password = BCrypt.hashpw(request.getParameter("password"), BCrypt.gensalt());
            String fotoPerfilC = request.getParameter("fotoPerfilC");
            String bdateParam = request.getParameter("bdate");
            LocalDate bdate = null;
            if (bdateParam != null && !bdateParam.isEmpty()) {
                try {
                    bdate = LocalDate.parse(bdateParam);
                } catch (Exception e) {
                    System.out.println("Fecha inválida: " + bdateParam);
                }
            }

            s.modificarCliente(nickNameCliente.toLowerCase(), nombreUser, userEmail.toLowerCase(), password, fotoPerfilC, apellido, bdate, nacionalidad, tipoDoc, numDoc, nickNameCliente.toLowerCase());
        
        Object usuarioActualizado = s.buscarPorNick(nickNameCliente.toLowerCase());
        session.setAttribute("usuario", usuarioActualizado);
        
        }

        else if (tipoUsuario.equals("AEROLINEA")) {
            
            String nombreA = request.getParameter("nombreUser");
            String descripcion = request.getParameter("descripcion");
            String web = request.getParameter("web");
            String passwordA = BCrypt.hashpw(request.getParameter("passwordA"), BCrypt.gensalt());
            String fotoPerfilA = request.getParameter("fotoPerfilA");

            s.modificarAerolinea(nickNameCliente.toLowerCase(), nombreA, userEmail, passwordA, fotoPerfilA, descripcion, web, nickNameCliente.toLowerCase());

            Object usuarioActualizado = s.buscarPorNick(nickNameCliente.toLowerCase());
            session.setAttribute("usuario", usuarioActualizado);
            System.out.println("Aerolínea modificada correctamente.");
        }

        else {
            System.out.println("Tipo de usuario desconocido: " + tipoUsuario);
        }

        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }
}
