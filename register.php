<?php
// Database connection settings
$host = 'sql311.infinityfree.com';
$username = 'if0_38590430'; // Your MySQL Username
$password = 'malabanan123456'; // Your MySQL Password
$dbname = 'if0_38590430_test_db01'; // Your MySQL Database Name

// Create a connection to the database
$conn = new mysqli($host, $username, $password, $dbname);

// Check if the connection was successful
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if form is submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Collect form data and sanitize
    $first_name = mysqli_real_escape_string($conn, $_POST['first_name']);
    $last_name = mysqli_real_escape_string($conn, $_POST['last_name']);
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
    $confirm_password = mysqli_real_escape_string($conn, $_POST['confirm_password']);

    // Check if passwords match
    if ($password !== $confirm_password) {
        echo "Passwords do not match!<br>";
        exit();
    }

    // Hash the password for security
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // SQL query to insert user data into the database
    $sql = "INSERT INTO users (first_name, last_name, username, email, password) 
            VALUES ('$first_name', '$last_name', '$username', '$email', '$hashed_password')";

    // Execute query and check for success
    if ($conn->query($sql) === TRUE) {
        // Successful registration, redirect to welcome page
        session_start();
        $_SESSION['username'] = $username; // Store username in session
        header("Location: welcome.php"); // Redirect to welcome page
        exit();
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Close the connection
    $conn->close();
}
?>
