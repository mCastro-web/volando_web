<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />

<body class="bg-base-200 min-h-screen flex flex-col">

<jsp:include page="includes/nav.jsp" />

<main class="flex flex-1 p-4 gap-4 bg-base-200">
    <section class="flex-1 bg-base-200 p-4 rounded-lg space-y-4">
        <div class="mt-10 w-full mx-auto max-w-4xl">
            <h1 class="text-3xl mb-2">Consulta de Check-in</h1>
            <p class="text-sm mb-6">Selecciona la reserva para ver sus datos.</p>
        </div>

        <!-- Formulario para seleccionar reserva -->
        <form action="${pageContext.request.contextPath}/ConsultaCheckinServlet" method="post"
              class="mt-6 max-w-4xl w-full mx-auto gap-4 bg-base-200 space-y-6">
            <input type="hidden" name="accion" value="verReserva" />
            <label class="form-control w-full">
                <div class="label">
                    <span class="label-text font-medium">Reserva</span>
                </div>
                <select name="idReserva" class="select select-bordered w-full bg-base-200" required>
                    <option disabled value="">Seleccione una reserva</option>
                    <c:forEach var="idReserva" items="${reservas}">
                        <option value="${idReserva}"
                                <c:if test="${idReserva == idReservaSeleccionada}">selected</c:if>>
                            Reserva #${idReserva}
                        </option>
                    </c:forEach>
                </select>
            </label>

            <div class="mt-6 mb-4 flex justify-between items-center">
                <button type="submit" class="btn btn-primary rounded-full">Ver datos de reserva</button>
            </div>
        </form>

        <!-- Mostrar datos de la reserva -->
        <c:if test="${not empty dtReserva}">
            <div class="mt-6 max-w-4xl w-full mx-auto p-4 bg-base-100 rounded-lg space-y-2">
                <h2 class="text-xl font-bold">Datos de la Reserva</h2>
                <p><strong>Vuelo:</strong> ${dtReserva.vuelo.nombre}</p>
                <p><strong>Fecha:</strong> ${dtReserva.fecha}</p>
                <p><strong>Tipo de asiento:</strong> ${dtReserva.tipoAsiento}</p>
                <p><strong>Costo:</strong> ${dtReserva.costo}</p>

                <form action="${pageContext.request.contextPath}/ConsultaCheckinServlet" method="post">
                    <input type="hidden" name="accion" value="verCheckin" />
                    <input type="hidden" name="idReserva" value="${idReservaSeleccionada}" />
                    <button type="submit" class="btn btn-secondary rounded-full mt-4">Ver datos de check-in</button>
                </form>
            </div>
        </c:if>

        <!-- Mostrar datos del check-in -->
        <c:if test="${not empty dtCheckin}">
            <div class="mt-6 max-w-4xl w-full mx-auto p-4 bg-base-100 rounded-lg space-y-2">
                <h2 class="text-xl font-bold">Datos del Check-in</h2>
                <p><strong>Hora de embarque:</strong> ${dtCheckin.horaEmbarque}</p>
                <p><strong>Ciudad origen:</strong> ${dtCheckin.ciudadOrigen}</p>
                <p><strong>Ciudad destino:</strong> ${dtCheckin.ciudadDestino}</p>

                <h3 class="font-semibold">Pasajeros:</h3>
                <ul>
                    <!-- *** CORRECCIÓN IMPORTANTE AQUÍ *** -->
                    <c:forEach var="p" items="${dtCheckin.pasajeros.pasajero}">
                        <li>${p.nombre} ${p.apellido} - ${p.tipoAsiento}</li>
                    </c:forEach>
                </ul>

                <form action="${pageContext.request.contextPath}/ConsultaCheckinServlet" method="post">
                    <input type="hidden" name="accion" value="pdfCheckin" />
                    <input type="hidden" name="idReserva" value="${idReservaSeleccionada}" />
                    <button type="submit" class="btn btn-primary rounded-full mt-4">Descargar Tarjeta de Embarque PDF</button>
                </form>
            </div>
        </c:if>

    </section>
</main>

<jsp:include page="includes/footer.jsp" />
<jsp:include page="includes/aside.jsp" />

<script>
    const notyf = new Notyf({ duration: 2000, position: { x: 'right', y: 'bottom' } });
    <% String ok = (String) request.getAttribute("notyf_success_checkin");
       String err = (String) request.getAttribute("notyf_error_checkin");
       if (ok != null) { %>
    notyf.success("<%= ok %>");
    <% } else if (err != null) { %>
    notyf.error("<%= err %>");
    <% } %>
</script>

<script src="${pageContext.request.contextPath}/js/flyon
