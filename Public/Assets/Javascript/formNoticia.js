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

ClassicEditor.create(document.querySelector("#editor"), {
  toolbar: [
    "undo",
    "redo",
    "|",
    "heading",
    "|",
    "bold",
    "italic",
    "bulletedList",
    "numberedList",
    "link",
  ],
  heading: {
    options: [
      {
        model: "paragraph",
        title: "Texto Normal",
        class: "ck-heading_paragraph",
      },
      {
        model: "heading4",
        view: "h4",
        title: "Subtitulo",
        class: "ck-heading_heading4",
      },
    ],
  },
}).catch((error) => {
  console.error(error)
})
