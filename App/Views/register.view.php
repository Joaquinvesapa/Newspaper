<?php
$db = new Database;
$connection = $db->getConnection();

$usuarioModel = new Usuario($connection);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $isAdmin = $usuarioModel->checkAdmin($_POST["adminpassword"]);
  if ($isAdmin) {
    $data = [
      "apenom" => $_POST["username"],
      "nombre_usuario" => $_POST["username"],
      "contrasenia" => $_POST["password"],
    ];
    var_dump($data);
    $usuarioModel->insert($data);
    header("Location: /newspaper/admin");
  }
}
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
      <h1>Registrar Usuario</h1>
      <form style="display:flex; flex-direction:column;" action="" method="POST">
        <label for="username">Nuevo Nombre de usuario</label>
        <input placeholder="Nombre de Usuario" type="text" name="username" id="username" required>
        <label for="password">Nueva Contraseña</label>
        <input placeholder="Contraseña" type="password" name="password" id="password" required>
        <label for="password">Contraseña de Administrador</label>
        <input placeholder="Contraseña de Administrador" type="password" name="adminpassword" id="adminpassword"
          required>
        <button>Registrar</button>
      </form>
    </section>
  </main>
</body>
<script type="module" src="<?= URL_PATH ?>/public/assets/javascript/admin.js"></script>

</html>