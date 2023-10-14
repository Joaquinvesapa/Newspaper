<?php

class Router{

  private $controller;
  private $method;

  function __construct(){
    $this->mathRoute();
  }

  public function mathRoute(){
    
    $url = explode('/',URL);
    // var_dump($url);

    $this->controller = !empty($url[1]) ? $url[1] : 'Page';
    $this->method = !empty($url[2]) ? $url[2] : 'home';

    $this->controller = $this->controller . 'Controller';//Generamos la ruta del controller de manera dinamica en base a la URL

    require_once(__DIR__ . '/controllers/' . $this->controller . '.php');//Requerimos el archivo del controller proporcionado en la URL
  }

  public function run(){
    $controller = new $this->controller();
    $method = $this->method;

    $controller->$method();
  }
}