<?php

class Categoria extends Orm{
  function __construct(PDO $connection){
    parent::__construct('id','categorias',$connection);
  }
}