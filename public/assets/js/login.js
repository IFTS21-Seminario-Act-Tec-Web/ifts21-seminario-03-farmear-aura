    const form   = document.getElementById("loginForm");
    const email  = document.getElementById("email");
    const pass   = document.getElementById("password");
    const toggle = document.getElementById("togglePass");
    const error  = document.getElementById("loginError");

    // Mostrar / ocultar contraseña
    toggle.addEventListener("click", () => {
      const visible = pass.type === "text";
      pass.type = visible ? "password" : "text";
      toggle.innerHTML = visible ? '<i class="bi bi-eye"></i>' : '<i class="bi bi-eye-slash"></i>';
      toggle.setAttribute("aria-label", visible ? "Mostrar contraseña" : "Ocultar contraseña");
    });

    // Validación básica de ejemplo (reemplazala por tu lógica real)
    form.addEventListener("submit", (e) => {
      e.preventDefault();
      [email, pass].forEach(i => i.classList.remove("is-invalid"));
      error.textContent = "";

      if (!email.checkValidity()) {
        email.classList.add("is-invalid");
        error.textContent = "Ingresá un email válido.";
        return;
      }
      if (pass.value.trim() === "") {
        pass.classList.add("is-invalid");
        error.textContent = "Ingresá tu contraseña.";
        return;
      }
      window.location.href = "../index.html";
    });