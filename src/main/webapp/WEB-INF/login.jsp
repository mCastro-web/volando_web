<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
  <jsp:include page="includes/head.jsp" />
  <body
    class="flex flex-col min-h-screen bg-[url('https://media.cntraveler.com/photos/5ecfba5e9a7ab19ab473f686/16:9/w_2560%2Cc_limit/Grenada-GettyImages-1126733787.jpg')] bg-cover bg-center bg-no-repeat"
  >
    <!-- Contenido central -->
    <main class="flex flex-1 items-center justify-center">
      <div class="card shadow-2xl dark:bg-base-200 bg-base-100">
        <div class="card-body">
          <div class="flex items-center justify-center mb-6">
            <img
              src="${pageContext.request.contextPath}/favicon.png"
              class="w-10 h-10 rounded-md"
              alt="logo"
            />
          </div>
          <h3
            class="text-base-content mb-8 text-2xl font-semibold text-center"
          >
            Iniciar sesión
          </h3>

          <form action="/LoginServlet" method="post" class="space-y-5">
            <!-- Usuario -->
            <div class="input-floating max-w-sm bg-base-200">
              <input
                type="text"
                id="user"
                name="user"
                placeholder=""
                class="input input-bordered w-full peer bg-base-200"
                required
              />
              <label class="input-floating-label bg-base-200" for="user">
                Correo electrónico o Nickname
              </label>
              <span class="helper-text hidden text-red-500" id="userError">
                Ingresá tu correo o nickname.
              </span>
              <% String errorUser = (String) request.getAttribute("errorUser");
                if (errorUser != null) { %>
                  <span class="text-red-500 text-sm mt-1"><%= errorUser %></span>
              <% } %>
            </div>


            <!-- Contraseña -->
            <div class="input-floating max-w-sm bg-base-200">
              <input
                type="password"
                id="pass"
                name="pass"
                placeholder=""
                class="input input-bordered w-full peer bg-base-200
                ${not empty errorPass ? 'input-error' : ''}"
                required
                minlength="6"
              />
              <label class="input-floating-label bg-base-200" for="pass">
                Contraseña
              </label>
              <% String errorPass = (String) request.getAttribute("errorPass");
                if (errorPass != null) { %>
                  <span class="text-red-500 text-sm mt-1"><%= errorPass %></span>
              <% } %>
            </div>


            <!-- Recordarme y enlace -->
            <div class="flex items-center justify-between">
              <label class="flex items-center gap-2 cursor-pointer">
                <input
                  type="checkbox"
                  id="rememberMe"
                  class="checkbox checkbox-primary"
                />
                <span class="label-text">Recordarme</span>
              </label>
              <a href="#" class="link link-primary"
                >¿Olvidaste tu contraseña?</a
              >
            </div>

            <button type="submit" class="btn btn-primary btn-block mt-4">
              Iniciar sesión en VolandoUy
            </button>
          </form>

          <p class="text-center text-base-content/80">
            ¿Nuevo en nuestra plataforma?
            <a href="registerindex" class="link link-primary">
              Crea una cuenta
            </a>
          </p>

          <div class="divider">o</div>
          <button class="btn btn-outline btn-block">
            <img
              src="https://cdn.flyonui.com/fy-assets/blocks/marketing-ui/brand-logo/google-icon.png"
              alt="google icon"
              class="size-5"
            />
            Iniciar sesión con Google
          </button>
        </div>
      </div>
    </main>

    <!-- Footer al fondo -->
    <footer
    >
      <jsp:include page="includes/footer.jsp" />
    </footer>

    <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
  </body>
</html>
