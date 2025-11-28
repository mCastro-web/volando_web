<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="bg-base-200 min-h-screen flex flex-col">

    
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

    <!-- Barra de Navegacion --> 
    <jsp:include page="includes/nav.jsp" />

    <!-- Hero Section -->
    <main class="flex-1">

      <div class="flex flex-col overflow-x-hidden">
        
        <!-- Hero Content -->
        <div class="mt-20 mx-auto flex max-w-7xl flex-col items-center gap-8 justify-self-center px-4 text-center sm:px-6 lg:px-8 pt-32 md:pt-40 lg:pt-48 pb-12">
          
          <!-- Title -->
          <h1 class="text-base-content relative z-1 text-2xl leading-[1.15] font-bold max-md:text-3xl md:max-w-3xl md:text-balance">
            <span>Descubre el Mundo con VolandoUy</span>
            <svg
              width="223"
              height="12"
              viewBox="0 0 223 12"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
              class="absolute -bottom-1.5 left-10 -z-1 max-lg:left-4 max-md:hidden"
            >
              <path
                d="M1.30466 10.7431C39.971 5.28788 76.0949 3.02 115.082 2.30401C143.893 1.77489 175.871 0.628649 204.399 3.63102C210.113 3.92052 215.332 4.91391 221.722 6.06058"
                stroke="url(#paint0_linear_10365_68643)"
                stroke-width="2"
                stroke-linecap="round"
              />
              <defs>
                <linearGradient
                  id="paint0_linear_10365_68643"
                  x1="19.0416"
                  y1="4.03539"
                  x2="42.8362"
                  y2="66.9459"
                  gradientUnits="userSpaceOnUse"
                >
                  <stop offset="0.2" stop-color="#0C4DC3" />
                  <stop offset="1" stop-color="#0a3d9f" />
                </linearGradient>
              </defs>
            </svg>
          </h1>
          
          <!-- Description -->
          <p class="text-base-content/80 max-w-3xl text-lg">
            Reserva tus vuelos a los mejores destinos del mundo. Ofertas exclusivas, rutas directas y paquetes especiales 
            para que tu viaje sea inolvidable. ¡Volá con nosotros!
          </p>

          <!-- CTA Button -->
          <a href="BusquedaServlet?queryBusqueda=" class="btn btn-primary btn-lg">
            Explorar Destinos
            <span class="material-icons">flight_takeoff</span>
          </a>
        </div>


<div class="mt-20 relative w-full overflow-hidden" style="aspect-ratio: 2.35;">
  <img
    id="heroImage"
    src="https://cdn.discordapp.com/attachments/1366301736406487092/1443748515313487933/avion.jpg?ex=692a3315&is=6928e195&hm=90d3f73699219bcc9e27854606d14880f381993adac87e4d94dc640402732665&"
    alt="Avión volando"
    class="w-full h-full object-cover"
  />
  <div class="absolute inset-0 bg-gradient-to-t from-base-100 via-transparent to-transparent"></div>
</div>

    
</main>



    <!-- Footer--> 
    <jsp:include page="includes/footer.jsp" />

    <!-- Menu Hamburguesa--> 
    <jsp:include page="includes/aside.jsp" />

</body>
</html>