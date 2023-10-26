<?php
$noticia = $parameters['data']['noticia']
  ?>

<section class="noticia-container">
  <h2>
    <?= $noticia["titulo"] ?>
  </h2>
  <div class="section-imagen">
    <img src="../<?= $noticia["imagen_url"] ?>" />
  </div>
  <section class="cuerpo">
    <div class="cuerpo-info">
      <span class="cuerpo-autor">Por
        <i>
          <?= $noticia["autor"] ?>
        </i>
      </span>
      <span class="cuerpo-fechahora">
        <?= formatearFecha($noticia["fecha_hora"]) ?>
      </span>
    </div>
    <article>
      <?= $noticia["cuerpo"] ?>
    </article>
    <!-- <?= $noticia["autor"] ?> -->
  </section>
</section>