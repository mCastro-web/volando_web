<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.*" %>
<%@ page import="publicadores.DtVuelo" %>
<%@ page import="publicadores.DtRutaVuelo" %>
<%@ page import="publicadores.DtReserva" %>
<%@ page import="publicadores.DtDatosVueloR" %>
<%@ page import="publicadores.TipoAsiento" %>


<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">

    <!-- Barra de Navegación -->
    <jsp:include page="includes/nav.jsp" />

    <main class="flex flex-col items-center min-h-screen bg-base-200 text-base-content px-6 py-12">
        <div class="mt-10 w-full mx-auto max-w-4xl">
            <h1 class="text-3xl mb-2">Reservar Vuelo</h1>
            <p class="text-sm mb-6">Completa el formulario para reservar tu vuelo.</p>
        </div>

        <div class="max-w-4xl w-full mx-auto gap-4">
<form method="post" action="${pageContext.request.contextPath}/ReservarVueloServlet" class="grid gap-6">

    <!-- Aerolínea -->
    <div>
        <label class="label"><span class="label-text">Aerolíneas disponibles</span></label>
        <select name="aerolinea_seleccionada" class="select select-bordered w-full bg-base-200"
                onchange="refrescar('aerolinea_seleccionada', this.value)">
            <option value="">Selecciona una aerolínea</option>
            <%
                List<String> aerolineas = (List<String>) request.getAttribute("aerolineas");
                String aerolineaSel = (String) request.getAttribute("aerolineaSeleccionada");
                if (aerolineas != null) {
                    for (String a : aerolineas) {
            %>
                <option value="<%= a %>" <%= (a.equals(aerolineaSel)) ? "selected" : "" %>><%= a %></option>
            <% }} %>
        </select>
    </div>

    <!-- Ruta -->
    <%
        if (aerolineaSel != null && !aerolineaSel.isEmpty()) {
            List<String> rutas = (List<String>) request.getAttribute("rutas");
    %>
    <div>
        <label class="label"><span class="label-text">Rutas disponibles</span></label>
        <select name="ruta_seleccionada" class="select select-bordered w-full bg-base-200"
                onchange="refrescar('ruta_seleccionada', this.value)">
            <option value="">Selecciona una ruta</option>
            <%
                String rutaSel = (String) request.getAttribute("rutaSeleccionada");
                if (rutas != null) {
                    for (String r : rutas) {
            %>
                <option value="<%= r %>" <%= (r.equals(rutaSel)) ? "selected" : "" %>><%= r %></option>
            <% }} %>
        </select>
    </div>
    <% } %>

    <!-- Vuelo -->
    <%
        String rutaSel = (String) request.getAttribute("rutaSeleccionada");
        if (rutaSel != null && !rutaSel.isEmpty()) {
            List<?> vuelos = (List<?>) request.getAttribute("vuelos");
    %>
    <div>
        <label class="label"><span class="label-text">Vuelos disponibles</span></label>
        <select name="vuelo_seleccionado" class="select select-bordered w-full bg-base-200"
                onchange="refrescar('vuelo_seleccionado', this.value)">
            <option value="">Selecciona un vuelo</option>
            <%
                String vueloSel = (String) request.getAttribute("vueloSeleccionado");
                if (vuelos != null) {
                    for (Object v : vuelos) {
                        DtDatosVueloR vueloObj = (DtDatosVueloR) v;
                        String nombre = vueloObj.getNombre();
            %>
                <option value="<%= nombre %>" <%= (nombre.equals(vueloSel)) ? "selected" : "" %>><%= nombre %></option>
            <% }} %>
        </select>
    </div>
    <% } %>

    <!-- Detalles del vuelo seleccionado -->
    <%
        DtVuelo dtVuelo = (DtVuelo) request.getAttribute("dtVuelo");
        if (dtVuelo != null) {
    %>
    <div class="card sm:max-w-sm">
        <figure class="h-48 w-full overflow-hidden">
            <img src="<%= dtVuelo.getUrlImagen() %>" alt="Imagen Vuelo"
                 class="w-full h-full object-cover transition-transform duration-500 ease-in-out hover:scale-110" />
        </figure>
        <div class="card-body">
            <h5 class="card-title">Detalles del Vuelo <%= dtVuelo.getNombre() %></h5>
            <p><b>Fecha de salida:</b> <%= dtVuelo.getFecha() %></p>
            <p><b>Duración:</b> <%= dtVuelo.getDuracion() %></p>
            <p><b>Asientos Turista:</b> <%= dtVuelo.getAsientosTurista() %></p>
            <p><b>Asientos Ejecutiva:</b> <%= dtVuelo.getAsientosEjecutivo() %></p>
        </div>
    </div>
    <% } %>

    <!-- Datos de reserva -->
    <div>
        <label>Tipo de Asiento</label>
        <select name="tipo_asiento" class="select select-bordered w-full bg-base-200">
            <option value="" disabled selected>Selecciona un tipo de asiento</option>
            <option>Turista</option>
            <option>Ejecutiva</option>
        </select>
    </div>

    <div>
        <label>Cantidad de Pasajes</label>
        <input type="number" name="cantidad_pasajes" min="1"
               value="<%= request.getAttribute("cantPasajeros") != null ? request.getAttribute("cantPasajeros") : 1 %>"
               class="input input-bordered w-full bg-base-200" />
    </div>

    <div>
        <label>Equipaje Extra</label>
        <input type="number" name="equipaje_extra" min="0"
               value="<%= request.getAttribute("equipaje_extra") != null ? request.getAttribute("equipaje_extra") : 0 %>"
               class="input input-bordered w-full bg-base-200" />
    </div>

    <!-- Pasajeros -->
    <% if (request.getAttribute("cantPasajeros") != null) {
        Integer cantPasajeros = (Integer) request.getAttribute("cantPasajeros");
        for (int i = 1; i <= cantPasajeros; i++) { %>
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
                <label>Nombre Pasajero <%= i %></label>
                <input type="text" name="nombre<%= i %>" placeholder="Nombre"
                       class="input input-bordered w-full bg-base-200" />
            </div>
            <div>
                <label>Apellido Pasajero <%= i %></label>
                <input type="text" name="apellido<%= i %>" placeholder="Apellido"
                       class="input input-bordered w-full bg-base-200" />
            </div>
        </div>
    <% }} %>

    <div>
        <label>Método de Pago</label>
        <select name="metodo_pago" class="select select-bordered w-full bg-base-200"
                onchange="refrescar('metodo_pago', this.value)">
            <option value="" disabled <%= (request.getParameter("metodo_pago") == null ? "selected" : "") %>>
                Selecciona un método de pago
            </option>
            <option value="debito_credito"
                    <%= "debito_credito".equals(request.getParameter("metodo_pago")) ? "selected" : "" %>>
                Pago General Débito/Crédito
            </option>
            <option value="paquete_comprado"
                    <%= "paquete_comprado".equals(request.getParameter("metodo_pago")) ? "selected" : "" %>>
                Pago con Paquete Comprado
            </option>
        </select>
    </div>

    <%
    String metodoPagoSel = request.getParameter("metodo_pago");
    if ("paquete_comprado".equalsIgnoreCase(metodoPagoSel)) {
        List<String> paquetesCliente = (List<String>) request.getAttribute("paquetesCliente");
    %>
<div>
    <label>Selecciona un Paquete Comprado</label>
    <select name="paquete_seleccionado" class="select select-bordered w-full bg-base-200">
        <option value="" disabled selected>Selecciona un paquete disponible</option>

        <% if (paquetesCliente != null && !paquetesCliente.isEmpty()) {
               for (String paq : paquetesCliente) {
                   String nombrePaq = paq.trim();
                   String id = "";

                   // Buscar el número (ID) al final del string
                   int lastDigitIndex = -1;
                   for (int i = nombrePaq.length() - 1; i >= 0; i--) {
                       if (Character.isDigit(nombrePaq.charAt(i))) {
                           lastDigitIndex = i;
                       } else {
                           break;
                       }
                   }

                   if (lastDigitIndex != -1) {
                       id = nombrePaq.replaceAll("\\D", ""); // elimina todo lo NO numérico
                       nombrePaq = nombrePaq.substring(0, lastDigitIndex).trim(); // solo el nombre
                   }
        %>
            <option value="<%= id %>"><%= nombrePaq %></option>
        <%     }
           } else { %>
            <option disabled>No tienes paquetes comprados</option>
        <% } %>
    </select>
</div>
<% } %>

    <%
