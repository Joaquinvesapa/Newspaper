<?php

class Router
{

  private $controller;
  private $method;
  private $categoria;
  private $id;

  function __construct()
  {
    $this->mathRoute();
  }

  public function mathRoute()
  {

    $controller = $_GET['con'] ?? 'Landing';
    $this->id = $_GET['id'] ?? null;
    $this->categoria = $_GET['cat'] ?? null;
    $this->method = $_GET['met'] ?? 'home';

    // var_dump($conntroller, $id, $categoria, $method);
  //  die() ;
    // $url = explode('/', URL);

    // $this->controller = !empty($url[1]) ? $url[1] : 'Landing';
    // $this->method = !empty($url[2]) ? $url[2] : 'home';


    $this->controller = $controller . 'Controller'; //Generamos la ruta del controller de manera dinamica en base a la URL
    $controllerFile = __DIR__ . '/controllers/' . $this->controller . '.php';
    if (file_exists($controllerFile)) {
      require_once($controllerFile); //Requerimos el archivo del controller proporcionado en la URL
      // var_dump($controller);
    } else {
      require_once(__DIR__ . '/controllers/NotFoundController.php'); //Requerimos el archivo del controller proporcionado en la URL
      $this->controller = 'NotFoundController'; 

      $controller = new $this->controller();
      $method = $this->method;

      $controller->$method();

      die();
    }
  }

  public function run()
  {
    
    $database = new Database();
    $conection = $database->getConnection();
    
    $controller = new $this->controller($conection);

    if($this->categoria){
      $controller->categoriaIndividual($this->categoria);
    }else if($this->id){
      $controller->noticiaIndividual($this->id);
    }else{
      $method = $this->method;
  
      $controller->$method();
    }
  }
}