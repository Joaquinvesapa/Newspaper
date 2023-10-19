<?php

?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<?= URL_PATH ?>/public/assets/css/login.css">
  <title>Login</title>
</head>

<body>
  <div class="alertas">
  </div>
  <main>
    <section>
      <h1>Login</h1>
      <form style="display:flex; flex-direction:column;" action="" method="POST">
        <label for="username">Username</label>
        <input placeholder="Nombre de Usuario" type="text" name="username" id="username">
        <label for="password">Contraseña</label>
        <input placeholder="Contraseña" type="text" name="password" id="password">
        <button>Ingresar</button>
      </form>
    </section>
  </main>
</body>
<script type="module" src="<?= URL_PATH ?>/public/assets/javascript/admin.js"></script>

</html>