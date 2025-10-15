<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Cliente" %>

<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">
    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

 <h2 class="mt-6 text-2xl font-bold mb-6 text-center">Usuarios registrados</h2>

    <div id="listaUsuarios" class="w-full max-w-3xl mx-auto space-y-3">
        <%
            List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
            if (clientes != null && !clientes.isEmpty()) {
                for (Cliente c : clientes) {
        %>
        <div class="text-center card bg-base-100 shadow-md p-4 flex justify-between items-center cursor-pointer hover:bg-base-300 transition"
             onclick="window.location.href='ViewUserServlet?nickname=<%= c.getNickname() %>'">
            <div>
                <h3 class="font-bold text-lg"><%= c.getNombre() %> <%= c.getApellido() %></h3>
                <p class="text-sm opacity-70"><%= c.getEmail() %></p>
            </div>
            <span class="mt-2 badge badge-primary">Ver perfil</span>
        </div>
        <% 
                }
            } else {
        %>
        <p class="text-gray-500 text-center">No hay clientes registrados.</p>
        <% } %>
    </div>
    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa-->
    <jsp:include page="includes/aside.jsp" />

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
</body>
</html>