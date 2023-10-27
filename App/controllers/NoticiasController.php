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
    // require_once(__DIR__ . "/../Views/home.view.php");
    // $this->render('home', [], 'layout');
    $params = array(
      "columns" => null,
      "joins" => null,
      "wheres" => null,
      "orderBy" => null,
    );

    $params["columns"] = "noticias.id as noticia_id, noticias.titulo as titulo, noticias.autor as autor, noticias.fecha_hora as fecha_hora, noticias.ubicacion as ubicacion,noticias.imagen_url as imagen_url, noticias.cuerpo as cuerpo, noticias.categoria_id as categoria_id,noticias.estado_id as estado_id, categorias.denominacion as categoria";

    $params["joins"] = ["INNER JOIN categorias ON categorias.id = noticias.categoria_id"];

    $noticias = $this->noticiaModel->getAll($params);
    $this->render('noticias', [
      'data' => [
        'noticias' => $noticias
      ]
    ], 'layout');
  }

  public function crear()
  {
    $this->render('formularionoticia', [], 'layout');

  }
  public function editar($id)
  {
    $noticia = $this->noticiaModel->getById($id);
    $this->render('formularionoticia', [
      'data' => [
        'noticia' => $noticia
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