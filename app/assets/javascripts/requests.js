// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$( document ).on('turbolinks:load', function() {

  // LIMIT THE NUMBER OF DATE/TIME AVAILABILITIES IN EACH REQUEST

  // var availabilities_count = $("#availabilities")[0].getElementsByClassName('nested-fields').length;
  var limit = 4;

  $('#availabilities').on('cocoon:before-insert', function(e) {
    availabilities_count = e.currentTarget.getElementsByClassName('nested-fields').length;
    if (availabilities_count == limit) {
      e.preventDefault();
      alert('limit reached');
    };
  })
  .on('cocoon:after-insert', function(e) {
    // remove add_button if limit exceeded
    if (availabilities_count == limit - 1 ) {
      $("#availabilities a.add_fields").hide();
    };
    // focus on date input of the recently added availability
    var last_element = this.getElementsByClassName('nested-fields')[availabilities_count];
    last_element.firstElementChild.firstElementChild.focus();
  })
  .on('cocoon:after-remove', function() {
    if (availabilities_count < limit ) {
      $("#availabilities a.add_fields").show();
    };
  });

});
