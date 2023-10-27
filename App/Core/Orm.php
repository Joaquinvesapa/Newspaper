<?php

class Orm
{

  protected $id;
  protected $table;
  protected $db;

  public function __construct($id, $table, PDO $conection)
  {
    $this->id = $id;
    $this->table = $table;
    $this->db = $conection;
  }

  /** Listar todos los registros
   * @param  object  $object The object to convert
   * @return array
   */
  public function getAll($params)
  {
    $joins = "";
    if (isset($params["joins"])) {
      foreach ($params["joins"] as $key => $join) {
        $joins .= $join;
      }
      $stm = $this->db->prepare("SELECT {$params['columns']} FROM {$this->table} {$joins} WHERE {$this->table}.estado_id = 1");
      $stm->execute();
      return $stm->fetchAll();
    }
    //Creamos el statement de la query
    $stm = $this->db->prepare("SELECT {$params['columns']} FROM {$this->table} WHERE {$this->table}.estado_id = 1");
    $stm->execute();
    return $stm->fetchAll();
  }

  /** Listar un registro por su id
   * @param  int $id del registro a listar
   * @return array 
   */
  public function getById($id, $inner = null)
  {
    $innerQuery = "";
    if ($inner != null) {
      $tablaSingularId = trim($inner["table"], 's') . "_id";
      $innerQuery = "INNER JOIN {$inner["table"]} ON {$inner["table"]}.id = {$this->table}.$tablaSingularId";
      $stm = $this->db->prepare("SELECT * FROM {$this->table} $innerQuery WHERE {$this->table}.id = :id");

      $stm->bindvalue(":id", $id);
      $stm->execute();
      return $stm->fetch();
    } else {
      $stm = $this->db->prepare("SELECT * FROM {$this->table} WHERE id = :id");
      $stm->bindvalue(":id", $id);
      $stm->execute();
      return $stm->fetch();
    }
  }

  /** Baja logica de la base de datos cambiando estado a inactivo
   * @param  int $id del registro a cambiar estado
   * @return string 
   */
  public function deleteById($id)
  {
    $stm = $this->db->prepare("UPDATE {$this->table} SET estado_id = 2 WHERE id = :id");
    $stm->bindvalue(":id", $id);
    $stm->execute();
  }

  /** Modificación en la base de datos de un registro en base a su id
   * @param  int $id del registro a modificar
   * @param  array $data del registro a modificar
   */
  public function updateById($id, $data)
  {

    //Inicio de la query
    $sql = "UPDATE {$this->table} SET ";
    //Recorremos la data y por cada valor generamos su "SET campo = :campo"
    foreach ($data as $key => $value) {
      $sql .= "{$key} = :{$key},";
    }

    $sql = trim($sql, ','); //Eliminar la coma final
    $sql .= " WHERE id = :id"; //Agregar condicional

    $stm = $this->db->prepare($sql);

    //Para cada clave de campo (:campo) le asignamos el valor correspondiente del $data ($value)
    foreach ($data as $key => $value) {
      $stm->bindvalue(":{$key}", $value);
    }
    //utilizamos el $id para el condicional 
    $stm->bindvalue(":id", $id);

    $stm->execute();
  }

  /** Insert de un registro en la base de datos
   * @param  array $data del registro a insertar
   */
  public function insert($data)
  {
    $sql = "INSERT INTO {$this->table} (";

    //Recorremos la data y por cada valor generamos su campo en el insert
    foreach ($data as $key => $value) {
      $sql .= " {$key},";
    }
    $sql .= " estado_id,";
    $sql = trim($sql, ',');
    $sql .= ") VALUES (";

    //Recorremos la data y por cada valor generamos su :campo
    foreach ($data as $key => $value) {
      $sql .= " :{$key},";
    }
    $sql .= " :estado_id,";
    $sql = trim($sql, ',');
    $sql .= ")";

    $stm = $this->db->prepare($sql);

    //Recorremos la data y asignamos a cada :campo su $valor
    foreach ($data as $key => $value) {
      $stm->bindvalue(":{$key}", $value);
    }
    $stm->bindvalue(":estado_id", 1); //por defecto los registros se crean con estado "Activo" (1)

    $stm->execute();
  }

  public function select($data)
  {
    // try{
    $sql = "SELECT * FROM {$this->table} WHERE ";
    foreach ($data as $key => $value) {
      $sql .= "{$key} = :{$key} AND ";
    }
    $sql = trim($sql, "AND ");
    $stm = $this->db->prepare($sql);

    $a = '';
    foreach ($data as $key => $value) {
      $stm->bindvalue(":{$key}", $value);
      $a .= ":{$key}" . $value;
    }
    // return $stm;
    $stm->execute();

    return $stm->fetch();

    // }catch(PDOException $e){
    //   return $e;
    // }
  }
}