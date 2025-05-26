<?php
header('Content-Type: application/json');
$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
    echo json_encode(['success' => false, 'message' => 'Données manquantes']);
    exit;
}

require_once '../config/Database.php';

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

    // Vérifier si une réservation existe déjà à cette date
    $stmt = $conn->prepare("SELECT COUNT(*) FROM Reservation_Restaurant WHERE Date_Arive = ? AND id_Restaurant = ?");
    $stmt->execute([$arrivalDate, $restaurantId]);
    if ($stmt->fetchColumn() > 0) {
        echo json_encode(['success' => false, 'message' => 'Une réservation existe déjà à cette date.']);
        exit;
    }

    // 1. Insérer client
    $stmt = $conn->prepare("INSERT INTO Client (FName_Client, LName_Client, Phone_Client, Email_Client) VALUES (?, ?, ?, ?)");
    $stmt->execute([$firstName, $lastName, $phone, $email]);
    $clientId = $conn->lastInsertId();

    // 2. Cuisine
    $stmt = $conn->prepare("SELECT id_Cuisine FROM Cuisine_Type WHERE name = ?");
    $stmt->execute([$kitchenType]);
    $cuisine = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$cuisine) {
        $stmt = $conn->prepare("INSERT INTO Cuisine_Type (name) VALUES (?)");
        $stmt->execute([$kitchenType]);
        $cuisineId = $conn->lastInsertId();
    } else {
        $cuisineId = $cuisine['id_Cuisine'];
    }

    // 3. Lier cuisine à restaurant
    $stmt = $conn->prepare("SELECT 1 FROM Restaurant_Cuisine WHERE id_Restaurant = ? AND id_Cuisine = ?");
    $stmt->execute([$restaurantId, $cuisineId]);
    if (!$stmt->fetchColumn()) {
        $stmt = $conn->prepare("INSERT INTO Restaurant_Cuisine (id_Restaurant, id_Cuisine) VALUES (?, ?)");
        $stmt->execute([$restaurantId, $cuisineId]);
    }

    // 4. Réservation
    $stmt = $conn->prepare("INSERT INTO Reservation_Restaurant (Date_Arive, Nbre_personnes, id_Client, id_Restaurant) VALUES (?, ?, ?, ?)");
    $stmt->execute([$arrivalDate, $guests, $clientId, $restaurantId]);
    $reservationId = $conn->lastInsertId();

    // 5. Facture
    $stmt = $conn->prepare("INSERT INTO Facture (montant_total, date_facture, id_Reservation_Restaurant) VALUES (?, ?, ?)");
    $stmt->execute([$total, date('Y-m-d'), $reservationId]);
    $factureId = $conn->lastInsertId();

    // 6. Paiement
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

