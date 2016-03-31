
$(function() {
  $( ".job.card" ).click(function(){
    $(this).toggleClass('fullscreen', 1000);
    $('body').toggleClass('black',1000);
    $('.card-title').toggleClass('large',1000);
    $('.close-icon').toggle();
    $('.description').toggle();
  });
});