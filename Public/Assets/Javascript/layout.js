window.addEventListener("DOMContentLoaded", () => {
  const loginbtn = document.getElementById("loginbtn");

  const mostrarMenu = document.querySelector(".menu");

  const cerrarMenu = document.querySelector(".cross");

  const section = document.querySelector(".responsive");

  mostrarMenu.addEventListener("click", () => {
    console.log(section);

    section.classList.toggle("none");
    mostrarMenu.classList.toggle("none");
    cerrarMenu.classList.toggle("none");
  });
  cerrarMenu.addEventListener("click", () => {
    console.log(section);

    section.classList.toggle("none");
    mostrarMenu.classList.toggle("none");
    cerrarMenu.classList.toggle("none");
  });
});

// const iniciarSesion = async () => {
//   await fetch("http://localhost/newspaper/admin/login")
//     .then((res) => res.json())
//     .then((data) => {
//       // console.log(data);
//       window.location.reload();
//     })
//     .catch((e) => console.log(e));
// };