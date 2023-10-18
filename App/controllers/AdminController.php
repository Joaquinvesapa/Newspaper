<?php

class AdminController extends Controller
{

  public function __construct()
  {
    // if (isset($_SESSION)) {
    //   echo json_encode($_SESSION['id']);
    // } else {
    //   // session_start();
    //   // $_SESSION['id'] = 1;
    // }


  }

  public function home()
  {
    $this->renderWithoutLayout('admin', []);

  }

  public function login()
  {
    // session_start();

    // $_SESSION['id'] = 1;
    $this->renderWithoutLayout('admin', []);
    // echo json_encode($_SESSION['id']);
    // header('Location: ' . URL_PATH);

  }

  public static function logout()
  {
    session_destroy();

    header('Location: ' . URL_PATH);
    // // header('Location: ')
  }
}