<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, publicadores.DtRutaVuelo" %>
<%@ page import="java.util.List, publicadores.DtVuelo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <jsp:include page="includes/nav.jsp" />

    <main class="flex flex-1 p-4 gap-4">
<section class="flex-1 bg-base-200 p-4  space-y-6 flex flex-col items-center align-center">

    <div class="w-full max-w-4xl mx-auto flex flex-col items-center text-start">
        <h1 class="text-3xl mb-2 text-start">Consulta de Rutas</h1>
        <p class="text-sm mb-6 text-start">
            Bienvenido a la sección de consulta de rutas. Aquí podrás buscar y seleccionar las rutas que mejor se adapten a tus necesidades.
        </p>
    </div>

    <!-- Form principal: usamos GET para facilitar bookmark / navegación -->
    <form action="${pageContext.request.contextPath}/ConsultaRutaVueloServlet" method="get" id="formConsulta" class="w-full max-w-4xl mx-auto flex flex-col items-center">

        <!-- FILTROS: aquí va el bloque que pediste (antes 'Rol') -->
        <div class="rounded-box p-4 space-y-4">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">

                <!-- BLOQUE: Listar categorías -->
                <div class="form-control flex flex-col gap-4">
                    <label class="label"><span class="label-text font-bold">Categorías</span></label>
<select id="selCatList" name="categoria"
        class="select select-bordered w-full bg-base-200"
        <c:if test="${not empty aerolineaSeleccionada}">disabled</c:if>>

                        <option value="">Seleccione una Categoría</option>
                        <%
                            List<String> categorias = (List<String>) request.getAttribute("categorias");
                            String catSel = (String) request.getAttribute("categoriaSeleccionada");
                            if (categorias != null && !categorias.isEmpty()) {
                                for (String c : categorias) {
                        %>
                            <option value="<%= c %>" <%= c.equals(catSel) ? "selected" : "" %>><%= c %></option>
                        <%
                                }
                            } else {
                        %>
                            <option value="">No hay categorías disponibles</option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <!-- BLOQUE: Listar aerolíneas + selector -->
                <div class="form-control flex flex-col gap-2">
                    <label class="label"><span class="label-text font-bold">Aerolínea</span></label>
<select id="selAero" name="aerolinea"
        class="select select-bordered w-full bg-base-200"
        <c:if test="${not empty categoriaSeleccionada}">disabled</c:if>>

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

                <!-- BLOQUE: Listar rutas confirmadas -->
                <div class="form-control">
                    <label class="label"><span class="label-text">&nbsp;</span></label>
                    <div class="flex gap-2">
                        <button type="submit" name="action" value="listarRutas" id="btnListarRutas"
                                class="btn btn-primary w-full">Listar Rutas Confirmadas</button>
                    </div>
                </div>

            </div>
        </div>  

        <!-- Mostrar rutas confirmadas (resultado de listarRutas) -->
        <div class="mt-6">
            <h3 class="font-semibold mb-2">Rutas Confirmadas</h3>
            <div id="rutasWrap" class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
                <%
                    List<DtRutaVuelo> rutasDt = (List<DtRutaVuelo>) request.getAttribute("rutasDt");
                    if (rutasDt != null && !rutasDt.isEmpty()) {
                        for (DtRutaVuelo ruta : rutasDt) {
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
    DtRutaVuelo rutaDetalle = (DtRutaVuelo) request.getAttribute("ruta");
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
            String rawUrl = rutaDetalle.getUrlVideo();
            String embedUrl = rawUrl;

            if (rawUrl != null && rawUrl.contains("watch?v=")) {
                embedUrl = rawUrl.replace("watch?v=", "embed/");
            }
        %>

        <iframe 
            src="<%= embedUrl %>" 
            width="560" height="315" 
            frameborder="0" 
            allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" 
            allowfullscreen>
        </iframe>

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
    
    <div class="flex justify-start mt-10">
    <button id="btnVolver" class="btn btn-outline rounded-full">Realizar Nueva Consulta</button>
    </div>

    </section>
   </main>

    <jsp:include page="includes/footer.jsp" />
    <jsp:include page="includes/aside.jsp" />

 <script>
(function () {
    const selAero = document.getElementById("selAero");
    const selCat = document.getElementById("selCatList");

    const hiddenCat = document.getElementById("hiddenCategoria");
    const hiddenAero = document.getElementById("hiddenAerolinea");

    const btnListar = document.getElementById("btnListarRutas");
    const form = document.getElementById("formConsulta");

    // CUANDO CAMBIA AEROLÍNEA → bloquear categoría
    if (selAero) {
        selAero.addEventListener("change", () => {
            hiddenAero.value = selAero.value;
            hiddenCat.value = "";

            selCat.disabled = selAero.value.trim() !== "";
        });
    }

    // CUANDO CAMBIA CATEGORÍA → bloquear aerolínea
    if (selCat) {
        selCat.addEventListener("change", () => {
            hiddenCat.value = selCat.value;
            hiddenAero.value = "";

            selAero.disabled = selCat.value.trim() !== "";
        });
    }

    // Estado inicial basado en hidden
    if (hiddenAero.value && hiddenAero.value.trim() !== "") {
        selCat.disabled = true;
    }
    if (hiddenCat.value && hiddenCat.value.trim() !== "") {
        selAero.disabled = true;
    }

if (btnVolver) {
    btnVolver.addEventListener("click", (e) => {
        e.preventDefault();

        // Limpiar selects
        selAero.value = "";
        selCat.value = "";

        // Limpiar hidden fields
        hiddenAero.value = "";
        hiddenCat.value = "";

        // Desbloquear ambos
        selAero.disabled = false;
        selCat.disabled = false;

        // Redirigir
        window.location.href = `${pageContext.request.contextPath}/ConsultaRutaVueloServlet`;
    });
}

})();
</script>


</body>
</html>
