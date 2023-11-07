<?php

require_once(__DIR__ . "/../Models/Noticia.php");


class NoticiasController extends Controller
{

  private $noticiaModel;

  public function __construct(PDO $conection)
  {
    $this->noticiaModel = new Noticia($conection);

  }

  public function home()
  {
    if (!isLogged()) {
      header("Location: /newspaper");
    } else {

      header('Location: /newspaper/noticias/pagina/1');
    }
  }

  public function crear()
  {
    if (!isLogged()) {
      header("Location: /newspaper");
    }
    $this->render('formularionoticia', [], 'layout');

  }
  public function editar($id)
  {
    if (!isLogged()) {
      header("Location: /newspaper");
    }
    $noticia = $this->noticiaModel->getNoticias($id);
    $this->render('formularionoticia', [
      'data' => [
        'noticia' => $noticia
      ]
    ], 'layout');
  }

  public function borrar($id)
  {
    if (!isLogged()) {
      header("Location: /newspaper");
    }
    $this->noticiaModel->deleteById($id);
    header('Location: /newspaper/noticias/home');

  }
  public function pagina($numeroPagina = 1)
  {
    $offset = obtenerOffsetPagina($numeroPagina);
    $noticias = $this->noticiaModel->getNoticias(-1, $offset);

    $this->render('noticias', [
      'data' => [
        'noticias' => $noticias
      ]
    ], 'layout');
  }

  public function noticiaIndividual($id)
  {
    $inner = array("table" => "categorias");
    $noticia = $this->noticiaModel->getById($id, $inner);
    $this->render('noticiaIndividual', [
      'data' => [
        'noticia' => $noticia
      ]
    ], 'layout');
  }
}