<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />

<body class="bg-base-200 min-h-screen flex flex-col">

<jsp:include page="includes/nav.jsp" />

<main class="flex flex-1 p-4 gap-4 bg-base-200">
    <section class="flex-1 bg-base-200 p-4 rounded-lg space-y-4">
        <div class="mt-10 w-full mx-auto max-w-4xl">
            <h1 class="text-3xl mb-2">Gestionar Seguimiento de Usuarios</h1>
            <p class="text-sm mb-6">Selecciona un usuario para seguir o dejar de seguir.</p>
        </div>

        <form action="${pageContext.request.contextPath}/SeguirServlet" method="post"
              class="mt-6 max-w-4xl w-full mx-auto gap-4 bg-base-200 space-y-6">

            <label class="form-control w-full">
                <div class="label">
                    <span class="label-text font-medium">Usuario</span>
                </div>
                <select name="usuarioSeleccionado" class="select select-bordered w-full bg-base-200" required>
                    <option disabled selected value="">Seleccione un usuario</option>
                    <c:forEach var="nick" items="${usuarios}">
                        <c:if test="${nick ne usuarioActual}">
                            <option value="${nick}">${nick}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </label>

            <div class="mt-6 mb-4 flex gap-4">
                <button type="submit" name="accion" value="seguir" class="btn btn-primary rounded-full">Seguir</button>
                <button type="submit" name="accion" value="dejarSeguir" class="btn btn-secondary rounded-full">Dejar de seguir</button>
            </div>
        </form>
    </section>
</main>

<jsp:include page="includes/footer.jsp" />
<jsp:include page="includes/aside.jsp" />

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