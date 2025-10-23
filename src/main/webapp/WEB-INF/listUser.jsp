<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Cliente" %>
<%@ page import="model.Aerolinea" %>


<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

   <div class=" w-full mx-auto    max-w-4xl">
    <h1 class="text-3xl mb-2">Listar Usuarios</h1>
    <p class="text-sm mb-6">
     A continuación se muestra una lista de todos los <b>usuarios registrados</b> en la plataforma VolandoUy.
    </p>
    

    <!-- Subtítulo -->
    <h2 class="text-xl">Datos del Usuario</h2>
    <p class="text-sm mb-4 text-base-content/80">
        Revisa los perfiles de los usuarios registrados, incluyendo sus nombres, apellidos y direcciones de correo electrónico.<br/>
        Haz clic en los usuarios para obtener más detalles sobre ellos.

    </p>
  </div>
  
<div id="listaUsuarios" class="grid grid-cols-2 md:grid-cols-2 gap-6 max-w-7xl mx-auto">

  <div class="space-y-3 w-full">
      <h2 class="text-xl font-semibold mb-2 text-center">Clientes</h2>
      <%
          List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
          if (clientes != null && !clientes.isEmpty()) {
              for (Cliente c : clientes) {
                String modalId = "modal-" + c.getNickname();
      %>
      <div        onclick="document.getElementById('<%= modalId %>').classList.remove('hidden')" class="card bg-base-100 shadow-md p-4 flex items-start justify-between cursor-pointer hover:bg-base-300 transition"
         >
          <div class="flex items-center gap-4">
              <img src="<%= c.getUrlImagen() != null ? c.getUrlImagen() : (request.getContextPath() + "/img/default-user.jpg") %>"
                   alt="Foto de <%= c.getNombre() %>"
                   class="w-16 h-16 object-cover rounded-full  shadow-sm">
              <div>
                  <h3 class="font-bold text-lg"><%= c.getNombre() %> <%= c.getApellido() %></h3>
                  <span class="text-sm opacity-70"><%= c.getEmail() %></span>
              </div>
          </div>
      </div>

<div id="<%= modalId %>" 
     class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm transition-opacity duration-300">

  <div class="bg-base-100 rounded-2xl shadow-2xl w-full max-w-md mx-4 p-6 relative animate-fadeIn">

      <button class="absolute top-3 right-3 text-gray-400 hover:text-gray-700 transition" 
              onclick="document.getElementById('<%= modalId %>').classList.add('hidden')">
          ✕
      </button>

      <div class="flex flex-col items-center text-center space-y-3 mt-2">
          <img src="<%= c.getUrlImagen() != null ? c.getUrlImagen() : (request.getContextPath() + "/img/default-user.jpg") %>"
               alt="Foto de <%= c.getNombre() %>"
               class="w-24 h-24 object-cover rounded-full border border-gray-300 shadow-md">

          <h3 class="font-bold text-xl mt-2"><%= c.getNombre() %> <%= c.getApellido() %></h3>
          <p class="text-sm text-gray-500"><%= c.getEmail() %></p>
          <p class="text-sm text-gray-500">Documento: <%= c.getNumDocumento() %></p>
          <p class="text-sm text-gray-500">Nacionalidad: <%= c.getNacionalidad() %></p>
          <p class="text-sm text-gray-500">Tipo Documento: <%= c.getTipoDocumento() %></p>
      </div>

      <div class="mt-6 flex justify-center">
          <button class="btn btn-primary"
                  onclick="document.getElementById('<%= modalId %>').classList.add('hidden')">
              Cerrar
          </button>
      </div>
  </div>
</div>

      <% 
              }
          } else {
      %>
      <p class="text-gray-500 text-center">No hay clientes registrados.</p>
      <% } %>
  </div>

  <div class="space-y-3 w-full">
      <h2 class="text-xl font-semibold mb-2 text-center">Aerolíneas</h2>
      <%
          List<Aerolinea> aerolineas = (List<Aerolinea>) request.getAttribute("aerolineas");
          if (aerolineas != null && !aerolineas.isEmpty()) {
              for (Aerolinea a : aerolineas) {
                String modalIdA = "modal-" + a.getNickname();
      %>
      <div class="card bg-base-100 shadow-md p-4 flex  items-start justify-between cursor-pointer hover:bg-base-300 transition"
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

<!-- Modal -->
    <div id="<%= modalIdA %>" 
         class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm transition-opacity duration-300">

      <div class="bg-base-100 rounded-2xl shadow-2xl w-full max-w-md mx-4 p-6 relative animate-fadeIn overflow-hidden">

          <!-- Botón cerrar -->
          <button class="absolute top-6 right-4 text-gray-400 hover:text-gray-700 transition" 
                  onclick="document.getElementById('<%= modalIdA %>').classList.add('hidden')">
              ✕
          </button>

          <!-- Contenido -->
          <div class="flex flex-col items-center">
              <img src="<%= a.getUrlImagen() != null ? a.getUrlImagen() : (request.getContextPath() + "/img/default-aerolinea.png") %>"
                   alt="Logo de <%= a.getNombre() %>"
                   class="w-24 h-24 object-cover rounded-full shadow-md">
            
              <h3 class="font-bold text-xl"><%= a.getNombre() %></h3>




          </div>

              <hr class="mt-4 mb-2">
                                         <p class=" italic text-sm text-center leading-relaxed">"<%= a.getDescripcion() != null ? a.getDescripcion() : "Sin descripción disponible." %>"
              </p>
               <hr class="mt-2 mb-4">


              <span class="text-sm text-start flex items-center gap-1">
                <i class="icon-[tabler--mail] size-4"></i>
                <b>Contacto:</b> <%= a.getEmail() %>
            </span>
             



        <% if (a.getSitioWeb() != null && !a.getSitioWeb().isEmpty()) { %>
        <p class="text-sm text-blue-600 hover:underline flex items-center gap-1">
            <a   href="<%= a.getSitioWeb() %>" target="_blank">Visitar sitio web</a>
        </p>
        <% } %>


        <%
            Map<String, List<String>> rutasPorAerolinea = (Map<String, List<String>>) request.getAttribute("rutasPorAerolinea");
            List<String> rutas = rutasPorAerolinea.get(a.getNickname());

            Map<String, List<String>> rutasPorAerolineaAll = (Map<String, List<String>>) request.getAttribute("rutasPorAerolineaAll");
            List<String> rutasAll = rutasPorAerolineaAll.get(a.getNickname());

            Object usuario  = session.getAttribute("usuario");
            String tipoCuenta = "usuario";
            
            if (usuario == null)  { tipoCuenta = "VISITANTE"; }
            else  {
            java.lang.reflect.Method getTipo = usuario.getClass().getMethod("getTipo");
            Object tipoObj = getTipo.invoke(usuario);
            if (tipoObj != null) tipoCuenta = tipoObj.toString().toUpperCase();
            
            String tipo = (String) session.getAttribute("tipoUsuario");

            if ("AEROLINEA".equalsIgnoreCase(tipo)) { %>

            <div class="w-full mt-4 text-left">
                <h4 class="font-semibold text-sm mb-1 flex items-center gap-2">
                    <i class="icon-[tabler--route] size-4"></i>
                    Rutas
                </h4>

                <% if (rutasAll != null && !rutasAll.isEmpty()) { %>
                    <ul class="list-disc ml-6 text-sm  space-y-1">
                        <% for (String r : rutasAll) { %>
                            <li><%= r %></li>
                        <% } %>
                    </ul>
                <% } else { %>
                    <p class="text-sm text-gray-400 italic ml-1">No hay rutas confirmadas.</p>
                <% } %>
            </div>




        <% } else if ("CLIENTE".equalsIgnoreCase(tipo)) { %>

            <div class="w-full mt-4 text-left">
                <h4 class="font-semibold text-sm mb-1 flex items-center gap-2">
                    <i class="icon-[tabler--route] size-4"></i>
                    Rutas confirmadas
                </h4>

                <% if (rutas != null && !rutas.isEmpty()) { %>
                    <ul class="list-disc ml-6 text-sm  space-y-1">
                        <% for (String r : rutas) { %>
                            <li><%= r %></li>
                        <% } %>
                    </ul>
                <% } else { %>
                    <p class="text-sm text-gray-400 italic ml-1">No hay rutas confirmadas.</p>
                <% } %>
            </div>


        <% } else { %>

            <div class="w-full mt-4 text-left">
                <h4 class="font-semibold text-sm mb-1 flex items-center gap-2">
                    <i class="icon-[tabler--route] size-4"></i>
                    Rutas confirmadas
                </h4>

                <% if (rutas != null && !rutas.isEmpty()) { %>
                    <ul class="list-disc ml-6 text-sm  space-y-1">
                        <% for (String r : rutas) { %>
                            <li><%= r %></li>
                        <% } %>
                    </ul>
                <% } else { %>
                    <p class="text-sm text-gray-400 italic ml-1">No hay rutas confirmadas.</p>
                <% } %>
            </div>
        <% } %>
 <% } %>


          <!-- Botones -->
          <div class="mt-6 flex justify-center gap-3">
              <button class="btn rounded-full btn-primary"
                      onclick="document.getElementById('<%= modalIdA %>').classList.add('hidden')">
                  Cerrar
              </button>
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

    </div>
    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>