$(function() {
  $('.view__message--new').on('submit', function(e){
    e.preventDefault();
    message = $('.view__message--new__input').val();
    console.log(message);
  });
});
