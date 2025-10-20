<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />


    <h2>Subir imagen a Supabase</h2>
    <form action="testServlet" method="post" enctype="multipart/form-data">
        <input type="file" name="file" accept="image/*" required>
        <button type="submit">Subir</button>
    </form>


        <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>