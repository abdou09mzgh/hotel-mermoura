<?php
require '../../config/database.php'; // utilise la connexion existante

header('Content-Type: application/json');

try {
    $stmt = $conn->query("
    SELECT
        (SELECT COUNT(*) FROM Chambre) AS total_rooms,
        (SELECT COUNT(*) FROM Reservation_Chambre
         WHERE CURDATE() >= Date_Arive AND CURDATE() <= Date_Depart) AS current_bookings
");

    $data = $stmt->fetch();
    echo json_encode($data);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>
