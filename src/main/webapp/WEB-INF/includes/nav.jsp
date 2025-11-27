    <!-- Barra de Navegacion --> 
    <nav class="navbar bg-[#0C4DC3] shadow-sm px-6">
        <!-- Izquierda de la NAV-->
        <div class="navbar-start gap-2">
            <div class="sm:overlay-layout-open:ps-64 min-h-full bg-primary transition-all duration-300">
            <div class="mt-1">
                <button
                type="button"
                class="btn btn-sm btn-circle shadow-none btn-primary"
                aria-haspopup="dialog"
                aria-expanded="false"
                aria-controls="collapsible-sidebar"
                data-overlay="#collapsible-sidebar"
                >
                    <span class="icon-[tabler--menu-2] size-7"></span>
                </button>
            </div>
            </div>
            
            <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2">
              <img src="${pageContext.request.contextPath}/favicon.png" 
                  class="w-8 h-8 rounded-md cursor-pointer hover:scale-105 transition-transform" 
                  alt="logo" />
            </a>
        </div>
        
        <!-- Centro de la NAV-->
        <div class="navbar-center w-full max-w-md mx-4">
            <form action="BusquedaServlet" method="GET" class="w-full flex justify-center">
                <div class="flex items-center w-full max-w-3xl bg-base-200 rounded-full shadow-md border border-base-300 overflow-hidden">
                    
                    <!-- Input -->
                    <input 
                        type="text" 
                        name="queryBusqueda" 
                        placeholder="Buscar rutas, paquetes..."
                        class="flex-grow px-4 py-2 bg-base-200 text-base-content focus:outline-none"
                    />

                    <!-- Botón de búsqueda -->
                    <button 
                        type="submit"
                        class="px-4 py-2 bg-base-200 hover:bg-base-300 transition-colors flex items-center justify-center"
                    >
                        <span class="icon-[tabler--search] size-5 text-base-content/70"></span>
                    </button>

                </div>
            </form>
        </div>


        <%
            Object usuario  = session.getAttribute("usuario");
            if (usuario == null) {
        %>  <!-- NAV PARA USUARIO NO LOG -->
        <div id="navres" class="navbar-end flex items-center gap-2">

        <button
          onclick="window.location.href='login'"
          class="border-white text-sm btn btn-sm btn-primary rounded mr-1 shadow-none"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="18"
            height="18"
            viewBox="0 0 24 24"
          >
            <path
              fill="currentColor"
              d="M12 4a4 4 0 0 1 4 4a4 4 0 0 1-4 4a4 4 0 0 1-4-4a4 4 0 0 1 4-4m0 10c4.42 0 8 1.79 8 4v2H4v-2c0-2.21 3.58-4 8-4"
            />
          </svg>
          Iniciar Sesion
        </button>
     
        </div>

    <%
        } else {
    %>  <!-- NAV PARA USUARIO LOGEADO -->     
        <div id="navres" class="navbar-end">
            <div class="dropdown relative inline-flex [--auto-close:inside] [--offset:8] [--placement:bottom-end]">
            <button id="dropdown-scrollable" type="button" class="dropdown-toggle flex items-center" aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
                <div class="avatar">
                <div class="size-9.5 rounded-full">
                                      <%
                          String imagenAvatar = "Usuario";
                          try {
                              java.lang.reflect.Method getUrlImagen = usuario.getClass().getMethod("getUrlImagen");
                              Object nombreObj = getUrlImagen.invoke(usuario);
                              if (nombreObj != null) imagenAvatar = nombreObj.toString();
                          } catch (Exception ex) { }
                      %>

                    <img src="<%= imagenAvatar %>" alt="avatar" />
                </div>
                </div>
            </button>
            <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu" aria-orientation="vertical" aria-labelledby="dropdown-avatar">
                <li class="dropdown-header gap-2">
                <div class="avatar">
                    <div class="w-10 rounded-full">

                      <%
                          String imagen = "Usuario";
                          try {
                              java.lang.reflect.Method getUrlImagen = usuario.getClass().getMethod("getUrlImagen");
                              Object nombreObj = getUrlImagen.invoke(usuario);
                              if (nombreObj != null) imagen = nombreObj.toString();
                          } catch (Exception ex) { }
                      %>
                      
                    <img src="<%= imagen %>" alt="avatar" />
                    </div>
                </div>
                <div>
                  <h6 class="text-base-content text-base font-semibold">
                      <%
                          String nombre = "Usuario";
                          try {
                              java.lang.reflect.Method getNombre = usuario.getClass().getMethod("getNombre");
                              Object nombreObj = getNombre.invoke(usuario);
                              if (nombreObj != null) nombre = nombreObj.toString();
                          } catch (Exception ex) { }
                      %>
                      <%= nombre %>
                  </h6>

                  <small class="text-base-content/50">
                      <%
                          String tipoCuenta = "Usuario";
                          try {
                              java.lang.reflect.Method getTipo = usuario.getClass().getMethod("getTipo");
                              Object tipoObj = getTipo.invoke(usuario);
                              if (tipoObj != null) tipoCuenta = tipoObj.toString();
                          } catch (Exception ex) { }
                      %>
                      <%= tipoCuenta %>
                  </small>
                </div>
                </li>
                <li>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/modUser">
                    <span class="icon-[tabler--user]"></span>
                    Mi Usuario
                </a>
                </li>
                <li>
                <a class="dropdown-item" href="#">
                    <span class="icon-[tabler--settings]"></span>
                    Configuracion
                </a>
                </li>
                <li class="dropdown-footer gap-2">
                    <a class="btn btn-error btn-soft btn-block" href="LogoutServlet">
                    <span class="icon-[tabler--logout]"></span>
                    Cerrar Sesion
                    </a>
                </li>
            </ul>
            </div>
        </div>
    <%
        }
    %>
</nav>
