<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, DataTypes.DtRutaVuelo" %>

<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

    <%
        Object usuario  = session.getAttribute("usuario");            
    %>

    <main class="flex flex-1 p-4 gap-4">
       <section class="flex-1 bg-base-100 p-4 rounded-lg shadow-md space-y-6">

      <h2 class="text-2xl font-bold mb-4">Consulta de paquete de ruta de vuelos</h2>
    <form action="${pageContext.request.contextPath}/ConsultaPaqueteRutaVueloServlet" method="get">
      <!-- FILTROS -->
      <div class="rounded-box border p-4 space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
          <!-- Rol -->
          <div class="form-control">
            <%
               String tipoCuenta = "usuario";
               try {
                  java.lang.reflect.Method getTipo = usuario.getClass().getMethod("getTipo");
                  Object tipoObj = getTipo.invoke(usuario);
                  if (tipoObj != null) tipoCuenta = tipoObj.toString().toUpperCase();
                     } catch (Exception ex) { }
                     String tipo = (String) session.getAttribute("tipoUsuario");

            if ("CLIENTE".equalsIgnoreCase(tipoCuenta)) {
         
         %>
               <label class="label"><span class="label-text">Rol </span></label>
               <select id="selRol" class="input input-bordered w-full bg-base-100">

               <option value="CLIENTE" <%= "CLIENTE".equalsIgnoreCase(tipoCuenta) ? "selected" : "" %>>Cliente</option>
            </select>
          </div>

                <div class="form-control">
    <label class="label"><span class="label-text">Paquete ruta de vuelo</span></label>
    <select id="selpaquete" name="paquete" class="select select-bordered w-full">
        <%
            List<String> paquetes = (List<String>) request.getAttribute("paquetes");
            if (paquetes != null && !paquetes.isEmpty()) {
                for (String a : paquetes) {
        %>
            <option value="<%= a %>" <%= a.equals(request.getAttribute("paqueteSeleccionado")) ? "selected" : "" %>><%= a %></option>
        <%
                }
                   } else {
    %>
        <option value="">No hay paquetes disponibles</option>
    <%
            }
        %>
    </select>
</div>


          <!-- Botón filtrar -->
          <div class="form-control">
           <button type="submit" id="btnFiltrar" class="btn btn-primary w-full">Ver datos del paquete</button>
          </div>
        </div>

        <!-- Paso 2: Rutas confirmadas -->
<div>
    <h3 class="font-semibold mb-2">Detalle del paquete</h3>
    <div id="rutasWrap" class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
        
    <%
        List<DataTypes.DtRutaVuelo> rutasDt = (List<DataTypes.DtRutaVuelo>) request.getAttribute("rutasDt");
        if (rutasDt != null && !rutasDt.isEmpty()) {
            for (DataTypes.DtRutaVuelo ruta : rutasDt) {
                String nombre = ruta.getNombre() != null ? ruta.getNombre() : ruta.toString();
                String descripcion = ruta.getDescripcion() != null ? ruta.getDescripcion() : "";
    %>
        <div class="card bg-base-100 shadow-xl">
            <div class="form-control">
                <!-- este submit envía rutaId al servlet -->
                <button type="submit" name="rutaId" value="<%= nombre %>" class="btn btn-primary w-full">
                    <%= nombre %>
                </button>
            </div>
            <div class="card-body">
                <p class="text-sm text-base-content/70"><%= descripcion.isBlank() ? "Sin descripción disponible" : descripcion %></p>
            </div>
        </div>
    <%
            }
        } else if (request.getParameter("aerolinea") != null) {
    %>
        <p class="col-span-full text-center text-base-content/70">No hay rutas confirmadas para esta aerolínea</p>
    <%
        }
    %>
    </div>
</div>

<!-- Nueva sección: Listado de vuelos (cuando se clicka una ruta) -->
<%
    List<?> vuelos = (List<?>) request.getAttribute("vuelos");
    String rutaSeleccionada = (String) request.getAttribute("rutaIdSeleccionada");
    if (vuelos != null && !vuelos.isEmpty()) {
%>
    <div class="mt-6">
        <h3 class="font-semibold mb-2">Vuelos en ruta: <span class="font-normal"><%= rutaSeleccionada %></span></h3>
        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
            <%
                for (Object v : vuelos) {
                    String vNombre = (v != null) ? v.toString() : "Sin nombre";
            %>
                <div class="card bg-base-100 shadow">
                    <div class="card-body">
                        <p class="font-medium mb-2"><%= vNombre %></p>
                        <!-- al hacer click enviamos vueloId al servlet -->
                        <button type="submit" name="vueloId" value="<%= vNombre %>" class="btn btn-outline w-full">Ver reserva del vuelo</button>
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

<!-- Paso 5: Listado de reservas del vuelo seleccionado (botones por reserva) -->
<%
    List<String> reservasVuelo = (List<String>) request.getAttribute("reservasVuelo");
    String mensajeReservas = (String) request.getAttribute("mensajeReservas");
    String vueloSeleccionado = (String) request.getAttribute("vueloIdSeleccionado");
    String reservaSeleccionada = (String) request.getAttribute("reservaSeleccionada");

    if (reservasVuelo != null && !reservasVuelo.isEmpty()) {
%>
    <div class="mt-8">
        <h3 class="font-semibold mb-2">Reservas del vuelo: <span class="font-normal"><%= vueloSeleccionado %></span></h3>

        <!-- Hidden inputs para mantener contexto al enviar reservaIndex -->
        <input type="hidden" name="vueloId" value="<%= vueloSeleccionado %>" />
        <% String aeroSel = (String) request.getAttribute("aerolineaSeleccionada"); 
           if (aeroSel != null) { %>
            <input type="hidden" name="aerolinea" value="<%= aeroSel %>" />
        <% } %>
        <% String rutaSel = (String) request.getAttribute("rutaIdSeleccionada");
           if (rutaSel != null) { %>
            <input type="hidden" name="rutaId" value="<%= rutaSel %>" />
        <% } %>

        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2">
            <% for (int i = 0; i < reservasVuelo.size(); i++) {
                   int numero = i + 1;
            %>
                <div>
                    <!-- botón que envía reservaIndex = numero -->
                    <button type="submit" name="reservaIndex" value="<%= numero %>" class="btn btn-sm btn-outline w-full">
                        Ver reserva N° <%= numero %>
                    </button>
                </div>
            <% } %>
        </div>

        <!-- Si se seleccionó una reserva concreta, la mostramos abajo -->
        <%
            if (reservaSeleccionada != null) {
        %>
            <div class="mt-4 p-3 rounded-md bg-base-200 shadow-sm">
                <p class="font-medium">Reserva seleccionada:</p>
                <p class="mt-2"><%= reservaSeleccionada %></p>
            </div>
        <%
            }
        %>
    </div>
<%
    } else if (mensajeReservas != null) {
%>
    <p class="mt-4 text-base-content/70"><%= mensajeReservas %></p>
<%
    }
%>

        </div>

      </div>

      <button class="btn btn-primary btn-block" onclick="window.location.href='../index.html'">Volver</button>
    </section>
               

          <% } else if ("AEROLINEA".equalsIgnoreCase(tipoCuenta)) { %>
               
          
          
          <label class="label"><span class="label-text">Rol </span></label>
               <select id="selRol" class="input input-bordered w-full bg-base-100">

               <option value="AEROLINEA" <%= "AEROLINEA".equalsIgnoreCase(tipoCuenta) ? "selected" : "" %>>Aerolínea</option>
                </select>
          </div>

           <%
                        String nickNameAero = "Usuario";
                        try {
                            java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
                            Object nombreObj = getNickname.invoke(usuario);
                            if (nombreObj != null) nickNameAero = nombreObj.toString();
                        } catch (Exception ex) { }
                    %>

            <!-- Nickname (no editable) -->
               <div class="form-control">
    <label class="label">
        <span class="label-text">Aerolínea</span>
    </label>
    <select 
        id="nicknameAero"
        name="aerolinea"
        value="<%= nickNameAero %>"
        class="input input-bordered w-full"
    >
        <option value="<%= nickNameAero %>" selected><%= nickNameAero %></option>
    </select>
</div>

            <!-- Botón filtrar -->
          <div class="form-control">
           <button type="submit" id="btnFiltrar" class="btn btn-primary w-full">Listar rutas confirmadas</button>
          </div>
        </div>

<!-- Paso 2: Rutas confirmadas (AEROLINEA) -->
<div>
    <h3 class="font-semibold mb-2">Rutas confirmadas</h3>
    <div id="rutasWrap" class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
        
    <%
        List<DataTypes.DtRutaVuelo> rutasDt2 = (List<DataTypes.DtRutaVuelo>) request.getAttribute("rutasDt");
        if (rutasDt2 != null && !rutasDt2.isEmpty()) {
            for (DataTypes.DtRutaVuelo ruta : rutasDt2) {
                String nombre = ruta.getNombre() != null ? ruta.getNombre() : ruta.toString();
                String descripcion = ruta.getDescripcion() != null ? ruta.getDescripcion() : "";
    %>
        <div class="card bg-base-100 shadow-xl">
            <div class="form-control">
                <!-- este submit envía rutaId al servlet -->
                <button type="submit" name="rutaId" value="<%= nombre %>" class="btn btn-primary w-full">
                    <%= nombre %>
                </button>
            </div>
            <div class="card-body">
                <p class="text-sm text-base-content/70"><%= descripcion.isBlank() ? "Sin descripción disponible" : descripcion %></p>
            </div>
        </div>
    <%
            }
        } else if (request.getParameter("aerolinea") != null) {
    %>
        <p class="col-span-full text-center text-base-content/70">No hay rutas confirmadas para esta aerolínea</p>
    <%
        }
    %>
    </div>
</div>

<!-- Nueva sección: Listado de vuelos (cuando se clicka una ruta) (AEROLINEA) -->
<%
    List<?> vuelos2 = (List<?>) request.getAttribute("vuelos");
    String rutaSeleccionada2 = (String) request.getAttribute("rutaIdSeleccionada");
    if (vuelos2 != null && !vuelos2.isEmpty()) {
%>
    <div class="mt-6">
        <h3 class="font-semibold mb-2">Vuelos en ruta: <span class="font-normal"><%= rutaSeleccionada2 %></span></h3>
        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
            <%
                for (Object v : vuelos2) {
                    String vNombre = (v != null) ? v.toString() : "Sin nombre";
            %>
                <div class="card bg-base-100 shadow">
                    <div class="card-body">
                        <p class="font-medium mb-2"><%= vNombre %></p>
                        <!-- al hacer click enviamos vueloId al servlet -->
                        <button type="submit" name="vueloId" value="<%= vNombre %>" class="btn btn-outline w-full">Ver reservas del vuelo</button>
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

<!-- Paso 5: Listado de reservas del vuelo seleccionado (AEROLINEA) -->
<%
    // Reutilizamos atributos ya seteados por el servlet (mismo nombre de atributos)
    List<String> reservasVuelo2 = (List<String>) request.getAttribute("reservasVuelo");
    String mensajeReservas2 = (String) request.getAttribute("mensajeReservas");
    String vueloSeleccionado2 = (String) request.getAttribute("vueloIdSeleccionado");
    String reservaSeleccionada2 = (String) request.getAttribute("reservaSeleccionada");

    if (reservasVuelo2 != null && !reservasVuelo2.isEmpty()) {
%>
    <div class="mt-8">
        <h3 class="font-semibold mb-2">Reservas del vuelo: <span class="font-normal"><%= vueloSeleccionado2 %></span></h3>

        <!-- Hidden inputs para mantener contexto al enviar reservaIndex -->
        <input type="hidden" name="vueloId" value="<%= vueloSeleccionado2 %>" />
        <% String aeroSel2 = (String) request.getAttribute("aerolineaSeleccionada"); 
           if (aeroSel2 != null) { %>
            <input type="hidden" name="aerolinea" value="<%= aeroSel2 %>" />
        <% } %>
        <% String rutaSel2 = (String) request.getAttribute("rutaIdSeleccionada");
           if (rutaSel2 != null) { %>
            <input type="hidden" name="rutaId" value="<%= rutaSel2 %>" />
        <% } %>

        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2">
            <% for (int i = 0; i < reservasVuelo2.size(); i++) {
                   int numero = i + 1;
            %>
                <div>
                    <!-- botón que envía reservaIndex = numero -->
                    <button type="submit" name="reservaIndex" value="<%= numero %>" class="btn btn-sm btn-outline w-full">
                        Ver reserva N° <%= numero %>
                    </button>
                </div>
            <% } %>
        </div>

        <!-- Si se seleccionó una reserva concreta, la mostramos abajo -->
        <%
            if (reservaSeleccionada2 != null) {
        %>
            <div class="mt-4 p-3 rounded-md bg-base-200 shadow-sm">
                <p class="font-medium">Reserva seleccionada:</p>
                <p class="mt-2"><%= reservaSeleccionada2 %></p>
            </div>
        <%
            }
        %>
    </div>
<%
    } else if (mensajeReservas2 != null) {
%>
    <p class="mt-4 text-base-content/70"><%= mensajeReservas2 %></p>
<%
    }
%>

        </div>

      </div>

      <button class="btn btn-primary btn-block" onclick="window.location.href='${pageContext.request.contextPath}/'">Volver</button>
    </section>

   <% } %>

   </main>
    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
    <script src="${pageContext.request.contextPath}/js/consultaPaqueteRutaVuelo.js"></script>
  </form>
</body>
</html>