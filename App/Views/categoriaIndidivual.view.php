<?php
$db = new Database();
$conection = $db->getConnection();

$categoria = $parameters["data"]["categoria"][0];
$noticias = $parameters["data"]["noticias"];

$noticiasModel = new Noticia($conection);

$totalNoticias = $noticiasModel->getTotalNoticiasPorCategoria($categoria["CategoriaId"])["Total"];
$paginas = 1;
if ($totalNoticias > 10) {
  $paginas = floor(($totalNoticias / 10) + 1);
}
?>
<link rel="stylesheet" href="/newspaper/public/assets/css/noticias.css">

<section class="main-top">
  <h2>
    <?= $categoria["Categoria"] ?>
  </h2>
</section>
<section class="noticias-container">
  <?php if (count($noticias) == 0): ?>
    <h3>No hay noticias para esta categoria</h3>
  <?php endif; ?>
  <?php foreach ($noticias as $key => $noticia): ?>
    <article class="article-noticia edit">
      <a class="article-noticia-link" href="<?= URL_PATH ?>/noticias/<?= $noticia['NoticiaId'] ?>">
        <section class="article-noticia-head">
          <!-- <div class="article-noticia-imagen-container"> -->
          <img class="article-noticia-imagen" src="../../../<?= $noticia['ImagenUrl'] ?>" alt="">
          <!-- </d iv> -->
          <h3 class="article-noticia-titulo">
            <?= $noticia['Titulo'] ?>
          </h3>
        </section>
        <div class="article-noticia-info">
          <p>
            <?= formatearFecha($noticia['FechaHora']) ?> -
            <?= $noticia['Ubicacion'] ?>
          </p>
          <p>
            <?= $noticia['Autor'] ?>
          </p>
        </div>
      </a>
      <section class="article-noticia-categoria">
        <br>
        <?php if (isLogged()): ?>
          <div style="display:flex;width:100%; justify-content:flex-end;">
            <a class="article-noticia-edit-link" href="<?= URL_PATH ?>/noticias/<?= $noticia['NoticiaId'] ?>/editar">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-pencil" width="24" height="24"
                viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round"
                stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M4 20h4l10.5 -10.5a2.828 2.828 0 1 0 -4 -4l-10.5 10.5v4"></path>
                <path d="M13.5 6.5l4 4"></path>
              </svg>
            </a>
            <button id="borrarNotitiabtn" data-noticia-id=<?= $noticia["NoticiaId"] ?> class="article-noticia-trash-link"
              href="<?= URL_PATH ?>/noticias/borrar/<?= $noticia['NoticiaId'] ?>">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-trash" width="24" height="24"
                viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round"
                stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M4 7l16 0"></path>
                <path d="M10 11l0 6"></path>
                <path d="M14 11l0 6"></path>
                <path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12"></path>
                <path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3"></path>
              </svg>
            </button>
          </div>
        <?php endif ?>
      </section>

    </article>
  <?php endforeach ?>
</section>
<?php if (count($noticias)): ?>
  <section class="noticias-paginas">
    <?php for ($i = 1; $i <= $paginas; $i++): ?>
      <a class="<?php echo $_GET['numPagina'] == $i ? 'selected' : '' ?>"
        href="<?= URL_PATH ?>/categorias/<?= $categoria['CategoriaId'] ?>/pagina/<?= $i ?>">
        <?= $i ?>
      </a>
    <?php endfor ?>
    <!-- <a class="<?php echo $_GET['id'] == 3 ? 'selected' : '' ?>" href="<?= URL_PATH ?>/noticias/pagina/3">3</a>
  <a class="<?php echo $_GET['id'] == 4 ? 'selected' : '' ?>" href="<?= URL_PATH ?>/noticias/pagina/4">4</a>
  <a class="<?php echo $_GET['id'] == 5 ? 'selected' : '' ?>" href="<?= URL_PATH ?>/noticias/pagina/5">5</a>
  <a class="<?php echo $_GET['id'] == 6 ? 'selected' : '' ?>" href="<?= URL_PATH ?>/noticias/pagina/6">6</a> -->
  </section>
<?php endif; ?>
<dialog id="favDialog">
  <section>
    <p>Desea eliminar la noticia?</p>
    <menu>
      <button id="cancel" type="reset">Cancelar</button>
      <button id="confirm" type="submit">Confirmar</button>
    </menu>
  </section>
</dialog>
<script src="<?= URL_PATH ?>/public/assets/javascript/noticias.js"></script>