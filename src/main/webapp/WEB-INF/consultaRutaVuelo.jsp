<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, DataTypes.DtRutaVuelo" %>
<%@ page import="java.util.List, DataTypes.DtVuelo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <jsp:include page="includes/nav.jsp" />

    <main class="flex flex-1 p-4 gap-4">
       <section class="flex-1 bg-base-100 p-4 rounded-lg shadow-md space-y-6">

      <h2 class="text-2xl font-bold mb-4">Consulta de Rutas</h2>

      <!-- Form principal: usamos GET para facilitar bookmark / navegación -->
      <form action="${pageContext.request.contextPath}/ConsultaRutaVueloServlet" method="get" id="formConsulta">

        <!-- FILTROS: aquí va el bloque que pediste (antes 'Rol') -->
        <div class="rounded-box border p-4 space-y-4">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                <!-- Lugar donde estarán los dos botones (Listar categorías / Listar aerolíneas) -->
                <div class="form-control">
                    <label class="label"><span class="label-text">Opciones</span></label>
                    <div class="flex gap-2">
                        <!-- Botón listar categorías -->
                        <button type="submit" name="action" value="listarCategorias"
                                id="btnListarCategorias"
                                class="btn btn-outline w-full">
                            Listar categorías
                        </button>

                        <!-- Botón listar aerolíneas -->
                        <button type="submit" name="action" value="listarAerolineas"
                                id="btnListarAerolineas"
                                class="btn btn-outline w-full">
                            Listar aerolíneas
                        </button>
                    </div>
                </div>

                <!-- Selector de Aerolínea (se muestra cuando el usuario lista aerolineas) -->
                <div class="form-control">
                    <label class="label"><span class="label-text">Aerolínea</span></label>
                    <select id="selAero" name="aerolinea" class="select select-bordered w-full"
                            <c:if test="${not empty categoriaSeleccionada}">disabled</c:if>>
                        <option value="">-- Seleccione --</option>
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

                <!-- Botón: Listar rutas confirmadas (este usa la selección de categoría o de aerolínea) -->
                <div class="form-control">
                    <label class="label"><span class="label-text">&nbsp;</span></label>
                    <div class="flex gap-2">
                        <button type="submit" name="action" value="listarRutas" id="btnListarRutas"
                                class="btn btn-primary w-full">Listar rutas confirmadas</button>
                    </div>
                </div>
            </div>

            <!-- Si el servidor indicó "mostrando = categorias", mostramos la lista de categorias -->
            <c:if test="${not empty mostrando and mostrando == 'categorias'}">
                <div class="mt-4">
                    <h3 class="font-semibold mb-2">Categorías</h3>
                    <div>
                        <%
                            List<String> categorias = (List<String>) request.getAttribute("categorias");
                            String catSel = (String) request.getAttribute("categoriaSeleccionada");
                            if (categorias != null && !categorias.isEmpty()) {
                        %>
                            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
                                <% for (String c : categorias) { %>
                                    <div class="card bg-base-100 shadow">
                                        <div class="card-body">
                                            <p class="font-medium mb-2"><%= c %></p>
                                            <!-- al hacer click enviamos categoria al servlet -->
                                            <button type="submit" name="categoria" value="<%= c %>" class="btn btn-outline w-full">
                                                Seleccionar categoría
                                            </button>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <%
                            } else {
                        %>
                            <p class="text-base-content/70">No hay categorías disponibles.</p>
                        <%
                            }
                        %>
                    </div>
                </div>
            </c:if>

        </div> <!-- /filtros -->

        <!-- Mostrar rutas confirmadas (resultado de listarRutas) -->
        <div class="mt-6">
            <h3 class="font-semibold mb-2">Rutas confirmadas</h3>
            <div id="rutasWrap" class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
                <%
                    List<DataTypes.DtRutaVuelo> rutasDt = (List<DataTypes.DtRutaVuelo>) request.getAttribute("rutasDt");
                    if (rutasDt != null && !rutasDt.isEmpty()) {
                        for (DataTypes.DtRutaVuelo ruta : rutasDt) {
                            String nombre = ruta.getNombre() != null ? ruta.getNombre() : ruta.toString();
                            String descripcion = ruta.getDescripcion() != null ? ruta.getDescripcion() : "";
                %>
                    <div class="card bg-base-100 shadow-xl">
                        <div class="form-control p-3">
                            <!-- este submit envía rutaId al servlet y mantiene filtros previos -->
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
                    } else {
                %>
                    <p class="col-span-full text-center text-base-content/70">No hay rutas para los filtros seleccionados.</p>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Mostrar detalles de la ruta seleccionada -->
<%
    DataTypes.DtRutaVuelo rutaDetalle = (DataTypes.DtRutaVuelo) request.getAttribute("ruta");
    if (rutaDetalle != null) {
%>
    <div class="card mt-6 p-4 rounded-md bg-base-200 shadow">
        <img src="<%= rutaDetalle.getUrlImagen() %>"
             class="object-cover transition-transform duration-500 ease-in-out hover:scale-110" />
        <h3 class="text-4xl font-semibold">
            Detalle de la ruta:
            <span class="font-normal"><%= rutaDetalle.getNombre() %></span>
        </h3>
        <table class="table-auto mt-3 w-full">
            <tr><th class="text-left pr-4">Nombre</th><td><%= rutaDetalle.getNombre() %></td></tr>
            <tr><th class="text-left pr-4">Descripción</th><td><%= rutaDetalle.getDescripcion() %></td></tr>
            <tr><th class="text-left pr-4">Fecha Alta</th><td><%= rutaDetalle.getFechaAlta() %></td></tr>
            <tr><th class="text-left pr-4">Costo Turista</th><td><%= rutaDetalle.getCostoBaseTurista() %></td></tr>
            <tr><th class="text-left pr-4">Costo Ejecutivo</th><td><%= rutaDetalle.getCostoBaseEjecutivo() %></td></tr>
            <tr><th class="text-left pr-4">Costo Equipaje Extra</th><td><%= rutaDetalle.getCostoEquipajeExtra() %></td></tr>
            <tr><th class="text-left pr-4">Origen</th><td><%= rutaDetalle.getOrigen() %></td></tr>
            <tr><th class="text-left pr-4">Destino</th><td><%= rutaDetalle.getDestino() %></td></tr>
            <tr><th class="text-left pr-4">Aerolínea</th><td><%= rutaDetalle.getAerolinea() %></td></tr>
            <tr><th class="text-left pr-4">Categoría</th><td><%= rutaDetalle.getCategoria() %></td></tr>
        </table>

        <%
          List<DtVuelo> vuelos = (List<DtVuelo>) request.getAttribute("ListaDtVuelo");
          String rutaSeleccionada = (String) request.getAttribute("rutaIdSeleccionada");
          if (vuelos != null && !vuelos.isEmpty()) {
        %>
        <div class="mt-6">
            <h3 class="font-semibold mb-2">
                Vuelos en ruta: <span class="font-normal"><%= rutaSeleccionada %></span>
            </h3>
            <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
                <%
                    for (DtVuelo v : vuelos) {
                        String vNombre = (v != null) ? v.getNombre() : "Sin nombre";
                        String vUrlImagen = (v != null) ? v.getUrlImagen() : "";
                %>
                <div class="card bg-base-100 shadow">
                    <div class="card-body">
                        <img src="<%= vUrlImagen %>" class="object-cover h-32 w-full rounded-md mb-4" />
                        <p class="font-medium mb-2"><%= vNombre %></p>
                                <a href="${pageContext.request.contextPath}/ConsultaVueloServlet?aerolinea=<%= java.net.URLEncoder.encode((String) request.getAttribute("aerolineaSeleccionada") != null ? (String) request.getAttribute("aerolineaSeleccionada") : "", "UTF-8") %>&rutaId=<%= java.net.URLEncoder.encode(rutaSeleccionada != null ? rutaSeleccionada : "", "UTF-8") %>&vueloId=<%= java.net.URLEncoder.encode(vNombre, "UTF-8") %>"
                                class="btn btn-outline w-full">
                                Ver vuelo
                                </a>
                    </div>
                </div>
                <%
                    } 
                %>
            </div>
        </div>
        <%
          } 
        %>
    </div>
<%
    } 
%>

        <input type="hidden" name="categoria" id="hiddenCategoria" value="<%= request.getAttribute("categoriaSeleccionada") != null ? request.getAttribute("categoriaSeleccionada") : "" %>"/>
        <input type="hidden" name="aerolinea" id="hiddenAerolinea" value="<%= request.getAttribute("aerolineaSeleccionada") != null ? request.getAttribute("aerolineaSeleccionada") : "" %>"/>

      </form>

      <button class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/'">Volver</button>

    </section>
   </main>

    <jsp:include page="includes/footer.jsp" />
    <jsp:include page="includes/aside.jsp" />

    <script>
        // Pequeña ayuda cliente: deshabilitar select aerolinea si se seleccionó category y viceversa
        (function(){
            const form = document.getElementById('formConsulta');
            const btnCategorias = document.getElementById('btnListarCategorias');
            const btnAerolineas = document.getElementById('btnListarAerolineas');
            const selAero = document.getElementById('selAero');
            const hiddenCat = document.getElementById('hiddenCategoria');
            const hiddenAero = document.getElementById('hiddenAerolinea');

            // Si hay una categoria seleccionada en el servidor, deshabilitar select de aerolinea
            if (hiddenCat && hiddenCat.value && hiddenCat.value.trim() !== "") {
                if (selAero) selAero.disabled = true;
            }
            if (hiddenAero && hiddenAero.value && hiddenAero.value.trim() !== "") {
                // si viene aerolinea seleccionada, no permitimos listar categorias sin resetear
            }

            // Al cambiar el select de aerolinea, colocamos el valor en hidden aerolinea
            if (selAero) {
                selAero.addEventListener('change', function(){
                    if (hiddenAero) hiddenAero.value = selAero.value;
                    // al elegir aerolinea, limpiar categoria para que no haya conflicto
                    if (hiddenCat) hiddenCat.value = "";
                });
            }
            // Si el usuario hace click en "Listar categorías" queremos que se borre la aerolinea seleccionada
            btnCategorias && btnCategorias.addEventListener('click', function(){
                if (selAero) selAero.value = "";
                if (hiddenAero) hiddenAero.value = "";
            });
            // Si hace click en "Listar aerolíneas" borramos la categoría
            btnAerolineas && btnAerolineas.addEventListener('click', function(){
                if (hiddenCat) hiddenCat.value = "";
            });

            // Cuando se envíe el form para listarRutas, aseguramos que si hay categoria en hidden lo priorizamos
            form && form.addEventListener('submit', function(e){
                // nada crítico — el servidor hace la validación — esto es solo UX ligera
            });

        })();
    </script>

</body>
</html>