<?php
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);
if (!$data) {
    echo json_encode(['success' => false, 'message' => 'Données manquantes']);
    exit;
}

require_once '../config/Database.php';

$arrivalDate = $data['arrival'];
$typeEvenement = trim($data['typeEvenement']);
$guests = (int)$data['guests'];
$firstName = $data['firstName'];
$lastName = $data['lastName'];
$email = $data['email'];
$phone = $data['phone'];
$paymentMethod = $data['paymentMethod'];

$hotelId = 1;
$salleId = 1;
$prixParPersonne = 200;
$total = $prixParPersonne * $guests;

try {
    $conn->beginTransaction();

    $stmt = $conn->prepare("SELECT COUNT(*) FROM Reservation_Salle WHERE Date_Arive = ? AND id_Salle = ?");
    $stmt->execute([$arrivalDate, $salleId]);
    if ($stmt->fetchColumn() > 0) {
        echo json_encode(['success' => false, 'message' => 'Une réservation existe déjà à cette date.']);
        exit;
    }

    $stmt = $conn->prepare("INSERT INTO Client (FName_Client, LName_Client, Phone_Client, Email_Client) VALUES (?, ?, ?, ?)");
    $stmt->execute([$firstName, $lastName, $phone, $email]);
    $clientId = $conn->lastInsertId();

    $stmt = $conn->prepare("INSERT INTO Reservation_Salle (Date_Arive, Nbre_personnes, Type_evenement, id_Client, id_Salle) VALUES (?, ?, ?, ?, ?)");
    $stmt->execute([$arrivalDate, $guests, $typeEvenement, $clientId, $salleId]);
    $reservationId = $conn->lastInsertId();

    $stmt = $conn->prepare("INSERT INTO Facture (montant_total, date_facture, id_Reservation_Salle) VALUES (?, ?, ?)");
    $stmt->execute([$total, date('Y-m-d'), $reservationId]);
    $factureId = $conn->lastInsertId();

    $stmt = $conn->prepare("INSERT INTO Paiement (mode_paiement, montant, date_paiement, id_Facture) VALUES (?, ?, ?, ?)");
    $stmt->execute([$paymentMethod, $total, date('Y-m-d'), $factureId]);

    $conn->commit();

    echo json_encode([
        'success' => true,
        'reservationId' => $reservationId,
        'price' => $total
    ]);
} catch (Exception $e) {
    $conn->rollBack();
    echo json_encode(['success' => false, 'message' => 'Erreur serveur']);
}
