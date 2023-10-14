<?php

class Noticia extends Orm{
  function __construct(PDO $connection){
    parent::__construct('id','noticias',$connection);
  }
}