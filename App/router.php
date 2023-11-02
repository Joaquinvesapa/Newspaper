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

    //Generamos la ruta del controller de manera dinamica en base a la URL
    $this->controller = $controller . 'Controller';

    $controllerFile = __DIR__ . '/controllers/' . $this->controller . '.php';

    if (file_exists($controllerFile)) {

      //Requerimos el archivo del controller proporcionado en la URL
      require_once($controllerFile);

    } else {

      //Requerimos el archivo del controller proporcionado en la URL
      require_once(__DIR__ . '/controllers/NotFoundController.php');
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

    $methodIndividual = str_replace("sController", '', $this->controller) . "Individual";

    $controller = new $this->controller($conection);

    $method = $this->method;

    if ($this->id) {

      if ($method == "editar" || $method == "pagina") {

        $controller->$method($this->id);

      } else {

        $controller->$methodIndividual($this->id);

      }
    } else {

      $controller->$method();
    }
  }
}