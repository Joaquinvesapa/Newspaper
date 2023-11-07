<?php
$db = new Database();
$conection = $db->getConnection();

$categoriasModel = new Categoria($conection);
$categorias = $categoriasModel->getAllCategorias();

$noticiasModel = new Noticia($conection);

$isEditar = false;
//Si llega informacion del controller, es que se quiere editar una noticia
if (isset($parameters['data'])) {
  $isEditar = true;
  $noticia = $parameters['data']['noticia'][0];
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

  //Movemos la imagen y obtenemos su ruta
  $imagenUrl = moveImage($_FILES['imagen']);

  //Creamos la data que vamos a enviar
  $data = array(
    'titulo' => $_POST['titulo'],
    'autor' => $_POST['autor'],
    'ubicacion' => $_POST['ubicacion'],
    'fecha_hora' => $_POST['fecha'],
    'categoria_id' => $_POST['categoria'],
    'cuerpo' => $_POST['cuerpo'],
    'imagen_url' => $imagenUrl
  );
  if (isset($noticia)) {
    if ($_FILES['imagen']['name'] == '') {
      $data['imagen_url'] = $noticia['ImagenUrl'];
    }
    $noticiasModel->updateById($noticia['NoticiaId'], $data);
  } else {
    $noticiasModel->insert($data);

  }
  header("Location: /newspaper/noticias/pagina/1");
}
?>
<link rel="stylesheet" href="<?= URL_PATH ?>/public/assets/css/formNoticia.css">

<div class="main-top">
  <?php if (!$isEditar): ?>

  <h2>Crear Noticia</h2>
  <?php else: ?>
  <h2>Editar Noticia</h2>
  <?php endif ?>
</div>
<form action="" method="POST" enctype="multipart/form-data">

  <section class="text-section">

    <label for="titulo">Titulo</label>
    <input placeholder="Titulo" type="text" name="titulo" id="titulo" value="<?php if (isset($noticia)) {
      echo $noticia["Titulo"];
    } else {
      echo "";
    } ?>" required>

    <label for="autor">Autor</label>
    <input placeholder="Autor" type="text" name="autor" id="autor" value="<?php if (isset($noticia)) {
      echo $noticia["Autor"];
    } else {
      echo "";
    } ?>" required>
    <label for="ubicacion">Ubicacion</label>
    <input placeholder="ubicacion" type="text" name="ubicacion" id="ubicacion" value="<?php if (isset($noticia)) {
      echo $noticia["Ubicacion"];
    } else {
      echo "";
    } ?>" required>

    <label for="fecha">Fecha</label>
    <input placeholder="Fecha" type="date" name="fecha" id="fecha" value="<?php if (isset($noticia)) {
      echo substr($noticia["FechaHora"], 0, 10);
    } else {
      echo "";
    } ?>" required>

    <label for="categoria">Categoria</label>
    <select placeholder="Categoria" type="text" name="categoria" id="categoria" required>
      <option value="" disabled selected hidden>Categoria</option>
      <?php if (isset($categorias)): ?>
      <?php foreach ($categorias as $key => $categoria): ?>
      <option value=" <?= $categoria["CategoriaId"] ?>" <?php if (isset($noticia) && $noticia["CategoriaId"] == $categoria["CategoriaId"]) {
              echo "selected";
            } ?>>
        <?= $categoria["Categoria"] ?>
      </option>
      <?php endforeach; ?>
      <?php endif; ?>
    </select>

    <label for="cuerpo">Cuerpo</label>
    <textarea name="cuerpo" id="editor">
    <?php echo isset($noticia) ? $noticia["Cuerpo"] : null ?>
    </textarea>

  </section>


  <section class="imagen-section">
    <label for="inpImagen" class="label-img">Agregar Imagen</label>
    <div class="imagen">
      <?php if (isset($noticia)): ?>
      <img src="<?= "../../" . $noticia["ImagenUrl"] ?>" alt="">
      <?php endif ?>
    </div>
    <input type="file" name="imagen" id="inpImagen" class="imagen-input"
      value="<?= "../../" . $noticia["ImagenUrl"] ?>">
  </section>

  <button class="btnEnviar">
    <?php if (isset($noticia)) {
      echo "Editar";
    } else {
      echo "Crear";
    } ?>
  </button>
</form>
<script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
<script src="<?= URL_PATH ?>/public/assets/javascript/formNoticia.js"></script>