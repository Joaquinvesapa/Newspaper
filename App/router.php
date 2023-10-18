<?php

class Router
{

  private $controller;
  private $method;

  function __construct()
  {
    $this->mathRoute();
  }

  public function mathRoute()
  {

    $url = explode('/', URL);

    $this->controller = !empty($url[1]) ? $url[1] : 'Landing';
    $this->method = !empty($url[2]) ? $url[2] : 'home';

    // var_dump($this->controller);
    // var_dump($this->method);

    $this->controller = $this->controller . 'Controller'; //Generamos la ruta del controller de manera dinamica en base a la URL
    $controllerFile = __DIR__ . '/controllers/' . $this->controller . '.php';
    if(file_exists($controllerFile)){
      require_once($controllerFile); //Requerimos el archivo del controller proporcionado en la URL
      // var_dump($controller);
    }else{
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
    $method = $this->method;

    $controller->$method();
  }
}
