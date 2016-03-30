$( document ).ready(function() {
  $( ".job.card" ).click(function() {
     $(this).find(".description").slideToggle( "slow", function() {
    });
  });
});