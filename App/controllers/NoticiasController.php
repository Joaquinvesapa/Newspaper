<?php

class NoticiasController extends Controller{

  public function __construct(PDO $conection){
    
  }

  public function home(){
    // require_once(__DIR__ . "/../Views/home.view.php");
    $this->render('home', [], 'layout');
  }
}