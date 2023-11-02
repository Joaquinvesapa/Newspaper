<?php

class Categoria extends Orm
{
  protected $db;

  function __construct(PDO $connection)
  {
    $this->db = $connection;

    parent::__construct('id', 'categorias', $connection);
  }
  public function getAllCategorias()
  {
    $stm = $this->db->prepare("SELECT * FROM v_get_categorias");

    $stm->execute();
    return $stm->fetchAll();
  }
}