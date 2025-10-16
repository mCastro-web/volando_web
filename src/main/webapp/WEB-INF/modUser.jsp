<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

    <%
        Object usuario  = session.getAttribute("usuario");            
    %>

    <main class="flex flex-1 p-4 gap-4">
        <!-- Contenido central -->
        <section class="flex-1 bg-base-100 p-4 rounded-lg shadow-md space-y-4">
                    <%
                        String nombre = "Usuario";
                        try {
                            java.lang.reflect.Method getNombre = usuario.getClass().getMethod("getNombre");
                            Object nombreObj = getNombre.invoke(usuario);
                            if (nombreObj != null) nombre = nombreObj.toString();
                        } catch (Exception ex) { }
                    %>
            <h2 class="mt-6 text-2xl font-bold text-center">Modificar Datos de <%= nombre %></h2>
            
            <form class="space-y-6 max-w-md mx-auto" action="ModUserServlet" method="post">
                <div class="mt-10"></div>




                    <%
                        String nickNameCliente = "Usuario";
                        try {
                            java.lang.reflect.Method getNickname = usuario.getClass().getMethod("getNickname");
                            Object nombreObj = getNickname.invoke(usuario);
                            if (nombreObj != null) nickNameCliente = nombreObj.toString();
                        } catch (Exception ex) { }
                    %>



            <!-- Nickname (no editable) -->
                <div class="mt-4 input-floating bg-base-100">
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

            <div class="mt-3"></div>
            <!-- Correo electrónico (no editable) -->
                <div class="input-floating bg-base-100">

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
            <div class="mt-10 input-floating bg-base-100">
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
                        class="input input-bordered w-full peer bg-base-100"
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
                <div class="input-floating">
                <textarea placeholder="Descripción de la aerolínea" class="textarea textarea-bordered w-full" id="descripcion "                        name="descripcion"
></textarea>
                </div>
                <div class="mt-3"></div>
                <div class="input-floating">
                <input type="url" placeholder="https://www.sitioweb.com" class="input input-bordered w-full" id="web"                        name="web"
 />
                <label class="input-floating-label" for="web">Sitio web (opcional)</label>
                </div>
            </div>
                <div class="mt-3"></div>
            <!-- Contraseña -->
            <div class="input-floating bg-base-100">
                <input type="password" placeholder="Nueva contraseña" class="input input-bordered w-full" id="passwordA"                         name="passwordA"
/>
                <label class="input-floating-label" for="password">Nueva Contraseña</label>
            </div>
                <div class="mt-3"></div>
            <!-- Confirmar Contraseña -->
            <div class="input-floating bg-base-100">
                <input type="password" placeholder="Confirmar contraseña" class="input input-bordered w-full" id="confirmPasswordA"                         name="confirmPasswordA"
/>
                <label class="input-floating-label" for="confirmPassword">Confirmar Contraseña</label>
            </div>
                <div class="mt-3"></div>
            <!-- Imagen -->
            <div class="form-control">
                <label class="label">
                <span class="label-text">Imagen de perfil</span>
                </label>
                <input id="fotoPerfilA" name="fotoPerfilA" type="file" accept="image/*" class="" />
            </div>
        
        <% } %>



                <div class="mt-3"></div>
            <!-- Botones -->
                <div class="mt-6 flex gap-3 justify-end">
                <button 
                    class="btn btn-outline " 
                    >
                    Cancelar
                </button>
                <button
                    type="submit"
                    class="btn btn-primary " 
                    >
                    Guardar Cambios
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