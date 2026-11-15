    const form     = document.getElementById("registroForm");
    const pass     = document.getElementById("password");
    const pass2    = document.getElementById("password2");
    const bar      = document.getElementById("strengthBar");
    const barLabel = document.getElementById("strengthLabel");
    const formErr  = document.getElementById("registroError");

    // ---- Mostrar / ocultar contraseña (sirve para los dos campos) ----
    document.querySelectorAll("[data-toggle]").forEach(btn => {
      btn.addEventListener("click", () => {
        const input = document.getElementById(btn.dataset.toggle);
        const visible = input.type === "text";
        input.type = visible ? "password" : "text";
        btn.innerHTML = visible ? '<i class="bi bi-eye"></i>' : '<i class="bi bi-eye-slash"></i>';
        btn.setAttribute("aria-label", visible ? "Mostrar contraseña" : "Ocultar contraseña");
      });
    });

    // ---- Indicador de fuerza de contraseña ----
    function fuerza(p) {
      let nivel = 0;
      if (p.length >= 8) nivel++;
      if (/[a-z]/.test(p) && /[A-Z]/.test(p)) nivel++;
      if (/\d/.test(p)) nivel++;
      if (/[^A-Za-z0-9]/.test(p) || p.length >= 12) nivel++;
      return p.length === 0 ? 0 : Math.max(nivel, 1);
    }

    pass.addEventListener("input", () => {
      const nivel = fuerza(pass.value);
      bar.dataset.level = nivel;
      barLabel.textContent = ["", "Débil", "Regular", "Buena", "Fuerte"][nivel];
    });

    // ---- Validación (de ejemplo: reemplazala por tu lógica real) ----
    function marcar(input, mensaje) {
      const err = input.closest(".fa-login-field").querySelector(".fa-login-field-error");
      err.textContent = mensaje || "";
      input.classList.toggle("is-invalid", !!mensaje);
      input.classList.toggle("is-valid", !mensaje && input.value.trim() !== "");
      return !mensaje;
    }

    form.addEventListener("submit", (e) => {
      e.preventDefault();
      formErr.textContent = "";

      const nombre   = document.getElementById("nombre");
      const apellido = document.getElementById("apellido");
      const usuario  = document.getElementById("usuario");
      const email    = document.getElementById("email");
      const terminos = document.getElementById("terminos");

      const ok = [
        marcar(nombre,   nombre.value.trim()   ? "" : "Ingresá tu nombre."),
        marcar(apellido, apellido.value.trim() ? "" : "Ingresá tu apellido."),
        marcar(usuario,  /^\S{3,}$/.test(usuario.value) ? "" : "Mínimo 3 caracteres, sin espacios."),
        marcar(email,    email.checkValidity() && email.value ? "" : "Ingresá un email válido."),
        marcar(pass,     pass.value.length >= 8 ? "" : "Debe tener al menos 8 caracteres."),
        marcar(pass2,    pass2.value && pass2.value === pass.value ? "" : "Las contraseñas no coinciden.")
      ].every(Boolean);

      if (!terminos.checked) {
        formErr.textContent = "Tenés que aceptar los términos para continuar.";
        return;
      }
      if (!ok) return;

      // Acá iría el envío al servidor
    });