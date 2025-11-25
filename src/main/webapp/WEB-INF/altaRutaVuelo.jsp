<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">

  <!-- Barra de Navegacion --> 
  <jsp:include page="includes/nav.jsp" />

    <main class="flex flex-1 p-4 gap-4 bg-base-200">

<section class="flex-1 bg-base-200 p-4 rounded-lg  space-y-4">

            <div class="mt-10 w-full mx-auto    max-w-4xl">
                <h1 class="text-3xl mb-2">Crear Ruta de Vuelo</h1>
                <p class="text-sm mb-6">
                    Completa el formulario para <b>crear una nueva ruta de vuelo</b> en el sistema.
                </p>
                
            </div>

      <!-- Formulario -->
      <form action="${pageContext.request.contextPath}/AltaRutaVueloServlet" method="post" enctype="multipart/form-data" class="max-w-4xl w-full mx-auto gap-4 base-200 mt-4 grid mx-auto">
        
      <label class=" mt-2 form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Nombre</span>
        </div>
        <input required id="nombreRuta" name="nombreRuta" type="text" placeholder="Ingresa el nombre de la ruta" class="input input-bordered w-full bg-base-200" />
        <span class="label-text-alt text-xs opacity-70">El nombre debe ser representativo de la Ruta.</span>
      </label>

        <label class="mt-2 form-control w-full">
          <div class="label">
            <span class="label-text font-medium">Descripción corta</span>
          </div>
          <input required id="descripcionCorta" name="descripcionCorta" type="text" placeholder="Ingresa una breve descripción" class="input input-bordered w-full bg-base-200" />
          <span class="label-text-alt text-xs opacity-70">Breve resumen de la ruta (máx. 100 caracteres recomendado).</span>
        </label>

        <label class="mt-2 form-control w-full">
          <div class="label">
            <span class="label-text font-medium">Descripción</span>
          </div>
          <textarea name="descripcion" class="textarea textarea-bordered w-full bg-base-200" required placeholder="Describe la ruta en detalle"></textarea>
          <span class="label-text-alt text-xs opacity-70">Descripción completa de la ruta (máx. 500 caracteres recomendado).</span>
        </label>

          <label class="mt-2 form-control w-full">
              <div class="label">
                  <span class="label-text font-medium">URL del video promocional</span>
              </div>
              <input id="urlVideo" name="urlVideo" type="text" placeholder="https://youtube.com/..."
                     class="input input-bordered w-full bg-base-200" />
              <span class="label-text-alt text-xs opacity-70">URL opcional de un video explicativo o promocional.</span>
          </label>

          <label class="mt-2 form-control w-full">
          <div class="label">
            <span class="label-text font-medium">Costo turista</span>
          </div>
          <input type="number" step="0.01" min="0" name="costoTurista" class="input input-bordered w-full bg-base-200" required />
          <span class="label-text-alt text-xs opacity-70">Precio por pasajero en clase turista.</span>
        </label>

        <label class="mt-2 form-control w-full">
          <div class="label">
            <span class="label-text font-medium">Costo ejecutivo</span>
          </div>
          <input type="number" step="0.01" min="0" name="costoEjecutivo" class="input input-bordered w-full bg-base-200" required />
          <span class="label-text-alt text-xs opacity-70">Precio por pasajero en clase ejecutiva.</span>
        </label>

        <label class="mt-2 form-control w-full">
          <div class="label">
            <span class="label-text font-medium">Costo equipaje extra</span>
          </div>
          <input type="number" step="0.01" min="0" name="costoEquipajeExtra" class="input input-bordered w-full bg-base-200" required />
          <span class="label-text-alt text-xs opacity-70">Costo por unidad de equipaje adicional.</span>
        </label>

        <label class="mt-2 form-control w-full">
          <div class="label">
            <span class="label-text font-medium">Ciudad de origen</span>
          </div>
          <select id="ciudadOrigen" name="ciudadOrigen" class="select select-bordered w-full bg-base-200" required>
            <option disabled selected value="">Seleccione una ciudad</option>
            <c:forEach var="c" items="${ciudades}">
              <option value="${c}">${c}</option>
            </c:forEach>
          </select>
          <span class="label-text-alt text-xs opacity-70">Selecciona la ciudad de salida.</span>
        </label>

        <label class="mt-2 form-control w-full">
          <div class="label">
            <span class="label-text font-medium">Ciudad de destino</span>
          </div>
          <select id="ciudadDestino" name="ciudadDestino" class="select select-bordered w-full bg-base-200" required>
            <option disabled selected value="">Seleccione una ciudad</option>
            <c:forEach var="c" items="${ciudades}">
              <option value="${c}">${c}</option>
            </c:forEach>
          </select>
          <span class="label-text-alt text-xs opacity-70">Selecciona la ciudad de llegada.</span>
        </label>

        <label class="mt-2 form-control w-full">
          <div class="label">
            <span class="label-text font-medium">Categoría</span>
          </div>
          <select id="categorias" name="categorias" class="select select-bordered w-full bg-base-200" required>
            <option disabled selected  value="">Seleccione una categoría</option>
            <c:forEach var="cat" items="${categorias}">
              <option value="${cat}">${cat}</option>
            </c:forEach>
          </select>
          <span class="label-text-alt text-xs opacity-70">Elige la categoría que mejor describa la ruta.</span>
        </label>


      <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Foto Representativa</span>
        </div>
        <input required type="file" name="fotoRepresentativa" id="fotoRepresentativa" accept="image/*" class="input input-bordered w-full bg-base-200" required />
        <div class="label">
          <span class="label-text-alt text-xs opacity-70">Sube una foto representativa de la ruta.</span>
        </div>
      </label>

<div class="mt-4 mb-4 flex justify-between items-center">
  <!-- Botón Cancelar -->
  <button
    type="button"
    onclick="window.location.href='/'"
    class="btn btn-outline rounded-full"
  >
    Cancelar
  </button>

  <!-- Botón Crear cuenta -->
  <button
    type="submit"
    class="btn btn-primary rounded-full"
  >
    Crear Ruta
  </button>
</div>

      </form>
    </div>
            </section>

  </main>

  <!-- Footer--> 
  <jsp:include page="includes/footer.jsp" />

  <!-- Menu Hamburguesa -->
  <jsp:include page="includes/aside.jsp" />

    <script>
    const notyf = new Notyf({
      duration: 2000,
      position: { x: 'right', y: 'top' }
    });

    <%
      String ok = (String) request.getAttribute("notyf_success_ARV");
      String err = (String) request.getAttribute("notyf_error_ARV");
      if (ok != null) { %>
        notyf.success("<%= ok %>");
      <% } else if (err != null) { %>
        notyf.error("<%= err %>");
      <% } %>
    </script>

  <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>

</body>
</html>