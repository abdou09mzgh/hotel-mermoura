<?php
session_start(); // Start the session
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Guest Information - Hotel Mermoura</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../Accueil.css">
        <script src="../Accueil.js"></script>
        <link rel="stylesheet" href="Réservation.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.0.0/fonts/remixicon.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" >
    </head>
    <body>
        <!--Head-->
        <div class="header">
            <div class="logo">
                <h1>HOTEL MERMOURA</h1>
                <p>GUELMA</p>
                <img class="Logo" src="../images/Logo.jfif">
            </div>
            <div class="menu">
                <ul>
                    <li id="Apropos">ABOUT</li>
                    <li id="Chambres">ROOMS</li>
                    <li id="Restaurant">RESTAURANT</li>
                    <li id="Services">SERVICES</li>
                    <li id="Reservation">BOOKING</li>
                    <li id="Contact">CONTACT</li>
                </ul>
                <div class="menu-toggle">
                    <i class="fas fa-bars"></i>
                </div>
            </div>
        </div>
        <div class="booking-page">
        <h2>Book Your Stay</h2>
        <p>Fill out the form below to reserve your room:</p>

        <form id="bookingForm" action="Réservation/Réservation.html" method="POST">
            <h3>Booking Form</h3>
            <div class="form-group">
                <label for="arrival">Arrival</label>
                <input type="date" id="arrival" name="arrival" required>
            </div>
            <div class="form-group">
                <label for="departure">Departure</label>
                <input type="date" id="departure" name="departure" required>
            </div>
            <div class="form-group">
                <label for="room-type">Room Type</label>
                <select id="room-type" name="room-type" required>
                    <option value="">-- Select --</option>
                    <optgroup label="Rooms">
                        <option value="Single">Single</option>
                        <option value="Double">Double</option>
                        <option value="Junior-Single">Junior-Single</option>
                        <option value="Junior-Double">Junior-Double</option>
                        <option value="Apart-Single">Apart-Single</option>
                        <option value="Apart-Double">Apart-Double</option>
                    </optgroup>
                </select>
            </div>
            <div class="form-group">
                <label for="guests">Number of Guests</label>
                <select id="guests" name="guests" required>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
            </div>
            <button type="submit" class="submit-btn">Book Now</button>
        </form>
    </div>
         <!-- Contenu principal -->
    <div class="content">
         <!-- Hero/Banner Section -->
         <div class="hero">
            <div class="hero-content">
                <h1>Welcome to Hotel Mermoura</h1>
                <p>A perfect blend of tradition and modernity</p>
            </div>
        </div>
       
        <div class="reservation-form-container">
        <?php
        // Display error message if any
        if (isset($_SESSION['error'])) {
            echo '<p style="color: red;">' . $_SESSION['error'] . '</p>';
            unset($_SESSION['error']); // Clear the error message after displaying
        }
        ?>
        <form id="clientForm" action="../api/process_booking.php" method="POST">
    <h2>Complete Your Reservation</h2>
    
    <div class="booking-summary">
        <h3>Your Booking Summary:</h3>
        <div id="bookingDetails"></div>
    </div>
    
    <div class="form-group">
        <label for="first-name">First Name *</label>
        <input type="text" id="first-name" name="first-name" required>
    </div>
    
    <div class="form-group">
        <label for="last-name">Last Name *</label>
        <input type="text" id="last-name" name="last-name" required>
    </div>
    
    <div class="form-group">
        <label for="email">Email *</label>
        <input type="email" id="email" name="email" required>
    </div>
    
    <div class="form-group">
        <label for="phone">Phone *</label>
        <input type="tel" id="phone" name="phone" required>
    </div>
    
    <div>
        <input id="hotel" type="checkbox" name="payment" value="Payment at the hotel" />
        <label for="hotel">Payment at the hotel</label>
    </div>
   
    <button type="submit" class="submit-btn">Confirm Reservation</button>
</form>

        </div>
    </div>

                                                <!--Footer-->
        <div class="footer">
            <div class="footer-content">
                <div class="footer-section about">
                    <div class="logo">
                        <h1>HOTEL MERMOURA</h1>
                        <p>GUELMA</p>
                    </div>
                    <p>Hotel Mermoura, located in the heart of the historic city of Guelma, 
                    combines comfort and tradition for an unforgettable experience.</p>
                    <div class="contact">
                        <span><a href="https://api.whatsapp.com/send/?phone=00213661322373&text&type=phone_number&app_absent=0"> +213 661 32 23 73</a></span>
                        <span><a href="https://mail.google.com/mail/u/0/#inbox?compose=GTvVlcSPGFjBbslQVGnCzrfpHpBxKBxtLgGRswpgwpGNqpWpNpnvgLffhrFxFpmDtgtRSgqFDdGCV">mermoura.marketing@gmail.com</a></span>
                    </div>
                </div>
                <div class="footer-section links">
                    <h2>Explore</h2>
                    <ul>
                        <li><a href="#apropos">About</a></li>
                        <li><a href="#chambres">Rooms</a></li>
                        <li><a href="#restaurant">Restaurant</a></li>
                        <li><a href="#services">Services</a></li>
                        <li><a href="#reservation">Booking</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-section newsletter">
                    <h2>Newsletter</h2>
                    <p>Subscribe to receive our special offers</p>
                    <form>
                        <input type="email" placeholder="Your email" required>
                        <button type="submit"><i class="fas fa-paper-plane"></i></button>
                    </form>
                    <div class="socials">
                        <a href="https://www.facebook.com/mermoura.hotel" target="_blank" aria-label="Facebook" style="text-decoration: none;">
                            <i class="ri-facebook-circle-line"></i>
                        </a>
                        <a href="https://www.instagram.com/mermoura.hotel" target="_blank" aria-label="Instagram" style="text-decoration: none;">
                            <i class="ri-instagram-line"></i>
                        </a>  
                        <a href="https://www.tiktok.com/@hotel.mermoura" target="_blank" aria-label="TikTok" style="text-decoration: none;">
                            <i class="ri-tiktok-line"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2023 Hotel Mermoura. All rights reserved.</p>
            </div>
        </div>
        <script src="Reservation.js"></script>
    </body>            
</html>
