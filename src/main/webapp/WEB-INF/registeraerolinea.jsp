<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<jsp:include page="includes/head.jsp" />
<body class="flex flex-col min-h-screen over">

  <nav class="navbar bg-[#0C4DC3] shadow-sm px-6">
        
        <!-- Izquierda de la NAV-->
        <div class="navbar-start">
          <div class="flex items-center">
            <a href="${pageContext.request.contextPath}/">
              <img src="${pageContext.request.contextPath}/favicon.png" 
                  class="w-8 h-8 rounded-md cursor-pointer hover:scale-105 transition-transform" 
                  alt="logo" />
            </a>
            <span class="text-white font-semibold">VolandoUy</span>
          </div>
        </div>
        
        <!-- Centro de la NAV-->
        <div class="navbar-end">
          <button
            onclick="window.location.href='login'"
            class="border-white text-sm btn btn-sm btn-primary rounded-full mr-1 shadow-none"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="18"
              height="18"
              viewBox="0 0 24 24"
            >
              <path
                fill="currentColor"
                d="M12 4a4 4 0 0 1 4 4a4 4 0 0 1-4 4a4 4 0 0 1-4-4a4 4 0 0 1 4-4m0 10c4.42 0 8 1.79 8 4v2H4v-2c0-2.21 3.58-4 8-4"
              />
            </svg>
            Iniciar Sesion
          </button>
        </div>
                </button>
        <button
          class="btn btn-sm btn-circle shadow-none btn-primary"
          aria-label="Circle Soft Icon Button"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
          >
            <path
              fill="currentColor"
              d="M12 22q-2.05 0-3.875-.788t-3.187-2.15t-2.15-3.187T2 12q0-2.075.788-3.887t2.15-3.175t3.187-2.15T12 2q2.075 0 3.888.788t3.174 2.15t2.15 3.175T22 12q0 2.05-.788 3.875t-2.15 3.188t-3.175 2.15T12 22m0-2.05q.65-.9 1.125-1.875T13.9 16h-3.8q.3 1.1.775 2.075T12 19.95m-2.6-.4q-.45-.825-.787-1.713T8.05 16H5.1q.725 1.25 1.813 2.175T9.4 19.55m5.2 0q1.4-.45 2.488-1.375T18.9 16h-2.95q-.225.95-.562 1.838T14.6 19.55M4.25 14h3.4q-.075-.5-.112-.987T7.5 12t.038-1.012T7.65 10h-3.4q-.125.5-.187.988T4 12t.063 1.013t.187.987m5.4 0h4.7q.075-.5.113-.987T14.5 12t-.038-1.012T14.35 10h-4.7q-.075.5-.112.988T9.5 12t.038 1.013t.112.987m6.7 0h3.4q.125-.5.188-.987T20 12t-.062-1.012T19.75 10h-3.4q.075.5.113.988T16.5 12t-.038 1.013t-.112.987m-.4-6h2.95q-.725-1.25-1.812-2.175T14.6 4.45q.45.825.788 1.713T15.95 8M10.1 8h3.8q-.3-1.1-.775-2.075T12 4.05q-.65.9-1.125 1.875T10.1 8m-5 0h2.95q.225-.95.563-1.838T9.4 4.45Q8 4.9 6.912 5.825T5.1 8"
            />
          </svg>
        </button>
  </nav>

<main class="flex flex-col items-center min-h-screen bg-base-200 text-base-content px-6 py-12">
      <!-- Título principal -->
  <div class="mt-10 w-full mx-auto    max-w-4xl">
    <h1 class="text-3xl mb-2">Crear Cuenta</h1>
    <p class="text-sm mb-6">
      Si ya eres parte de VolandoUY, no necesitas crear una cuenta nueva. 
      <a href="login" class="underline font-semibold">inicia sesión</a> 
      con tus datos de siempre.
    </p>
    

    <!-- Subtítulo -->
    <h2 class="text-xl mb-2">Datos de la aerolínea</h2>
    <p class="text-sm mb-4 text-base-content/80">
