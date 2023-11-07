<?php
$mensaje = $parameters["data"]["mensaje"][0];
$db = new Database();
$connection = $db->getConnection();

$mensajeModel = new Mensaje($connection);
$respuestaModel = new Respuesta($connection);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $data = [
    "Email" => $mensaje["Email"],
    "Nombre" => $mensaje["Nombre"],
    "Asunto" => $_POST["asunto"],
    "Mensaje" => $_POST["mensaje"]
  ];
  enviarMail($data);
  $mensajeModel->mensajeEnviado($mensaje["MensajeId"]);
  $respuestaModel->crearRespuesta($data, $mensaje["MensajeId"]);
  header("Location: /newspaper/mensajes/pagina/1");
}

?>
<link rel="stylesheet" href="<?= URL_PATH ?>/public/assets/css/responder.css">
<section class="container-responder">
  <h2 style="margin-block: 1rem;">Responder Mensaje</h2>
  <section class="mensaje-info">
    <a href="<?= URL_PATH ?>/mensajes/<?= $mensaje["MensajeId"] ?>">
      Mensaje -
      <?= $mensaje["Asunto"] ?>

      -
      <?= $mensaje["Nombre"] ?>
    </a>
    <p>
      <?= formatearFecha($mensaje["FechaHora"]) ?>
    </p>
  </section>
  <form method="post">
    <label for="email">
      Para
    </label>
    <input type="email" id="email" name="email" value="<?= $mensaje["Email"] ?>" readonly>
    <label for="asunto">
      Asunto
    </label>
    <input type="text" name="asunto" id="asunto">
    <label>
      Mensaje
    </label>
    <textarea name="mensaje" id="editor">
      </textarea>
    <button>Enviar</button>
  </form>
</section>
<script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>

<script src="<?= URL_PATH ?>/public/assets/javascript/responder.js"></script>