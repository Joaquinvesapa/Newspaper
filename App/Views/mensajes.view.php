<!-- <script src="/newspaper/Public/Assets/javascript/script.js"></script> -->
<?php
// Extraigo de los parametros la data, que es un array associativo
$mensajes = $parameters['data']['mensajes'];
$db = new Database();
$conection = $db->getConnection();

$mensajesModel = new Mensaje($conection);

$totalMensajes = $mensajesModel->getTotalMensajes()["Total"];
$paginas = 1;
if ($totalMensajes > 20) {
  $paginas = floor(($totalMensajes / 20) + 1);
}

?>
<link rel="stylesheet" href="/newspaper/public/assets/css/mensajes.css">

<h2>Mensajes</h2>
<section class="buttons">
  <a class="<?php if ($_GET["met"] == "pagina")
      echo "selected" ?>" href="
    <?= URL_PATH ?>/mensajes/pagina/1">Recibidos
  </a>
  <a class="<?php if ($_GET["met"] == "enviados")
      echo "selected" ?>" href="<?= URL_PATH ?>/mensajes/enviados/pagina/1">Enviados</a>
</section>
<?php if (count($mensajes) != 0): ?>
<section class="container-mensajes">
  <ul class="lista-mensajes">
    <?php foreach ($mensajes as $mensaje): ?>
    <!--  Si el estado es distinto a uno, continuo el loop y no renderizo el mensaje -->
    <li class="mensaje <?php if ($_GET["met"] == "enviados")
          echo "enviado" ?>">
      <a href=<?php echo $_GET["met"] != "enviados" ? URL_PATH . "/mensajes/{$mensaje["MensajeId"]}"
          : URL_PATH . "/mensajes/enviados/{$mensaje["MensajeId"]}" ?>>
        <p class="nombre">
          <?php echo $mensaje['Nombre']; ?>
        </p>
        <p class="asunto">
          <?php echo $mensaje['Asunto']; ?>
        </p>
        <p class="fechahora">
          <?= formatearFecha($mensaje['FechaHora']) ?>
        </p>
      </a>
      <?php if ($_GET["met"] != "enviados"): ?>
      <button id="borrar" class="btnborrar" data-mensaje-id='<?php echo $mensaje['MensajeId'] ?>'><svg
          xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-trash" width="24" height="24"
          viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round"
          stroke-linejoin="round">
          <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
          <path d="M4 7l16 0"></path>
          <path d="M10 11l0 6"></path>
          <path d="M14 11l0 6"></path>
          <path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12"></path>
          <path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3"></path>
        </svg></button>
      <?php endif ?>
    </li>
    <?php endforeach; ?>
  </ul>
</section>
<dialog id="favDialog">
  <section method="post">
    <p>Desea eliminar el mensaje?</p>
    <menu>
      <button id="cancel" type="reset">Cancel</button>
      <button id="confirm" type="submit">Confirm</button>
    </menu>
  </section>
</dialog>
<section class="mensajes-paginas">
  <?php for ($i = 1; $i <= $paginas; $i++): ?>
  <a class="<?php echo $_GET['id'] == $i ? 'selected' : '' ?>" href="<?= URL_PATH ?>/mensajes/pagina/<?= $i ?>">
    <?= $i ?>
  </a>
  <?php endfor ?>
</section>
<?php else: ?>
<h3>No hay mensajes para mostrar</h3>

<?php endif ?>
<script src="<?= URL_PATH ?>/public/assets/javascript/mensajes.js">

</script>