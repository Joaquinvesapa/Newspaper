<?php
class Err{

  public $error;
  public $mensaje;
  public function __construct($error = null, $mensaje = null){
    $this->mensaje = $mensaje;
    $this->error = $error;
  }

}