// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$( document ).on('turbolinks:load', function() {

 $("#sticky_footer").show(function() {
  // if sticky_footer is present
  $('[data-toggle="popover"]').popover({
      animated: 'fade',
      html: true,
      placement: 'bottom',
      container: $('[id="sticky_menu"]'),
      trigger: 'focus',
      content: $('#sticky_footer .add-menu')[0].innerHTML,
    });
  });


});
