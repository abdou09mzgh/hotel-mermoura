// document.getElementById("userAccountForm").addEventListener("submit", function(event) {
//     event.preventDefault();

//     const firstName = document.getElementById("userFirstName").value.trim();
//     const lastName = document.getElementById("userLastName").value.trim();
//     const username = document.getElementById("username").value.trim();
//     const password = document.getElementById("userPassword").value.trim();
//     const hotelId = document.getElementById("hotelId").value.trim();

//     const userData = {
//         userFirstName: firstName,
//         userLastName: lastName,
//         username: username,
//         hotelId: hotelId
//     };

//     localStorage.setItem('isLoggedIn', 'true');
//     localStorage.setItem('userData', JSON.stringify(userData));

//     window.location.href = '/hotel-mermoura/admin/dashboard.html';
// });


document.getElementById("userAccountForm").addEventListener("submit", function(event) {
    event.preventDefault();

    let firstName = document.getElementById("userFirstName").value;
    let lastName = document.getElementById("userLastName").value;
    let username = document.getElementById("username").value;
    let password = document.getElementById("userPassword").value;
    let hotelId = document.getElementById("hotelId").value;

    let data = `userFirstName=${encodeURIComponent(firstName)}&` +
                `userLastName=${encodeURIComponent(lastName)}&` +
                `username=${encodeURIComponent(username)}&` +
                `userPassword=${encodeURIComponent(password)}&` +
                `hotelId=${encodeURIComponent(hotelId)}`;

    fetch("php/sign-up.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            window.location.href = "/hotel-mermoura/admin/dashboard.html";
        } else {
            document.getElementById("message").textContent = result;
        }
    })
    .catch(() => {
        document.getElementById("message").textContent = "Erreur lors de l’envoi.";
    });
});
