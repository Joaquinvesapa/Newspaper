<?php

class Controller
{

  public function render($path, $parameters = [], $layout = '')
  {
    // ob_start();

    $content = __DIR__ . "/../Views/" . $path . ".view.php";
    // require_once(__DIR__ . "/../Views/" . $path . ".view.php");
    // $content = ob_get_clean();

    require_once(__DIR__ . "/../Views/Layouts/" . $layout . ".layout.php");
  }
}
