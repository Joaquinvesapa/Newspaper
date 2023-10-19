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
    // require_once(__DIR__ . "/../Views/home.view.php");
    // $this->render('home', [], 'layout');
    // if(!isset($_SESSION['admin']) || $_SESSION['admin'] == false){
    //   header('Location: /newspaper/noticias');
    // }

    $mensajes = $this->mensajeModel->getAll();
    $this->render('mensajes', [
      'data' => [
        'mensajes' => $mensajes
      ]
    ], 'layout');

    echo "<pre>";
    // var_dump($_SESSION['admin']);
    var_dump($mensajes);
    echo "</pre>";
    // echo "<pre>";
    // var_dump($mensajes);
    // echo "</pre>";
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

  public function delete()
  {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
      // Recupero los valores del post
      $postData = file_get_contents('php://input');
      $body = json_decode($postData, true);

      $id = $body['id'];
      $this->mensajeModel->deleteById($id);


      // Si haces echo $variable, devuelte en string, asi que en js tenes que usar en el then .text()
      // Si hace echo json_encode($variable), devuelve un json, asi que en js tenes que usar en el then .json()

      // Si haces echo $variable -> en js recibis directamente el valor solo
      // Si haces echo json_encode(['deletedId' => $id]) -> en js recibis un objeto con la propiedad deletedId (que es el id que borraste

      // echo $id; 
      echo json_encode(['id' => $id]);
      return; //Retorno para que no siga la ejecucion del codigo y no redirija (porque si la peticion es post, retorna el html de la pagina, y no quiero eso)
    }

    // Si recibe una peticion GET redirijo porque no quiero que se pueda acceder a esta ruta por GET
    // Solo por post para hacer las bajas logicas
    header('Location: /newspaper/mensajes/home');
  }
}