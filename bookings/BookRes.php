
<?php
include 'db.php';

$sql = "SELECT * FROM Restaurant";
$result = $conn->query($sql);

$restaurants = [];

while ($row = $result->fetch_assoc()) {
    $restaurants[] = $row;
}

echo json_encode($restaurants);
$conn->close();
?>
<?php
include 'db.php';

$prix = $_POST['prix'];
$capacite = $_POST['capacite'];
$statut = $_POST['statut'];
$food = $_POST['food']; // Define the $food variable
$id_hotel = $_POST['id_hotel'];

$sql = "INSERT INTO Restaurant (Prix, capacite, statut, food, id_Hotel)
        VALUES (?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param("dissi", $prix, $capacite, $statut, $food, $id_hotel);

if ($stmt->execute()) {
    echo "Restaurant added successfully.";
} else {
    echo "Error: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>