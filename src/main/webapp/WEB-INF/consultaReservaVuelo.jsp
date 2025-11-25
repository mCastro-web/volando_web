<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="publicadores.DtRutaVuelo" %>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" />

<body class="bg-base-200 min-h-screen flex flex-col">

    <!-- Barra de navegación -->
    <jsp:include page="includes/nav.jsp" />

    <% 
        Object usuario = session.getAttribute("usuario"); 
        String tipoCuenta = "USUARIO";

        try {
            java.lang.reflect.Method getTipo = usuario.getClass().getMethod("getTipo");
            Object tipoObj = getTipo.invoke(usuario);
            if (tipoObj != null) tipoCuenta = tipoObj.toString().toUpperCase();
        } catch (Exception e) { }
    %>

    <main class="flex flex-1 p-4 gap-4">
        <section class="flex-1 bg-base-100 p-4 rounded-lg shadow-md space-y-6">

            <h2 class="text-2xl font-bold mb-4">Consulta de Reserva de Vuelo</h2>

            <!-- FORMULARIO PRINCIPAL -->
            <form action="${pageContext.request.contextPath}/ConsultaReservaVueloServlet" method="get">

            <!-- ==================================================== -->
            <!--           MODO CLIENTE                               -->
            <!-- ==================================================== -->
            <% if ("CLIENTE".equalsIgnoreCase(tipoCuenta)) { %>

                <div class="rounded-box border p-4 space-y-4">

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">

                        <!-- Rol -->
                        <div class="form-control">
                            <label class="label"><span class="label-text">Rol</span></label>
                            <select class="input input-bordered w-full bg-base-100">
                                <option value="CLIENTE" selected>Cliente</option>
                            </select>
                        </div>

                        <!-- Aerolíneas -->
                        <div class="form-control">
                            <label class="label"><span class="label-text">Aerolínea</span></label>
                            <select id="selAero" name="aerolinea" class="select select-bordered w-full">

                                <%
                                    List<String> aerolineas = (List<String>) request.getAttribute("aerolineas");
                                    String aeroSel = (String) request.getAttribute("aerolineaSeleccionada");

                                    if (aerolineas != null && !aerolineas.isEmpty()) {
                                        for (String a : aerolineas) {
                                %>
                                            <option value="<%= a %>" <%= a.equals(aeroSel) ? "selected" : "" %>><%= a %></option>
                                <%
                                        }
                                    } else {
                                %>
                                        <option value="">No hay aerolíneas disponibles</option>
                                <%
                                    }
                                %>

                            </select>
                        </div>

                        <!-- Botón filtrar -->
                        <div class="form-control">
                            <label class="label"><span class="label-text">&nbsp;</span></label>
                            <button type="submit" class="btn btn-primary w-full">Listar rutas confirmadas</button>
                        </div>

                    </div>

                    <!-- LISTADO DE RUTAS -->
                    <div class="mt-4">
                        <h3 class="font-semibold mb-2">Rutas confirmadas</h3>

                        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">

                            <%
                                List<DtRutaVuelo> rutasCliente = (List<DtRutaVuelo>) request.getAttribute("rutasDt");
                                if (rutasCliente != null && !rutasCliente.isEmpty()) {

                                    for (DtRutaVuelo ruta : rutasCliente) {
                                        String nombre = ruta.getNombre();
                                        String descripcion = ruta.getDescripcion();
                            %>

                                <div class="card bg-base-100 shadow-xl">
                                    <div class="form-control p-3">
                                        <button type="submit" name="rutaId" value="<%= nombre %>" class="btn btn-primary w-full">
                                            <%= nombre %>
                                        </button>
                                    </div>
                                    <div class="card-body">
                                        <p class="text-sm text-base-content/70">
                                            <%= (descripcion == null || descripcion.isBlank()) ? "Sin descripción disponible" : descripcion %>
                                        </p>
                                    </div>
                                </div>

                            <%
                                    }
                                } else if (request.getParameter("aerolinea") != null) {
                            %>

                                <p class="col-span-full text-center text-base-content/70">
                                    No hay rutas confirmadas para esta aerolínea.
                                </p>

                            <%
                                }
                            %>

                        </div>
                    </div>

                    <!-- VUELOS DE UNA RUTA -->
                    <%
                        List<?> vuelos = (List<?>) request.getAttribute("vuelos");
                        String rutaSel = (String) request.getAttribute("rutaIdSeleccionada");

                        if (vuelos != null && !vuelos.isEmpty()) {
                    %>

                        <div class="mt-6">
                            <h3 class="font-semibold mb-2">Vuelos en ruta:
                                <span class="font-normal"><%= rutaSel %></span>
                            </h3>

                            <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
                                <%
                                    for (Object v : vuelos) {
                                        String nombreVuelo = (v != null) ? v.toString() : "Sin nombre";
                                %>

                                    <div class="card bg-base-100 shadow">
                                        <div class="card-body">
                                            <p class="font-medium mb-2"><%= nombreVuelo %></p>

                                            <button type="submit" name="vueloId"
                                                value="<%= nombreVuelo %>" class="btn btn-outline w-full">
                                                Ver reserva del vuelo
                                            </button>
                                        </div>
                                    </div>

                                <%
                                    }
                                %>
                            </div>
                        </div>

                    <% } %>


                    <!-- RESERVAS DEL VUELO -->
                    <%
                        List<String> reservasVuelo = (List<String>) request.getAttribute("reservasVuelo");
                        String vueloSel = (String) request.getAttribute("vueloIdSeleccionado");
                        String reservaSel = (String) request.getAttribute("reservaSeleccionada");
                        String mensajeReservas = (String) request.getAttribute("mensajeReservas");

                        if (reservasVuelo != null && !reservasVuelo.isEmpty()) {
                    %>

                        <div class="mt-8">
                            <h3 class="font-semibold mb-2">Reservas del vuelo:
                                <span class="font-normal"><%= vueloSel %></span>
                            </h3>

                            <input type="hidden" name="vueloId" value="<%= vueloSel %>">
                            <input type="hidden" name="aerolinea" value="<%= aeroSel %>">
                            <input type="hidden" name="rutaId" value="<%= rutaSel %>">

                            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2">

                                <% for (int i = 0; i < reservasVuelo.size(); i++) { %>

                                    <button type="submit" name="reservaIndex"
                                            value="<%= (i + 1) %>"
                                            class="btn btn-sm btn-outline w-full">
                                        Ver reserva N° <%= (i + 1) %>
                                    </button>

                                <% } %>

                            </div>

                            <% if (reservaSel != null) { %>
                                <div class="mt-4 p-3 rounded-md bg-base-200 shadow-sm">
                                    <p class="font-medium">Reserva seleccionada:</p>
                                    <p class="mt-2"><%= reservaSel %></p>
                                </div>
                            <% } %>

                        </div>

                    <% } else if (mensajeReservas != null) { %>

                        <p class="mt-4 text-base-content/70"><%= mensajeReservas %></p>

                    <% } %>


                    <!-- PASAJES -->
                    <%
                        if (reservaSel != null) {
                            List<String> pasajes = (List<String>) request.getAttribute("pasajes");
                            String mensajePasajes = (String) request.getAttribute("mensajePasajes");
                    %>

                        <div class="mt-6 p-4 rounded-md bg-base-100 shadow-sm">
                            <h4 class="font-semibold mb-2">Pasajes asociados a la reserva:</h4>

                            <% if (pasajes != null && !pasajes.isEmpty()) { %>

                                <ul class="list-disc ml-6 space-y-1">
                                <% for (String p : pasajes) { %>
                                    <li><%= p %></li>
                                <% } %>
                                </ul>

                            <% } else if (mensajePasajes != null) { %>

                                <p class="text-error mt-2"><%= mensajePasajes %></p>

                            <% } else { %>

                                <p class="text-base-content/70 mt-2">No hay pasajes asociados a esta reserva.</p>

                            <% } %>
                        </div>

                    <% } %>

                </div>

            <!-- FIN CLIENTE -->
            <% } else if ("AEROLINEA".equalsIgnoreCase(tipoCuenta)) { %>

            <!-- ==================================================== -->
            <!--               MODO AEROLINEA                         -->
            <!-- ==================================================== -->

                <div class="rounded-box border p-4 space-y-4">

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">

                        <!-- Rol -->
                        <div class="form-control">
                            <label class="label"><span class="label-text">Rol</span></label>
                            <select class="input input-bordered w-full bg-base-100">
                                <option value="AEROLINEA" selected>Aerolínea</option>
                            </select>
                        </div>

                        <!-- Aerolínea (nickname) -->
                        <%
                            String nickAero = "AEROLINEA";
                            try {
                                java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
                                Object nickObj = getNickname.invoke(usuario);
                                if (nickObj != null) nickAero = nickObj.toString();
                            } catch (Exception e) {}
                        %>

                        <div class="form-control">
                            <label class="label"><span class="label-text">Aerolínea</span></label>
                            <select name="aerolinea" class="input input-bordered w-full">
                                <option value="<%= nickAero %>" selected><%= nickAero %></option>
                            </select>
                        </div>

                        <div class="form-control">
                            <label class="label"><span class="label-text">&nbsp;</span></label>
                            <button type="submit" class="btn btn-primary w-full">Listar rutas confirmadas</button>
                        </div>

                    </div>

                    <!-- RUTAS AEROLÍNEA -->
                    <div class="mt-6">
                        <h3 class="font-semibold mb-2">Rutas confirmadas</h3>

                        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">

                            <%
                                List<DtRutaVuelo> rutasAero = (List<DtRutaVuelo>) request.getAttribute("rutasDt");

                                if (rutasAero != null && !rutasAero.isEmpty()) {

                                    for (DtRutaVuelo ruta : rutasAero) {
                                        String nombre = ruta.getNombre();
                                        String descripcion = ruta.getDescripcion();
                            %>

                                <div class="card bg-base-100 shadow-xl">
                                    <div class="form-control">
                                        <button type="submit" name="rutaId" value="<%= nombre %>" class="btn btn-primary w-full">
                                            <%= nombre %>
                                        </button>
                                    </div>
                                    <div class="card-body">
                                        <p class="text-sm text-base-content/70">
                                            <%= (descripcion == null || descripcion.isBlank()) ? "Sin descripción disponible" : descripcion %>
                                        </p>
                                    </div>
                                </div>

                            <%
                                    }
                                } else if (request.getParameter("aerolinea") != null) {
                            %>

                                <p class="col-span-full text-center text-base-content/70">
                                    No hay rutas confirmadas para esta aerolínea
                                </p>

                            <%
                                }
                            %>

                        </div>
                    </div>

                    <!-- VUELOS -->
                    <%
                        List<?> vuelosAero = (List<?>) request.getAttribute("vuelos");
                        String rutaSelAero = (String) request.getAttribute("rutaIdSeleccionada");

                        if (vuelosAero != null && !vuelosAero.isEmpty()) {
                    %>

                        <div class="mt-6">
                            <h3 class="font-semibold mb-2">Vuelos en ruta:
                                <span class="font-normal"><%= rutaSelAero %></span></h3>

                            <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">

                                <%
                                    for (Object v : vuelosAero) {
                                        String nombreVuelo = (v != null) ? v.toString() : "Sin nombre";
                                %>

                                    <div class="card bg-base-100 shadow">
                                        <div class="card-body">
                                            <p class="font-medium mb-2"><%= nombreVuelo %></p>

                                            <button type="submit" name="vueloId"
                                                value="<%= nombreVuelo %>" class="btn btn-outline w-full">
                                                Ver reservas del vuelo
                                            </button>
                                        </div>
                                    </div>

                                <%
                                    }
                                %>

                            </div>
                        </div>

                    <% } %>


                    <!-- RESERVAS AEROLÍNEA -->
                    <%
                        List<String> reservas2 = (List<String>) request.getAttribute("reservasVuelo");
                        String vueloSel2 = (String) request.getAttribute("vueloIdSeleccionado");
                        String reservaSel2 = (String) request.getAttribute("reservaSeleccionada");
                        String mensajeRes2 = (String) request.getAttribute("mensajeReservas");

                        if (reservas2 != null && !reservas2.isEmpty()) {
                    %>

                        <div class="mt-8">
                            <h3 class="font-semibold mb-2">Reservas del vuelo:
                                <span class="font-normal"><%= vueloSel2 %></span></h3>

                            <input type="hidden" name="vueloId" value="<%= vueloSel2 %>"/>
                            <input type="hidden" name="aerolinea" value="<%= nickAero %>"/>
                            <input type="hidden" name="rutaId" value="<%= rutaSelAero %>"/>

                            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2">
                                <% for (int i = 0; i < reservas2.size(); i++) { %>

                                    <button type="submit" name="reservaIndex"
                                            value="<%= (i + 1) %>"
                                            class="btn btn-sm btn-outline w-full">
                                        Ver reserva N° <%= (i + 1) %>
                                    </button>

                                <% } %>
                            </div>

                            <% if (reservaSel2 != null) { %>
                                <div class="mt-4 p-3 rounded-md bg-base-200 shadow-sm">
                                    <p class="font-medium">Reserva seleccionada:</p>
                                    <p class="mt-2"><%= reservaSel2 %></p> 
                                </div>
                            <% } %>

                        </div>

                    <% } else if (mensajeRes2 != null) { %>

                        <p class="mt-4 text-base-content/70"><%= mensajeRes2 %></p>

                    <% } %>


                    <!-- PASAJES AERO -->
                    <%
                        if (reservaSel2 != null) {

                            List<String> pasajes2 = (List<String>) request.getAttribute("pasajes");
                            String msjPas = (String) request.getAttribute("mensajePasajes");
                    %>

                        <div class="mt-6 p-4 rounded-md bg-base-100 shadow-sm">
                            <h4 class="font-semibold mb-2">Pasajes asociados a la reserva:</h4>

                            <% if (pasajes2 != null && !pasajes2.isEmpty()) { %>

                                <ul class="list-disc ml-6 space-y-1">
                                    <% for (String p : pasajes2) { %>
                                        <li><%= p %></li>
                                    <% } %>
                                </ul>

                            <% } else if (msjPas != null) { %>

                                <p class="text-error mt-2"><%= msjPas %></p>

                            <% } else { %>

                                <p class="text-base-content/70 mt-2">
                                    No hay pasajes asociados a esta reserva.
                                </p>

                            <% } %>

                        </div>

                    <% } %>

                </div>

            <% } %>

            <!-- BOTÓN VOLVER -->
            <button class="btn btn-primary btn-block mt-6"
                onclick="window.location.href='${pageContext.request.contextPath}/'">
                Volver
            </button>

            </form>

        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="includes/footer.jsp" />

    <!-- Aside -->
    <jsp:include page="includes/aside.jsp" />

</body>
</html>
