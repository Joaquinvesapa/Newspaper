<?php

class Noticia extends Orm
{
  protected $id;
  protected $table;
  protected $db;
  function __construct(PDO $connection)
  {
    $this->table = 'noticias';
    $this->db = $connection;

    parent::__construct('id', 'noticias', $connection);
  }

  public function getNoticias($id = -1, $offset = 0)
  {
    //Creamos el statement de la query
    $stm = $this->db->prepare("CALL sp_get_noticias({$id},{$offset})");

    $stm->execute();
    return $stm->fetchAll();
  }

  public function getTotal()
  {
    $stm = $this->db->prepare("SELECT * FROM v_total_noticias");
    $stm->execute();
    return $stm->fetch();
  }

  public function getNoticiaPorCategoria($categoriaId)
  {
    $stm = $this->db->prepare("CALL sp_get_noticias_por_categoria({$categoriaId})");

    $stm->execute();
    return $stm->fetchAll();
  }
}