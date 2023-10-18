<?php

class CategoriasController extends Controller{

  public function __construct(PDO $conection){
    
  }

  public function home(){
    $this->render('categorias', [], 'layout');

  }
}