<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

    <script>
    <% String successMsg = (String) request.getAttribute("notyf_success");
    if (successMsg != null) { %>
        const notyf = new Notyf({
        duration: 4000,
        position: { x: 'right', y: 'top' }
        });
        notyf.success("<%= successMsg %>");
    <% } %>
    </script>


    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

</body>
</html>