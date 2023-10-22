<?php
$noticias = $parameters['data']['noticias'];
// $noticias = json_encode($data);
?>
<h2>Todas las Noticias</h2>
<section class="noticias-container">
  <?php foreach ($noticias as $key => $noticia): ?>
  <article class="article-noticia">
    <a class="article-noticia-link" href="<?= URL_PATH ?>/noticias/<?= $noticia['id'] ?>">
      <section class="article-noticia-head">
        <!-- <div class="article-noticia-imagen-container"> -->
        <img class="article-noticia-imagen" src="./<?= $noticia['imagen_url'] ?>" alt="">
        <!-- </div> -->
        <h3 class="article-noticia-titulo">
          <?= $noticia['titulo'] ?>
        </h3>
      </section>
      <div class="article-noticia-info">
        <?= formatearFecha($noticia['fecha_hora']) ?> -
        <?= $noticia['autor'] ?>
      </div>
    </a>
  </article>
  <?php endforeach ?>
</section>