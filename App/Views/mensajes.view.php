<!-- <script src="/newspaper/Public/Assets/javascript/script.js"></script> -->
<?php
// Extraigo de los parametros la data, que es un array associativo
$mensajes = $parameters['data']['mensajes'];
var_dump($parameters);
?>
<script src="/newspaper/Public/Assets/javascript/borrarMensaje.js "></script>

<h1>Estoy en el Home</h1>
<form action="/newspaper/mensajes/create" method="post">
  <input type="text" name="nombre" placeholder="Nombre">
  <input type="text" name="email" placeholder="Email">
  <input type="text" name="mensaje" placeholder="Mensaje">
  <button>enviar</button>
</form>

<?php foreach ($mensajes as $mensaje) : ?>
<!--  Si el estado es distinto a uno, continuo el loop y no renderizo el mensaje -->
<?php if ($mensaje['estado_id'] != 1) continue; ?>
<div class="mensaje">
  <h2><?php echo $mensaje['nombre']; ?></h2>
  <p><?php echo $mensaje['mensaje']; ?></p>
  <button id="borrar" data-mensajeid='<?php echo $mensaje['id'] ?>'>Borrar</button>
</div>
<?php endforeach; ?>
<?php

// echo '<pre>';
// var_dump($parameters['data']);
// echo '</pre>';
?>
<p>funciona</p>