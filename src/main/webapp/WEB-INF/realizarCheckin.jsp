<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />

<body class="bg-base-200 min-h-screen flex flex-col">

<!-- Barra de Navegacion -->
<jsp:include page="includes/nav.jsp" />

<main class="flex flex-1 p-4 gap-4 bg-base-200">
    <section class="flex-1 bg-base-200 p-4 rounded-lg space-y-4">
        <div class="mt-10 w-full mx-auto max-w-4xl">
            <h1 class="text-3xl mb-2">Realizar Check-in</h1>
            <p class="text-sm mb-6">
                Selecciona la reserva para la cual deseas realizar el check-in.
            </p>
        </div>

        <form action="${pageContext.request.contextPath}/CheckinServlet" method="post"
              class="mt-6 max-w-4xl w-full mx-auto gap-4 bg-base-200 space-y-6">

            <!-- Selección de reserva -->
            <label class="form-control w-full">
                <div class="label">
                    <span class="label-text font-medium">Reserva pendiente</span>
                </div>
                <select name="idReserva" class="select select-bordered w-full bg-base-200" required>
                    <option disabled selected value="">Seleccione una reserva</option>
                    <c:forEach var="idReserva" items="${reservas}">
                        <option value="${idReserva}">Reserva #${idReserva}</option>
                    </c:forEach>
                </select>
                <span class="label-text-alt text-xs opacity-70">Solo se muestran reservas pendientes de check-in.</span>
            </label>

            <!-- Botones -->
            <div class="mt-6 mb-4 flex justify-between items-center">
                <button type="button" onclick="window.location.href='/'"
                        class="btn btn-outline rounded-full">
                    Cancelar
                </button>
                <button type="submit" class="btn btn-primary rounded-full">
                    Realizar Check-in
                </button>
            </div>
        </form>
    </section>
</main>

<!-- Footer -->
<jsp:include page="includes/footer.jsp" />

<!-- Menu Hamburguesa -->
<jsp:include page="includes/aside.jsp" />

<!-- Notificaciones -->
<script>
    const notyf = new Notyf({
        duration: 2000,
        position: { x: 'right', y: 'bottom' }
    });

    <%
      String ok = (String) request.getAttribute("notyf_success_checkin");
      String err = (String) request.getAttribute("notyf_error_checkin");
      if (ok != null) { %>
    notyf.success("<%= ok %>");
    <% } else if (err != null) { %>
    notyf.error("<%= err %>");
    <% } %>
</script>

<script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>
