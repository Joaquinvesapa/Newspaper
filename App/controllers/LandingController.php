<?php

class LandingController extends Controller{

  public function __construct(){

  }

  public function home(){
    $this->render('landing', [], 'layout');
  }
}