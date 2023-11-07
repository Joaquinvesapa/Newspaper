var borrar = document.querySelectorAll("#borrarNotitiabtn")
var cancelButton = document.getElementById("cancel")
var confirmButton = document.getElementById("confirm")
var favDialog = document.getElementById("favDialog")
let noticiaId = 0
borrar.forEach((btnBorrar) =>
  btnBorrar.addEventListener("click", () => {
    noticiaId = btnBorrar.dataset.noticiaId
    favDialog.showModal()
  })
)

confirmButton.addEventListener("click", () => {
  console.log(noticiaId)
  fetch(`http://localhost/newspaper/noticias/borrar/${noticiaId}`)
  window.location.reload()
})

cancelButton.addEventListener("click", () => {
  favDialog.close()
})
