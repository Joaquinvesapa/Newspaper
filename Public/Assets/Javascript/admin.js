const form = document.querySelector("form");

form.addEventListener("submit", (e) => {
  e.preventDefault();
  checkLogin();
});

const checkLogin = () => {
  fetch("http://localhost/newspaper/admin/login", {
    method: "POST",
    body: JSON.stringify({
      nombreUsuario: "admin",
      contrasenia: "admin",
    }),
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((res) => res.json())
    .then((data) => console.log(data));
};
