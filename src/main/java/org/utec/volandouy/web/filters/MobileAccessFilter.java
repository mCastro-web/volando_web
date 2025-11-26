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
        String path = req.getRequestURI().toLowerCase();

        System.out.println("[MobileFilter] User-Agent: " + userAgent);
        System.out.println("[MobileFilter] Path solicitado: " + path);

        // ---------------------------
        // 1) Detectar móvil correctamente
        // ---------------------------
        boolean isMobile = false;
        if (userAgent != null) {
            String ua = userAgent.toLowerCase();
            isMobile =
                    ua.contains("iphone") ||
                            ua.contains("android") ||
                            ua.contains("ipad") ||
                            ua.contains("ipod") ||
                            ua.contains("windows phone") ||
                            ua.contains("mobile");
        }

        // ---------------------------
        // 2) Recursos públicos SIEMPRE permitidos (para evitar loops)
        // ---------------------------
        boolean esRecursoPublico =
                path.endsWith(".css") ||
                        path.endsWith(".js") ||
                        path.endsWith(".png") ||
                        path.endsWith(".jpg") ||
                        path.endsWith(".jpeg") ||
                        path.endsWith(".svg") ||
                        path.contains("/assets/") ||
                        path.contains("/login") ||
                        path.contains("/logoutservlet");

        if (esRecursoPublico) {
            chain.doFilter(request, response);
            return;
        }

        // ---------------------------
        // 3) Si NO es móvil → dejar pasar todo
        // ---------------------------
        if (!isMobile) {
            chain.doFilter(request, response);
            return;
        }

        // ---------------------------
        // 4) Validar sesión SOLO para móviles
        // ---------------------------
        HttpSession session = req.getSession(false);
        Object usuario = (session != null) ? session.getAttribute("usuario") : null;

        if (usuario == null) {
            System.out.println("[MobileFilter] Móvil sin sesión. Redirigiendo a login...");
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ---------------------------
        // 5) Rutas permitidas para móvil estando logueado
        // ---------------------------
        boolean permitido =
                path.equals("/") ||
                        path.endsWith("/index") ||
                        path.contains("/consultarutavuelo") ||
                        path.contains("/consultarutavueloservlet") ||
                        path.contains("/mobilenodisponible");

        if (!permitido) {
            System.out.println("[MobileFilter] Ruta NO permitida para móvil. Redirigiendo...");
            res.sendRedirect(req.getContextPath() + "/MobileNoDisponible");
            return;
        }

        System.out.println("[MobileFilter] Ruta permitida para móvil.");
        chain.doFilter(request, response);
    }
}
