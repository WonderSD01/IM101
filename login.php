<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

// REMOVE or COMMENT OUT THIS PART
// echo "Login.php is running!";
// exit();

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

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Collect and sanitize form data
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    // SQL query to select user data from the database
    $sql = "SELECT * FROM users WHERE username = '$username'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();

        // Verify the password
        if (password_verify($password, $row['password'])) {
            $_SESSION['user_id'] = $row['id'];  // Store user ID in session
            $_SESSION['username'] = $row['username'];  // Store username in session

            // Redirect using JavaScript (fixes InfinityFree issue)
            echo "<script>window.location.href = 'dashboard.php';</script>";
            exit();
        } else {
            echo "<script>alert('Incorrect password!'); window.location.href = 'login.html';</script>";
            exit();
        }
    } else {
        echo "<script>alert('Username not found!'); window.location.href = 'login.html';</script>";
        exit();
    }
}

// Close the connection
$conn->close();
?>
