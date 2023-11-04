<?php

class Categoria extends Orm
{
  protected $db;

  function __construct(PDO $connection)
  {
    $this->db = $connection;

    parent::__construct('id', 'categorias', $connection);
  }
  public function getAllCategorias($id = -1)
  {
    $stm = $this->db->prepare("CALL sp_get_categorias({$id})");

    $stm->execute();

    return $stm->fetchAll();
  }
}