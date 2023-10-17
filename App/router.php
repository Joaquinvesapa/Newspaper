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

    // var_dump(URL);
    // die();
    $url = explode('/', URL);
    // define('PAGE', !empty($url[1]) ? $url[1] : 'Page' )
    $this->controller = !empty($url[1]) ? $url[1] : 'Page';
    $this->method = !empty($url[2]) ? $url[2] : 'home';

    // var_dump($this->controller);
    // var_dump($this->method);

    $this->controller = $this->controller . 'Controller'; //Generamos la ruta del controller de manera dinamica en base a la URL

    // var_dump(__DIR__ . '/controllers/' . $this->controller . '.php');
    // die();
    require_once(__DIR__ . '/controllers/' . $this->controller . '.php'); //Requerimos el archivo del controller proporcionado en la URL
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
