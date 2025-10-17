<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

    <main class="flex flex-1 p-4 gap-4">



    <!-- Contenido central -->
    <section class="flex-1 bg-base-100 p-4 rounded-lg shadow-md space-y-6">
        <h2 class="text-2xl font-bold text-center">Consulta de Vuelo</h2>

        <!-- Filtros -->
        <div class="rounded-box border p-4 space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
            <!-- Aerolínea -->
            <div class="form-control">
            <label class="label"><span class="label-text">Aerolínea</span></label>
            <select id="selAero" class="select select-bordered w-full"></select>
            </div>

            <div class="form-control">
            <button id="btnFiltrar" class="mt-2   btn btn-primary w-full">Listar rutas confirmadas</button>
            </div>
        </div>

        <!-- Paso 2: Rutas confirmadas -->
        <div>
            <h3 class="font-semibold mb-2">Rutas confirmadas de la aerolínea</h3>
            <div id="rutasWrap" class="grid md:grid-cols-2 lg:grid-cols-3 gap-3 max-w-sm">
            <!-- tarjetas de rutas -->
            </div>
            <p id="msgRutas" class="text-sm text-base-content/70 mt-2"></p>
        </div>

        <!-- Paso 3: Vuelos de la ruta seleccionada -->
        <div id="vuelosPanel" class="hidden">
            <div class="flex items-center justify-between mt-4 mb-2">
            <h3 class="font-semibold">Vuelos de la ruta: <span id="rutaNombre" class="font-normal"></span></h3>
            <button id="btnClearRuta" class="btn btn-ghost btn-sm">Cambiar ruta</button>
            </div>
            <div id="vuelosWrap" class="max-w-sm grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
            <!-- tarjetas de vuelos -->
            </div>
        </div>

        <!-- Paso 4: Datos del vuelo -->
        <div id="vueloPanel" class="hidden">
            <div class="flex items-center justify-between mt-4 mb-2">
            <h3 class="font-semibold">Datos del vuelo</h3>
            <button id="btnClearVuelo" class="btn btn-ghost btn-sm">Cambiar vuelo</button>
            </div>

            <div class="grid md:grid-cols-2 gap-4">
            <div>
                <img id="vueloImg" class="w-full h-56 md:h-72 object-cover rounded-lg" alt="Imagen del vuelo">
            </div>
            <div class="space-y-2">
                <p><span class="font-medium">Código:</span> <span id="vueloCod"></span></p>
                <p><span class="font-medium">Ruta:</span> <span id="vueloRuta"></span></p>
                <p><span class="font-medium">Fecha:</span> <span id="vueloFecha"></span></p>
                <p><span class="font-medium">Duración:</span> <span id="vueloDur"></span></p>
                <p><span class="font-medium">Aerolínea:</span> <span id="vueloAero"></span></p>
                <p><span class="font-medium">Estado de ruta:</span> <span id="vueloEstadoRuta"></span></p>
            </div>
            </div>
            

            <!-- Bloques condicionales: reservas -->
            <div id="panelAero" class="hidden mt-4">
            <h4 class="font-semibold mb-2">Reservas del vuelo (vista Aerolínea)</h4>
            <div id="tablaReservas" class="overflow-x-auto">
                <!-- tabla -->
            </div>
            </div>

            <div id="panelCliente" class="hidden mt-4">
            <h4 class="font-semibold mb-2">Mi reserva</h4>
            <div id="miReserva" class="bg-base-100 border rounded-lg p-3">
                <!-- datos reserva cliente -->
            </div>
            </div>
        </div>
        </div>

        <button class="btn btn-primary btn-block" onclick="window.location.href='index.html'">Volver</button>
    </section>

    </main>

    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>