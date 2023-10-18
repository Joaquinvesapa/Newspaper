<?php
if(isset($parameters['data'])){
  $noticia = $parameters['data']['noticia'];
}
?>

<h1>Form Noticia</h1>

<?php if(isset($noticia)) :?>
  <?php var_dump($noticia);?>
<?php endif;?>