<?php
session_start();

// Check if the user is logged in (to prevent accessing the welcome page directly without logging in)
if (!isset($_SESSION['user_id'])) {
    header("Location: login.html");
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="wrapper">
        <h2>Welcome, <?php echo $_SESSION['username']; ?>!</h2>
        <p>Thank you for registering with us. You are now successfully logged in.</p>
        <p><a href="dashboard.php">Go to your dashboard</a></p>
    </div>
</body>
</html>
