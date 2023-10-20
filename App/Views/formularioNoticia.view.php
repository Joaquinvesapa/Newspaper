<?php
$db = new Database();
$conection = $db->getConnection();

$categoriasModel = new Categoria($conection);
$categorias = $categoriasModel->getAll();

$isEditar = false;
if (isset($parameters['data'])) {
  $isEditar = true;
  $noticia = $parameters['data']['noticia'];
}
?>
<?php if (!$isEditar): ?>
<h3>Crear Noticia</h3>
<?php else: ?>
<h3>Editar Noticia</h3>
<?php endif ?>

<form action="" method="POST" enctype="multipart/form-data">

  <section class="text-section">

    <label for="titulo">Titulo</label>
    <input placeholder="Titulo" type="text" name="titulo" id="titulo" value="<?php if (isset($noticia)) {
      echo $noticia["titulo"];
    } else {
      echo "";
    } ?>">

    <label for="autor">Autor</label>
    <input placeholder="Autor" type="text" name="autor" id="autor" value="<?php if (isset($noticia)) {
      echo $noticia["autor"];
    } else {
      echo "";
    } ?>">

    <label for="fecha">Fecha</label>
    <input placeholder="Fecha" type="date" name="fecha" id="fecha" value="<?php if (isset($noticia)) {
      echo substr($noticia["fecha_hora"], 0, 10);
    } else {
      echo "";
    } ?>">

    <label for="categoria">Categoria</label>
    <select placeholder="Categoria" type="text" name="categoria" id="categoria">
      <option value="" disabled selected hidden>Categoria</option>
      <?php if (isset($categorias)): ?>
      <?php foreach ($categorias as $key => $categoria): ?>
      <option value=" <?= $categoria["id"] ?>" <?php if (isset($noticia) && $noticia["categoria_id"] == $categoria["id"]) {
              echo "selected";
            } ?>>
        <?= $categoria["denominacion"] ?>
      </option>
      <?php endforeach; ?>
      <?php endif; ?>
    </select>

    <label for="cuerpo">Cuerpo</label>
    <textarea name="cuerpo" id="cuerpo" cols="30" rows="15" placeholder="Cuerpo">
    <?php if (isset($noticia)) {
      echo $noticia["texto"];
    } else {
      echo "";
    } ?>
    </textarea>

  </section>


  <section class="imagen-section">
    <input type="file" name="imagen" id="inpImagen" class="imagen-input" value=''>
    <label for="inpImagen" class="label-img">Agregar Imagen</label>
    <div class="imagen">
      <?php if (isset($noticia)): ?>
      <img src="<?= "../" . $noticia["imagen_url"] ?>" alt="">
      <?php endif ?>
      <!-- <img src="../Fotos\debate.png" alt=""> -->
    </div>
  </section>

  <button class="btnEnviar">Enviar</button>
</form>
<script src="<?= URL_PATH ?>/public/assets/javascript/formNoticia.js"></script>