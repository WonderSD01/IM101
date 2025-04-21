<?php
session_start();
session_destroy(); // Destroy the session to log out
header("Location: login.html"); // Redirect to the login page after logging out
exit();
?>
