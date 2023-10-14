<?php

class Mensaje extends Orm{
  function __construct(PDO $connection){
    parent::__construct('id','mensajes',$connection);
  }
}