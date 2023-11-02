<?php
require_once(__DIR__ . "/../Models/Categoria.php");

class CategoriasController extends Controller
{
  private $categoriaModel;

  public function __construct(PDO $conection)
  {
    $this->categoriaModel = new Categoria($conection);

  }

  public function home()
  {
    $categorias = $this->categoriaModel->getAllCategorias();
    $this->render('categorias', [
      'data' => [
        'categorias' => $categorias
      ]
    ], 'layout');

  }
  public function categoriaIndividual($idCategoria)
  {
    $categoria = $this->categoriaModel->select([
      "id" => $idCategoria
    ]);
    if ($categoria) {
      $this->render('noticiaIndivisual', [
        'data' => [
          'noticia' => $categoria
        ]
      ], 'layout');
    } else {
      $this->render('notfound', [], 'layout');
    }
  }
}