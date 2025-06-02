document.getElementById('phone-form').addEventListener('submit', function(e) {
    e.preventDefault();

    const phoneInput = document.getElementById('phone').value.trim();
    const errorMsg = document.getElementById('error-msg');
    const regex = /^(05|06|07)\d{8}$/;

    if (!regex.test(phoneInput)) {
        errorMsg.textContent = "Phone number must start with 05, 06, or 07 and contain exactly 10 digits.";
        errorMsg.style.display = "block";
    } else {
        errorMsg.style.display = "none";
        window.location.href = `yourbook2.html?phone=${encodeURIComponent(phoneInput)}`;
    }
});
