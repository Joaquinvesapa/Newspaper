<?php
require_once(__DIR__ . "/../Models/Categoria.php");

class CategoriasController extends Controller
{
  private $categoriaModel;
  private $noticiaModel;

  public function __construct(PDO $conection)
  {
    $this->categoriaModel = new Categoria($conection);
    $this->noticiaModel = new Noticia($conection);

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
    $categoria = $this->categoriaModel->getAllCategorias($idCategoria);
    $noticias = $this->noticiaModel->getNoticiaPorCategoria($idCategoria);
    if ($categoria) {
      $this->render('categoriaIndidivual', [
        'data' => [
          'categoria' => $categoria,
          'noticias' => $noticias,
        ]
      ], 'layout');
    } else {
      $this->render('notfound', [], 'layout');
    }
  }
}