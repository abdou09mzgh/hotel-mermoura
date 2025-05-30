<?php
require '../../config/database.php';
header('Content-Type: application/json');

$query = $_GET['query'] ?? '';
$query = trim($query);

if ($query === '') {
    echo json_encode([]);
    exit;
}

try {
    $stmt = $conn->prepare("
        SELECT 
            id_Client, 
            FName_Client, 
            LName_Client, 
            Phone_Client, 
            Email_Client 
        FROM Client 
        WHERE 
            FName_Client LIKE :search OR 
            LName_Client LIKE :search OR 
            Phone_Client LIKE :search OR 
            Email_Client LIKE :search 
        LIMIT 20
    ");
    $search = '%' . $query . '%';
    $stmt->bindValue(':search', $search);
    $stmt->execute();

    $results = $stmt->fetchAll();
    echo json_encode($results);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Erreur serveur']);
}
