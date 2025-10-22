<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.PaqueteVuelo" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

    <main class="flex flex-col items-center min-h-screen bg-base-200 text-base-content px-6 py-12">
        <div class="mt-10 w-full mx-auto max-w-4xl">
            <h1 class="text-3xl mb-2">Compra de Paquete</h1>
            <p class="text-sm mb-6">
                Bienvenido a la sección de compra de paquetes. Aquí podrás adquirir paquetes de viaje que incluyen vuelos, alojamiento y actividades turísticas a precios especiales.
            </p>

            <h2 class="text-xl mb-2">Datos del Paquete</h2>
            <p class="text-sm mb-4 text-base-content/80">
                Explora nuestros paquetes disponibles y elige el que mejor se adapte a tus necesidades. Cada paquete incluye detalles sobre el itinerario, alojamiento, transporte y actividades incluidas.
            </p>
        </div>
    
        <div class="max-w-4xl w-full mx-auto gap-4">
            <form method="post" class="grid gap-6" action="${pageContext.request.contextPath}/CompraPaqueteServlet">   
                <div>
                <label class="label">
                    <span class="label-text">Paquetes disponibles</span>
                </label>

                <select name="paquete_seleccionado" class="bg-base-200 select select-bordered w-full" onchange="this.form.submit()">
                    <option value="">Selecciona un paquete</option>
                    <%
                    List<PaqueteVuelo> paquetes = (List<PaqueteVuelo>) request.getAttribute("paquetes");
                    if (paquetes != null && !paquetes.isEmpty()) {
                        for (PaqueteVuelo paquete : paquetes) {
                    %>
                            <option value="<%= paquete.getNombre() %>">
                            <%= paquete.getNombre() %> - <%= paquete.getCostoConDescuento() %> USD
                            </option>
                    <%
                        }
                    } else {
                    %>
                        <option disabled>No hay paquetes disponibles</option>
                    <%
                    }
                    %>
                </select>

                <span class="text-xs text-gray-500 mt-2 block">
                    Si no ves el paquete que buscas, por favor contacta a nuestro soporte.
                </span>

                <%
                String errorMsg = (String) request.getAttribute("errorMsg");
                if (errorMsg != null) {
                %>
                    <span class="text-sm text-error mt-1 block"><%= errorMsg %></span>
                <%
                }
                %>
                </div>

   
<%
PaqueteVuelo seleccionado = (PaqueteVuelo) request.getAttribute("paqueteSeleccionado");
if (seleccionado != null) {
%>

<div class="card sm:max-w-sm mt-6">
  <figure class="h-48 w-full overflow-hidden">
    <img
      src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&w=1000&q=80"
      alt="Imagen del paquete"
      class="w-full h-full object-cover transition-transform duration-500 ease-in-out hover:scale-110"
    />
  </figure>

  <div class="card-body">
    <button class="card-title"><%= seleccionado.getCostoConDescuento() %> USD</button>
    <h5 class="card-title"><%= seleccionado.getNombre() %></h5>
    <p class="text-sm text-base-content/80"><%= seleccionado.getDescripcion() %></p>

    <div class="mt-2 grid grid-cols-2 sm:grid-cols-3 gap-4">
      <div>
        <p><b>Duración</b></p>
        <p class="text-sm text-base-content/70"><%= seleccionado.getDiasValidez() %> días</p>
      </div>

      <div>
        <p><b>Descuento</b></p>
        <p class="text-sm text-base-content/70"><%= seleccionado.getDescuento() %>%</p>
      </div>

      <div>
        <p><b>Alta</b></p>
        <p class="text-sm text-base-content/70"><%= seleccionado.getAltaFecha() %></p>
      </div>
    </div>
  </div>
</div>

<% } %>


                <div class="mt-4 mb-4 flex justify-between items-center">
                    <button type="button" onclick="window.location.href='/'" class="btn btn-outline rounded-full">
                        Cancelar
                    </button>

                    <button type="submit" class="btn btn-primary rounded-full">
                    Comprar Paquete
                    </button>
                </div> 
            </form>
        </div>
    </main>












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


    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

</body>
</html>