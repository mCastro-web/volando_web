<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />


<main class="flex flex-1 p-4 gap-4">

  <!-- Contenido central -->
    <section class="flex-1 bg-base-200 p-4 rounded-lg  space-y-4">
  <div class=" w-full mx-auto    max-w-4xl">
    <h1 class="text-3xl mb-2">Crear Vuelo</h1>
    <p class="text-sm mb-6">
Completa el formulario para crear un nuevo vuelo en la plataforma VolandoUy.
    </p>
    

    <!-- Subtítulo -->
    <h2 class="text-xl">Datos del Vuelo</h2>
    <p class="text-sm mb-4 text-base-content/80">
      Proporciona la información necesaria para registrar un nuevo vuelo, incluyendo detalles como la ruta, fecha, duración y capacidad de asientos.
      Asegúrate de que todos los campos estén correctamente llenados antes de enviar el formulario.

    </p>
  </div>






    <form class="mt-10 max-w-4xl w-full mx-auto gap-4 bg-base-200  space-y-6 mx-auto"  action="AltaVueloServlet" enctype="multipart/form-data" method="post" >

                  <!-- Rutas -->
                  <div class="relative">
                    <span>Rutas Disponibles</span>
                      <select name="ruta" class="bg-base-200 select select-bordered w-full peer mt-1 pt-6">
                        <option value="" disabled selected>Selecciona una ruta</option>
                        <c:forEach var="c" items="${sessionScope.rutas}">
                          <option value="${c}">${c}</option>
                        </c:forEach>
                      </select>
                    <span class="text-xs text-gray-500 mt-2 block">Elige la ruta que deseas utilizar.</span>
                  </div>




      <div class="relative bg-base-200 ">
        <span>Nombre del vuelo</span>
        <input type="text" id="nombreVuelo" name="nombreVuelo" placeholder="Nombre del vuelo" class="bg-base-200 input input-bordered w-full peer mt-1 pt-6" required />
        <span class="text-xs text-gray-500 mt-2 block">El nombre del vuelo debe ser único.</span>
      </div>

      <div class="relative mt-3">
        <span>Fecha del Vuelo</span>
        <input type="date" id="fechaVuelo" name="fechaVuelo" class="bg-base-200  input input-bordered w-full peer mt-1 pt-6" required />
        <span class="text-xs text-gray-500 mt-2 block">Selecciona la fecha del vuelo.</span>
      </div>

      <div class="relative mt-3">
        <span>Duración</span>
        <input type="number" id="duracion" name="duracion" class="bg-base-200  input input-bordered w-full peer mt-1 pt-6" required />
        <span class="text-xs text-gray-500 mt-2 block">Introduce la duración en minutos (ej. 90 = 1:30).</span>
      </div>

      <div class="relative mt-3">
        <span>Asientos máx. Turista</span>
        <input type="number" id="asientosTurista" name="asientosTurista" min="0" step="20" class="bg-base-200  input input-bordered w-full peer mt-1 pt-6" placeholder="0" required />
        <span class="text-xs text-gray-500 mt-2 block">Introduce el número máximo de asientos disponibles por clase.</span>
      </div>

      <div class="relative mt-3">
        <span>Asientos máx. Ejecutivo</span>
        <input type="number" id="asientosEjecutivo" name="asientosEjecutivo" min="0" step="1" class="bg-base-200  input input-bordered w-full peer mt-1 pt-6" placeholder="0" required />
        <span class="text-xs text-gray-500 mt-2 block">Introduce el número máximo de asientos disponibles por clase.</span>
      </div>
      <div class="mt-3"></div> 

      <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Imagen del vuelo</span>
        </div>
        <input type="file" name="file" accept="image/*" required class="input input-bordered w-full bg-base-200"/>
        <div class="label">
          <span class="label-text-alt text-xs opacity-70">Sube una imagen representativa del vuelo.</span>
        </div>
      </label>

      <div class="mt-3"></div>

<div class="mt-10 mb-4 flex justify-between items-center">
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
    Crear Vuelo
  </button>
</div>

      <div id="msg" class="text-sm mt-3"></div>
    </form>
  </section>
</main>




    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />







    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

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

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>