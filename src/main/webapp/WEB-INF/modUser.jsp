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
            
            <form class="space-y-6 max-w-md mx-auto" onsubmit="return false;">
                <div class="mt-10"></div>

            <!-- Nickname (no editable) -->
                <div class="mt-4 input-floating bg-base-100">
                    <input
                        type="text"
                        id="nickname"
                        value="<%= nombre %>"
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
            <div class="input-floating bg-base-100">
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
                        value="<%= nombreUser %>"
                        placeholder=" "
                        class="input input-bordered w-full peer bg-base-100"
                    />
                    <label for="nombreUser" class="input-floating-label bg-base-100">
                        Nombre
                    </label>
            </div>
                <div class="mt-3"></div>
            <!-- Campos extra para CLIENTE -->
            <div id="clienteFields" class="hidden space-y-4">
                <div class="input-floating">
                <input type="text" placeholder="Apellido" class="input input-bordered w-full" id="apellido" />
                <label class="input-floating-label" for="apellido">Apellido</label>
                </div>
                <div class="mt-3"></div>
                <div class="input-floating">
                <input type="date" class="input input-bordered w-full" id="fechaNacimiento" />
                <label class="input-floating-label" for="fechaNacimiento">Fecha de Nacimiento</label>
                </div>
                <div class="mt-3"></div>
                <div class="input-floating">
                <input type="text" placeholder="Nacionalidad" class="input input-bordered w-full" id="nacionalidad" />
                <label class="input-floating-label" for="nacionalidad">Nacionalidad</label>
                </div>
                <div class="mt-3"></div>
                <div class="input-floating">
                <input type="text" placeholder="Tipo de Documento" class="input input-bordered w-full" id="tipoDoc" />
                <label class="input-floating-label" for="tipoDoc">Tipo de Documento</label>
                </div>
                <div class="mt-3"></div>
                <div class="input-floating">
                <input type="text" placeholder="Número de Documento" class="input input-bordered w-full" id="numDoc" />
                <label class="input-floating-label" for="numDoc">Número de Documento</label>
                </div>
            </div>

            <!-- Campos extra para AEROLÍNEA -->
            <div id="aerolineaFields" class="hidden space-y-4">
                <div class="input-floating">
                <textarea placeholder="Descripción de la aerolínea" class="textarea textarea-bordered w-full" id="descripcion"></textarea>
                </div>
                <div class="mt-3"></div>
                <div class="input-floating">
                <input type="url" placeholder="https://www.sitioweb.com" class="input input-bordered w-full" id="web" />
                <label class="input-floating-label" for="web">Sitio web (opcional)</label>
                </div>
            </div>
                <div class="mt-3"></div>
            <!-- Contraseña -->
            <div class="input-floating bg-base-100">
                <input type="password" placeholder="Nueva contraseña" class="input input-bordered w-full" id="password" />
                <label class="input-floating-label" for="password">Nueva Contraseña</label>
            </div>
                <div class="mt-3"></div>
            <!-- Confirmar Contraseña -->
            <div class="input-floating bg-base-100">
                <input type="password" placeholder="Confirmar contraseña" class="input input-bordered w-full" id="confirmPassword" />
                <label class="input-floating-label" for="confirmPassword">Confirmar Contraseña</label>
            </div>
                <div class="mt-3"></div>
            <!-- Imagen -->
            <div class="form-control">
                <label class="label">
                <span class="label-text">Imagen de perfil</span>
                </label>
                <input type="file" accept="image/*" class="" />
            </div>
                <div class="mt-3"></div>
            <!-- Botones -->
                <div class="mt-6 flex gap-3 justify-end">
                <button 
                    class="btn btn-outline " 
                    onclick="window.location.href='index.html'">
                    Cancelar
                </button>
                <button 
                    class="btn btn-primary " 
                    onclick="window.location.href='index.html'">
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