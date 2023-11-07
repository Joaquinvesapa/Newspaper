<?php

class Mensaje extends Orm
{
  protected $db;
  function __construct(PDO $connection)
  {
    $this->db = $connection;
    parent::__construct('id', 'mensajes', $connection);
  }

  function getMensajes($id = -1, $estado_id = 6, $offset = 0)
  {

    $stm = $this->db->prepare("CALL sp_get_mensajes({$id},{$estado_id},{$offset})");
    $stm->execute();
    return $stm->fetchAll();
  }

  public function insertMensajes($data)
  {
    $sql = "INSERT INTO {$this->table} (";

    //Recorremos la data y por cada valor generamos su campo en el insert
    foreach ($data as $key => $value) {
      $sql .= " {$key},";
    }
    $sql = trim($sql, ',');
    $sql .= ") VALUES (";

    //Recorremos la data y por cada valor generamos su :campo
    foreach ($data as $key => $value) {
      $sql .= " :{$key},";
    }
    $sql = trim($sql, ',');
    $sql .= ")";

    $stm = $this->db->prepare($sql);

    //Recorremos la data y asignamos a cada :campo su $valor
    foreach ($data as $key => $value) {
      $stm->bindvalue(":{$key}", $value);
    }
    // var_dump($stm);
    // die();
    $stm->execute();
  }

  public function getTotalMensajes()
  {
    $stm = $this->db->prepare("SELECT * FROM v_get_total_mensajes");
    $stm->execute();
    return $stm->fetch();
  }

  public function mensajeEnviado($id)
  {
    $stm = $this->db->prepare("UPDATE mensajes SET mensajes.estado_id = 5 WHERE mensajes.id = :id");
    $stm->bindParam(":id", $id);
    $stm->execute();

  }
}