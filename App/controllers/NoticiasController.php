<?php

require_once(__DIR__ . "/../Models/Noticia.php");


class NoticiasController extends Controller{

  private $noticiaModel;
  
  public function __construct(PDO $conection){
    $this->noticiaModel = new Noticia($conection);
    
  }

  public function home(){
    // require_once(__DIR__ . "/../Views/home.view.php");
    // $this->render('home', [], 'layout');

    $noticias = $this->noticiaModel->getAll();
    $this->render('home', [
      'data' => [
        'noticias' => $noticias
      ]
    ], 'layout');
    echo "<pre>";
    // var_dump($_SESSION['admin']);
    // var_dump($noticias);
    echo "</pre>";
  }

  public function crear(){
    $this->render('formularionoticia', [], 'layout');

  }
  public function editar(){
    $noticia = $this->noticiaModel->getById(1);
    $this->render('formularionoticia', [
      'data' => [
        'noticia' => $noticia
      ]
    ], 'layout');
  }
}