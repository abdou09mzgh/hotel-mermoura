<?php
require_once '../../config/database.php';

$response = [];

// Chambre
$sqlChambre = "
    SELECT 
        c.id_Client,
        CONCAT(c.FName_Client, ' ', c.LName_Client) AS full_name,
        c.Email_Client,
        c.Phone_Client,
        ch.id_Chambre,
        COALESCE(p.Mode_Paiement, 'Non payé') AS payment,
        rc.Date_Arive,
        rc.Date_Depart
    FROM Client c
    JOIN Reservation_Chambre rc ON c.id_Client = rc.id_Client
    JOIN Chambre ch ON rc.id_Chambre = ch.id_Chambre
    LEFT JOIN Facture f ON f.id_Reservation_Chambre = rc.id_Reservation
    LEFT JOIN Paiement p ON p.id_Facture = f.id_Facture
    ORDER BY rc.Date_Arive DESC
";
$stmt = $conn->query($sqlChambre);
$response['chambre'] = $stmt->fetchAll();

// Restaurant
$sqlRestaurant = "
    SELECT 
        c.id_Client,
        CONCAT(c.FName_Client, ' ', c.LName_Client) AS full_name,
        c.Email_Client,
        c.Phone_Client,
        rr.id_Restaurant,
        ct.name AS cuisine,
        COALESCE(p.Mode_Paiement, 'Non payé') AS payment,
        rr.Date_Arive
    FROM Client c
    JOIN Reservation_Restaurant rr ON c.id_Client = rr.id_Client
    JOIN Cuisine_Type ct ON rr.id_Cuisine = ct.id_Cuisine
    LEFT JOIN Facture f ON f.id_Reservation_Restaurant = rr.id_Reservation
    LEFT JOIN Paiement p ON p.id_Facture = f.id_Facture
    ORDER BY rr.Date_Arive DESC
";
$stmt = $conn->query($sqlRestaurant);
$response['restaurant'] = $stmt->fetchAll();

// Salle
$sqlSalle = "
    SELECT 
        c.id_Client,
        CONCAT(c.FName_Client, ' ', c.LName_Client) AS full_name,
        c.Email_Client,
        c.Phone_Client,
        rs.id_Salle,
        rs.Type_evenement,
        COALESCE(p.Mode_Paiement, 'Non payé') AS payment,
        rs.Date_Arive
    FROM Client c
    JOIN Reservation_Salle rs ON c.id_Client = rs.id_Client
    LEFT JOIN Facture f ON f.id_Reservation_Salle = rs.id_Reservation
    LEFT JOIN Paiement p ON p.id_Facture = f.id_Facture
    ORDER BY rs.Date_Arive DESC
";
$stmt = $conn->query($sqlSalle);
$response['salle'] = $stmt->fetchAll();

header('Content-Type: application/json');
echo json_encode($response);
?>
