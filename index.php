<?php
require_once(__DIR__ . '/App/autoload.php');
require_once(__DIR__ . '/vendor/autoload.php');

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// require_once(__DIR__ . '/router.php');
$router = new Router();

$router->run();