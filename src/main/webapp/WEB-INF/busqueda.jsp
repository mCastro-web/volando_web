<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <jsp:include page="/WEB-INF/includes/head.jsp" />
    <title>Resultados de Búsqueda - Volando.uy</title>
</head>
<body class="bg-base-200 min-h-screen flex flex-col">

    <jsp:include page="/WEB-INF/includes/nav.jsp" />

    <main class="flex-grow container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-6">Resultados de búsqueda para: "${query}"</h1>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            <!-- Rutas de Vuelo -->
            <div>
                <h2 class=" font-semibold mb-4 flex items-center gap-2">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                    Rutas de Vuelo
                </h2>
                <c:if test="${empty rutas}">
                    <div class="alert alert-info">No se encontraron rutas.</div>
                </c:if>
                <div class="grid gap-4">
                    <c:forEach var="ruta" items="${rutas}">
                        <div class="card bg-base-100 shadow-xl hover:shadow-2xl transition-shadow">
                            <div class="card-body">
                                <h3 class="card-title">
                                    <a href="ConsultaRutaVueloServlet?rutaId=${ruta.nombre}" class="hover:underline text-primary">
                                        ${ruta.nombre}
                                    </a>
                                </h3>
                                <p class="text-sm text-gray-500">${ruta.descripcionCorta}</p>
                                <div class="card-actions justify-end mt-2">
                                    <div class="badge badge-outline">${ruta.fechaAlta}</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Paquetes -->
            <div>
                <h2 class="font-semibold mb-4 flex items-center gap-2">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" /></svg>
                    Paquetes
                </h2>
                <c:if test="${empty paquetes}">
                    <div class="alert alert-info">No se encontraron paquetes.</div>
                </c:if>
                <div class="grid gap-4">
                    <c:forEach var="paquete" items="${paquetes}">
                        <div class="card bg-base-100 shadow-xl hover:shadow-2xl transition-shadow">
                            <div class="card-body">
                                <h3 class="card-title">
                                    <a href="ConsultaPaqueteRutaVueloServlet?paquete=${paquete.nombre}" class="hover:underline text-secondary">
                                        ${paquete.nombre}
                                    </a>
                                </h3>
                                <p class="text-sm text-gray-500">${paquete.descripcion}</p>
                                <div class="card-actions justify-end mt-2">
                                    <div class="badge badge-outline">${paquete.altaFecha}</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
