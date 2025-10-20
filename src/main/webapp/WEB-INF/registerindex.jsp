<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
  <body
    class="flex flex-col min-h-screen bg-[url('https://media.cntraveler.com/photos/5ecfba5e9a7ab19ab473f686/16:9/w_2560%2Cc_limit/Grenada-GettyImages-1126733787.jpg')] bg-cover bg-center bg-no-repeat"
  >

    <main class="flex flex-1 justify-center items-center p-4 h-xl">
        <section class="d  p-8 items-center rounded-lg shadow-md w-full max-w-2xl">
            <div class="mt-6 flex flex-col justify-center  sm:flex-row gap-6 mt-6">
                <button
                onclick="window.location.href='registercliente'"
                class="btn btn-primary btn-lg h-20 w-64 text-lg font-semibold shadow-md hover:shadow-lg transition-all"
                >
            
                Registrarme como un Cliente
                </button>

                <button
                onclick="window.location.href='registeraerolinea'"
                class="text-center btn btn-primary btn-lg h-20 w-64 text-lg font-semibold shadow-md hover:shadow-lg transition-all"
                >
                
                Registrarme como Aerolínea
                </button>
            </div>
        </section>
    </main>    

    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>