<?php

require_once(__DIR__ . '/config.php');
require_once(__DIR__ . '/router.php');
require_once(__DIR__ . '/Core/Controller.php');
require_once(__DIR__ . '/Core/Orm.php');
require_once(__DIR__ . '/Core/Err.php');
require_once(__DIR__ . '/Core/Response.php');
require_once(__DIR__ . '/Services/database.php');
require_once(__DIR__ . '/Helpers/functions.php');
require_once(__DIR__ . '/Helpers/enviarMails.php');
$modelos = glob(__DIR__ . '/models/*.php');
foreach ($modelos as $m)
  require_once $m;

$modelos = glob(__DIR__ . '/PHPMailer/*.php'); foreach ($modelos as $m)
  require_once $m;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;