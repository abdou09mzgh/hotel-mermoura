<?php
require_once '../../config/database.php';

$response = [];

// Clients avec réservation chambre
$sqlChambre = "
    SELECT 
        c.id_Client,
        CONCAT(c.FName_Client, ' ', c.LName_Client) AS full_name,
        c.Email_Client,
        c.Phone_Client,
        tc.nom_type AS nom_chambre,
        rc.Date_Arive,
        rc.Date_Depart
    FROM Client c
    JOIN Reservation_Chambre rc ON c.id_Client = rc.id_Client
    JOIN Chambre ch ON rc.id_Chambre = ch.id_Chambre
    JOIN Type_Chambre tc ON ch.id_Type_Chambre = tc.id_Type_Chambre
    ORDER BY rc.Date_Arive DESC
";
$stmt = $conn->query($sqlChambre);
$response['chambre'] = $stmt->fetchAll();

// Clients avec réservation restaurant
$sqlRestaurant = "
    SELECT 
        c.id_Client,
        CONCAT(c.FName_Client, ' ', c.LName_Client) AS full_name,
        c.Email_Client,
        c.Phone_Client,
        rr.id_Restaurant,
        ct.name AS cuisine,
        rr.Date_Arive
    FROM Client c
    JOIN Reservation_Restaurant rr ON c.id_Client = rr.id_Client
    JOIN Cuisine_Type ct ON rr.id_Cuisine = ct.id_Cuisine
    ORDER BY rr.Date_Arive DESC
";
$stmt = $conn->query($sqlRestaurant);
$response['restaurant'] = $stmt->fetchAll();

// Clients avec réservation salle
$sqlSalle = "
    SELECT 
        c.id_Client,
        CONCAT(c.FName_Client, ' ', c.LName_Client) AS full_name,
        c.Email_Client,
        c.Phone_Client,
        rs.id_Salle,
        rs.Type_evenement,
        rs.Date_Arive
    FROM Client c
    JOIN Reservation_Salle rs ON c.id_Client = rs.id_Client
    ORDER BY rs.Date_Arive DESC
";
$stmt = $conn->query($sqlSalle);
$response['salle'] = $stmt->fetchAll();

header('Content-Type: application/json');
echo json_encode($response);
?>
