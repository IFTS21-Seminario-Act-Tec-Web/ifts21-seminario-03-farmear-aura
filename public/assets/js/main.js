// ============================================================
// FARMEAR AURA — main.js
//
// Interactividad del sitio. Este archivo maneja:
//   1. Año dinámico en el footer
//   2. Botón "volver arriba"
//   3. Sección activa en el nav (IntersectionObserver)
//   4. Demo de reserva
//   5. Formulario de contacto con validación
//
// Nota: el colapso del menú hamburguesa en mobile
// está manejado por Bootstrap JS (bootstrap.bundle.min.js).
// ============================================================


// ─── 1. AÑO DINÁMICO EN EL FOOTER ───────────────────────────
// Insertar el año actual evita tener que actualizarlo a mano.

document.getElementById('year').textContent = new Date().getFullYear();


// ─── 2. BOTÓN "VOLVER ARRIBA" ────────────────────────────────
// Aparece luego de scrollear 400px hacia abajo.
// Al hacer clic, sube suavemente al inicio de la página.

const topBtn = document.getElementById('topBtn');

window.addEventListener('scroll', () => {
  if (window.scrollY > 400) {
    topBtn.classList.add('visible');
  } else {
    topBtn.classList.remove('visible');
  }
}, { passive: true });
// passive: true le indica al navegador que este listener
// nunca llamará a preventDefault(). Mejora la performance
// del scroll porque el navegador no tiene que esperar.

topBtn.addEventListener('click', () => {
  window.scrollTo({ top: 0, behavior: 'smooth' });
});


// ─── 3. SECCIÓN ACTIVA EN EL NAV ─────────────────────────────
//
// PROBLEMA: queremos que el link del nav que corresponde
// a la sección visible quede resaltado (clase "active").
//
// OPCIÓN A — scroll event (la forma tradicional):
//   window.addEventListener('scroll', () => { ... });
//   Adentro calculamos posiciones con getBoundingClientRect()
//   o con offsetTop. Funciona, pero se ejecuta decenas de
//   veces por segundo mientras el usuario hace scroll.
//
// OPCIÓN B — IntersectionObserver (la forma moderna):
//   Registramos qué secciones queremos "observar". El
//   navegador nos avisa cuando una sección entra o sale
//   del área visible, sin que nosotros calculemos nada.
//   Es más eficiente porque corre fuera del hilo principal.
//
// Usamos la Opción B.

// Seleccionamos todos los links del nav que tienen data-section
const navLinks = document.querySelectorAll('.fa-nav-link[data-section]');

// Seleccionamos todas las secciones que tienen id
const sections = document.querySelectorAll('section[id]');

// Configuración del observer:
const observerOptions = {
  root: null,
  // root: null significa que el viewport del navegador
  // es la referencia de visibilidad.

  rootMargin: '-25% 0px -65% 0px',
  // rootMargin recorta el área de referencia:
  // -25% desde arriba: la sección se activa cuando
  //   su borde superior bajó 25% desde el top del viewport.
  // -65% desde abajo: la sección se desactiva cuando
  //   su borde superior está en el 35% inferior del viewport.
  // Efecto neto: solo la sección que ocupa la franja
  // entre 25% y 35% del viewport se considera "activa".
  // Ajustar estos valores cambia cuándo cambia el link activo.

  threshold: 0
  // threshold: 0 significa que el callback se dispara
  // con cualquier porcentaje mínimo de intersección.
};

const sectionObserver = new IntersectionObserver((entries) => {
  // entries es un array con todas las secciones que
  // cambiaron su estado de intersección en este ciclo.

  entries.forEach(entry => {
    if (entry.isIntersecting) {
      // Esta sección entró al área activa del viewport.

      // 1. Quitamos "active" de todos los links
      navLinks.forEach(link => link.classList.remove('active'));

      // 2. Buscamos el link que apunta a esta sección
      //    usando el atributo data-section que pusimos en el HTML
      const sectionId = entry.target.id;
      const matchingLink = document.querySelector(
        `.fa-nav-link[data-section="${sectionId}"]`
      );

      // 3. Lo marcamos como activo
      if (matchingLink) {
        matchingLink.classList.add('active');
      }
    }
  });

}, observerOptions);

// Registramos cada sección para ser observada
sections.forEach(section => sectionObserver.observe(section));



// ─── 5. FORMULARIO DE CONTACTO ───────────────────────────────
// Validación con la API nativa del navegador (HTML5).
// No necesitamos librerías externas para esto.
//
// En la etapa de backend, el submit enviará los datos a
// POST /api/contact en FastAPI (ver src/routes/contact.py).

const contactForm = document.getElementById('contactForm');
const formMsg     = document.getElementById('formMsg');

contactForm.addEventListener('submit', (event) => {

  // Siempre prevenimos el envío real del formulario
  // hasta que tengamos el backend listo.
  event.preventDefault();

  // checkValidity() devuelve true si todos los campos
  // cumplen sus restricciones: required, minlength, type, etc.
  if (!contactForm.checkValidity()) {
    // reportValidity() muestra los mensajes nativos del
    // navegador debajo de cada campo inválido.
    contactForm.reportValidity();
    return; // cortamos la ejecución acá
  }

  // Si llegamos acá, el formulario es válido.
  formMsg.textContent = '✓ Consulta lista para enviar. En la siguiente etapa se enviará a FastAPI.';

  // Limpiamos el formulario después de un envío exitoso.
  contactForm.reset();
});


  // FORMULARIO DE RESERCAVA

  const formReserva = document.getElementById('formReserva');
  const sala = document.getElementById('sala');
  const opciones = sala.options;
  const nombre = document.getElementById('Nombre');
  const apellido = document.getElementById('Apellido');
  const telefono = document.getElementById('Teléfono');
  const email = document.getElementById('Email');

  formReserva.addEventListener('submit', e => {

    e.preventDefault();

    if (!formReserva.checkValidity()) {
      formReserva.reportValidity();
      return;
    }
    formReserva.reportValidity();
    

    formReserva.reset();

  });