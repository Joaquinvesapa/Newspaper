<?php
$categorias = $parameters["data"]["categorias"];

?>
<section class="main-top">
<h2>Desde Categorias</h2>
</section>

<section class="categorias-container">
  <?php if(isset($categorias)) : ?>
    <?php foreach ($categorias as $key => $categoria) :?>
      <a href="<?=URL_PATH?>/categorias/<?=$categoria["id"]?>">
        <article class="categoria">
        <h3><?=$categoria["denominacion"]?></h3>
        </article>
      </a>
    <?php endforeach ?>
    <?php endif ?>
</section>