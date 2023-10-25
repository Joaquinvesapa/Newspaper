<?php
$noticias = $parameters['data']['noticias'];
// var_dump(json_encode($noticias));
// $noticias = json_encode($data);
?>
<section class="main-top">
  <h2>Todas las Noticias</h2>
  <?php if (isLogged()): ?>
    <a href="<?= URL_PATH ?>/noticias/crear">Crear Noticia</a>
  <?php endif ?>
</section>
<section class="noticias-container">
  <?php foreach ($noticias as $key => $noticia): ?>
    <article class="article-noticia edit">
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
          <p>
            <?= formatearFecha($noticia['fecha_hora']) ?> -
            <?= $noticia['autor'] ?>
          </p>
        </div>
      </a>
      <?php if (isLogged()): ?>
        <section class="article-noticia-edit-section">
          <a class="article-noticia-edit-link" href="<?= URL_PATH ?>/noticias/<?= $noticia['id'] ?>/editar">
            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-pencil" width="24" height="24"
              viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round"
              stroke-linejoin="round">
              <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
              <path d="M4 20h4l10.5 -10.5a2.828 2.828 0 1 0 -4 -4l-10.5 10.5v4"></path>
              <path d="M13.5 6.5l4 4"></path>
            </svg>
          </a>
        </section>
      <?php endif ?>
    </article>
  <?php endforeach ?>
</section>