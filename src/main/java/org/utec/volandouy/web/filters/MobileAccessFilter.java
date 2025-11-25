package org.utec.volandouy.web.filters;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class MobileAccessFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String userAgent = req.getHeader("User-Agent");
        boolean isMobile = userAgent != null && userAgent.toLowerCase().contains("mobile");

        String path = req.getRequestURI().toLowerCase();

        // DEBUG: imprimir User-Agent y la ruta
        System.out.println("[MobileFilter] User-Agent: " + userAgent);
        System.out.println("[MobileFilter] Path solicitado: " + path);

        // Recursos estáticos siempre permitidos
        if (path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png") || path.endsWith(".jpg")) {
            chain.doFilter(request, response);
            return;
        }

        // Si no es móvil, dejamos pasar todo
        if (!isMobile) {
            chain.doFilter(request, response);
            return;
        }
        // Obtener sesión y usuario
        
        HttpSession session = req.getSession(false);
        Object usuario = (session != null) ? session.getAttribute("usuario") : null;

        // Si es móvil y no hay usuario y no está intentando ir al login, redirigir al login
        if (isMobile && usuario == null && !path.contains("/login")) {
            System.out.println("[MobileFilter] Móvil sin sesión, redirigiendo a login...");
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Rutas permitidas para móviles (en minúsculas)
        boolean permitido =
                path.equals("/") ||
                path.endsWith("/index") ||
                path.contains("/login") ||
                path.contains("/logoutservlet") ||
                path.contains("/consultarutavuelo") || path.contains("/consultarutavueloservlet") ||
                path.contains("/mobilenodisponible");

        if (!permitido) {
            System.out.println("[MobileFilter] Ruta NO permitida para móvil, redirigiendo...");
            res.sendRedirect(req.getContextPath() + "/MobileNoDisponible");
            return;
        }

        System.out.println("[MobileFilter] Ruta permitida para móvil.");
        chain.doFilter(request, response);
    }
}
