<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="publicadores.DtRutaVuelo" %>
<%@ page import="publicadores.DtVuelo" %>
<%@ page import="publicadores.DtReserva" %>


<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
<!-- Barra de Navegacion -->
<jsp:include page="includes/nav.jsp" />

<%
    Object usuario = session.getAttribute("usuario");
    String tipoCuenta = "PUBLICO"; // valor por defecto para visitantes

    try {
        if (usuario != null) {
            java.lang.reflect.Method getTipo = usuario.getClass().getMethod("getTipo");
            Object tipoObj = getTipo.invoke(usuario);
            if (tipoObj != null) tipoCuenta = tipoObj.toString().toUpperCase();
        }
    } catch (Exception ex) { }
%>

<main class="flex flex-1 p-4 gap-4">
    <section class="flex-1 bg-base-200 p-4 rounded-lg  space-y-6">
        <h2 class="text-2xl font-bold mb-4">Consulta de Vuelo</h2>

        <% if ("CLIENTE".equalsIgnoreCase(tipoCuenta) || "PUBLICO".equalsIgnoreCase(tipoCuenta)) { %>

        <!-- FILTROS -->
        <form action="${pageContext.request.contextPath}/ConsultaVueloServlet" method="get">
            <div class="rounded-box p-4 space-y-4">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">

                    <!-- Rol -->
                    <div class="form-control">
                        <label class="label"><span class="label-text">Rol</span></label>
                        <select id="selRol" class="input input-bordered w-full bg-base-100" disabled>
                            <% if ("CLIENTE".equalsIgnoreCase(tipoCuenta)) { %>
                            <option value="CLIENTE" selected>Cliente</option>
                            <% } else if ("PUBLICO".equalsIgnoreCase(tipoCuenta)) { %>
                            <option value="PUBLICO" selected>Visitante</option>
                            <% } %>
                        </select>
                    </div>

                    <!-- Aerolínea -->
                    <div class="form-control">
                        <label class="label"><span class="label-text">Aerolínea</span></label>
                        <select id="selAero" name="aerolinea" class="select select-bordered w-full">
                            <option value="">Seleccione una Aerolínea</option>
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

                    <!-- Botón Listar Rutas -->
                    <div class="form-control">
                        <label class="label"><span class="label-text">&nbsp;</span></label>
                        <button type="submit" class="btn btn-primary w-full">Listar rutas confirmadas</button>
                    </div>
                </div>
            </div>
        </form>

            <!-- Paso 2: Rutas confirmadas -->
            <div>
                <h3 class="font-semibold mb-2">Rutas confirmadas</h3>
                <div id="rutasWrap" class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">

                    <%
                        List<DtRutaVuelo> rutasDt = (List<DtRutaVuelo>) request.getAttribute("rutasDt");
                        if (rutasDt != null && !rutasDt.isEmpty()) {
                            for (DtRutaVuelo ruta : rutasDt) {
                                String nombre = ruta.getNombre() != null ? ruta.getNombre() : ruta.toString();
                                String descripcion = ruta.getDescripcion() != null ? ruta.getDescripcion() : "";
                    %>
                    <div class="card bg-base-100 shadow-xl">
                        <div class="form-control">
                            <form action="${pageContext.request.contextPath}/ConsultaVueloServlet" method="get">
                                <input type="hidden" name="aerolinea" value="<%= request.getAttribute("aerolineaSeleccionada") %>">
                                <button type="submit" name="rutaId" value="<%= nombre %>" class="btn btn-primary w-full">
                                    <%= nombre %>
                                </button>
                            </form>
                        </div>
                        <div class="card-body">
                            <p class="text-sm text-base-content/70">
                                <%= descripcion.isBlank() ? "Sin descripción disponible" : descripcion %>
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

            <!-- Paso 3: Vuelos de la ruta seleccionada -->
            <%
                List<String> vuelos = (List<String>) request.getAttribute("vuelos"); // tu lista de nombres de vuelos
                String rutaSeleccionada = (String) request.getAttribute("rutaIdSeleccionada");
                String aerolineaSeleccionada = (String) request.getAttribute("aerolineaSeleccionada");
                List<String> reservasCliente = (List<String>) request.getAttribute("reservasCliente"); // reservas del vuelo seleccionado
                String vueloSeleccionado = (String) request.getAttribute("vueloIdSeleccionado"); // vuelo seleccionado

                if (vuelos != null && !vuelos.isEmpty()) {
            %>
            <div class="mt-6">
                <h3 class="font-semibold mb-2">
                    Vuelos en ruta: <span class="font-normal"><%= rutaSeleccionada %></span>
                </h3>
                <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
                    <%
                        for (String vNombre : vuelos) {
                    %>
                    <div class="card bg-base-100 shadow">
                        <div class="card-body">
                            <p class="font-medium mb-2"><%= vNombre %></p>

                            <!-- Botón normal para ver vuelo -->
                            <form action="${pageContext.request.contextPath}/ConsultaVueloServlet" method="get">
                                <input type="hidden" name="aerolinea" value="<%= aerolineaSeleccionada %>">
                                <input type="hidden" name="rutaId" value="<%= rutaSeleccionada %>">
                                <button type="submit" name="vueloId" value="<%= vNombre %>" class="btn btn-outline w-full">
                                    Ver vuelo
                                </button>
                            </form>

                            <!-- Mostrar reservas del cliente solo si es el vuelo seleccionado -->
                            <%
                                if (vNombre.equals(vueloSeleccionado) && reservasCliente != null) {
                                    for (String r : reservasCliente) {
                                        // Extraer el ID de la reserva del String
                                        String reservaId = "";
                                        if (r.startsWith("Reserva Nro: ")) {
                                            int guion = r.indexOf(" -");
                                            if (guion > 0) {
                                                reservaId = r.substring(12, guion); // número de reserva
                                            }
                                        }
                            %>
                            <div class="mt-2 p-4 border rounded bg-base-200">
                                <p><%= r %></p> <!-- Muestra todo el texto de la reserva -->
                                <form action="${pageContext.request.contextPath}/ConsultaReservaVueloServlet" method="get">
                                    <input type="hidden" name="aerolinea" value="<%= aerolineaSeleccionada %>">
                                    <input type="hidden" name="rutaId" value="<%= rutaSeleccionada %>">
                                    <input type="hidden" name="vueloId" value="<%= vNombre %>">
                                    <input type="hidden" name="reservaId" value="<%= reservaId %>">
                                    <button type="submit" class="btn btn-primary w-full mt-1">Ver reserva</button>
                                </form>
                            </div>
                            <%
                                    }
                                }
                            %>

                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
            } else if (request.getParameter("rutaId") != null) {
            %>
            <p class="mt-4 text-base-content/70">No hay vuelos para la ruta seleccionada.</p>
            <%
                }
            %>

        </div>

        <% } else if ("AEROLINEA".equalsIgnoreCase(tipoCuenta)) { %>


        <!-- FILTROS -->
        <form action="${pageContext.request.contextPath}/ConsultaVueloServlet" method="get">
            <div class="rounded-box border p-4 space-y-4">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">

                    <!-- Rol -->
                    <div class="form-control">
                        <label class="label"><span class="label-text">Rol </span></label>
                        <select id="selRol" class="input input-bordered w-full bg-base-100">
                            <option value="AEROLINEA" selected>Aerolínea</option>
                        </select>
                    </div>

                    <!-- Aerolínea -->
                    <div class="form-control">
                        <label class="label"><span class="label-text">Aerolínea</span></label>
                        <select id="selAero" name="aerolinea" class="select select-bordered w-full">
                            <option value="">Seleccione una Aerolínea</option>
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

                    <!-- Botón Listar Rutas -->
                    <div class="form-control">
                        <label class="label"><span class="label-text">&nbsp;</span></label>
                        <button type="submit" class="btn btn-primary w-full">Listar rutas confirmadas</button>
                    </div>
                </div>
            </div>
        </form>

            <!-- Paso 2: Rutas confirmadas -->
            <div>
                <h3 class="font-semibold mb-2">Rutas confirmadas</h3>
                <div id="rutasWrap" class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">

                    <%
                        List<DtRutaVuelo> rutasDt = (List<DtRutaVuelo>) request.getAttribute("rutasDt");
                        if (rutasDt != null && !rutasDt.isEmpty()) {
                            for (DtRutaVuelo ruta : rutasDt) {
                                String nombre = ruta.getNombre() != null ? ruta.getNombre() : ruta.toString();
                                String descripcion = ruta.getDescripcion() != null ? ruta.getDescripcion() : "";
                    %>
                    <div class="card bg-base-100 shadow-xl">
                        <div class="form-control">
                            <form action="${pageContext.request.contextPath}/ConsultaVueloServlet" method="get">
                                <input type="hidden" name="aerolinea" value="<%= aeroSel %>">
                                <button type="submit" name="rutaId" value="<%= nombre %>" class="btn btn-primary w-full">
                                    <%= nombre %>
                                </button>
                            </form>
                        </div>
                        <div class="card-body">
                            <p class="text-sm text-base-content/70">
                                <%= descripcion.isBlank() ? "Sin descripción disponible" : descripcion %>
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

            <!-- Paso 3: Vuelos de la ruta seleccionada -->
            <%
                List<?> vuelos = (List<?>) request.getAttribute("vuelos");
                String rutaSeleccionada = (String) request.getAttribute("rutaIdSeleccionada");
                String aerolineaSeleccionada = (String) request.getAttribute("aerolineaSeleccionada");
                String nickLogueado = (String) request.getAttribute("nickNameAero"); // viene del servlet
                if (vuelos != null && !vuelos.isEmpty()) {
            %>
            <div class="mt-6">
                <h3 class="font-semibold mb-2">
                    Vuelos en ruta: <span class="font-normal"><%= rutaSeleccionada %></span>
                </h3>
                <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
                    <%
                        for (Object v : vuelos) {
                            String vNombre = (v != null) ? v.toString() : "Sin nombre";
                    %>
                    <div class="card bg-base-100 shadow">
                        <div class="card-body">
                            <p class="font-medium mb-2"><%= vNombre %></p>

                            <!-- Botón normal para ver vuelo -->
                            <form action="${pageContext.request.contextPath}/ConsultaVueloServlet" method="get">
                                <input type="hidden" name="aerolinea" value="<%= aerolineaSeleccionada %>">
                                <input type="hidden" name="rutaId" value="<%= rutaSeleccionada %>">
                                <button type="submit" name="vueloId" value="<%= vNombre %>" class="btn btn-outline w-full">
                                    Ver vuelo
                                </button>
                            </form>

                            <!-- Si el nickname logueado coincide con la aerolínea consultada -->
                            <% if (nickLogueado != null && aerolineaSeleccionada != null
                                    && nickLogueado.equalsIgnoreCase(aerolineaSeleccionada)) { %>
                            <a href="http://localhost:9090/ConsultaReservaVueloServlet?aerolinea=<%= aerolineaSeleccionada %>&vueloId=<%= vNombre %>"
                               class="btn btn-primary w-full mt-2">
                                Ver reservas del vuelo
                            </a>
                            <% } %>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
            } else if (request.getParameter("rutaId") != null) {
            %>
            <p class="mt-4 text-base-content/70">No hay vuelos para la ruta seleccionada.</p>
            <%
                }
            %>
        </div>

        <% } %> <!-- Fin bloque aerolínea -->



        <!-- Paso 4: Detalle del vuelo seleccionado -->
        <%
            String vueloIdSeleccionado = (String) request.getAttribute("vueloIdSeleccionado");
            DtVuelo dtVuelo = (DtVuelo) request.getAttribute("dtVuelo");
            if (vueloIdSeleccionado != null && dtVuelo != null) {
        %>
        <div class="mt-8 p-6 border rounded-lg bg-base-200 shadow-lg">
            <h4 class="text-xl font-semibold mb-3">
                Detalles del Vuelo: <span class="font-normal"><%= dtVuelo.getNombre() %></span>
            </h4>

            <div class="space-y-2">
                <p><strong>Fecha de Salida:</strong> <%= dtVuelo.getFecha() %></p>
                <p><strong>Duración:</strong> <%= dtVuelo.getDuracion() %></p>
                <p><strong>Asientos Turista:</strong> <%= dtVuelo.getAsientosTurista() %></p>
                <p><strong>Asientos Ejecutivos:</strong> <%= dtVuelo.getAsientosEjecutivo() %></p>
            </div>

            <%
                String urlImg = dtVuelo.getUrlImagen();
                if (urlImg != null && !urlImg.isBlank()) {
            %>
            <img src="<%= urlImg %>"
                 alt="Imagen del Vuelo"
                 class="w-64 h-64 object-cover mt-4 rounded-lg shadow-md" />
            <% } else { %>
            <p class="text-sm text-gray-400 mt-4">Sin imagen disponible</p>
            <% } %>
        </div>
        <% } %>

        <!-- Sección reserva: mostrar botón Ver reserva o mensaje según dtReservaExists -->
        <%
            Boolean dtReservaExists = (Boolean) request.getAttribute("dtReservaExists");
            if (dtReservaExists != null && dtReservaExists.booleanValue()) {
        %>
        <!-- Hay reserva: mostramos botón para ver detalle (envía verReserva=1) -->
        <form action="${pageContext.request.contextPath}/ConsultaVueloServlet" method="get" class="mt-4 space-y-3">
            <input type="hidden" name="aerolinea" value="${param.aerolinea}" />
            <input type="hidden" name="rutaId" value="${param.rutaId}" />
            <input type="hidden" name="vueloId" value="${param.vueloId != null ? param.vueloId : (dtVuelo != null ? dtVuelo.nombre : '')}" />
            <button type="submit" name="verReserva" value="1" class="btn btn-success">
                Ver reserva
            </button>
        </form>

        <c:if test="${param.verReserva == '1' and not empty dtReserva}">
            <div class="mt-4 card bg-base-100 shadow">
                <div class="card-body">
                    <h4 class="font-semibold">Detalle de la reserva</h4>
                    <p><strong>Código reserva:</strong> ${dtReserva.getId()}</p>
                    <p><strong>Fecha reserva:</strong> ${dtReserva.getFecha()}</p>
                    <p><strong>Asiento:</strong> ${dtReserva.getTipoAsiento()}</p>
                    <p><strong>Equipaje Extra:</strong> ${dtReserva.getEquipajeExtra()}</p>
                    <p><strong>Costo:</strong> ${dtReserva.getCosto()}</p>

                    <c:forEach var="pasaje" items="${dtReserva.getPasajes()}">
                        <p><strong>Pasaje:</strong> ${pasaje}</p>
                        <p><strong>Nombre:</strong> ${pasaje.getNombre()}</p>
                        <p><strong>Apellido:</strong> ${pasaje.getApellido()}</p>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <%
        } else if (dtReservaExists != null && !dtReservaExists.booleanValue()) {
        %>
        <p class="text-base-content/70">No hay reserva registrada para este vuelo.</p>
        <%
            } else {
                // dtReservaExists == null -> no es cliente o no se consultó la reserva
            }
        %>




        <!-- Botón Volver -->
        <button class="btn btn-primary btn-block mt-6"
                onclick="window.location.href='${pageContext.request.contextPath}/'">Volver</button>
    </section>
</main>

<!-- Footer -->
<jsp:include page="includes/footer.jsp" />
<jsp:include page="includes/aside.jsp" />

<script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
<script src="${pageContext.request.contextPath}/js/consultaVuelo.js"></script>
</body>
</html>
