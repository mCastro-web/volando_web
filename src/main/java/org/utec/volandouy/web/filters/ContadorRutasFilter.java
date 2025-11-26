package org.utec.volandouy.web.filters;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import publicadores.ControladorSistemaPublish;
import publicadores.ControladorSistemaPublishService;

public class ContadorRutasFilter implements Filter {

     private ControladorSistemaPublish getPort() {
        return new ControladorSistemaPublishService().getControladorSistemaPublishPort();
    }

    ControladorSistemaPublish port = getPort();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;

        String rutaId = req.getParameter("rutaId");
        if (rutaId != null && !rutaId.isEmpty()) {
            port.incrementarVisitaRuta(rutaId);
            System.out.println("[ContadorRutasFilter] Visita incrementada para: " + rutaId);
        }


        chain.doFilter(request, response);
    }
}