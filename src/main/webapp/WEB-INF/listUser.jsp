<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="publicadores.DtCliente" %>
<%@ page import="publicadores.Aerolinea" %>

<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">

<!-- NAV -->
<jsp:include page="includes/nav.jsp" />

<div class="w-full mx-auto max-w-4xl mt-10">
    <h1 class="text-3xl mb-2">Listar Usuarios</h1>
    <p class="text-sm mb-6">
        A continuación se muestra una lista de todos los <b>usuarios registrados</b> en la plataforma VolandoUy.
    </p>

    <h2 class="text-xl">Datos del Usuario</h2>
    <p class="text-sm mb-4 text-base-content/80">
        Revisa los perfiles de los usuarios registrados, incluyendo sus nombres, apellidos y direcciones de correo <br/>
        Haz clic en los usuarios para obtener más detalles.
    </p>
</div>

<div id="listaUsuarios" class="grid grid-cols-2 md:grid-cols-2 mt-10 gap-6 max-w-7xl mx-auto">
    <!-- ============================ -->
    <!--       LISTA DE CLIENTES      -->
    <!-- ============================ -->
    <div class="space-y-3 w-full">
        <h2 class="text-xl font-semibold mb-2 text-center">Clientes</h2>

        <%
            List<DtCliente> clientes = (List<DtCliente>) request.getAttribute("clientes");
            Map<String, List<String>> seguidoresPorUsuario = (Map<String, List<String>>) request.getAttribute("seguidoresPorUsuario");
            Map<String, List<String>> seguidosPorUsuario = (Map<String, List<String>>) request.getAttribute("seguidosPorUsuario");
            List<String> misReservas = (List<String>) request.getAttribute("misReservas");
            List<String> misPaquetes = (List<String>) request.getAttribute("misPaquetes");
            String nicknameLogueado = null;
            if(session != null && session.getAttribute("usuario") != null) {
                nicknameLogueado = ((publicadores.DtUsuario)session.getAttribute("usuario")).getNickname();
            }

            if (clientes != null && !clientes.isEmpty()) {
                for (DtCliente c : clientes) {
                    String modalId = "modal-" + c.getNickname();
        %>


        <div class="card bg-base-100 shadow-md p-4 flex items-start justify-between cursor-pointer hover:bg-base-300 transition"
             onclick="document.getElementById('<%= modalId %>').classList.remove('hidden')">

            <div class="flex items-center gap-4">
                <img src="<%= c.getUrlImagen() != null ? c.getUrlImagen() : (request.getContextPath() + "/img/default-user.jpg") %>"
                     alt="Foto de <%= c.getNombre() %>"
                     class="w-16 h-16 object-cover rounded-full shadow-sm">

                <div>
                    <h3 class="font-bold text-lg">
                        <%= c.getNombre() %> <%= c.getApellido() %>
                    </h3>
                    <p class="text-sm opacity-70">Haz click para saber más sobre este usuario.</p>
                </div>
            </div>
        </div>

        <!-- MODAL CLIENTE -->
        <div id="<%= modalId %>"
             class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm transition-opacity duration-300">

            <div class="bg-base-100 rounded-2xl shadow-2xl w-full max-w-md mx-4 p-6 relative">

                <button class="absolute top-3 right-3 text-gray-400 hover:text-gray-700"
                        onclick="document.getElementById('<%= modalId %>').classList.add('hidden')">✕</button>

                <div class="flex flex-col items-center text-center space-y-3">
                    <img src="<%= c.getUrlImagen() != null ? c.getUrlImagen() : (request.getContextPath() + "/img/default-user.jpg") %>"
                         class="w-24 h-24 object-cover rounded-full border shadow">
                    <h3 class="font-bold text-xl"><%= c.getNombre() %> <%= c.getApellido() %></h3>
                    <p class="text-sm text-gray-500"><%= c.getEmail() %></p>
                    <p class="text-sm text-gray-500">Documento: <%= c.getNumeroDoc() %></p>
                    <p class="text-sm text-gray-500">Nacionalidad: <%= c.getNacionalidad() %></p>
                    <p class="text-sm text-gray-500">Tipo Documento: <%= c.getTipoDoc() %></p>
                </div>

                <!-- SEGUIDORES / SEGUIDOS -->
                <div class="mt-4 w-full text-left">
                    <h4 class="font-semibold text-sm mb-1">Seguidores:</h4>
                    <ul class="list-disc ml-6 text-sm">
                        <%
                            List<String> seguidores = seguidoresPorUsuario.get(c.getNickname());
                            if(seguidores != null && !seguidores.isEmpty()) {
                                for(String s : seguidores){ %>
                        <li><%= s %></li>
                        <%      }
                        } else { %>
                        <li class="text-gray-400 italic">No tiene seguidores</li>
                        <% } %>
                    </ul>

                    <h4 class="font-semibold text-sm mb-1 mt-2">Seguidos:</h4>
                    <ul class="list-disc ml-6 text-sm">
                        <%
                            List<String> seguidos = seguidosPorUsuario.get(c.getNickname());
                            if(seguidos != null && !seguidos.isEmpty()) {
                                for(String s : seguidos){ %>
                        <li><%= s %></li>
                        <%      }
                        } else { %>
                        <li class="text-gray-400 italic">No sigue a nadie</li>
                        <% } %>
                    </ul>
                </div>

                <!-- SOLO SI EL CLIENTE LOGUEADO ESTÁ VIENDO SU PERFIL -->
                <% if(c.getNickname().equals(nicknameLogueado)) { %>
                <div class="mt-4 w-full text-left">

                    <!-- Mis Reservas -->
                    <h4 class="font-semibold text-sm mb-1">Mis Reservas:</h4>
                    <ul class="list-disc ml-6 text-sm">
                        <% if(misReservas != null && !misReservas.isEmpty()) {
                            for(String r : misReservas){
                                // Parse: "Reserva Nro: 83 - Vuelo: R3-001 - Pasajes: 2 - Tipo: EJECUTIVO"
                                String reservaId = "";
                                String vueloId = "";
                                if(r.contains("Reserva Nro: ")) {
                                    int nroStart = r.indexOf("Nro: ") + 5;
                                    int nroEnd = r.indexOf(" -", nroStart);
                                    if(nroEnd > nroStart) reservaId = r.substring(nroStart, nroEnd).trim();
                                }
                                if(r.contains("Vuelo: ")) {
                                    int vueloStart = r.indexOf("Vuelo: ") + 7;
                                    int vueloEnd = r.indexOf(" -", vueloStart);
                                    if(vueloEnd > vueloStart) vueloId = r.substring(vueloStart, vueloEnd).trim();
                                }
                        %>
                        <li>
                            <%= r %>
                            <!-- Ver Reserva: needs vueloId to find reservation  -->
                            <a class="btn btn-xs btn-primary ml-2"
                               href="<%= request.getContextPath() %>/ConsultaReservaVueloServlet?vueloId=<%= vueloId %>">Ver Reserva</a>
                            <!-- Ver Ruta: show route via vueloId -->
                            <a class="btn btn-xs btn-secondary ml-2"
                               href="<%= request.getContextPath() %>/ConsultaVueloServlet?vueloId=<%= vueloId %>">Ver Ruta</a>
                        </li>
                        <%  }
                        } else { %>
                        <li class="text-gray-400 italic">No tiene reservas</li>
                        <% } %>
                    </ul>

                    <!-- Mis Paquetes -->
                    <h4 class="font-semibold text-sm mb-1 mt-2">Mis Paquetes:</h4>
                    <ul class="list-disc ml-6 text-sm">
                        <% if(misPaquetes != null && !misPaquetes.isEmpty()) {
                            for(String p : misPaquetes){
                                // Parse: "Reserva Nro: 78 - Paquete: paq131"
                                String paqueteNombre = "";
                                if(p.contains("Paquete: ")) {
                                    paqueteNombre = p.substring(p.indexOf("Paquete: ") + 9).trim();
                                }
                        %>
                        <li>
                            <%= p %>
                            <!-- Use 'paquete' parameter, not 'paqueteId' -->
                            <a class="btn btn-xs btn-primary ml-2"
                               href="<%= request.getContextPath() %>/ConsultaPaqueteRutaVueloServlet?paquete=<%= java.net.URLEncoder.encode(paqueteNombre, "UTF-8") %>">Ver Paquete</a>
                        </li>
                        <%  }
                        } else { %>
                        <li class="text-gray-400 italic">No tiene paquetes</li>
                        <% } %>
                    </ul>

                </div>
                <% } %>



                <div class="mt-6 flex justify-center">
                    <button class="btn btn-primary"
                            onclick="document.getElementById('<%= modalId %>').classList.add('hidden')">
                        Cerrar
                    </button>
                </div>
            </div>
        </div>

        <% }
        } else { %>
        <p class="text-gray-500 text-center">No hay clientes registrados.</p>
        <% } %>
    </div>
    <!-- ============================ -->
    <!--       LISTA AEROLÍNEAS       -->
    <!-- ============================ -->

    <div class="space-y-3 w-full">
        <h2 class="text-xl font-semibold mb-2 text-center">Aerolíneas</h2>

        <%
            List<Aerolinea> aerolineas = (List<Aerolinea>) request.getAttribute("aerolineas");
            if (aerolineas != null && !aerolineas.isEmpty()) {
                for (Aerolinea a : aerolineas) {
                    String modalIdA = "modal-" + a.getNickname();
        %>

        <div class="card bg-base-100 shadow-md p-4 flex items-start justify-between cursor-pointer hover:bg-base-300 transition"
             onclick="document.getElementById('<%= modalIdA %>').classList.remove('hidden')">

            <div class="flex items-center gap-4">
                <img src="<%= a.getUrlImagen() != null ? a.getUrlImagen() : (request.getContextPath() + "/img/default-user.jpg") %>"
                     alt="Logo de <%= a.getNombre() %>"
                     class="w-16 h-16 object-cover rounded-full shadow-sm">

                <div>
                    <h3 class="font-bold text-lg"><%= a.getNombre() %></h3>
                    <p class="text-sm opacity-70">Haz click para saber más sobre esta aerolínea.</p>
                </div>
            </div>
        </div>

        <!-- MODAL AEROLINEA -->
        <div id="<%= modalIdA %>"
             class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm transition-opacity duration-300">

            <div class="bg-base-100 rounded-2xl shadow-2xl w-full max-w-md mx-4 p-6 relative">

                <button class="absolute top-6 right-4 text-gray-400 hover:text-gray-700"
                        onclick="document.getElementById('<%= modalIdA %>').classList.add('hidden')">✕</button>

                <div class="flex flex-col items-center text-center">
                    <img src="<%= a.getUrlImagen() != null ? a.getUrlImagen() : (request.getContextPath() + "/img/default-aerolinea.png") %>"
                         class="w-24 h-24 object-cover rounded-full shadow-md">

                    <h3 class="font-bold text-xl"><%= a.getNombre() %></h3>
                </div>

                <hr class="mt-4 mb-2">
                <p class="italic text-sm text-center">"<%= a.getDescripcion() != null ? a.getDescripcion() : "Sin descripción disponible." %>"</p>
                <hr class="mt-2 mb-4">

                <span class="text-sm flex items-center gap-1">
                    <b>Contacto:</b> <%= a.getEmail() %>
                </span>

                <% if (a.getSitioWeb() != null && !a.getSitioWeb().isEmpty()) { %>
                <p class="text-sm text-blue-600 hover:underline">
                    <a href="<%= a.getSitioWeb() %>" target="_blank">Visitar sitio web</a>
                </p>
                <% } %>

                <!-- RUTAS -->
                <%
                    Map<String, List<String>> rutasPorAerolinea = (Map<String, List<String>>) request.getAttribute("rutasPorAerolinea");
                    List<String> rutas = rutasPorAerolinea.get(a.getNickname());

                    Map<String, List<String>> rutasPorAerolineaAll = (Map<String, List<String>>) request.getAttribute("rutasPorAerolineaAll");
                    List<String> rutasAll = rutasPorAerolineaAll.get(a.getNickname());

                    Object usuario = session.getAttribute("usuario");
                    String tipo = (String) session.getAttribute("tipoUsuario");
                %>

                <div class="w-full mt-4 text-left">
                    <h4 class="font-semibold text-sm mb-1 flex items-center gap-2">Rutas</h4>

                    <% if ("AEROLINEA".equalsIgnoreCase(tipo)) { %>

                    <% if (rutasAll != null && !rutasAll.isEmpty()) { %>
                    <ul class="list-disc ml-6 text-sm space-y-1">
                        <% for (String r : rutasAll) { %>
                        <li><a href="<%= request.getContextPath() %>/ConsultaRutaVueloServlet?rutaId=<%= java.net.URLEncoder.encode(r, "UTF-8") %>" 
                               class="text-primary hover:underline"><%= r %></a></li>
                        <% } %>
                    </ul>
                    <% } else { %>
                    <p class="text-sm text-gray-400 italic ml-1">No hay rutas confirmadas.</p>
                    <% } %>

                    <% } else { %>

                    <% if (rutas != null && !rutas.isEmpty()) { %>
                    <ul class="list-disc ml-6 text-sm space-y-1">
                        <% for (String r : rutas) { %>
                        <li><a href="<%= request.getContextPath() %>/ConsultaRutaVueloServlet?rutaId=<%= java.net.URLEncoder.encode(r, "UTF-8") %>" 
                               class="text-primary hover:underline"><%= r %></a></li>
                        <% } %>
                    </ul>
                    <% } else { %>
                    <p class="text-sm text-gray-400 italic ml-1">No hay rutas confirmadas.</p>
                    <% } %>

                    <% } %>
                </div>

                <%
                    List<String> seguidoresA = seguidoresPorUsuario.get(a.getNickname());
                    List<String> seguidosA = seguidosPorUsuario.get(a.getNickname());
                %>

                <div class="mt-4 w-full text-left">
                    <h4 class="font-semibold text-sm mb-1">Seguidores</h4>
                    <% if (seguidoresA != null && !seguidoresA.isEmpty()) { %>
                    <ul class="list-disc ml-6 text-sm space-y-1">
                        <% for (String s : seguidoresA) { %>
                        <li><%= s %></li>
                        <% } %>
                    </ul>
                    <% } else { %>
                    <p class="text-sm text-gray-400 italic ml-1">No tiene seguidores.</p>
                    <% } %>

                    <h4 class="font-semibold text-sm mt-3 mb-1">Seguidos</h4>
                    <% if (seguidosA != null && !seguidosA.isEmpty()) { %>
                    <ul class="list-disc ml-6 text-sm space-y-1">
                        <% for (String s : seguidosA) { %>
                        <li><%= s %></li>
                        <% } %>
                    </ul>
                    <% } else { %>
                    <p class="text-sm text-gray-400 italic ml-1">No sigue a ningún usuario.</p>
                    <% } %>
                </div>

                <div class="mt-6 flex justify-center gap-3">
                    <button class="btn rounded-full btn-primary"
                            onclick="document.getElementById('<%= modalIdA %>').classList.add('hidden')">Cerrar</button>
                </div>

            </div>
        </div>

        <%
            }
        } else {
        %>
        <p class="text-gray-500 text-center">No hay aerolíneas registradas.</p>
        <% } %>
    </div>

</div>

<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />

<!-- ASIDE MENU -->
<jsp:include page="includes/aside.jsp" />

<script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>
