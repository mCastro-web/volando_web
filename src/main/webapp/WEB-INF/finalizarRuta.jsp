<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />

<body class="bg-base-200 min-h-screen flex flex-col">
<jsp:include page="includes/nav.jsp" />

<main class="flex flex-1 p-4 gap-4 bg-base-200">

    <section class="flex-1 bg-base-200 p-4 rounded-lg space-y-4">
        <div class="mt-10 w-full mx-auto max-w-4xl">
            <h1 class="text-3xl mb-2">Finalizar Ruta de Vuelo</h1>
            <p class="text-sm mb-6">
                Selecciona una ruta confirmada para mostrar sus datos o marcarla como finalizada.
            </p>
        </div>

        <form action="${pageContext.request.contextPath}/FinalizarRutaServlet" method="post"
              class="mt-6 max-w-4xl w-full mx-auto gap-4 bg-base-200 space-y-6">

            <!-- Select de rutas -->
            <label class="form-control w-full">
                <div class="label">
                    <span class="label-text font-medium">Ruta de vuelo</span>
                </div>
                <select name="rutaSeleccionada" class="select select-bordered w-full bg-base-200" required>
                    <option disabled selected value="">Seleccione una ruta</option>
                    <c:forEach var="r" items="${rutas}">
                        <option value="${r}" <c:if test="${r eq rutaSeleccionada}">selected</c:if>>${r}</option>
                    </c:forEach>
                </select>
            </label>

            <!-- Botón para mostrar datos -->
            <div class="mt-6 flex gap-4">
                <button type="submit" name="action" value="mostrarDatos" class="btn btn-primary rounded-full">
                    Mostrar Datos de la Ruta
                </button>
            </div>

            <!-- Mostrar datos de la ruta -->
            <c:if test="${not empty ruta}">
                <div class="bg-base-100 p-4 rounded-lg shadow-md space-y-2">
                    <p><strong>Nombre:</strong> ${ruta.nombre}</p>
                    <p><strong>Aerolínea:</strong> ${ruta.aerolinea}</p>
                    <p><strong>Categoría:</strong> ${ruta.categoria}</p>
                    <p><strong>Destino:</strong> ${ruta.destino}</p>
                    <p><strong>Origen:</strong> ${ruta.origen}</p>
                    <p><strong>Estado:</strong> ${ruta.estado}</p>
                    <p><strong>Cantidad de visitas:</strong> ${ruta.cantVisitas}</p>
                    <p><strong>Descripción:</strong> ${ruta.descripcion}</p>
                </div>

                <c:if test="${not empty ListaDtVuelo}">
                    <div class="mt-4 bg-base-100 p-4 rounded-lg shadow-md">
                        <h2 class="text-xl mb-2">Vuelos asociados</h2>
                        <ul class="list-disc pl-6">
                            <c:forEach var="vuelo" items="${ListaDtVuelo}">
                                <li>
                                        ${vuelo.nombre} - Fecha: ${vuelo.fecha} - Duración: ${vuelo.duracion}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </c:if>

            <!-- Botón para finalizar -->
            <div class="mt-6 flex gap-4">
                <button type="submit" name="action" value="finalizar" class="btn btn-error rounded-full">
                    Finalizar Ruta
                </button>
            </div>

        </form>
    </section>

</main>

<jsp:include page="includes/footer.jsp" />
<jsp:include page="includes/aside.jsp" />

<!-- Notyf -->
<script>
    const notyf = new Notyf({ duration: 2000, position: { x: 'right', y: 'bottom' } });
    <%
        String ok = (String) request.getAttribute("notyf_success");
        String err = (String) request.getAttribute("notyf_error");
        if (ok != null) {
    %>
    notyf.success("<%= ok %>");
    <% } else if (err != null) { %>
    notyf.error("<%= err %>");
    <% } %>
</script>

<script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>
