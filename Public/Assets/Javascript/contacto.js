const form = document.querySelector("form")
console.log(form)
form.addEventListener("submit", (e) => {
  e.preventDefault()
  fetch("http://localhost/newspaper/contacto", { method: "POST" })
})
