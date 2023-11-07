<?php
require_once(__DIR__ . "/../Models/Mensaje.php");


class MensajesController extends Controller
{

  private $mensajeModel;

  public function __construct(PDO $conection)
  {

    $this->mensajeModel = new Mensaje($conection);
  }

  public function home()
  {
    header('Location: /newspaper/mensajes/pagina/1');
  }

  public function pagina($numeroPagina)
  {
    $offset = obtenerOffset($numeroPagina);
    $mensajes = $this->mensajeModel->getMensajes(-1, 6, $offset);

    $this->render('mensajes', [
      'data' => [
        'mensajes' => $mensajes
      ]
    ], 'layout');
  }

  public function create()
  {
    var_dump($_POST);
    $data = array(
      'nombre' => $_POST['nombre'],
      'email' => $_POST['email'],
      'mensaje' => $_POST['mensaje']
    );
    $this->mensajeModel->insert($data);
    header('Location: /newspaper/mensajes/home');
    $this->render('create', [], 'layout');
  }

  public function borrar($id)
  {

    $this->mensajeModel->deleteById($id);
    header('Location: /newspaper/mensajes/home');

  }

  public function mensajeIndividual($id)
  {

    $mensaje = $this->mensajeModel->getMensajes($id, 6);
    if ($mensaje) {
      $this->render('mensajeIndividual', [
        'data' => [
          'mensaje' => $mensaje,
        ]
      ], 'layout');
    } else {
      $this->render('notfound', [], 'layout');
    }
  }

  public function responder($id)
  {
    $mensaje = $this->mensajeModel->getMensajes($id, 6);
    if ($mensaje) {
      $this->render('responderMensaje', [
        'data' => [
          'mensaje' => $mensaje,
        ]
      ], 'layout');
    } else {
      $this->render('notfound', [], 'layout');
    }
  }
}