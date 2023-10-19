<?php

class Response{
  public $data;
  public $status;
  public function __construct($data = null, $status = 200){
    $this->status = $status;
    $this->data = $data;
  }
}