<?php
$categorias = $parameters["data"]["categorias"];

?>
<link rel="stylesheet" href="<?= URL_PATH ?>/public/assets/css/categorias.css">
<section class="main-top">
  <h2>Todas las Categorías</h2>
</section>

<section class="categorias-container">
  <?php if (isset($categorias)): ?>
    <?php foreach ($categorias as $key => $categoria): ?>
      <a href="<?= URL_PATH ?>/categorias/<?= $categoria["CategoriaId"] ?>/pagina/1" style="">
        <article class=" categoria">
          <h3>
            <?= $categoria["Categoria"] ?>
          </h3>
        </article>
      </a>
    <?php endforeach ?>
  <?php endif ?>
</section>