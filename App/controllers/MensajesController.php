<?php
require_once(__DIR__ . "/../Models/Mensaje.php");


class MensajesController extends Controller
{

  private $mensajeModel;
  private $respuestaModel;

  public function __construct(PDO $conection)
  {

    $this->mensajeModel = new Mensaje($conection);
    $this->respuestaModel = new Respuesta($conection);
  }

  public function home()
  {
    if (!isLogged()) {
      header("Location: /newspaper");
    } else {

      header('Location: /newspaper/mensajes/pagina/1');
    }
  }

  public function pagina($numeroPagina)
  {
    $offset = obtenerOffsetMensajes($numeroPagina);
    $mensajes = $this->mensajeModel->getMensajes(-1, 6, $offset);

    $this->render('mensajes', [
      'data' => [
        'mensajes' => $mensajes
      ]
    ], 'layout');
  }

  public function enviados($numeroPagina)
  {
    if (!isLogged()) {
      header("Location: /newspaper");
    }
    if (isset($_GET['pag'])) {
      $offset = obtenerOffsetMensajes($numeroPagina);
      $mensajes = $this->mensajeModel->getMensajes(-1, 5, $offset);

      $this->render('mensajes', [
        'data' => [
          'mensajes' => $mensajes
        ]
      ], 'layout');

    } else {

      $mensaje = $this->mensajeModel->getMensajes($numeroPagina, 5);
      $respuesta = $this->respuestaModel->getRespuesta($numeroPagina);
      if ($mensaje) {
        $this->render('mensajeIndividual', [
          'data' => [
            'mensaje' => $mensaje,
            'respuesta' => $respuesta,
          ]
        ], 'layout');
      } else {
        $this->render('notfound', [], 'layout');
      }
    }
  }

  public function create()
  {
    if (!isLogged()) {
      header("Location: /newspaper");
    }
    // var_dump($_POST);
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
    if (!isLogged()) {
      header("Location: /newspaper");
    }
    $this->mensajeModel->deleteById($id);
    header('Location: /newspaper/mensajes/home');

  }

  public function mensajeIndividual($id)
  {
    if (!isLogged()) {
      header("Location: /newspaper");
    }
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
    if (!isLogged()) {
      header("Location: /newspaper");
    }
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