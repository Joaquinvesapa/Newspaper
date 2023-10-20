import { handleNotification } from "./handleNotification.js";

const form = document.querySelector("form");

form.addEventListener("submit", (e) => {
  e.preventDefault();
  const password = document.querySelector("#password").value;
  const username = document.querySelector("#username").value;
  checkLogin(username, password);
});

const checkLogin = (username, password) => {
  fetch("http://localhost/newspaper/admin/login", {
    method: "POST",
    body: JSON.stringify({
      nombreUsuario: username,
      contrasenia: password,
    }),
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((res) => res.json())
    .then((data) => {
      if (data.status === 200) {
        window.location.assign("/newspaper/noticias");
      } else {
        console.log(data);
        handleNotification(data.error);
      }
    });
};
