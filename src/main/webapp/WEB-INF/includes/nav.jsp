    <!-- Barra de Navegacion --> 
    <nav class="navbar bg-[#0C4DC3] shadow-sm px-6">
        <!-- Izquierda de la NAV-->
        <div class="navbar-start">
            <div class="sm:overlay-layout-open:ps-64 min-h-full bg-primary transition-all duration-300">
            <div class="">
                <button
                type="button"
                class="btn btn-sm btn-circle shadow-none btn-primary"
                aria-haspopup="dialog"
                aria-expanded="false"
                aria-controls="collapsible-sidebar"
                data-overlay="#collapsible-sidebar"
                >
                    <span class="icon-[tabler--menu-2] size-5"></span>
                </button>
            </div>
            </div>
        </div>
        
        <!-- Centro de la NAV-->
        <div class="navbar-center">
            <div class="flex items-center gap-3">
            <img src="${pageContext.request.contextPath}/favicon.png" class="w-8 h-8 rounded-md" alt="logo" />
            </div>
        </div>

    <%
        Object usuario  = session.getAttribute("usuario");
        if (usuario == null) {
    %>  <!-- NAV PARA USUARIO NO LOG -->
        <div id="navres" class="navbar-end">
        <button
          class="text-sm btn btn-sm btn-primary shadow-none rounded"
          onclick="window.location.href='consultaVuelo.html'"
        >
          Estado de Vuelo<svg
            xmlns="http://www.w3.org/2000/svg"
            width="18"
            height="18"
            viewBox="0 0 24 24"
          >
            <path
              fill="currentColor"
              d="M14 3v2h3.59l-9.83 9.83l1.41 1.41L19 6.41V10h2V3m-2 16H5V5h7V3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7h-2z"
            />
          </svg>
        </button>

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
        <button
          class="btn btn-sm btn-circle shadow-none btn-primary"
          aria-label="Circle Soft Icon Button"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="20"
            height="20"
            viewBox="0 0 24 24"
          >
            <path
              fill="currentColor"
              d="M12 22q-2.05 0-3.875-.788t-3.187-2.15t-2.15-3.187T2 12q0-2.075.788-3.887t2.15-3.175t3.187-2.15T12 2q2.075 0 3.888.788t3.174 2.15t2.15 3.175T22 12q0 2.05-.788 3.875t-2.15 3.188t-3.175 2.15T12 22m0-2.05q.65-.9 1.125-1.875T13.9 16h-3.8q.3 1.1.775 2.075T12 19.95m-2.6-.4q-.45-.825-.787-1.713T8.05 16H5.1q.725 1.25 1.813 2.175T9.4 19.55m5.2 0q1.4-.45 2.488-1.375T18.9 16h-2.95q-.225.95-.562 1.838T14.6 19.55M4.25 14h3.4q-.075-.5-.112-.987T7.5 12t.038-1.012T7.65 10h-3.4q-.125.5-.187.988T4 12t.063 1.013t.187.987m5.4 0h4.7q.075-.5.113-.987T14.5 12t-.038-1.012T14.35 10h-4.7q-.075.5-.112.988T9.5 12t.038 1.013t.112.987m6.7 0h3.4q.125-.5.188-.987T20 12t-.062-1.012T19.75 10h-3.4q.075.5.113.988T16.5 12t-.038 1.013t-.112.987m-.4-6h2.95q-.725-1.25-1.812-2.175T14.6 4.45q.45.825.788 1.713T15.95 8M10.1 8h3.8q-.3-1.1-.775-2.075T12 4.05q-.65.9-1.125 1.875T10.1 8m-5 0h2.95q.225-.95.563-1.838T9.4 4.45Q8 4.9 6.912 5.825T5.1 8"
            />
          </svg>
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
                    <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar 1" />
                </div>
                </div>
            </button>
            <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu" aria-orientation="vertical" aria-labelledby="dropdown-avatar">
                <li class="dropdown-header gap-2">
                <div class="avatar">
                    <div class="w-10 rounded-full">
                    <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar" />
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
                <a class="dropdown-item" href="modificarUsuario.html">
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
                <li>
                <a class="dropdown-item" href="consultaVuelo.html">
                    <span class="icon-[tabler--receipt-rupee]"></span>
                    Estado de Vuelos
                </a>
                </li>
                <li class="dropdown-footer gap-2">
                    <a class="btn btn-error btn-soft btn-block" href="LogoutServlet">
                    <span class="icon-[tabler--logout]"></span>
                    Cerrar Sesión
                    </a>
                </li>
            </ul>
            </div>
        </div>
    <%
        }
    %>
</nav>
