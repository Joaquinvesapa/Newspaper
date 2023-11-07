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
    if (isset($_SESSION["id"])) {
      header("Location: /newspaper");
    } else {
      $this->renderWithoutLayout('admin', []);
    }
  }
  public function registro()
  {
    if (isset($_SESSION["id"])) {
      header("Location: /newspaper");
    } else {
      $this->renderWithoutLayout('register', []);
    }
  }

  public function login()
  {
    $loginData = file_get_contents('php://input');
    $body = json_decode($loginData, true);
    $nombreUsuario = $body["nombreUsuario"];
    $contraseña = $body["contrasenia"];

    $this->usuarioModel = new Usuario($this->db, $nombreUsuario, $contraseña);
    try {
      $response = $this->usuarioModel->checkLogin();
      if ($response) {
        $_SESSION['id'] = $response['id'];
        $_SESSION['nombre_usuario'] = $response['nombre_usuario'];
        $_SESSION['apenom'] = $response['id'];
        // var_dump($_SESSION);
        echo json_encode(new Response($response));

      } else {
        throw new Exception('No se encontro el usuario');
      }

    } catch (Exception $e) {
      $error = new Err($e->getMessage(), "Error");
      echo json_encode($error);
    }
  }

  public static function logout()
  {
    session_destroy();

    header('Location: ' . URL_PATH);
    // // header('Location: ')
  }

  public function crear()
  {
    $loginData = file_get_contents('php://input');
    $body = json_decode($loginData, true);
    $nuevoNombreUsuario = $body["nombreUsuario"];
    $nuevaContraseña = $body["contrasenia"];
    $admincontraseña = $body["admincontrasenia"];

    $this->usuarioModel = new Usuario($this->db);
    try {
      $checkLogin = $this->usuarioModel->checkAdmin($admincontraseña);
      if ($checkLogin) {
        $nuevoUsuario = [
          "apenom" => $nuevoNombreUsuario,
          "nombre_usuario" => $nuevoNombreUsuario,
          "contrasenia" => $nuevaContraseña,
        ];
        $this->usuarioModel->insert($nuevoUsuario);
        echo json_encode(new Response($checkLogin));

      } else {
        throw new Exception('No se pudo registrar el usuario');
      }

    } catch (Exception $e) {
      $error = new Err($e->getMessage(), "Error");
      echo json_encode($error);
    }
  }
}