<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, data_types.DtPaqueteVuelo, data_types.DtRutaVuelo" %>

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
                   <option value="CLIENTE" selected>Cliente</option>
               </select>
          </div>

          <!-- Selector de paquetes -->
          <div class="form-control">
            <label class="label"><span class="label-text">Paquete ruta de vuelo</span></label>
            <select id="selpaquete" name="paquete" class="select select-bordered w-full">
                <%
                    List<String> paquetes = (List<String>) request.getAttribute("paquetes");
                    if (paquetes != null && !paquetes.isEmpty()) {
                        for (String a : paquetes) {
                %>
                    <option value="<%= a %>" <%= a.equals(request.getAttribute("paqueteSeleccionado")) ? "selected" : "" %>>
                        <%= a %>
                    </option>
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

<%
    DtPaqueteVuelo paqueteDt = (DtPaqueteVuelo) request.getAttribute("paqueteDt");
    if (paqueteDt != null) {
%>
<div class="mt-6 p-4 rounded-lg border bg-base-200 shadow-sm">
    <h3 class="text-xl text-center font-semibold mb-3">
        Detalles del paquete "<%= paqueteDt.getNombre() %>"
    </h3>
    <hr class="mb-4">
    <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
        <div>
            <p class="font-medium">Nombre:</p>
            <p><%= paqueteDt.getNombre() %></p>
        </div>
        <div>
            <p class="font-medium">Descripción:</p>
            <p><%= paqueteDt.descripcion() %></p>
        </div>
        <div>
            <p class="font-medium">Costo:</p>
            <p>USD <%= paqueteDt.costo() %></p>
        </div>
        <div>
            <p class="font-medium">Descuento:</p>
            <p><%= paqueteDt.descuento() %> %</p>
        </div>
        <div>
            <p class="font-medium">Días de validez:</p>
            <p><%= paqueteDt.diasValidez() %></p>
        </div>
        <div>
            <p class="font-medium">Fecha de alta:</p>
            <p><%= paqueteDt.altaFecha() %></p>
        </div>
    </div>
</div>
<%
    } else if (request.getParameter("paquete") != null) {
%>
<p class="mt-4 text-base-content/70 text-center">
    No se encontraron detalles para el paquete seleccionado.
</p>
<%
    }
%>

<!-- Paso 3: Rutas del paquete -->
<div class="mt-8">
  <h3 class="font-semibold mb-2">Rutas del paquete</h3>
  <div id="rutasWrap" class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">

    <%
      List<String> rutas = (List<String>) request.getAttribute("rutas");
      if (rutas != null && !rutas.isEmpty()) {
          for (String nombreRuta : rutas) {
    %>
      <div class="card bg-base-100 shadow-xl">
        <div class="form-control">
          <form action="${pageContext.request.contextPath}/ConsultaRutaVueloServlet" method="get">
            <input type="hidden" name="paquete" value="<%= paqueteDt != null ? paqueteDt.getNombre() : "" %>">
            <button type="submit" name="rutaId" value="<%= nombreRuta %>" class="btn btn-primary w-full">
              <%= nombreRuta %>
            </button>
          </form>
        </div>
        <div class="card-body">
          <p class="text-sm text-base-content/70">
            Ruta asociada al paquete seleccionado
          </p>
        </div>
      </div>
    <%
          }
      } else if (request.getParameter("paquete") != null) {
    %>
      <p class="col-span-full text-center text-base-content/70">
        No hay rutas asociadas a este paquete.
      </p>
    <%
      }
    %>
  </div>
</div>

      <button class="btn btn-primary btn-block mt-6" onclick="window.location.href='${pageContext.request.contextPath}/'">Volver</button>
    </section>

    <% } else if ("AEROLINEA".equalsIgnoreCase(tipoCuenta)) { %>

          <label class="label"><span class="label-text">Rol </span></label>
          <select id="selRol" class="input input-bordered w-full bg-base-100">
              <option value="AEROLINEA" selected>Aerolínea</option>
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

          <div class="form-control">
            <label class="label"><span class="label-text">Aerolínea</span></label>
            <select id="nicknameAero" name="aerolinea" class="input input-bordered w-full">
                <option value="<%= nickNameAero %>" selected><%= nickNameAero %></option>
            </select>
          </div>

          <div class="form-control">
           <button type="submit" id="btnFiltrar" class="btn btn-primary w-full">Listar rutas confirmadas</button>
          </div>
        </div>

<!-- Paso 2: Rutas confirmadas (AEROLÍNEA) -->
<div>
    <h3 class="font-semibold mb-2">Rutas confirmadas</h3>
    <div id="rutasWrap" class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
    <%
        List<DtRutaVuelo> rutasDt2 = (List<DtRutaVuelo>) request.getAttribute("rutasDt");
        if (rutasDt2 != null && !rutasDt2.isEmpty()) {
            for (DtRutaVuelo ruta : rutasDt2) {
                String nombre = ruta.getNombre() != null ? ruta.getNombre() : ruta.toString();
                String descripcion = ruta.getDescripcion() != null ? ruta.getDescripcion() : "";
    %>
        <div class="card bg-base-100 shadow-xl">
            <div class="form-control">
                <button type="submit" name="rutaId" value="<%= nombre %>" class="btn btn-primary w-full">
                    <%= nombre %>
                </button>
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
        <p class="col-span-full text-center text-base-content/70">No hay rutas confirmadas para esta aerolínea</p>
    <%
        }
    %>
    </div>
</div>

<!-- Vuelos y reservas (AEROLÍNEA) -->
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
                        <button type="submit" name="vueloId" value="<%= vNombre %>" class="btn btn-outline w-full">
                            Ver reservas del vuelo
                        </button>
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

      <button class="btn btn-primary btn-block mt-6" onclick="window.location.href='${pageContext.request.contextPath}/'">Volver</button>
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
