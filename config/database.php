<?php
// Database connection details
$servername = "localhost"; 
$username = "root";        
$password = "";            
$dbname = "hotel-mermoura";  

try {
    // Create PDO connection
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    
    // Set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Optional: Set default fetch mode to associative array
    $conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    
    // Optional: Disable emulated prepared statements for security
    $conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    // echo "Connected successfully"; // You can uncomment this for testing
} catch(PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?>