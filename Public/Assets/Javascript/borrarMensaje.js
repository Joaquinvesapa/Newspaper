window.addEventListener("DOMContentLoaded", () => {
  const deleteBtns = document.querySelectorAll("#borrar");

  deleteBtns.forEach((btn) => {
    btn.addEventListener("click", (e) => {
      // console.log(btn.dataset.noticiaid);
      const id = btn.dataset.noticiaid;
      borrarNoticia(id);
    });
  });
});

const borrarNoticia = (id) => {
  fetch("http://localhost/newspaper/mensajes/delete", {
    method: "POST",
    body: JSON.stringify({ id }),
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((res) => {
      // return res.text() si devolves echo solo desde php
      // return res.json() si devolves json_encode desde php
      return res.json();
    })
    .then((data) => {
      console.log(data);

      // Si por alguna razon no se elimina la noticia, se muestra un mensaje de error
      // ya que el servidor devuelve un objeto vacio
      if (!data.id) {
        alert("No se pudo borrar el mensaje");
      }

      //Ya sea que se haya borrado o no, se recarga la pagina.
      /*
        Nota:
        Me di cuenta al hacerlo, que si usar el metodo de hacer una peticion post,
        tenes que recargar la pagina desde js despues para que se refleje el cambio.

        Porque si bien al momento de hacer la peticion post ( si todo sale bien ),
        se hace la baja logica, el cliente sigue teniendo el mensaje en el DOM.

        Entonces tenes que refrescar la pagina (cliente) para que se traiga los mensajes
        nuevamente desde el servidor, y ahi si se refleja el cambio.
      */
      window.location.reload();
    })
    .catch((err) => console.log(err));
};