Ingresá los datos oficiales de tu aerolínea <b>tal como figuran en los registros comerciales</b>.
Esta información se utilizará para la <b>emisión de vuelos, facturación y verificación de identidad empresarial</b>.
    </p>
  </div>
  
  
  <div class="max-w-4xl w-full mx-auto gap-4">
    <!-- Formulario -->
    <form class="mt-4 grid gap-6" action="RegisterAServlet" method="post" enctype="multipart/form-data">
      
            <!-- Nombre(s) -->
      <label class=" mt-2 form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Nickname</span>
        </div>
        <input required id="nicknameAerolinea" name="nicknameAerolinea" type="text" placeholder="Ingresa tu nombre o nombres" class="input input-bordered w-full bg-base-200" />
        <div id="nickname-feedback"></div>
        <span class="label-text-alt text-xs opacity-70">El nickname debe ser único y representativo de tu aerolínea.</span>
      </label>

      <!-- Nombre(s) -->
      <label class=" form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Nombre(s)</span>
        </div>
        <input required id="nombreAerolinea" name="nombreAerolinea" type="text" placeholder="Ingresa tu nombre o nombres" class="input input-bordered w-full bg-base-200" />
        <span class="label-text-alt text-xs opacity-70">Usa el nombre legal completo de la aerolínea.</span>
      </label>

      <!-- Apellidos -->
      <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Correo electrónico</span>
        </div>
        <input required id="emailAerolinea" name="emailAerolinea" type="text" placeholder="Ingresa tu correo electrónico" class="input input-bordered w-full bg-base-200" required />
        <div id="email-feedback"></div>
        <div class="label">
          <span class="label-text-alt text-xs opacity-70"><b>Prefiere tu email empresarial </b> para asegurar que recibas nuestra comunicación.</span>
        </div>
      </label>

      <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Descripción</span>
        </div>
        <input required type="text" id="descripcionAerolinea" name="descripcionAerolinea" placeholder="Ingresa una breve descripción" class="input input-bordered w-full bg-base-200" required />
        <div class="label">
          <span class="label-text-alt text-xs opacity-70">Describe brevemente los servicios que ofreces.</span>
        </div>
      </label>

            <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Sitio web</span>
        </div>
        <input type="url" id="sitioWebAerolinea" name="sitioWebAerolinea" placeholder="Ingresa tu sitio web" class="input input-bordered w-full bg-base-200" required />
        <div class="label">
        </div>
      </label>
      <!-- Contra -->
<div class="">
  <div class="flex mb-2">
    <div class="flex-1">
              <span class="label-text font-medium">Contraseña</span>

      <input required type="password" name="password" id="password-hints" class="input bg-base-200" placeholder="Ingresa tu Contraseña" />
      <div
        data-strong-password='{
          "target": "#password-hints",
          "hints": "#password-hints-content",
          "stripClasses": "strong-password:hide strong-password-accepted:bg-teal-500 h-1.5 flex-auto bg-neutral/20"
        }'
        class="rounded-full overflow-hidden mt-2 flex gap-0.5">
      </div>
    </div>
  </div>
  <div id="password-hints-content" class="mb-3">
    <div>
      <span class="text-sm text-base-content">Nivel:</span>
      <span
        data-pw-strength-hint='["Vacía", "Débil", "Media", "Fuerte", "Muy fuerte", "Súper fuerte"]'
        class="text-base-content text-sm font-semibold">
      </span>
    </div>
    <h6 class="my-2 text-base font-semibold text-base-content">Tu contraseña debe contener:</h6>
    <ul class="text-base-content/80 space-y-1 text-sm">
      <li data-pw-strength-rule="min-length" class="strong-password-active:text-success flex items-center gap-x-2">
        <span class="icon-[tabler--circle-check] hidden size-5 shrink-0" data-check></span>
        <span class="icon-[tabler--circle-x] hidden size-5 shrink-0" data-uncheck></span>
        Mínimo de 6 caracteres.
      </li>
      <li data-pw-strength-rule="lowercase" class="strong-password-active:text-success flex items-center gap-x-2">
        <span class="icon-[tabler--circle-check] hidden size-5 shrink-0" data-check></span>
        <span class="icon-[tabler--circle-x] hidden size-5 shrink-0" data-uncheck></span>
        Debe contener letras minúsculas.
      </li>
      <li data-pw-strength-rule="uppercase" class="strong-password-active:text-success flex items-center gap-x-2">
        <span class="icon-[tabler--circle-check] hidden size-5 shrink-0" data-check></span>
        <span class="icon-[tabler--circle-x] hidden size-5 shrink-0" data-uncheck></span>
        Debe contener letras mayúsculas.
      </li>
      <li data-pw-strength-rule="numbers" class="strong-password-active:text-success flex items-center gap-x-2">
        <span class="icon-[tabler--circle-check] hidden size-5 shrink-0" data-check></span>
        <span class="icon-[tabler--circle-x] hidden size-5 shrink-0" data-uncheck></span>
        Debe contener números.
      </li>
      <li data-pw-strength-rule="special-characters" class="strong-password-active:text-success flex items-center gap-x-2">
        <span class="icon-[tabler--circle-check] hidden size-5 shrink-0" data-check></span>
        <span class="icon-[tabler--circle-x] hidden size-5 shrink-0" data-uncheck></span>
        Debe contener caracteres especiales.
      </li>
    </ul>
  </div>
