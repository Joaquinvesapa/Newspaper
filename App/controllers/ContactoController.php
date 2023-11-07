<?php

class ContactoController extends Controller
{
  private $mensajeModel;

  public function __construct(PDO $conection)
  {
    $this->mensajeModel = new Mensaje($conection);
  }

  public function home()
  {
    $this->render('contacto', [], 'layout');

  }
  public function crearMensaje($data)
  {

  }
}