<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">

  <!-- Barra de Navegacion --> 
  <jsp:include page="includes/nav.jsp" />

  <main class="flex-grow container mx-auto px-4 py-8">
    <div class="max-w-3xl mx-auto bg-base-100 p-8 rounded-2xl shadow-md">

      <h1 class="text-2xl font-bold mb-6 text-center">Alta de Ruta de Vuelo</h1>

      <!-- Formulario -->
      <form action="${pageContext.request.contextPath}/AltaRutaVueloServlet" method="post" enctype="multipart/form-data" class="space-y-4">
        
        <div>
          <label class="block font-semibold">Nombre</label>
          <input type="text" name="nombre" class="input input-bordered w-full" required>
        </div>

        <div>
          <label class="block font-semibold">Descripción corta</label>
          <input type="text" name="descripcionCorta" class="input input-bordered w-full" required>
        </div>

        <div>
          <label class="block font-semibold">Descripción</label>
          <textarea name="descripcion" class="textarea textarea-bordered w-full" required></textarea>
        </div>

        <div>
          <label class="block font-semibold">Costo turista</label>
          <input type="number" step="0.01" name="costoTurista" class="input input-bordered w-full" required>
        </div>

        <div>
          <label class="block font-semibold">Costo ejecutivo</label>
          <input type="number" step="0.01" name="costoEjecutivo" class="input input-bordered w-full" required>
        </div>

        <div>
          <label class="block font-semibold">Costo equipaje extra</label>
          <input type="number" step="0.01" name="costoEquipajeExtra" class="input input-bordered w-full" required>
        </div>

        <div>
          <label class="block font-semibold">Ciudad de origen</label>
          <select name="ciudadOrigen" class="select select-bordered w-full" required>
            <option value="">Seleccione una ciudad</option>
            <c:forEach var="c" items="${ciudades}">
              <option value="${c}">${c}</option>
            </c:forEach>
          </select>
        </div>

        <div>
          <label class="block font-semibold">Ciudad de destino</label>
          <select name="ciudadDestino" class="select select-bordered w-full" required>
            <option value="">Seleccione una ciudad</option>
            <c:forEach var="c" items="${ciudades}">
              <option value="${c}">${c}</option>
            </c:forEach>
          </select>
        </div>

        <div>
          <label class="block font-semibold">Categoría</label>
          <select name="categorias" class="select select-bordered w-full" required>
            <option value="">Seleccione una categoría</option>
            <c:forEach var="cat" items="${categorias}">
              <option value="${cat}">${cat}</option>
            </c:forEach>
          </select>
        </div>


        <div>
          <label class="block font-semibold">Imagen</label>
          <input type="file" name="imagen" accept="image/*" class="file-input file-input-bordered w-full">
        </div>

        <div class="flex justify-center">
          <button type="submit" class="btn btn-primary">Crear ruta</button>
        </div>

      </form>
    </div>
  </main>

  <!-- Footer--> 
  <jsp:include page="includes/footer.jsp" />

  <!-- Menu Hamburguesa -->
  <jsp:include page="includes/aside.jsp" />

  <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>