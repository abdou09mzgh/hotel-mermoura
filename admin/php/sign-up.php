<?php
session_start();
require_once $_SERVER['DOCUMENT_ROOT'].'/hotel-mermoura/config/database.php';

if (
    isset($_POST['username']) &&
    isset($_POST['userFirstName']) &&
    isset($_POST['userLastName']) &&
    isset($_POST['userPassword']) &&
    isset($_POST['hotelId'])
) {
    $username = trim($_POST['username']);
    $prenom = trim($_POST['userFirstName']);
    $nom = trim($_POST['userLastName']);
    $password = $_POST['userPassword'];
    $hotelId = (int) $_POST['hotelId'];

    try {
        $sql = "SELECT * FROM Admin WHERE User_name = ?";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$username]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($result) {
            echo "Nom d'utilisateur déjà utilisé.";
            exit();
        }

        $sql = "INSERT INTO Admin (FirstName, LastName, User_name, password, id_Hotel) VALUES (?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
        $stmt->execute([$prenom, $nom, $username, $hashedPassword, $hotelId]);

        $_SESSION['admin_id'] = $conn->lastInsertId();
        $_SESSION['username'] = $username;
        $_SESSION['nom'] = $nom;
        $_SESSION['prenom'] = $prenom;

        echo "success";
        exit();
    } catch (PDOException $e) {
        echo "Erreur serveur.";
        exit();
    }
} else {
    echo "Champs manquants.";
    exit();
}
