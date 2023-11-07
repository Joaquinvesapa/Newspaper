<?php

class Respuesta extends Orm
{
  protected $db;
  function __construct(PDO $connection)
  {
    $this->db = $connection;
    parent::__construct('id', 'respuestas', $connection);
  }

  function getRespuesta($idMensaje = -1)
  {
    $stm = $this->db->prepare("SELECT * FROM v_get_respuestas WHERE MensajeRespondidoId = {$idMensaje}");
    $stm->execute();
    return $stm->fetch();
  }

  public function crearRespuesta($data, $idMensaje)
  {
    $sql = "INSERT INTO {$this->table}(respuesta, mensaje_respondido_id) VALUES ('{$data["Mensaje"]}',{$idMensaje})";
    $stm = $this->db->prepare($sql);
    // var_dump($stm);
    // die();
    $stm->execute();
  }

}