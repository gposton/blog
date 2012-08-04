$(document).ready(
  function() {
    $( '.best_in_place' ).best_in_place();
    $( '.datepicker' ).datepicker({ dateFormat: "yy-mm-dd" });
    $( '.rsvp' ).bind("ajax:success", function(){
      $(this).parent('td').siblings('.rsvp_status').children('#rsvp_no').slideToggle();
      $(this).parent('td').siblings('.rsvp_status').children('#rsvp_yes').slideToggle();
    });
  }
);
