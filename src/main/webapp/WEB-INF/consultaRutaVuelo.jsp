<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />


<main class="flex flex-1 p-4 gap-4 bg-base-200">
     
    <section class="flex-1 bg-base-200 p-4 rounded-lg  space-y-4">

            <div class="mt-10 w-full mx-auto text-center   max-w-4xl">
                <h1 class="text-3xl mb-2">Consultar Rutas de Vuelo</h1>     
            </div>
            
            <form class="mt-10 max-w-4xl w-full  mx-auto gap-6 base-200  space-y-6 mx-auto" action="ModUserServlet" method="post">
                <div class="mt-4 grid grid-cols-1 md:grid-cols-3 gap-6">
                  <!-- Aerolínea -->
                  <div class="relative">
                    <span>Aerolíneas Disponibles</span>
                    <select name="aerolinea" class="select select-bordered w-full peer mt-1 pt-6">
                      <option value="" disabled selected>Selecciona una aerolínea</option>
                      <option>ZulyFly</option>
                    </select>
                    <span class="text-xs text-gray-500 mt-2 block">Elige la aerolínea que opera la ruta.</span>
                  </div>

                  <!-- Categoría -->
                  <div class="relative">
                    <span>Categorías Disponibles</span>
                    <select name="categoria" class="select select-bordered w-full peer mt-1 pt-6">
                      <option value="" disabled selected>Selecciona una categoría</option>
                      <option>Nacionales</option>
                    </select>
                    <span class="text-xs text-gray-500 mt-2 block">Selecciona el tipo o alcance de la ruta.</span>
                  </div>

                    <div class="mt-0.5">
                    <button class="mt-6 btn btn-primary btn-block">Buscar Rutas</button>
                    </div>
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