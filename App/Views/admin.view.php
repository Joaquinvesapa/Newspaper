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
      <form action="" method="POST" style="display:flex; flex-direction:column;">
        <label for="username">Username</label>
        <input placeholder="Nombre de Usuario" type="text" name="username" id="username" required>
        <label for="password">Contraseña</label>
        <input placeholder="Contraseña" type="password" name="password" id="password" autocomplete="on" required>
        <button>Ingresar</button>
      </form>
      <!-- <a href="<?= URL_PATH ?>/admin/registro" style="font-size: 14px; color: var(--primary)">Registrar nuevo
        usuario</a> -->
    </section>
  </main>
</body>
<script type="module" src="<?= URL_PATH ?>/public/assets/javascript/admin.js"></script>

</html>