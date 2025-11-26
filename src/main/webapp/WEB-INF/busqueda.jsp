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
        <div class="mb-6">
            <h1 class="text-3xl font-bold mb-2">Resultados de búsqueda</h1>
            <c:if test="${not empty query}">
                <p class="text-lg text-base-content/70">Mostrando resultados para: "<span class="font-semibold">${query}</span>"</p>
            </c:if>
        </div>

        <!-- Controles de Filtrado y Ordenamiento -->
        <div class="bg-base-100 rounded-lg shadow-md p-4 mb-6">
            <div class="flex flex-wrap gap-4 items-center">
                <div class="flex items-center gap-2">
                    <span class="icon-[tabler--arrows-sort] size-5"></span>
                    <span class="font-semibold text-sm">Ordenar:</span>
                </div>
                <div class="flex gap-2">
                    <button onclick="ordenarResultados('fecha')" class="btn btn-sm btn-outline" id="btn-fecha">
                        <span class="icon-[tabler--calendar] size-4"></span>
                        Por Fecha (Descendente)
                    </button>
                    <button onclick="ordenarResultados('alfabetico')" class="btn btn-sm btn-outline" id="btn-alfabetico">
                        <span class="icon-[tabler--sort-ascending-letters] size-4"></span>
                        Alfabéticamente (A-Z)
                    </button>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mt-4">
            <!-- Rutas de Vuelo -->
            <div>
                <h2 class="text-2xl font-semibold mb-4 flex items-center gap-2">
                    <span class="icon-[tabler--route] size-5"></span>
                    Rutas de Vuelo
                    <span class="badge badge-primary badge-sm">${not empty rutas ? rutas.size() : 0}</span>
                </h2>
                <c:if test="${empty rutas}">
                    <div class="alert alert-info shadow-lg">
                        <span class="icon-[tabler--info-circle] size-5"></span>
                        <span>No se encontraron rutas de vuelo.</span>
                    </div>
                </c:if>
                <div class="grid gap-4" id="rutas-container">
                    <c:forEach var="ruta" items="${rutas}">
                        <div class="card bg-base-100 shadow-xl hover:shadow-2xl transition-shadow ruta-item" data-nombre="${ruta.nombre}" data-fecha="${ruta.fechaAlta}">
                            <div class="card-body">
                                <h3 class="card-title text-lg">
                                    <a href="ConsultaRutaVueloServlet?rutaId=${ruta.nombre}" class="hover:underline font-bold">
                                        ${ruta.nombre}
                                    </a>
                                </h3>
                                <p class="text-sm text-base-content/70">${ruta.descripcionCorta}</p>
                                <div class="card-actions justify-between items-center mt-2">
                                    <div class="badge badge-outline gap-1">
                                        <span class="icon-[tabler--calendar] size-3"></span>
                                        ${ruta.fechaAlta}
                                    </div>
                                    <a href="ConsultaRutaVueloServlet?rutaId=${ruta.nombre}" class="btn btn-primary btn-xs">Ver detalles</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Paquetes -->
            <div>
                <h2 class="text-2xl font-semibold mb-4 flex items-center gap-2 mt-4">
                    <span class="icon-[tabler--packages] size-5"></span>
                    Paquetes
                    <span class="badge badge-secondary badge-sm">${not empty paquetes ? paquetes.size() : 0}</span>
                </h2>
                <c:if test="${empty paquetes}">
                    <div class="alert alert-info shadow-lg">
                        <span class="icon-[tabler--info-circle] size-5"></span>
                        <span>No se encontraron paquetes.</span>
                    </div>
                </c:if>
                <div class="grid gap-4" id="paquetes-container">
                    <c:forEach var="paquete" items="${paquetes}">
                        <div class="card bg-base-100 shadow-xl hover:shadow-2xl transition-shadow paquete-item" data-nombre="${paquete.nombre}" data-fecha="${paquete.altaFecha}">
                            <div class="card-body">
                                <h3 class="card-title text-lg">
                                    <a href="ConsultaPaqueteRutaVueloServlet?paquete=${paquete.nombre}" class="hover:underline font-bold">
                                        ${paquete.nombre}
                                    </a>
                                </h3>
                                <p class="text-sm text-base-content/70">${paquete.descripcion}</p>
                                <div class="card-actions justify-between items-center mt-2">
                                    <div class="badge badge-outline gap-1">
                                        <span class="icon-[tabler--calendar] size-3"></span>
                                        ${paquete.altaFecha}
                                    </div>
                                    <a href="ConsultaPaqueteRutaVueloServlet?paquete=${paquete.nombre}" class="btn btn-secondary btn-xs">Ver detalles</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/includes/footer.jsp" />

    <script>
        let ordenActual = 'fecha'; // Por defecto: fecha descendente

        function ordenarResultados(tipo) {
            ordenActual = tipo;
            
            // Actualizar botones activos
            document.getElementById('btn-fecha').classList.toggle('btn-active', tipo === 'fecha');
            document.getElementById('btn-alfabetico').classList.toggle('btn-active', tipo === 'alfabetico');

            // Ordenar rutas
            ordenarItems('rutas-container', '.ruta-item', tipo);
            
            // Ordenar paquetes
            ordenarItems('paquetes-container', '.paquete-item', tipo);
        }

        function ordenarItems(containerId, itemSelector, tipo) {
            const container = document.getElementById(containerId);
            if (!container) return;

            const items = Array.from(container.querySelectorAll(itemSelector));
            
            items.sort((a, b) => {
                if (tipo === 'alfabetico') {
                    const nombreA = a.dataset.nombre.toLowerCase();
                    const nombreB = b.dataset.nombre.toLowerCase();
                    return nombreA.localeCompare(nombreB);
                } else { // fecha descendente
                    const fechaA = new Date(a.dataset.fecha);
                    const fechaB = new Date(b.dataset.fecha);
                    return fechaB - fechaA; // Descendente (más reciente primero)
                }
            });

            // Reordenar en el DOM
            items.forEach(item => container.appendChild(item));
        }

        // Inicializar con ordenamiento por fecha (descendente) al cargar
        document.addEventListener('DOMContentLoaded', () => {
            ordenarResultados('fecha');
        });
    </script>
</body>
</html>
