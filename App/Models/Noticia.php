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

  public function getAllNoticias()
  {
    //Creamos el statement de la query
    $stm = $this->db->prepare("SELECT *,noticias.id as noticia_id, categorias.denominacion as categoria FROM {$this->table} LEFT JOIN categorias ON categorias.id = {$this->table}.categoria_id WHERE {$this->table}.estado_id = 1 ORDER BY noticias.fecha_hora DESC");
    $stm->execute();
    return $stm->fetchAll();
  }
}