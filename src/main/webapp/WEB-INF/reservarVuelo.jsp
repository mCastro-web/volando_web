<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.*" %>
<%@ page import="DataTypes.DtVuelo" %>
<%@ page import="DataTypes.DtRutaVuelo" %>
<%@ page import="DataTypes.DtReserva" %>
<%@ page import="DataTypes.DtDatosVueloR" %>

<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />



    <main class="flex flex-col items-center min-h-screen bg-base-200 text-base-content px-6 py-12">
        <div class="mt-10 w-full mx-auto max-w-4xl">
            <h1 class="text-3xl mb-2">Reservar Vuelo</h1>
            <p class="text-sm mb-6">
                Completa el formulario para reservar tu vuelo.
            </p>
            
            <h2 class="text-xl mb-2">Datos del Vuelo</h2>
            <p class="text-sm mb-4 text-base-content/80">
                Completa los siguientes campos con la información del vuelo que deseas. 
                Asegúrate de que todos los datos sean correctos antes de continuar.
            </p>
        </div>
    
        <div class="max-w-4xl w-full mx-auto gap-4">
<form method="post" action="${pageContext.request.contextPath}/ReservarVueloServlet" class="grid gap-6">

    <div class="bg-base-200">
        <label class="label"><span class="label-text">Aerolíneas disponibles</span></label>
        <select name="aerolinea_seleccionada" class="bg-base-200 select select-bordered w-full" onchange="this.form.submit()">
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
        <span class="text-xs text-gray-500 mt-2 block"> Si no ves la aerolínea que buscas, por favor contacta a nuestro soporte.</span>
    </div>

    <%
        if (aerolineaSel != null && !aerolineaSel.isEmpty()) {
            List<String> rutas = (List<String>) request.getAttribute("rutas");
    %>
    <div>
        <label class="label"><span class="label-text">Rutas disponibles</span></label>
        <select name="ruta_seleccionada" class="bg-base-200 select select-bordered w-full" onchange="this.form.submit()">
            <option value="">Selecciona una ruta</option>
            <%
                String rutaSel = (String) request.getAttribute("rutaSeleccionada");
                if (rutas != null) {
                    for (String r : rutas) {
            %>
                <option value="<%= r %>" <%= (r.equals(rutaSel)) ? "selected" : "" %>><%= r %></option>
            <% }} %>
        </select>
        <span class="text-xs text-gray-500 mt-2 block"> Si no ves la ruta que buscas, por favor contacta a nuestro soporte.</span>
    </div>
    <% } %>

    <%
        String rutaSel = (String) request.getAttribute("rutaSeleccionada");
        if (rutaSel != null && !rutaSel.isEmpty()) {
            List<?> vuelos = (List<?>) request.getAttribute("vuelos");
    %>
    <div>
        <label class="label"><span class="label-text">Vuelos disponibles</span></label>
            <select name="vuelo_seleccionado" class="bg-base-200 select select-bordered w-full" onchange="this.form.submit()">
                <option value="">Selecciona un vuelo</option>
                <%
                    String vueloSel = (String) request.getAttribute("vueloSeleccionado");
                    if (vuelos != null) {
                        for (Object v : vuelos) {
                            DataTypes.DtDatosVueloR vueloObj = (DataTypes.DtDatosVueloR) v;
                            String nombre = vueloObj.getNombre();
                %>
                    <option value="<%= nombre %>" <%= (nombre.equals(vueloSel)) ? "selected" : "" %>><%= nombre %></option>
                <% }} %>
            </select>
        <span class="text-xs text-gray-500 mt-2 block"> Si no ves el vuelo que buscas, por favor contacta a nuestro soporte.</span>
    </div>
    <% } %>

    <%
        DtVuelo dtVuelo = (DtVuelo) request.getAttribute("dtVuelo");
        if (dtVuelo != null) {
    %>

    <div class="card sm:max-w-sm">
    <figure class="h-48 w-full overflow-hidden">
        <img
        src="<%= dtVuelo.getUrlImagen() %>"
        alt="Watch"
        class="w-full h-full object-cover transition-transform duration-500 ease-in-out hover:scale-110"
        />
    </figure>

    <div class="card-body">
        <h5 class="card-title">Detalles del Vuelo, <%= dtVuelo.getNombre() %></h5>
        <p><b>Fecha de salida</b>  <%= dtVuelo.getFecha() %></p>

        <br />

        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div>
            <p><b>Duración</b></p>
            <p class="text-sm text-base-content/70"> <%= dtVuelo.getDuracion() %></p>
        </div>

        <div>
            <p><b>Asientos Clase Turista</b></p>
            <p class="text-sm text-base-content/70"> <%= dtVuelo.getAsientosTurista() %></p>
        </div>

        <div>
            <p><b>Asientos Clase Ejecutiva</b></p>
            <p class="text-sm text-base-content/70"> <%= dtVuelo.getAsientosEjecutivo() %></p>
        </div>
        </div>
    </div>
    </div>

    <% } %>

                <div class="relative">
                    <span>Tipo de Asiento</span>
                    <select name="tipo_asiento" class="bg-base-200 select select-bordered w-full peer mt-1 pt-6">
                        <option value="" disabled selected>Selecciona un tipo de asiento</option>
                        <option>Turista</option>
                        <option>Ejecutiva</option>
                    </select>
                    <span class="text-xs text-gray-500 mt-2 block">Elige el tipo de asiento que deseas reservar.</span>
                </div>

                <div class="relative">
                    <span>Cantidad de Pasajes</span>
                    <input type="number" name="cantidad_pasajes" min="1" class="bg-base-200 input input-bordered w-full peer mt-1 pt-6" placeholder="Cantidad de Pasajes" />
                    <span class="text-xs text-gray-500 mt-2 block">Elige la cantidad de pasajes que deseas reservar.</span>
                </div>
        
                <div class="relative">
                    <span>Equipaje Extra</span>
                    <input type="number" name="equipaje_extra" min="0" class="bg-base-200 input input-bordered w-full peer mt-1 pt-6" placeholder="Cantidad de Equipaje Extra" />
                    <span class="text-xs text-gray-500 mt-2 block">Elige la cantidad de equipaje extra que deseas incluir.</span>
                </div>

                <% if (request.getAttribute("cantPasajeros") != null) { %>
                    <%
                    Integer cantPasajeros = (Integer) request.getAttribute("cantPasajeros");
                    for (int i = 1; i <= cantPasajeros; i++) {
                %>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 w-full">
                        
                        <div class="relative">
                            <span>Nombre Pasajero <%= i %></span>
                            <input type="text" name="nombre<%= i %>" class="bg-base-200 input input-bordered w-full peer mt-1 pt-6" placeholder="Nombre" />
                            <span class="text-xs text-gray-500 mt-2 block">Ingresa tu nombre completo.</span>
                        </div>
                        <div class="relative">
                            <span>Apellido Pasajero <%= i %></span>
                            <input type="text" name="apellido<%= i %>" class="bg-base-200 input input-bordered w-full peer mt-1 pt-6" placeholder="Apellido" />
                            <span class="text-xs text-gray-500 mt-2 block">Ingresa tu apellido completo.</span>
                        </div>
                    </div>
                    <% } %>
                <% } %>

                <div class="relative">
                    <span>Metodo de Pago</span>
                    <select name="metodo_pago" class="select bg-base-200 select-bordered w-full peer mt-1 pt-6">
                        <option value="" disabled selected>Selecciona un método de pago</option>
                        <option>Pago General Débito/Crédito</option>
                        <option>Pago con Paquete ya Comprado</option>
                    </select>
                    <span class="text-xs text-gray-500 mt-2 block">Elige el método de pago que deseas utilizar.</span>
                </div>

                


               <!--  <div class="relative">
                    <span>Paquete a Descontar</span>
                    <select name="paquete_descuento" class="select select-bordered w-full peer mt-1 pt-6">
                        <option value="" disabled selected>Selecciona un paquete a descontar</option>
                        <option>Paquete 1</option>
                        <option>Paquete 2</option>
                    </select>
                    <span class="text-xs text-gray-500 mt-2 block">Elige el paquete que deseas descontar.</span>
                </div>-->

                <%
                    Integer resumenCant = (Integer) request.getAttribute("cantPasajeros");
                    if (resumenCant == null) {
                        String cp = request.getParameter("cantidad_pasajes");
                        try { resumenCant = (cp != null && !cp.isEmpty()) ? Integer.valueOf(cp) : null; } catch (Exception e) { resumenCant = null; }
                    }
                    String resumenTipo = request.getParameter("tipo_asiento");
                    if (resumenTipo == null) resumenTipo = (String) request.getAttribute("tipoAsiento");
                    String resumenEquipaje = request.getParameter("equipaje_extra");
                    if (resumenEquipaje == null) resumenEquipaje = (String) request.getAttribute("equipajeExtra");
                    String resumenMonto = (String) request.getAttribute("montoTotal");
                %>

                <div class="card bg-base-100 w-full">
                  <div class="card-body">
                    <h5 class="card-title">Resumen de Compra</h5>
                    <hr class="mt-2">
                    <div class="grid grid-cols-2 gap-2 py-2">
                      <div class="text-sm text-base-content/80">Cantidad de Pasajeros</div>
                      <div class="text-sm font-medium text-right"><%= (resumenCant != null) ? resumenCant : "-" %></div>

                      <div class="text-sm text-base-content/80">Tipo de Pasaje</div>
                      <div class="text-sm font-medium text-right"><%= (resumenTipo != null && !resumenTipo.isEmpty()) ? resumenTipo : "-" %></div>

                      <div class="text-sm text-base-content/80">Equipaje Extra</div>
                      <div class="text-sm font-medium text-right"><%= (resumenEquipaje != null && !resumenEquipaje.isEmpty()) ? resumenEquipaje : "0" %></div>

                      <div class="text-sm text-base-content/80">Monto Total</div>
                      <div class="text-sm font-bold text-right"><%= (resumenMonto != null && !resumenMonto.isEmpty()) ? resumenMonto : "-" %></div>
                    </div>

                    <p class="text-xs text-gray-500 mt-2">Revisa los datos antes de continuar con la reserva.</p>
                  </div>
                </div>

                <div class="mt-4 mb-4 flex justify-between items-center">
                    <button type="button" onclick="window.location.href='/'" class="btn btn-outline rounded-full">
                        Cancelar
                    </button>

                    <button type="submit" class="btn btn-primary rounded-full">
                    Reservar Vuelo
                    </button>
                </div> 
</form>
        </div>
    </main>

    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <script>
    const notyf = new Notyf({
      duration: 2000,
      position: { x: 'right', y: 'bottom' }
    });

    <%
      String ok = (String) request.getAttribute("notyf_success");
      String err = (String) request.getAttribute("notyf_error");
      if (ok != null) { %>
        notyf.success("<%= ok %>");
      <% } else if (err != null) { %>
        notyf.error("<%= err %>");
      <% } %>
    </script>

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>