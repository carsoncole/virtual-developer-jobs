$( document ).ready(function() {

  $( ".job.card" ).click(function() {
     $(".description").first().slideToggle( "slow", function() {


    });
  });
});