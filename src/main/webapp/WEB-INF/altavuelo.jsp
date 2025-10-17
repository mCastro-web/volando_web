<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />


<main class="flex flex-1 p-4 gap-4">

  <!-- Contenido central -->
  <section class="flex-1 bg-base-100 p-4 rounded-lg shadow-md space-y-6">
    <h2 class="text-2xl font-bold text-center">Alta de Vuelo</h2>

    <!-- SELECCIÓN DE RUTA -->
    <div class="rounded-box border p-4">
      <h3 class="font-semibold mb-3">1) Seleccionar Ruta de Vuelo</h3>

      <div role="tablist" class="tabs tabs-boxed mb-4">
        <button id="tab-rapido" role="tab" class="tab tab-active">Rápido (por nombre)</button>
        <button id="tab-carrusel" role="tab" class="tab">Carrusel</button>
      </div>

<div id="modo-rapido">
  <label class="label">
    <span class="label-text">Seleccioná la ruta</span>
  </label>

  <select id="buscarRuta" name="ruta" class="select select-bordered w-full bg-base-200">
    <option value="" disabled selected>-- Seleccionar ruta --</option>
    <%
      List<String> rutas = (List<String>) session.getAttribute("rutas");
      if (rutas != null && !rutas.isEmpty()) {
          for (String ruta : rutas) {
    %>
            <option value="<%= ruta %>"><%= ruta %></option>
    <%
          }
      } else {
    %>
          <option disabled>No hay rutas disponibles</option>
    <%
      }
    %>
  </select>
</div>

      <!-- Modo Carrusel (NUEVO FORMATO con thumbnails) -->
      <div id="modo-carrusel" class="hidden">
        <div id="horizontal-thumbnails" data-carousel='{ "loadingClasses": "opacity-0" }' class="relative w-full">
          <div class="carousel">
            <!-- Slides -->
            <div id="carouselBody" class="carousel-body h-64 md:h-80 opacity-0">
              <!-- slides dinámicos -->
            </div>

            <!-- Thumbnails -->
            <div id="carouselPagination" class="carousel-pagination bg-base-100 absolute bottom-0 end-0 start-0 z-1 h-20 md:h-24 flex justify-center gap-2 overflow-x-auto pt-2">
              <!-- thumbs dinámicos -->
            </div>

            <!-- Prev/Next -->
            <button id="btnPrev" type="button" class="carousel-prev start-5 max-sm:start-3 carousel-disabled:opacity-50 size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow-base-300/20 shadow-sm">
              <span class="icon-[tabler--chevron-left] size-5 cursor-pointer"></span>
              <span class="sr-only">Previous</span>
            </button>
            <button id="btnNext" type="button" class="carousel-next end-5 max-sm:end-3 carousel-disabled:opacity-50 size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow-base-300/20 shadow-sm">
              <span class="icon-[tabler--chevron-right] size-5"></span>
              <span class="sr-only">Next</span>
            </button>
          </div>
        </div>

        <div id="seleccionRutaCarrusel" class="mt-3 text-sm text-base-content/70"></div>
      </div>

      <!-- Índice oculto -->
      <input type="hidden" id="rutaIndexSeleccionada" />
    </div>

    <!-- FORMULARIO ALTA DE VUELO -->
    <form id="formVuelo" class="space-y-6 max-w-md mx-auto"  action="AltaVueloServlet" method="post" >
      <div class="input-floating">
        <input type="text" id="nombreVuelo" name="nombreVuelo" placeholder="Nombre del vuelo" class="input input-bordered w-full" required />
        <label class="input-floating-label" for="nombreVuelo">Nombre de Vuelo (único)</label>
      </div>
      <div class="mt-3"></div>

      <div class="input-floating">
        <input type="date" id="fechaVuelo" name="fechaVuelo" class="input input-bordered w-full" required />
        <label class="input-floating-label" for="fechaVuelo">Fecha del Vuelo</label>
      </div>
      <div class="mt-3"></div>  

      <div class="input-floating">
        <input type="time" id="duracion" name="duracion" step="60" class="input input-bordered w-full" required />
        <label class="input-floating-label" for="duracion">Duración (HH:MM)</label>
      </div>
      <div class="mt-3"></div> 

      <div class="input-floating">
        <input type="number" id="asientosTurista" name="asientosTurista" min="0" step="1" class="input input-bordered w-full" placeholder="0" required />
        <label class="input-floating-label" for="asientosTurista">Asientos máx. Turista</label>
      </div>
      <div class="mt-3"></div> 

      <div class="input-floating">
        <input type="number" id="asientosEjecutivo" name="asientosEjecutivo" min="0" step="1" class="input input-bordered w-full" placeholder="0" required />
        <label class="input-floating-label" for="asientosEjecutivo">Asientos máx. Ejecutivo</label>
      </div>
      <div class="mt-3"></div> 

      <div class="form-control">
        <label class="label"><span class="label-text">Imagen del vuelo (opcional)</span></label>
        <input type="file" id="imagenVuelo" name="imagenVuelo" accept="image/*" class="file-input file-input-bordered w-full" />
        <img id="preview" class="mt-3 rounded-lg max-h-40 hidden" alt="Previsualización">
      </div>
      <div class="mt-3"></div>

      <button class="btn btn-primary btn-block" type="submit" name="btnConfirmar" id="btnConfirmar">Confirmar</button>
      <div class="mt-3"></div>
      <button type="button" class="btn btn-ghost btn-block" onclick="window.location.href='../views/index.html'">Cancelar</button>

      <div id="msg" class="text-sm mt-3"></div>
    </form>
  </section>
</main>




    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />







    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>