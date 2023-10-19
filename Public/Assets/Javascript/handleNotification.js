export function handleNotification(mensaje) {
  const notificaciones = document.querySelector(".alertas");

  let notificacion = document.createElement("div");
  notificacion.classList.add("alerta");
  notificacion.innerHTML = `<span class="mensaje">${mensaje}</span>`;
  // console.log(notificacion);
  notificaciones.appendChild(notificacion);
  setTimeout(() => {
    notificaciones.lastChild.remove();
  }, 5000);
}

// modules.export = handleNotification;
