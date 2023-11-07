import { handleNotification } from "./handleNotification.js"

const form = document.querySelector("form")
console.log(form)
form.addEventListener("submit", (e) => {
  e.preventDefault()
  const password = document.querySelector("#password").value
  const username = document.querySelector("#username").value
  const adminpassword = document.querySelector("#adminpassword")
  if (adminpassword.value !== "") {
    registrarUsuario(username, password, adminpassword.value)
  } else {
    console.log("login")
    checkLogin(username, password)
  }
})

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
        window.location.assign("/newspaper/noticias/pagina/1")
      } else {
        console.log(data)
        handleNotification(data.error)
      }
    })
}

const registrarUsuario = (username, password, adminpassword) => {
  fetch("http://localhost/newspaper/admin/registro/crear", {
    method: "POST",
    body: JSON.stringify({
      nombreUsuario: username,
      contrasenia: password,
      admincontrasenia: adminpassword,
    }),
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((res) => res.json())
    .then((data) => {
      if (data.status === 200) {
        window.location.assign("/newspaper/admin")
      } else {
        console.log(data)
        handleNotification(data.error)
      }
    })
}
