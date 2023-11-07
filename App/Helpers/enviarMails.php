<?php
//Import PHPMailer classes into the global namespace
//These must be at the top of your script, not inside a function

//Load Composer's autoloader
// require_once('../../PHPMailer/PHPMailer.php');
// require_once('/PHPMailer/SMTP.php');
// require_once('/PHPMailer/Exception.php');
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;


//Create an instance; passing `true` enables exceptions

function enviarMail($data)
{
  $mail = new PHPMailer(true);
  $options["ssl"] = array(
    "verify_peer" => false,
    "verify_peer_name" => false,
    "allow_self_signed" => true,
  );
  try {
    //Server settings
    $mail->SMTPDebug = 0; //Enable verbose debug output
    $mail->isSMTP(); //Send using SMTP
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = $_ENV['EMAIL_CONTACTO']; //SMTP username
    $mail->Password = $_ENV['APP_MAIL_KEY']; //SMTP password
    $mail->SMTPSecure = 'ssl';
    $mail->Port = 465; //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

    //Recipients
    $mail->setFrom('newspapercontacto@gmail.com', 'Newspaper');
    $mail->smtpConnect($options);
    $mail->addAddress($data['Email']);
    //Content
    $mail->isHTML(true); //Set email format to HTML
    $mail->Subject = $data["Asunto"];
    $mail->Body = $data["Mensaje"];
    $mail->send();
  } catch (Exception $e) {
    echo "El mensaje no se pudo enviar por el siguiente error: {$mail->ErrorInfo}";
  }
}