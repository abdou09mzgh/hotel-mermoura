<?php
require '../../config/database.php'; // Ton fichier existant avec la connexion PDO

try {
    $stmt = $conn->query("SELECT id_Admin, FirstName, LastName, User_name FROM Admin");
    $admins = $stmt->fetchAll();

    echo json_encode($admins);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
