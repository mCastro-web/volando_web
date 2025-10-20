<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

    <%
        Object usuario  = session.getAttribute("usuario");            
    %>

    <main class="flex flex-1 p-4 gap-4 bg-base-200">
        <!-- Contenido central -->
        <section class="flex-1 bg-base-200 p-4 rounded-lg  space-y-4">

            <div class="mt-10 w-full mx-auto    max-w-4xl">
                <h1 class="text-3xl mb-2">Modificar Datos</h1>
                <p class="text-sm mb-6">
           <b> Actualizá la información de tu cuenta</b> de VolandoUy. 
             Asegurate de que tus datos estén siempre correctos para una mejor experiencia.
                </p>
                
            </div>
            
            <form class="max-w-4xl w-full mx-auto gap-4 base-200  space-y-6 mx-auto" action="ModUserServlet" method="post">
                <div class="mt-10"></div>

<div class="flex items-center gap-6">
  <!-- Imagen de perfil actual -->
  <div class="avatar">

                       <%
                          String imagen = "Usuario";
                          try {
                              java.lang.reflect.Method getUrlImagen = usuario.getClass().getMethod("getUrlImagen");
                              Object nombreObj = getUrlImagen.invoke(usuario);
                              if (nombreObj != null) imagen = nombreObj.toString();
                          } catch (Exception ex) { }
                      %>
                      
    <div class="w-20 h-20 bg-base-200 rounded-full ring ring-primary ring-offset-base-100 ring-offset-2 overflow-hidden">
      <img
        src="<%= imagen %>"
        alt="Foto de perfil actual"
        class="object-cover w-full h-full"
      />
    </div>
  </div>

  <!-- Selector de nueva imagen -->
  <div class="form-control w-full max-w-xs">
    <label class="label">
      <span class="label-text font-medium">Cambiar imagen de Perfil</span>
    </label>
        <input type="file" name="file" accept="image/*"  class="input input-bordered w-full bg-base-200"/>

    <label class="label">
      <span class="label-text-alt text-xs opacity-70">Seleccioná una nueva imagen de perfil.</span>
    </label>
  </div>
