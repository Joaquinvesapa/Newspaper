<?php
require_once(__DIR__ . "/../Models/Usuario.php");

class AdminController extends Controller
{
  private $usuarioModel;
  private $db;
  public function __construct(PDO $connection)
  {
    $this->db = $connection;
  }

  public function home()
  {
    $this->renderWithoutLayout('admin', []);

  }

  public function login()
  {
    $loginData = file_get_contents('php://input');
    $body = json_decode($loginData, true);
    $nombreUsuario = $body["nombreUsuario"];
    $contraseña = $body["contrasenia"];

    $this->usuarioModel = new Usuario($this->db, $nombreUsuario, $contraseña);

    $usuario = $this->usuarioModel->checkLogin();
    if ($usuario) {
      // $_SESSION["ids"] = $usuario["id"];
      // $_SESSION["apenom"] = $usuario["apenom"];
      // $_SESSION["nombre_usuario"] = $usuario["nombre_usuario"];
      // $_SESSION["contrasenia"] = $usuario["contrasenia"];
      // header('Location: ' . URL_PATH . "/noticias");
      echo json_encode($usuario);

    } else {
      echo json_encode("Hubo un Error");

    }
    // return;
    // echo json_encode($this->usuarioModel);
  }

  public static function logout()
  {
    session_destroy();

    header('Location: ' . URL_PATH);
    // // header('Location: ')
  }
}