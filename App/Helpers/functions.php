<?php

function isLogged()
{
  return isset($_SESSION['id']);
}