</div>


                    <%
                        String nickNameCliente = "Usuario";
                        try {
                            java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
                            Object nombreObj = getNickname.invoke(usuario);
                            if (nombreObj != null) nickNameCliente = nombreObj.toString();
                        } catch (Exception ex) { }
                    %>



            <!-- Nickname (no editable) -->
                <div class="bg-base-200 mt-10 input-floating bg-base-100">
                    <input
                        type="text"
                        id="nickname"
                        name="nickname"
                        value="<%= nickNameCliente %>"
                        placeholder=" "
                        class="input input-bordered w-full peer bg-base-100"
                        disabled
                    />
                    <label for="nickname" class="input-floating-label bg-base-100">
                        Nickname
                    </label>
                </div>

            <div class="mt-3 bg-base-200"></div>
            <!-- Correo electrónico (no editable) -->
                <div class="bg-base-200 input-floating bg-base-100">

                <%
                    String userEmail = "Usuario";
                        try {
                            java.lang.reflect.Method getEmail = usuario.getClass().getMethod("getEmail");
                            Object nombreObj = getEmail.invoke(usuario);
                            
                            if (nombreObj != null) userEmail = nombreObj.toString();
                        } catch (Exception ex) { }
                %>
                    <input
                        type="text"
                        id="userEmail"
                        name="userEmail"
                        value="<%= userEmail %>"
                        placeholder=" "
                        class="input input-bordered w-full peer bg-base-100"
                        disabled
                    />
                    <label for="userEmail" class="input-floating-label bg-base-100">
                        Correo electrónico
                    </label>
            </div>
                <div class="mt-3"></div>
            <!-- Nombre -->
            <div class="mt-10 input-floating bg-base-200">
                <%
                    String nombreUser = "Usuario";
                        try {
                            java.lang.reflect.Method getNombre = usuario.getClass().getMethod("getNombre");
                            Object nombreObj = getNombre.invoke(usuario);
                            
                            if (nombreObj != null) nombreUser = nombreObj.toString();
                        } catch (Exception ex) { }
                %>
                    <input
                        type="text" 
                        id="nombreUser"
                        name="nombreUser"
                        value="<%= nombreUser %>"
                        placeholder=" "
                        class="input input-bordered w-full peer bg-base-200"
                        required
                    />
                    <label for="nombreUser" class="input-floating-label bg-base-100">
                        Nombre
                    </label>
            </div>
                <div class="mt-3"></div>

        <%  
            String tipoCuenta = "usuario";
                          try {
                              java.lang.reflect.Method getTipo = usuario.getClass().getMethod("getTipo");
                              Object tipoObj = getTipo.invoke(usuario);
                              if (tipoObj != null) tipoCuenta = tipoObj.toString().toUpperCase();
            } catch (Exception ex) { }
            String tipo = (String) session.getAttribute("tipoUsuario");

            if ("CLIENTE".equalsIgnoreCase(tipoCuenta)) {
        %>

            <!-- Campos extra para CLIENTE -->
            <div id="clienteFields" class=" space-y-4">
                <%
                    String Apellido = "Usuario";
                        try {
                            java.lang.reflect.Method getApellido = usuario.getClass().getMethod("getApellido");
                            Object nombreObj = getApellido.invoke(usuario);
                            
                            if (nombreObj != null) Apellido = nombreObj.toString();
                        } catch (Exception ex) { }
                %>
                <div class="input-floating bg-base-100">
                <input required type="text" placeholder="Apellido" value="<%= Apellido %>" class="bg-base-100 input input-bordered w-full" id="apellido" name="apellido"/>
                <label class="input-floating-label bg-base-100" for="apellido">Apellido</label>
                </div>





                <div class="mt-3"></div>
        

                <%
                    String nacionalidad = "Usuario";
                        try {
                            java.lang.reflect.Method getNacionalidad = usuario.getClass().getMethod("getNacionalidad");
                            Object nombreObj = getNacionalidad.invoke(usuario);
                            
                            if (nombreObj != null) nacionalidad = nombreObj.toString();
                        } catch (Exception ex) { }
                %>  
                <div class="mt-3"></div>
                <div class="input-floating bg-base-100">
                <input                         name="nacionalidad"
 required type="text" placeholder="Nacionalidad" value="<%= nacionalidad %>" class="input input-bordered w-full bg-base-100" id="nacionalidad" />
                <label class="input-floating-label bg-base-100" for="nacionalidad">Nacionalidad</label>


                </div>
                <div class="mt-3"></div>
                <div class="input-floating bg-base-100" >
                <select  type="text" placeholder="Tipo de Documento" class="input input-bordered w-full bg-base-100" id="tipoDoc"                         name="tipoDoc"
>
                        <option value="CI">CI</option>
                        <option value="Pasaporte">PASAPORTE</option>
                </select>
                <label class="input-floating-label" for="tipoDoc">Tipo de Documento</label>


                <%
                    String documentoci = "Usuario";
                        try {
                            java.lang.reflect.Method getDocumento = usuario.getClass().getMethod("getNumeroDoc");
                            Object nombreObj = getDocumento.invoke(usuario);
                            
                            if (nombreObj != null) documentoci = nombreObj.toString();
                        } catch (Exception ex) { }
                %> 
                </div>
                <div class="mt-3"></div>
                <div class="input-floating bg-base-100">
                <input required value="<%= documentoci %>" type="text" placeholder="Número de Documento" class="bg-base-100 input input-bordered w-full" id="numDoc"                         name="numDoc"
/>
                <label class="input-floating-label bg-base-100" for="numDoc">Número de Documento</label>
                </div>


                <!-- Contraseña -->
            <div class="mt-10 input-floating bg-base-100">
                <input  type="password" placeholder="Nueva contraseña" class="input input-bordered w-full" id="password"                        name="password"
 />
                <label class="input-floating-label" for="password">Nueva Contraseña</label>
            </div>
                <div class="mt-3"></div>
            <!-- Confirmar Contraseña -->
            <div class="input-floating bg-base-100">
                <input  type="password" placeholder="Confirmar contraseña" class="input input-bordered w-full" id="confirmPassword"                        name="confirmPassword"
 />
                <label class="input-floating-label" for="confirmPassword">Confirmar Contraseña</label>
            </div>

                                        <div class="form-control">
                <label class="label">
                <span class="label-text">Imagen de perfil</span>
                </label>
<input  id="fotoPerfilC" name="fotoPerfil" type="file" class="input" aria-label="file-input" />            </div>

            </div>
       <%
            } else if ("AEROLINEA".equalsIgnoreCase(tipoCuenta)) {
        %>
            <!-- Campos extra para AEROLÍNEA -->
            
            <div id="aerolineaFields" class=" space-y-4">
                <div class="bg-base-200 input-floating">

                <% 
                String descripcion = "Descripción de la aerolínea";
                try {
                    java.lang.reflect.Method getDescripcion = usuario.getClass().getMethod("getDescripcion");
                    Object nombreObj = getDescripcion.invoke(usuario);
                    if (nombreObj != null) descripcion = nombreObj.toString();
                } catch (Exception ex) { }
                %>
                    <textarea placeholder="Descripción de la aerolínea" class="bg-base-200 textarea textarea-bordered w-full" id="descripcion" name="descripcion"><%= descripcion %></textarea>
                </div>



                <div class="mt-3"></div>
                <div class="input-floating bg-base-200">
                <%
                String web = "https://www.sitioweb.com";
                try {
                    java.lang.reflect.Method getWeb = usuario.getClass().getMethod("getWeb");
                    Object nombreObj = getWeb.invoke(usuario);
                    if (nombreObj != null) web = nombreObj.toString();
                } catch (Exception ex) { }
                %>
                <input type="url" placeholder="https://www.sitioweb.com" class="bg-base-200 input input-bordered w-full" id="web" name="web" value="<%= web %>" />
                <label class="input-floating-label bg-base-200" for="web">Sitio web</label>
                </div>
            </div>
                <div class="mt-3"></div>
            <!-- Contraseña -->
            <div class="input-floating bg-base-200">
                <input type="password" placeholder="Nueva contraseña" class="bg-base-200 input input-bordered w-full" id="passwordA"                         name="passwordA"
/>
                <label class="input-floating-label" for="password">Nueva Contraseña</label>
            </div>
                <div class="mt-3"></div>
            <!-- Confirmar Contraseña -->
            <div class="input-floating bg-base-200">
                <input type="password" placeholder="Confirmar contraseña" class="bg-base-200 input input-bordered w-full" id="confirmPasswordA"                         name="confirmPasswordA"
/>
                <label class="input-floating-label" for="confirmPassword">Confirmar Contraseña</label>
            </div>
                <div class="mt-3"></div>
            <!-- Imagen -->


        
        <% } %>



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
    Guardar cambios
  </button>
</div>
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