<?php

class NotFoundController extends Controller{

  public function __construct(){
    
  }

  public function home(){
    $this->render('notfound', [], 'layout');

  }
}