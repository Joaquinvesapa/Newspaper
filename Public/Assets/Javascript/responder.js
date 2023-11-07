ClassicEditor.create(document.querySelector("#editor"), {
  toolbar: ["undo", "redo", "|", "heading", "|", "bold", "italic", "link"],
  heading: {
    options: [
      {
        model: "paragraph",
        title: "Texto Normal",
        class: "ck-heading_paragraph",
      },
      {
        model: "heading3",
        view: "h3",
        title: "Titulo",
        class: "ck-heading_heading3",
      },
      {
        model: "heading4",
        view: "h4",
        title: "Subtitulo",
        class: "ck-heading_heading4",
      },
    ],
  },
  config: {
    heading: 500,
  },
}).catch((error) => {
  console.error(error)
})
