<?php

$folderPath = dirname($_SERVER['SCRIPT_NAME']);//Extraemos el nombre de la ruta padre el proyecto
$urlPath = $_SERVER['REQUEST_URI'];
$url = substr($urlPath, strlen($folderPath));//Extraemos todo lo que viene despues de la ruta padre

define('URL', $url);//Guardamos la variable $url en una constante global URL
// $url = explode('/',$url);
$page = !empty($url) ? $url : 'Page';
define('PAGE', $page);
