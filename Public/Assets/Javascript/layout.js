window.addEventListener("DOMContentLoaded", () => {
  const loginbtn = document.getElementById("loginbtn")

  const mostrarMenu = document.querySelector(".menu")

  const cerrarMenu = document.querySelector(".cross")

  const section = document.querySelector(".responsive")

  mostrarMenu.addEventListener("click", () => {
    console.log(section)

    section.classList.toggle("none")
    mostrarMenu.classList.toggle("none")
    cerrarMenu.classList.toggle("none")
  })
  cerrarMenu.addEventListener("click", () => {
    console.log(section)

    section.classList.toggle("none")
    mostrarMenu.classList.toggle("none")
    cerrarMenu.classList.toggle("none")
  })
})

// window.navigator.serviceWorker.register("../../service-]worker.js")
// const iniciarSesion = async () => {
//   await fetch("http://localhost/newspaper/admin/login")
//     .then((res) => res.json())
//     .then((data) => {
//       // console.log(data);
//       window.location.reload();
//     })
//     .catch((e) => console.log(e));
// };

let prevUrl = document.referrer
const volverbtn = document.getElementById("volver")
volverbtn.addEventListener("click", () => {
  if (prevUrl.indexOf(window.location.host) !== -1) {
    // Ir a la página anterior
    window.history.back()
  }
})
