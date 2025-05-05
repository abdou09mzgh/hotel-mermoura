<?php
session_start();
require_once $_SERVER['DOCUMENT_ROOT'].'/hotel-mermoura/config/database.php';

if (isset($_POST['username']) && isset($_POST['userPassword'])) {
    $username = trim($_POST['username']);
    $password = $_POST['userPassword'];

    try {
        $sql = "SELECT * FROM Admin WHERE User_name = ?";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($password, $user['password'])) {
            $_SESSION['admin_id'] = $user['id_Admin'];
            $_SESSION['username'] = $user['User_name'];
            $_SESSION['nom'] = $user['LastName'];
            $_SESSION['prenom'] = $user['FirstName'];

            header("Location: /hotel-mermoura/admin/dashboard.html");
            exit();
        } else {
            $_SESSION['error'] = "Nom d'utilisateur ou mot de passe incorrect.";
            header("Location: /hotel-mermoura/admin/index.html");
            exit();
        }
    } catch (PDOException $e) {
        $_SESSION['error'] = "Erreur serveur.";
        header("Location: /hotel-mermoura/admin/index.html");
        exit();
    }
} else {
    $_SESSION['error'] = "Champs manquants.";
    header("Location: /hotel-mermoura/admin/index.html");
    exit();
}
