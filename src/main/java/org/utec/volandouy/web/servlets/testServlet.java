package org.utec.volandouy.web.servlets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import sistema.*;

@WebServlet("/testServlet")
@MultipartConfig
public class testServlet extends HttpServlet {

        Sistema s = Sistema.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        Part filePart = request.getPart("file");
        String url = s.subirImagen(filePart, "prueba");

        response.setContentType("text/plain; charset=UTF-8");
        if (url != null) {
            response.getWriter().println("✅ Imagen subida correctamente:");
            response.getWriter().println(url);
        } else {
            response.getWriter().println("❌ Error al subir imagen.");
        }
    }
}