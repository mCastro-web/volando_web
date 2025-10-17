<aside id="collapsible-sidebar" class="overlay [--body-scroll:true] overlay-open:translate-x-0 drawer drawer-start sm:overlay-layout-open:translate-x-0 hidden w-64 [--auto-close:sm] [--is-layout-affect:true] sm:absolute sm:z-0 sm:flex sm:shadow-none lg:[--overlay-backdrop:false] border-0 !shadow-none !m-0 !p-0">
      <div class="drawer-body px-0 pt-0">
        <!-- Header del MENU -->
        <div class="bg-[#0A4DC3] text-white px-4 py-2 flex items-center gap-3">
            <img src="${pageContext.request.contextPath}/favicon.png" class="w-8 h-8 rounded-md" alt="logo" />
          <div>
            <h2 class="text-lg font-bold leading-tight">VolandoUy</h2>
            <p class="text-xs opacity-90">Menú de opciones</p>
          </div>

        </div>

          <hr class="mt-2 mx-4 w-[85%] bg-base-100">
                      
                                        
        <%  
            Object usuario  = session.getAttribute("usuario");
            String tipoCuenta = "usuario";
                          try {
                              java.lang.reflect.Method getTipo = usuario.getClass().getMethod("getTipo");
                              Object tipoObj = getTipo.invoke(usuario);
                              if (tipoObj != null) tipoCuenta = tipoObj.toString().toUpperCase();
            } catch (Exception ex) { }
            String tipo = (String) session.getAttribute("tipoUsuario");

            if ("CLIENTE".equalsIgnoreCase(tipoCuenta)) {
        %>

                <!-- Contenido para CLIENTE -->
                <ul class="dark:text-white mt-2 menu p-0">
                    <li>
                        <a href="${pageContext.request.contextPath}/ListUserServlet" class="flex items-center gap-2">
                            <span class="icon-[tabler--users] size-5"></span>
                            Usuarios
                        </a>
                    </li>
                    <li>
                        <a href="consultaUsuario.html">
                            <span class="icon-[tabler--users] size-5"></span>
                            Reservar Vuelos
                        </a>
                    </li>
                    <li>
                        <a href="consultaVuelo.html">
                            <span class="icon-[tabler--plane] size-5"></span>
                            Reservas
                        </a>
                    </li>
                    <li>
                        <a href="consultaRutaVuelo.html">
                            <span class="icon-[tabler--route] size-5"></span>
                            Comprar Paquetes
                        </a>
                    </li>
                    <li>
                        <a href="consultaPaquete.html" class="flex items-center gap-2">
                            <span class="icon-[tabler--map-search] size-5"></span>
                            Paquetes
                        </a>
                    </li>
                    <li>
                        <a href="consultaPaquete.html" class="flex items-center gap-2">
                            <span class="icon-[tabler--map-search] size-5"></span>
                            Vuelos
                        </a>
                    </li>
                    <li>
                        <a href="consultaPaquete.html" class="flex items-center gap-2">
                            <span class="icon-[tabler--map-search] size-5"></span>
                            Rutas de Vuelo
                        </a>
                    </li>
                </ul>
        <%
            } else if ("AEROLINEA".equalsIgnoreCase(tipoCuenta)) {
        %>
                <!-- Contenido para AEROLINEA -->
                <ul class="dark:text-white mt-2 menu p-0">
                    <li>
                        <a <a href="${pageContext.request.contextPath}/altavuelo" class="flex items-center gap-2">
                            <span class="icon-[tabler--map-search] size-5"></span>
                            Crear Vuelo
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/AltaRutaVueloServlet">
                            <span class="icon-[tabler--users] size-5"></span>
                            Crear Rutas de Vuelo
                        </a>
                    </li>
                    <li>
                        <a href="consultaVuelo.html">
                            <span class="icon-[tabler--plane] size-5"></span>
                            Consultar Reservas
                        </a>
                    </li>
                    <li>
                        <a href="consultaRutaVuelo.html">
                            <span class="icon-[tabler--route] size-5"></span>
                            Consultar Paquetes
                        </a>
                    </li>
                    <li>
                        <a href="consultaPaquete.html" class="flex items-center gap-2">
                            <span class="icon-[tabler--map-search] size-5"></span>
                            Consultar Rutas
                        </a>
                    </li>
                    <li>
                        <a href="consultaPaquete.html" class="flex items-center gap-2">
                            <span class="icon-[tabler--map-search] size-5"></span>
                            Consultar Usuarios
                        </a>
                    </li>
                </ul>
        <%
            } else {
        %>
                <!-- Contenido para VISITANTE -->
                <ul class="dark:text-white mt-2 menu p-0">
                    <li>
                        <a href="${pageContext.request.contextPath}/ListUserServlet" class="flex items-center gap-2">
                            <span class="icon-[tabler--users] size-5"></span>
                            Usuarios
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/consultaVuelo">
                            <span class="icon-[tabler--plane] size-5"></span>
                            Vuelos
                        </a>
                    </li>
                    <li>
                        <a href="consultaRutaVuelo.html">
                            <span class="icon-[tabler--route] size-5"></span>
                            Rutas de Vuelo
                        </a>
                    </li>
                    <li>
                        <a href="consultaPaquete.html" class="flex items-center gap-2">
                            <span class="icon-[tabler--map-search] size-5"></span>
                            Paquetes de Rutas
                        </a>
                    </li>
                </ul>
        <%
            }
        %>




















       
</aside>