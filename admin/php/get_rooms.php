<?php
require '../../config/database.php'; // your connection file

$limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$offset = ($page - 1) * $limit;

$stmt = $conn->prepare("
    SELECT C.id_Chambre AS room_id, T.nom_type, T.Prix, T.nombres_chambres,
           C.statut, T.id_Type_Chambre
    FROM Chambre C
    JOIN Type_Chambre T ON C.id_Type_Chambre = T.id_Type_Chambre
    LIMIT :offset, :limit
");
$stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
$stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
$stmt->execute();
$rooms = $stmt->fetchAll();

echo json_encode($rooms);
