<?php
header('Content-Type: application/json');
$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
    echo json_encode(['success' => false, 'message' => 'Données manquantes']);
    exit;
}

require_once '../config/Database.php';

$arrivalDate = $data['arrival'];
$kitchenType = $data['kitchenType'];
$guests = (int)$data['guests'];
$firstName = $data['firstName'];
$lastName = $data['lastName'];
$email = $data['email'];
$phone = $data['phone'];
$paymentMethod = $data['paymentMethod'];

$hotelId = 1;
$prixParPersonne = 30.00;
$total = $prixParPersonne * $guests;

try {
    $conn->beginTransaction();

    // Client
    $stmt = $conn->prepare("INSERT INTO Client (FName_Client, LName_Client, Phone_Client, Email_Client) VALUES (?, ?, ?, ?)");
    $stmt->execute([$firstName, $lastName, $phone, $email]);
    $clientId = $conn->lastInsertId();

    // Restaurant
    $stmt = $conn->prepare("INSERT INTO Restaurant (Date_Arive, capacite, Kitchen_type, id_Client, id_Hotel) VALUES (?, ?, ?, ?, ?)");
    $stmt->execute([$arrivalDate, $guests, $kitchenType, $clientId, $hotelId]);
    $restaurantId = $conn->lastInsertId();

    // Reservation
    $stmt = $conn->prepare("INSERT INTO Reservation (Date_Arive, Date_Depart, Nbre_personnes, id_Client, id_Restaurant, id_Hotel) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->execute([$arrivalDate, $arrivalDate, $guests, $clientId, $restaurantId, $hotelId]);
    $reservationId = $conn->lastInsertId();

    // Facture
    $stmt = $conn->prepare("INSERT INTO Facture (montant_total, date_facture, id_Reservation) VALUES (?, ?, ?)");
    $stmt->execute([$total, date('Y-m-d'), $reservationId]);
    $factureId = $conn->lastInsertId();

    // Paiement
    $stmt = $conn->prepare("INSERT INTO Paiement (mode_paiement, montant, date_paiement, id_Facture) VALUES (?, ?, ?, ?)");
    $stmt->execute([$paymentMethod, $total, date('Y-m-d'), $factureId]);

    $conn->commit();

    echo json_encode(['success' => true, 'reservationId' => $reservationId]);
} catch (Exception $e) {
    $conn->rollBack();
    echo json_encode(['success' => false, 'message' => 'Erreur serveur']);
}
