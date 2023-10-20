const inputImagen = document.getElementById("inpImagen")

inputImagen.addEventListener("change", () => {
  let file = inputImagen.files[0]
  crearPreview(file)
})

const crearPreview = (file) => {
  const urlImagen = URL.createObjectURL(file)
  let img = `<img src="${urlImagen}">`

  const imgContainer = document.querySelector(".imagen")
  imgContainer.innerHTML = img
}
