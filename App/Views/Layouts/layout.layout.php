<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>
    <?php echo substr(PAGE, 1); ?>
  </title>
  <link rel="stylesheet" href="/newspaper/public/assets/css/noticias.css">
  <link rel="stylesheet" href="<?= URL_PATH ?>/public/assets/css/formNoticia.css">
  <link rel="stylesheet" href="/newspaper/public/assets/css/styles.css">

</head>

<body>
  <script src="/newspaper/Public/Assets/javascript/layout.js"></script>
  <header>
    <a href="/newspaper">
      Newspaper
    </a>
    <?php if (isLogged()): ?>
    <section class="section">
      <nav>
        <a href="<?= URL_PATH ?>/noticias">Noticias</a>
        <a href="<?= URL_PATH ?>/categorias">Categorias</a>
        <a href="<?= URL_PATH ?>/contacto">Contacto</a>
        <a href="<?= URL_PATH ?>/mensajes">Mensajes</a>
      </nav>
      <div>
        <a class="sessionbtn" href="<?= URL_PATH ?>/admin/logout">Cerrar Sesion</a>
      </div>
    </section>
    <?php else: ?>
    <section class='section'>
      <nav>
        <a href="<?= URL_PATH ?>/noticias">Noticias</a>
        <a href="<?= URL_PATH ?>/categorias">Categorias</a>
        <a href="<?= URL_PATH ?>/contacto">Contacto</a>
      </nav>
      <div>
        <a id="loginbtn" class="sessionbtn" href="<?= URL_PATH ?>/admin">Administración</a>
      </div>

    </section>

    <?php endif ?>
    <button class="menu"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-menu-2" width="24"
        height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round"
        stroke-linejoin="round">
        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
        <path d="M4 6l16 0"></path>
        <path d="M4 12l16 0"></path>
        <path d="M4 18l16 0"></path>
      </svg></button>
    <button class="menu cross none"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-x"
        width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none"
        stroke-linecap="round" stroke-linejoin="round">
        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
        <path d="M18 6l-12 12"></path>
        <path d="M6 6l12 12"></path>
      </svg></button>
  </header>
  <?php if (isLogged()): ?>
  <section class='section responsive none'>
    <div>
      <a class="sessionbtn end" href="<?= URL_PATH ?>/admin/logout">Cerrar Sesion</a>
    </div>
    <nav>
      <a href="<?= URL_PATH ?>/noticias">Noticias</a>
      <a href="<?= URL_PATH ?>/categorias">Categorias</a>
      <a href="<?= URL_PATH ?>/contacto">Contacto</a>
      <a href="<?= URL_PATH ?>/mensajes">Mensajes</a>
    </nav>
  </section>
  <?php else: ?>
  <section class="section responsive none">
    <div>
      <a id="loginbtn" class="sessionbtn" href="<?= URL_PATH ?>/admin">Administración</a>
    </div>
    <nav>
      <a href="<?= URL_PATH ?>/noticias">Noticias</a>
      <a href="<?= URL_PATH ?>/categorias">Categorias</a>
      <a href="<?= URL_PATH ?>/contacto">Contacto</a>
    </nav>

  </section>
  <?php endif; ?>
  <main>
    <!-- <button id="mostrarmenu">Mostrar menu</button> -->
    <?php require_once($content); ?>
  </main>
  <footer>
    <p>Joaquin Vesco Aparicio © 2023 </p>
  </footer>
</body>

</html>