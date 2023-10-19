<?php
class Usuario extends Orm
{

  private $nombreUsuario;
  private $contraseña;
  function __construct(PDO $connection, $nombreUsuario = null, $contraseña = null)
  {
    parent::__construct('id', 'usuarios', $connection);

    $this->nombreUsuario = $nombreUsuario ?? $this->nombreUsuario;
    $this->contraseña = $contraseña ?? $this->contraseña;
  }

  public function checkLogin()
  {
    // return $this->nombreUsuario;
    return $this->select([
      "nombre_usuario" => $this->nombreUsuario,
      "contrasenia" => $this->contraseña
    ]);
  }
}