<?php
header('Content-Type: application/json');
require_once '../config/database.php'; // Assure-toi du chemin exact

// $conn vient de Database.php

$data = json_decode(file_get_contents("php://input"), true);
if (!$data) {
    echo json_encode(['success' => false, 'message' => 'Données manquantes']);
    exit;
}

$arrivalDate = $data['arrival'];
$kitchenType = trim($data['kitchenType']);
$guests = (int)$data['guests'];
$firstName = $data['firstName'];
$lastName = $data['lastName'];
$email = $data['email'];
$phone = $data['phone'];
$paymentMethod = $data['paymentMethod'];

$hotelId = 1;
$restaurantId = 1;
$prixParPersonne = 2000;
$total = $prixParPersonne * $guests;

try {
    $conn->beginTransaction();

    // Vérifier si cuisine existe
    $stmt = $conn->prepare("SELECT id_Cuisine FROM Cuisine_Type WHERE name = ?");
    $stmt->execute([$kitchenType]);
    $cuisine = $stmt->fetch();

    if (!$cuisine) {
        // Insérer nouvelle cuisine
        $stmt = $conn->prepare("INSERT INTO Cuisine_Type (name) VALUES (?)");
        $stmt->execute([$kitchenType]);
        $cuisineId = $conn->lastInsertId();
    } else {
        $cuisineId = $cuisine['id_Cuisine'];
    }

    // Insérer client
    $stmt = $conn->prepare("INSERT INTO Client (FName_Client, LName_Client, Phone_Client, Email_Client) VALUES (?, ?, ?, ?)");
    $stmt->execute([$firstName, $lastName, $phone, $email]);
    $clientId = $conn->lastInsertId();

    // Insérer réservation restaurant en passant id_Cuisine
    $stmt = $conn->prepare("
        INSERT INTO Reservation_Restaurant (Date_Arive, Nbre_personnes, id_Client, id_Restaurant, id_Cuisine)
        VALUES (?, ?, ?, ?, ?)
    ");
    $stmt->execute([$arrivalDate, $guests, $clientId, $restaurantId, $cuisineId]);

    $reservationId = $conn->lastInsertId();

    // Facture
    $stmt = $conn->prepare("INSERT INTO Facture (montant_total, date_facture, id_Reservation_Restaurant) VALUES (?, ?, ?)");
    $stmt->execute([$total, date('Y-m-d'), $reservationId]);

    $factureId = $conn->lastInsertId();

    // Paiement
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
    echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
}
?>
