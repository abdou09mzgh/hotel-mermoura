document.addEventListener('DOMContentLoaded', function() {
    // Smooth scrolling for navigation links
    document.querySelectorAll('.menu ul li, .footer-section.links ul li a').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('id') || this.getAttribute('href').substring(1);
            const targetSection = document.getElementById(targetId);
            
            if (targetSection) {
                window.scrollTo({
                    top: targetSection.offsetTop - 80,
                    behavior: 'smooth'
                });
                
                // Close mobile menu if open
                document.querySelector('.menu ul').classList.remove('show');
            }
        });
    });
    
    // Mobile menu toggle
    const menuToggle = document.querySelector('.menu-toggle');
    const menu = document.querySelector('.menu ul');
    
    menuToggle.addEventListener('click', function() {
        menu.classList.toggle('show');
    });
    
    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('.header');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });
    
    // Room slider functionality
    let currentSlide = 0;
    const slides = document.querySelectorAll('.chambre');
    const totalSlides = slides.length;
    
    function showSlide(index) {
        slides.forEach((slide, i) => {
            slide.classList.toggle('active', i === index);
        });
        
        const slideWidth = document.querySelector('.chambre').offsetWidth;
        document.querySelector('.chambre-slides').style.transform = `translateX(-${index * slideWidth}px)`;
    }
    
    function nextSlide() {
        currentSlide = (currentSlide + 1) % totalSlides;
        showSlide(currentSlide);
    }
    
    function prevSlide() {
        currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
        showSlide(currentSlide);
    }
    
    // Initialize slider
    showSlide(currentSlide);
    
    // Assign functions to global scope for button clicks
    window.nextSlide = nextSlide;
    window.prevSlide = prevSlide;
    
    //  // Gestion du formulaire de réservation
  
    //   const bookingForm = document.getElementById('bookingForm');
    //   if (bookingForm) {
    //       bookingForm.addEventListener('submit', function(e) {
    //           e.preventDefault();
              
    //           // Validation des dates
    //           const arrival = new Date(this.arrival.value);
    //           const departure = new Date(this.departure.value);
              
    //           if (departure <= arrival) {
    //               alert("La date de départ doit être après l'arrivée");
    //               return;
    //           }
  
    //           // Préparation des données
    //           const bookingData = {
    //               arrival: this.arrival.value,
    //               departure: this.departure.value,
    //               roomType: this['room-type'].value,
    //               guests: this.guests.value
    //           };
  
    //           // Stockage et redirection
    //           localStorage.setItem('hotelBooking', JSON.stringify(bookingData));
    //           window.location.href = 'Reservation/Reservation.php';
    //       });
    //   }
      
    // Newsletter form
    const newsletterForm = document.querySelector('.footer-section.newsletter form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input').value;
            
            if (!email.includes('@')) {
                alert('Veuillez entrer une adresse email valide');
                return;
            }
            
            alert('Merci pour votre inscription à notre newsletter!');
            this.querySelector('input').value = '';
        });
    }
    
    // Button animations
    document.querySelectorAll('.Button1, .Button2, .Button3, .submit-btn, .hero-btn').forEach(button => {
        button.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-3px)';
            this.style.boxShadow = '0 10px 20px rgba(0, 0, 0, 0.1)';
        });
        
        button.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = 'none';
        });
    });
    
    // Image hover effects
    document.querySelectorAll('.gallery-item, .service-item, .news-item').forEach(item => {
        item.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-10px)';
        });
        
        item.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });
    
    // Current year for footer
    document.querySelector('.footer-bottom p').innerHTML = `&copy; ${new Date().getFullYear()} Hôtel Mermoura. Tous droits réservés.`;
});

// Transfers
window.onload = function () {
  const links = [
    { buttonId: 'Apropos', sectionId: 'apropos' },
    { buttonId: 'Chambres', sectionId: 'chambres' },
    { buttonId: 'Restaurant', sectionId: 'restaurant' },
    { buttonId: 'Salle', sectionId: 'salle' },
    { buttonId: 'Services', sectionId: 'services' },
    { buttonId: 'Contact', sectionId: 'contact' },
  ];

  links.forEach(link => {
    const button = document.getElementById(link.buttonId);
    const section = document.getElementById(link.sectionId);

    if (button && section) {
      button.onclick = () => {
        section.scrollIntoView({ behavior: 'smooth' });
      };
    }
  });

  const routes = {
    '#Reservation': 'bookings/book.html',
    '.Button1': 'bookings/book.html',
    '.Button2': 'about/Apropos.html',
    '.Button3': 'bookings/book.html',
    '.Button4': 'Bookings/BookRes.html',
    '.Button5' : 'Bookings/BookSalle.html'
  };
  
  Object.entries(routes).forEach(([selector, path]) => {
    const btn = document.querySelector(selector);
    if (btn) {
      btn.onclick = () => {
        window.location.href = path;
      };
    }
  });
  

//   const btn4 = document.querySelector('.Button4');
//  const fin_btn4 = document.getElementById('reservation'); 

//   if (btn4 && fin_btn4) {
//   btn4.onclick = function() {
//     fin_btn4.scrollIntoView({
//       behavior: 'smooth'
//     });
//   };
// }

  const img = document.querySelector('img.Logo');
  const fin_img = document.querySelector('.hero'); 

  if (img && fin_img) {
  img.onclick = function() {
    fin_img.scrollIntoView({
      behavior: 'smooth'
    });
  };
}
};