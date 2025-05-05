document.addEventListener('DOMContentLoaded', () => {
  const btn1 = document.querySelector('.Button1');

  if (btn1) {
    btn1.addEventListener('click', () => {
      window.location.href = '../bookings/book.html';
    });
  }

  const logo = document.querySelector('img.Logo');
  if(logo) {
    logo.addEventListener('click', () => {
      window.location.href = '../Accueil.html';
    } );
  }
  
});