Boolean rutaEnPaquete = (Boolean) request.getAttribute("rutaEnPaquete");
if (rutaEnPaquete != null && rutaEnPaquete) {

    // ✅ Estos vienen como atributos, no parámetros
    Integer cantidad_pasajes = (Integer) request.getAttribute("cantidadPasajerosPaquete");
    if (cantidad_pasajes == null) cantidad_pasajes = 1;

    Integer cantPasajeros = (Integer) request.getAttribute("cantPasajeros");
    if (cantPasajeros == null) cantPasajeros = 1;

    // ✅ Ahora casteamos correctamente los enums
    TipoAsiento tipoAsiento = (TipoAsiento) request.getAttribute("tipoDeAsiento");
    TipoAsiento tipoAsientoSeleccionado = (TipoAsiento) request.getAttribute("tipoAsiento");

    // --- Depuración opcional ---
    System.out.println("Tipo de asiento del paquete: " + tipoAsiento);
    System.out.println("Tipo de asiento seleccionado: " + tipoAsientoSeleccionado);
    System.out.println("Pasajes disponibles en paquete: " + cantidad_pasajes);
    System.out.println("Pasajeros solicitados: " + cantPasajeros);

    // ✅ Comparación directa entre enums
    if (tipoAsiento != null && tipoAsientoSeleccionado != null
        && tipoAsiento == tipoAsientoSeleccionado
        && cantPasajeros >= cantidad_pasajes) {
%>
        <button type="submit" class="btn btn-primary rounded-full"
                onclick="document.getElementById('confirmar').value='true'">
            Reservar Vuelo
        </button>
<%
    }
}
%>



    <!-- Resumen -->
    <div class="card bg-base-100 w-full">
        <div class="card-body">
            <h5 class="card-title">Resumen de Compra</h5>
            <hr>
            <div class="grid grid-cols-2 gap-2 py-2">
                <div class="text-sm text-base-content/80">Cantidad de Pasajeros</div>
                <div class="text-sm font-medium text-right">
                    <%= request.getAttribute("cantPasajeros") != null ? request.getAttribute("cantPasajeros") : 1 %>
                </div>
                <div class="text-sm text-base-content/80">Tipo de Pasaje</div>
                <div class="text-sm font-medium text-right">
                    <%= request.getParameter("tipo_asiento") != null ? request.getParameter("tipo_asiento") : "-" %>
                </div>
                <div class="text-sm text-base-content/80">Equipaje Extra</div>
                <div class="text-sm font-medium text-right">
                    <%= request.getAttribute("equipaje_extra") != null ? request.getAttribute("equipaje_extra") : 0 %>
                </div>
                <div class="text-sm text-base-content/80">Monto Total</div>
                <div class="text-sm font-bold text-right">
                    <%= request.getAttribute("montoTotal") != null ? request.getAttribute("montoTotal") : "-" %>
                </div>
            </div>
        </div>
    </div>

    <input type="hidden" name="confirmar" id="confirmar" value="">
    <div class="mt-4 mb-4 flex justify-between items-center">
        <button type="button" onclick="window.location.href='/'" class="btn btn-outline rounded-full">Cancelar</button>
        <button type="submit" class="btn btn-primary rounded-full"
                onclick="document.getElementById('confirmar').value='true'">
            Reservar Vuelo
        </button>
    </div>
</form>
        </div>
    </main>

    <jsp:include page="includes/footer.jsp" />

    <script>
function refrescar(param, valor) {
    const form = document.querySelector("form");
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = param;
    input.value = valor;
    form.appendChild(input);
    form.submit(); // envía el formulario con todos los datos actuales
}

    const notyf = new Notyf({ duration: 2000, position: { x: 'right', y: 'bottom' } });
    <% String ok = (String) request.getAttribute("notyf_success");
       String err = (String) request.getAttribute("notyf_error");
       if (ok != null) { %> notyf.success("<%= ok %>");
       <% } else if (err != null) { %> notyf.error("<%= err %>");
       <% } %>
    </script>

    <jsp:include page="includes/aside.jsp" />
    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>
