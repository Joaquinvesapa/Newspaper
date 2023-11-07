<?php

$db = new Database();
$connection = $db->getConnection();
$mensajeModel = new Mensaje($connection);


if ($_SERVER['REQUEST_METHOD'] == 'POST') {

  //Creamos la data que vamos a enviar
  $data = array(
    'nombre' => $_POST['nombre'],
    'asunto' => $_POST['asunto'],
    'email' => $_POST['email'],
    'mensaje' => $_POST['mensaje'],
    'estado_id' => 6,
    //por defecto sera recibido
  );
  if (isset($data)) {

    $mensajeModel->insertMensajes($data);

  }
  header("Location: /newspaper/contacto");
}
?>
<link rel="stylesheet" href="/newspaper/public/assets/css/contacto.css">

<h2>Desde Contacto</h2>
<section class="container-formulario-contacto">
  <form action="" method="post">
    <label for="nombre">
      Nombre
    </label>
    <input type="text" id="nombre" name="nombre" placeholder="Nombre">

    <label for="email">
      Email
    </label>
    <input type="email" id="email" name="email" placeholder="Email">

    <label for="asunto">
      Asunto
    </label>
    <input type="text" id="asunto" name="asunto" placeholder="Asunto">

    <label for="cuerpo">Cuerpo
    </label>
    <textarea name="mensaje" id="editor">
    </textarea>

    <button>Enviar Mensaje</button>
  </form>
  <article class="container-imagen">
    <img src="/newspaper/public/images/Avion de papel.png" alt="">
  </article>
</section>
<script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>

<script src="<?= URL_PATH ?>/public/assets/javascript/contacto.js"></script>