</div>

      <!-- Apellidos -->
      <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Confirmar Contraseña</span>
        </div>
        <input required type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirma tu contraseña" class="input input-bordered w-full bg-base-200" required />
        <div class="label">
        </div>
      </label>

      <!-- Apellidos -->
      <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Foto de Perfil</span>
        </div>
        <input type="file" name="file" accept="image/*" required class="input input-bordered w-full bg-base-200"/>
        <div class="label">
          <span class="label-text-alt text-xs opacity-70">Sube una foto para tu perfil.</span>
        </div>
      </label>

      <!-- Botón -->
<!-- Botones al final del formulario -->
<div class="mt-4 mb-4 flex justify-between items-center">
  <!-- Botón Cancelar -->
  <button
    type="button"
    onclick="window.location.href='/'"
    class="btn btn-outline rounded-full"
  >
    Cancelar
  </button>

  <!-- Botón Crear cuenta -->
  <button
    type="submit"
    class="btn btn-primary rounded-full"
  >
    Crear cuenta
  </button>
</div>

    </form>
  </div>
  <div class="mt-10"></div>
</main>

  <!-- Footer--> 
  <jsp:include page="includes/footer.jsp" />

  <!-- Menu Hamburguesa-->
  <jsp:include page="includes/aside.jsp" />

  <script src="${pageContext.request.contextPath}/js/flyonui.js"></script>
  <script>
    function debounce(func, wait) {
        let timeout;
        return function(...args) {
            const context = this;
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(context, args), wait);
        };
    }

    async function validateField(type, value, elementId, feedbackId) {
        const feedbackElement = document.getElementById(feedbackId);
        const inputElement = document.getElementById(elementId);
        
        if (!value) {
            feedbackElement.textContent = "";
            inputElement.classList.remove("input-error", "input-success");
            return;
        }

        try {
            const response = await fetch('ValidacionServlet?type=' + type + '&value=' + encodeURIComponent(value));
            const data = await response.json();
            
            if (data.exists) {
                feedbackElement.textContent = data.message;
                feedbackElement.className = "text-error text-sm mt-1";
                inputElement.classList.add("input-error");
                inputElement.classList.remove("input-success");
            } else {
                feedbackElement.textContent = data.message;
                feedbackElement.className = "text-success text-sm mt-1";
                inputElement.classList.add("input-success");
                inputElement.classList.remove("input-error");
            }
        } catch (error) {
            console.error('Error validating ' + type, error);
        }
    }

    document.getElementById('nicknameAerolinea').addEventListener('input', debounce(function(e) {
        validateField('nickname', e.target.value, 'nicknameAerolinea', 'nickname-feedback');
    }, 500));

    document.getElementById('emailAerolinea').addEventListener('input', debounce(function(e) {
        validateField('email', e.target.value, 'emailAerolinea', 'email-feedback');
    }, 500));
  </script>
</body>
</html>