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
    <h1 class="text-3xl mb-2">Crear cuenta</h1>
    <p class="text-sm mb-6">
      Si ya eres parte de VolandoUY, no necesitas crear una cuenta nueva. 
      <a href="login" class="underline font-semibold">inicia sesión</a> 
      con tus datos de siempre.
    </p>
    

    <!-- Subtítulo -->
    <h2 class="text-xl mb-2">Datos Personales</h2>
    <p class="text-sm mb-4 text-base-content/80">
        Completa los siguientes campos con tu información personal. 
        Asegúrate de que todos los datos sean correctos antes de continuar.
    </p>
  </div>
  
  
  <div class="max-w-4xl w-full mx-auto gap-4">
    <!-- Formulario -->
    <form class="mt-4 grid gap-6" action="RegisterServlet" method="post">
      
            <!-- Nombre(s) -->
      <label class=" mt-2 form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Nickname</span>
        </div>
        <input required id="nicknameCliente" name="nicknameCliente" type="text" placeholder="Ingresa tu nombre o nombres" class="input input-bordered w-full bg-base-200" />
        <span class="label-text-alt text-xs opacity-70">El nickname debe ser único y representativo de tu Usuario.</span>
      </label>


      <!-- Apellidos -->
      <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Correo electrónico</span>
        </div>
        <input required id="emailCliente" name="emailCliente" type="text" placeholder="Ingresa tu correo electrónico" class="input input-bordered w-full bg-base-200" required />
        <div class="label">
          <span class="label-text-alt text-xs opacity-70"><b>Prefiere tu email personal </b> para asegurar que recibas nuestra comunicación.</span>
        </div>
      </label>

            <!-- Nombre(s) -->
      <label class=" form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Nombre(s)</span>
        </div>
        <input required id="nombreCliente" name="nombreCliente" type="text" placeholder="Ingresa tu nombre o nombres" class="input input-bordered w-full bg-base-200" />
        <span class="label-text-alt text-xs opacity-70">Usa tu nombre completo.</span>
      </label>


      <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Apellido</span>
        </div>
        <input required type="text" id="apellidoCliente" name="apellidoCliente" placeholder="Ingresa tu apellido" class="input input-bordered w-full bg-base-200" required />
        <div class="label">
          <span class="label-text-alt text-xs opacity-70">Usa tu apellido completo.</span>
        </div>
      </label>

      <label class="form-control w-full">
          <div class="label">
            <span class="label-text font-medium">Tipo Documento</span>
          </div>
          <select id="tipoDocumento" name="tipoDocumento" class="select select-bordered w-full bg-base-200">
            <option value="" disabled selected>Selecciona tu tipo de documento</option>
            <option value="CI">Cédula de Identidad</option>
            <option value="Pasaporte">Pasaporte</option>
        </select>
        <span class="label-text-alt text-xs opacity-70">Selecciona el tipo de documento que usarás para identificarte.</span>
      </label>

            <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Documento</span>
        </div>
        <input type="text" id="documentoCliente" name="documentoCliente" placeholder="Ingresa tu numero de documento" class="input input-bordered w-full bg-base-200" required />
        <div class="label">
        </div>
        <span class="label-text-alt text-xs opacity-70">Ingresa el número de tu documento de identidad.</span>
      </label>

                  <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Fecha de Nacimiento</span>
        </div>
        <input type="date" id="fechaNacimientoCliente" name="fechaNacimientoCliente" placeholder="Ingresa tu fecha de nacimiento" class="input input-bordered w-full bg-base-200" required />
        <div class="label">
        </div>
        <span class="label-text-alt text-xs opacity-70">Selecciona tu fecha de nacimiento.</span>
      </label>

      <label class="form-control w-full">
        <div class="label">
          <span class="label-text font-medium">Nacionalidad</span>
        </div>
        <select id="nacionalidadCliente" name="nacionalidadCliente" class="select select-bordered w-full bg-base-200">
                <option value="" disabled selected>Selecciona tu nacionalidad</option>
                <option value="Afghanistan">Afghanistan</option>
                <option value="Åland Islands">Åland Islands</option>
                <option value="Albania">Albania</option>
                <option value="Algeria">Algeria</option>
                <option value="American Samoa">American Samoa</option>
                <option value="Andorra">Andorra</option>
                <option value="Angola">Angola</option>
                <option value="Anguilla">Anguilla</option>
                <option value="Antarctica">Antarctica</option>
                <option value="Antigua and Barbuda">Antigua and Barbuda</option>
                <option value="Argentina">Argentina</option>
                <option value="Armenia">Armenia</option>
                <option value="Aruba">Aruba</option>
                <option value="Australia">Australia</option>
                <option value="Austria">Austria</option>
                <option value="Azerbaijan">Azerbaijan</option>
                <option value="Bahamas">Bahamas</option>
                <option value="Bahrain">Bahrain</option>
                <option value="Bangladesh">Bangladesh</option>
                <option value="Barbados">Barbados</option>
                <option value="Belarus">Belarus</option>
                <option value="Belgium">Belgium</option>
                <option value="Belize">Belize</option>
                <option value="Benin">Benin</option>
                <option value="Bermuda">Bermuda</option>
                <option value="Bhutan">Bhutan</option>
                <option value="Bolivia">Bolivia</option>
                <option value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
                <option value="Botswana">Botswana</option>
                <option value="Bouvet Island">Bouvet Island</option>
                <option value="Brazil">Brazil</option>
                <option value="British Indian Ocean Territory">British Indian Ocean Territory</option>
                <option value="Brunei Darussalam">Brunei Darussalam</option>
                <option value="Bulgaria">Bulgaria</option>
                <option value="Burkina Faso">Burkina Faso</option>
                <option value="Burundi">Burundi</option>
                <option value="Cambodia">Cambodia</option>
                <option value="Cameroon">Cameroon</option>
                <option value="Canada">Canada</option>
                <option value="Cape Verde">Cape Verde</option>
                <option value="Cayman Islands">Cayman Islands</option>
                <option value="Central African Republic">Central African Republic</option>
                <option value="Chad">Chad</option>
                <option value="Chile">Chile</option>
                <option value="China">China</option>
                <option value="Christmas Island">Christmas Island</option>
                <option value="Cocos (Keeling) Islands">Cocos (Keeling) Islands</option>
                <option value="Colombia">Colombia</option>
                <option value="Comoros">Comoros</option>
                <option value="Congo">Congo</option>
                <option value="Congo, The Democratic Republic of The">Congo, The Democratic Republic of The</option>
                <option value="Cook Islands">Cook Islands</option>
                <option value="Costa Rica">Costa Rica</option>
                <option value="Cote D'ivoire">Cote D'ivoire</option>
                <option value="Croatia">Croatia</option>
                <option value="Cuba">Cuba</option>
                <option value="Cyprus">Cyprus</option>
                <option value="Czech Republic">Czech Republic</option>
                <option value="Denmark">Denmark</option>
                <option value="Djibouti">Djibouti</option>
                <option value="Dominica">Dominica</option>
                <option value="Dominican Republic">Dominican Republic</option>
                <option value="Ecuador">Ecuador</option>
                <option value="Egypt">Egypt</option>
                <option value="El Salvador">El Salvador</option>
                <option value="Equatorial Guinea">Equatorial Guinea</option>
                <option value="Eritrea">Eritrea</option>
                <option value="Estonia">Estonia</option>
                <option value="Ethiopia">Ethiopia</option>
                <option value="Falkland Islands (Malvinas)">Falkland Islands (Malvinas)</option>
                <option value="Faroe Islands">Faroe Islands</option>
                <option value="Fiji">Fiji</option>
                <option value="Finland">Finland</option>
                <option value="France">France</option>
                <option value="French Guiana">French Guiana</option>
                <option value="French Polynesia">French Polynesia</option>
                <option value="French Southern Territories">French Southern Territories</option>
                <option value="Gabon">Gabon</option>
                <option value="Gambia">Gambia</option>
                <option value="Georgia">Georgia</option>
                <option value="Germany">Germany</option>
                <option value="Ghana">Ghana</option>
                <option value="Gibraltar">Gibraltar</option>
                <option value="Greece">Greece</option>
                <option value="Greenland">Greenland</option>
                <option value="Grenada">Grenada</option>
                <option value="Guadeloupe">Guadeloupe</option>
                <option value="Guam">Guam</option>
                <option value="Guatemala">Guatemala</option>
                <option value="Guernsey">Guernsey</option>
                <option value="Guinea">Guinea</option>
                <option value="Guinea-bissau">Guinea-bissau</option>
                <option value="Guyana">Guyana</option>
                <option value="Haiti">Haiti</option>
                <option value="Heard Island and Mcdonald Islands">Heard Island and Mcdonald Islands</option>
                <option value="Holy See (Vatican City State)">Holy See (Vatican City State)</option>
                <option value="Honduras">Honduras</option>
                <option value="Hong Kong">Hong Kong</option>
                <option value="Hungary">Hungary</option>
                <option value="Iceland">Iceland</option>
                <option value="India">India</option>
                <option value="Indonesia">Indonesia</option>
                <option value="Iran, Islamic Republic of">Iran, Islamic Republic of</option>
                <option value="Iraq">Iraq</option>
                <option value="Ireland">Ireland</option>
                <option value="Isle of Man">Isle of Man</option>
                <option value="Israel">Israel</option>
                <option value="Italy">Italy</option>
                <option value="Jamaica">Jamaica</option>
                <option value="Japan">Japan</option>
                <option value="Jersey">Jersey</option>
                <option value="Jordan">Jordan</option>
                <option value="Kazakhstan">Kazakhstan</option>
                <option value="Kenya">Kenya</option>
                <option value="Kiribati">Kiribati</option>
                <option value="Korea, Democratic People's Republic of">Korea, Democratic People's Republic of</option>
                <option value="Korea, Republic of">Korea, Republic of</option>
                <option value="Kuwait">Kuwait</option>
                <option value="Kyrgyzstan">Kyrgyzstan</option>
                <option value="Lao People's Democratic Republic">Lao People's Democratic Republic</option>
                <option value="Latvia">Latvia</option>
                <option value="Lebanon">Lebanon</option>
                <option value="Lesotho">Lesotho</option>
                <option value="Liberia">Liberia</option>
                <option value="Libyan Arab Jamahiriya">Libyan Arab Jamahiriya</option>
                <option value="Liechtenstein">Liechtenstein</option>
                <option value="Lithuania">Lithuania</option>
                <option value="Luxembourg">Luxembourg</option>
                <option value="Macao">Macao</option>
                <option value="Macedonia, The Former Yugoslav Republic of">Macedonia, The Former Yugoslav Republic of</option>
                <option value="Madagascar">Madagascar</option>
                <option value="Malawi">Malawi</option>
                <option value="Malaysia">Malaysia</option>
                <option value="Maldives">Maldives</option>
                <option value="Mali">Mali</option>
                <option value="Malta">Malta</option>
                <option value="Marshall Islands">Marshall Islands</option>
                <option value="Martinique">Martinique</option>
                <option value="Mauritania">Mauritania</option>
                <option value="Mauritius">Mauritius</option>
                <option value="Mayotte">Mayotte</option>
                <option value="Mexico">Mexico</option>
                <option value="Micronesia, Federated States of">Micronesia, Federated States of</option>
                <option value="Moldova, Republic of">Moldova, Republic of</option>
                <option value="Monaco">Monaco</option>
                <option value="Mongolia">Mongolia</option>
                <option value="Montenegro">Montenegro</option>
                <option value="Montserrat">Montserrat</option>
                <option value="Morocco">Morocco</option>
                <option value="Mozambique">Mozambique</option>
                <option value="Myanmar">Myanmar</option>
                <option value="Namibia">Namibia</option>
                <option value="Nauru">Nauru</option>
                <option value="Nepal">Nepal</option>
                <option value="Netherlands">Netherlands</option>
                <option value="Netherlands Antilles">Netherlands Antilles</option>
                <option value="New Caledonia">New Caledonia</option>
                <option value="New Zealand">New Zealand</option>
                <option value="Nicaragua">Nicaragua</option>
                <option value="Niger">Niger</option>
                <option value="Nigeria">Nigeria</option>
                <option value="Niue">Niue</option>
                <option value="Norfolk Island">Norfolk Island</option>
                <option value="Northern Mariana Islands">Northern Mariana Islands</option>
                <option value="Norway">Norway</option>
                <option value="Oman">Oman</option>
                <option value="Pakistan">Pakistan</option>
                <option value="Palau">Palau</option>
                <option value="Palestinian Territory, Occupied">Palestinian Territory, Occupied</option>
                <option value="Panama">Panama</option>
                <option value="Papua New Guinea">Papua New Guinea</option>
                <option value="Paraguay">Paraguay</option>
                <option value="Peru">Peru</option>
                <option value="Philippines">Philippines</option>
                <option value="Pitcairn">Pitcairn</option>
                <option value="Poland">Poland</option>
                <option value="Portugal">Portugal</option>
                <option value="Puerto Rico">Puerto Rico</option>
                <option value="Qatar">Qatar</option>
                <option value="Reunion">Reunion</option>
                <option value="Romania">Romania</option>
                <option value="Russian Federation">Russian Federation</option>
                <option value="Rwanda">Rwanda</option>
                <option value="Saint Helena">Saint Helena</option>
                <option value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
                <option value="Saint Lucia">Saint Lucia</option>
                <option value="Saint Pierre and Miquelon">Saint Pierre and Miquelon</option>
                <option value="Saint Vincent and The Grenadines">Saint Vincent and The Grenadines</option>
                <option value="Samoa">Samoa</option>
                <option value="San Marino">San Marino</option>
                <option value="Sao Tome and Principe">Sao Tome and Principe</option>
                <option value="Saudi Arabia">Saudi Arabia</option>
                <option value="Senegal">Senegal</option>
                <option value="Serbia">Serbia</option>
                <option value="Seychelles">Seychelles</option>
                <option value="Sierra Leone">Sierra Leone</option>
                <option value="Singapore">Singapore</option>
                <option value="Slovakia">Slovakia</option>
                <option value="Slovenia">Slovenia</option>
                <option value="Solomon Islands">Solomon Islands</option>
                <option value="Somalia">Somalia</option>
                <option value="South Africa">South Africa</option>
                <option value="South Georgia and The South Sandwich Islands">South Georgia and The South Sandwich Islands</option>
                <option value="Spain">Spain</option>
                <option value="Sri Lanka">Sri Lanka</option>
                <option value="Sudan">Sudan</option>
                <option value="Suriname">Suriname</option>
                <option value="Svalbard and Jan Mayen">Svalbard and Jan Mayen</option>
                <option value="Swaziland">Swaziland</option>
                <option value="Sweden">Sweden</option>
                <option value="Switzerland">Switzerland</option>
                <option value="Syrian Arab Republic">Syrian Arab Republic</option>
                <option value="Taiwan">Taiwan</option>
                <option value="Tajikistan">Tajikistan</option>
                <option value="Tanzania, United Republic of">Tanzania, United Republic of</option>
                <option value="Thailand">Thailand</option>
                <option value="Timor-leste">Timor-leste</option>
                <option value="Togo">Togo</option>
                <option value="Tokelau">Tokelau</option>
                <option value="Tonga">Tonga</option>
                <option value="Trinidad and Tobago">Trinidad and Tobago</option>
                <option value="Tunisia">Tunisia</option>
                <option value="Turkey">Turkey</option>
                <option value="Turkmenistan">Turkmenistan</option>
                <option value="Turks and Caicos Islands">Turks and Caicos Islands</option>
                <option value="Tuvalu">Tuvalu</option>
                <option value="Uganda">Uganda</option>
                <option value="Ukraine">Ukraine</option>
                <option value="United Arab Emirates">United Arab Emirates</option>
                <option value="United Kingdom">United Kingdom</option>
                <option value="United States">United States</option>
                <option value="United States Minor Outlying Islands">United States Minor Outlying Islands</option>
                <option value="Uruguay">Uruguay</option>
                <option value="Uzbekistan">Uzbekistan</option>
                <option value="Vanuatu">Vanuatu</option>
                <option value="Venezuela">Venezuela</option>
                <option value="Viet Nam">Viet Nam</option>
                <option value="Virgin Islands, British">Virgin Islands, British</option>
                <option value="Virgin Islands, U.S.">Virgin Islands, U.S.</option>
                <option value="Wallis and Futuna">Wallis and Futuna</option>
                <option value="Western Sahara">Western Sahara</option>
                <option value="Yemen">Yemen</option>
                <option value="Zambia">Zambia</option>
                <option value="Zimbabwe">Zimbabwe</option>
        </select>
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
        <input required type="file" name="fotoPerfil" id="fotoPerfil" accept="image/*" class="input input-bordered w-full bg-base-200" required />
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
</body>
</html>