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

// REQUEST#SHOW MOBILE MODIFICATIONS

  $('.scrollable-content').show(function() {
    var parent = $(this).parent();
    var requestContainer = $('.request-container');

    var footer = $('.request-footer');

    $(window).on('resize', function() {

      $(requestContainer).css({
       	'min-height' : $(footer)[0].offsetTop - $(requestContainer)[0].offsetTop
      });

      if ( $(parent).css('overflow-y') == 'scroll' ) {
        console.log('scroll set');
        $('.body-element').css('height',0);
        ($(parent).css({
          'position':'fixed',
          'top': $(parent)[0].offsetTop + "px",
          'bottom': 0
        }));
        $('.scrollable-content').addClass('mb-5');
        $('.comment-input').addClass('fixed-bottom');
      } else {
        console.log('scroll unset');
        $('.body-element').css('height','initial');
        ($(parent).css({
          'position':'initial',
          'top': $(parent).offsetTop,
          'bottom': 0
        }));
        $('.scrollable-content').removeClass('mb-5');
        $('.comment-input').removeClass('fixed-bottom');
      };
    }).resize();
  });


});
