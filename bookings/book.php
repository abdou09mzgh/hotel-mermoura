<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

require_once $_SERVER['DOCUMENT_ROOT'].'/hotel-mermoura/config/database.php';

try {
    $input = json_decode(file_get_contents('php://input'), true);

    $required = ['arrival', 'departure', 'roomType', 'guests', 'firstName', 'lastName', 'email', 'phone', 'paymentMethod'];
    foreach ($required as $field) {
        if (empty($input[$field])) {
            throw new Exception("Le champ $field est requis");
        }
    }

    if (!filter_var($input['email'], FILTER_VALIDATE_EMAIL)) {
        throw new Exception("L'email fourni est invalide.");
    }

    $arrivalDate = new DateTime($input['arrival']);
    $departureDate = new DateTime($input['departure']);
    if ($departureDate <= $arrivalDate) {
        throw new Exception("La date de départ doit être après la date d'arrivée.");
    }

    $hotelId = 1;
    $conn->beginTransaction();


    $conn->exec("
        UPDATE Chambre c
        JOIN Reservation_Chambre r ON c.id_Chambre = r.id_Chambre
        SET c.statut = 'Empty'
        WHERE CURDATE() >= r.Date_Depart
    ");

    // Insère le client
    $stmt = $conn->prepare("INSERT INTO Client (FName_Client, LName_Client, Phone_Client, Email_Client) VALUES (?, ?, ?, ?)");
    $stmt->execute([$input['firstName'], $input['lastName'], $input['phone'], $input['email']]);
    $clientId = $conn->lastInsertId();

    // Cherche une chambre disponible
    $stmt = $conn->prepare("SELECT c.id_Chambre, tc.Prix 
                            FROM Chambre c
                            JOIN Type_Chambre tc ON c.id_Type_Chambre = tc.id_Type_Chambre
                            WHERE tc.nom_type = ? AND c.statut = 'Empty' AND c.id_Hotel = ?
                            LIMIT 1");
    $stmt->execute([$input['roomType'], $hotelId]);
    $room = $stmt->fetch();

    if (!$room) {
        throw new Exception("Chambre non disponible");
    }

    // Insère la réservation
    $stmt = $conn->prepare("INSERT INTO Reservation_Chambre (Date_Arive, Date_Depart, Nbre_personnes, id_Client, id_Chambre) 
                            VALUES (?, ?, ?, ?, ?)");
    $stmt->execute([$input['arrival'], $input['departure'], $input['guests'], $clientId, $room['id_Chambre']]);
    $reservationId = $conn->lastInsertId();

    // Met à jour le statut de la chambre à "Occupied"
    $conn->exec("UPDATE Chambre SET statut = 'Occupied' WHERE id_Chambre = ".$room['id_Chambre']);

    // Calcule le prix total
    $nights = $arrivalDate->diff($departureDate)->days;
    $total = $room['Prix'] * $nights;

    // Insère la facture
    $stmt = $conn->prepare("INSERT INTO Facture (montant_total, date_facture, id_Reservation_Chambre) 
                            VALUES (?, CURDATE(), ?)");
    $stmt->execute([$total, $reservationId]);
    $invoiceId = $conn->lastInsertId();

    // Gère le paiement
    $paymentMode = $input['paymentMethod'];
    if (!in_array($paymentMode, ['online', 'hotel'])) {
        throw new Exception("Mode de paiement invalide.");
    }

    $paymentDate = ($paymentMode === 'online') ? (new DateTime())->format('Y-m-d') : $arrivalDate->format('Y-m-d');

    $stmt = $conn->prepare("INSERT INTO Paiement (mode_paiement, montant, date_paiement, id_Facture) 
                            VALUES (?, ?, ?, ?)");
    $stmt->execute([$paymentMode, $total, $paymentDate, $invoiceId]);

    $conn->commit();

    echo json_encode([
        'success' => true,
        'reservationId' => $reservationId,
        'total' => $total
    ]);
    exit;

} catch (Exception $e) {
    if ($conn->inTransaction()) {
        $conn->rollBack();
    }
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
