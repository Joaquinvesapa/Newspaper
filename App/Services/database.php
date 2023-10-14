<?php

class Database{

  private $connection;
  public function __construct(){
    $options = [
      PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
      PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ];
    $this->connection = new PDO("mysql:host=localhost;dbname=newspapr",'root','', $options);
    // $this->connection->exec("SET CHARSET SET UTF8");
  }

  public function getConnection(){
    return $this->connection;
  }
}