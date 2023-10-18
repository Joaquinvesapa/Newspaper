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
    $contraseña = $body["contraseña"];

    $this->usuarioModel = new Usuario($this->db, $nombreUsuario, $contraseña);

    $usuario = $this->usuarioModel->checkLogin();
    echo json_encode($usuario);
    return;
    // echo json_encode($this->usuarioModel);
  }

  public static function logout()
  {
    session_destroy();

    header('Location: ' . URL_PATH);
    // // header('Location: ')
  }
}