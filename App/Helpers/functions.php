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

function formatearFecha($fecha)
{
  return date_format(date_create($fecha), "d/m/Y");
}

function obtenerOffset($numeroPagina)
{
  return ($numeroPagina * 10) - 10;
}