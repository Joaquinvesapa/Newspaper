<?php

function isLogged()
{
  return isset($_SESSION['id']);
}

function moveImage($image)
{
  $nombre = $image['name'];
  $ruta_provisional = $image['tmp_name'];
  $carpeta = "Fotos/";

  $src = $carpeta . $nombre;

  if (file_exists($src)) {
    return $src;
  }
  move_uploaded_file($ruta_provisional, $src);
  return $src;

}