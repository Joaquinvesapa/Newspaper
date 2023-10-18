<?php

class ContactoController extends Controller{

  public function __construct(PDO $conection){
    
  }

  public function home(){
    $this->render('contacto', [], 'layout');

  }
}