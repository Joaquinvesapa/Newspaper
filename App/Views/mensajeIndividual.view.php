<?php
$mensaje = $parameters['data']["mensaje"][0];

$respuesta = isset($parameters["data"]["respuesta"]) ? $parameters["data"]["respuesta"] : null;
?>
<link rel="stylesheet" href="<?= URL_PATH ?>/public/assets/css/mensaje.css">
<section class="container-mensaje">
  <h3>
    <?= $mensaje["Asunto"] ?>
  </h3>
  <p>
    De:
    <?= $mensaje["Nombre"] ?>
  </p>
  <p>Email:
    <?= $mensaje["Email"] ?>
  </p>
  <div>
    <?= $mensaje["Mensaje"] ?>
  </div>
  <?php if (!isset($_GET["met"])): ?>
    <a href="<?= URL_PATH ?>/mensajes/responder/<?= $mensaje["MensajeId"] ?>">Responder</a>
  <?php endif ?>
</section>
<hr>
<?php if (isset($respuesta)): ?>
  <section class="container-mensaje">
    <h3>
      Respuesta
    </h3>
    <div style="border:none; padding:0">
      <?= $respuesta["Respuesta"] ?>
    </div>
  </section>
<?php endif ?>