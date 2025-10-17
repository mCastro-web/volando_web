<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-100 min-h-screen flex flex-col">

    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

 <h2 class="mt-6 text-2xl font-bold mb-6 text-center">Alta Usuario</h2>

<form 
  action="RegisterServlet" 
  method="post" 
  class="max-w-lg mx-auto mt-8 p-8 rounded-2xl bg-base-200 shadow-lg space-y-5"
  enctype="multipart/form-data"
>

  <!-- Email -->
  <div class="input-floating w-full bg-base-200">
    <input type="email" name="email" id="email" placeholder=" " class="input input-bordered w-full bg-base-200 peer" required />
    <label for="email" class="input-floating-label bg-base-200">Correo electrónico</label>
  </div>

  <!-- Confirmar Email -->
  <div class="input-floating w-full bg-base-200">
    <input type="email" name="emailcheck" id="emailcheck" placeholder=" " class="input input-bordered w-full bg-base-200 peer" required />
    <label for="emailcheck" class="input-floating-label bg-base-200">Confirmar correo electrónico</label>
  </div>

  <!-- Usuario -->
  <div class="input-floating w-full bg-base-200">
    <input type="text" name="user" id="user" placeholder=" " class="input input-bordered w-full bg-base-200 peer" required />
    <label for="user" class="input-floating-label bg-base-200">Usuario (Nickname)</label>
  </div>

  <!-- Contraseña -->
  <div class="input-floating w-full bg-base-200">
    <input type="password" name="pass" id="pass" placeholder=" " class="input input-bordered w-full bg-base-200 peer" required />
    <label for="pass" class="input-floating-label bg-base-200">Contraseña</label>
  </div>

  <!-- Confirmar Contraseña -->
  <div class="input-floating w-full bg-base-200">
    <input type="password" name="passcheck" id="passcheck" placeholder=" " class="input input-bordered w-full bg-base-200 peer" required />
    <label for="passcheck" class="input-floating-label bg-base-200">Confirmar contraseña</label>
  </div>

  <!-- Nombre -->
  <div class="input-floating w-full bg-base-200">
    <input type="text" name="name" id="name" placeholder=" " class="input input-bordered w-full bg-base-200 peer" required />
    <label for="name" class="input-floating-label bg-base-200">Nombre</label>
  </div>

  <!-- Apellido -->
  <div class="input-floating w-full bg-base-200">
    <input type="text" name="apellido" id="apellido" placeholder=" " class="input input-bordered w-full bg-base-200 peer" required />
    <label for="apellido" class="input-floating-label bg-base-200">Apellido</label>
  </div>

  <!-- Nacionalidad -->
  <div class="input-floating w-full bg-base-200">
    <input type="text" name="nacionalidad" id="nacionalidad" placeholder=" " class="input input-bordered w-full bg-base-200 peer" required />
    <label for="nacionalidad" class="input-floating-label bg-base-200">Nacionalidad</label>
  </div>

  <!-- Número de Documento -->
  <div class="input-floating w-full bg-base-200">
    <input type="text" name="numeroDoc" id="numeroDoc" placeholder=" " class="input input-bordered w-full bg-base-200 peer" required />
    <label for="numeroDoc" class="input-floating-label bg-base-200">Número de Documento</label>
  </div>

  <!-- Tipo de Documento -->
  <div class="form-control w-full">
    <label for="tipoDoc" class="label">
      <span class="label-text opacity-80">Tipo de Documento</span>
    </label>
    <select name="tipoDoc" id="tipoDoc" class="select select-bordered w-full bg-base-200" required>
      <option value="" disabled selected>-- Seleccionar --</option>
      <option value="CI">Cédula de Identidad</option>
      <option value="Pasaporte">Pasaporte</option>
    </select>
  </div>

  <!-- Fecha de Nacimiento -->
  <div class="form-control w-full">
    <label for="bdate" class="label">
      <span class="label-text opacity-80">Fecha de Nacimiento</span>
    </label>
    <input type="date" name="bdate" id="bdate" class="input input-bordered w-full bg-base-200" required />
  </div>

  <!-- Archivo -->
  <div class="form-control w-full">
    <label for="file" class="label">
      <span class="label-text opacity-80">Archivo (opcional)</span>
    </label>
    <input type="file" name="file" id="file" class="file-input file-input-bordered w-full bg-base-200" />
  </div>

  <!-- Botones -->
  <div class="mt-6 flex gap-3 justify-end">
    <button type="button" class="btn btn-outline w-1/2" onclick="window.location.href='index.html'">
      Cancelar
    </button>
    <button type="submit" class="btn btn-primary w-1/2">
      Enviar
    </button>
  </div>
</form>

    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>
