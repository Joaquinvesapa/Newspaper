<?php
require_once(__DIR__ . "/../Models/Mensaje.php");

class MensajesController extends Controller{

  private $mensajeModel;

  public function __construct(PDO $conection){
    
    $this->mensajeModel = new Mensaje($conection);
  }

  public function home(){
    // require_once(__DIR__ . "/../Views/home.view.php");
    // $this->render('home', [], 'layout');
    if(!isset($_SESSION['admin']) || $_SESSION['admin'] == false){
      header('Location: /newspaper/noticias');
    }
    $mensajes = $this->mensajeModel->getAll();

    echo "<pre>";
    var_dump($_SESSION['admin']);
    var_dump($mensajes);
    echo "</pre>";
  }
}