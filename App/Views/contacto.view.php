<?php
//Import PHPMailer classes into the global namespace
//These must be at the top of your script, not inside a function

//Load Composer's autoloader
var_dump("../ __DIR__");
// require_once('../../PHPMailer/PHPMailer.php');
// require_once('/PHPMailer/SMTP.php');
// require_once('/PHPMailer/Exception.php');
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;


//Create an instance; passing `true` enables exceptions
function enviarMail()
{
  $mail = new PHPMailer(true);
  $options["ssl"] = array(
    "verify_peer" => false,
    "verify_peer_name" => false,
    "allow_self_signed" => true,
  );
  try {
    //Server settings
    $mail->SMTPDebug = 2; //Enable verbose debug output
    $mail->isSMTP(); //Send using SMTP
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = $_ENV['EMAIL_CONTACTO']; //SMTP username
    $mail->Password = $_ENV['APP_MAIL_KEY']; //SMTP password
    $mail->SMTPSecure = 'ssl';
    $mail->Port = 465; //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

    //Recipients
    $mail->smtpConnect($options);
    $mail->addAddress($_ENV['EMAIL_CONTACTO'], 'JoaquinVesapa');
    //Content
    $mail->isHTML(true); //Set email format to HTML
    $mail->Subject = 'Here is the subject';
    $mail->Body = 'This is the HTML message body <b>in bold!</b>';
    $mail->send();
    echo 'Message has been sent';
  } catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
  }
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  enviarMail();
}
?>

<h2>Desde Contacto</h2>
<form action="">
  <button>enviarMail</button>
</form>
<script src="<?= URL_PATH ?>/public/assets/javascript/contacto.js"></script>