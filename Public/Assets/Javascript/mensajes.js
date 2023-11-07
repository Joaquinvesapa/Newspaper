var borrar = document.querySelectorAll("#borrar")
var cancelButton = document.getElementById("cancel")
var confirmButton = document.getElementById("confirm")
var favDialog = document.getElementById("favDialog")
let mensajeId = 0
borrar.forEach((btnBorrar) =>
  btnBorrar.addEventListener("click", () => {
    mensajeId = btnBorrar.dataset.mensajeId
    favDialog.showModal()
  })
)

confirmButton.addEventListener("click", () => {
  console.log(mensajeId)
  fetch(`http://localhost/newspaper/mensajes/borrar/${mensajeId}`)
  window.location.reload()
})

cancelButton.addEventListener("click", () => {
  favDialog.close()
})
