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

// REQUEST#SHOW MOBILE <--> DESKTOP MODIFICATIONS

  resizeAfterAlert = function() {
    var rc = $('.request-middle-column');
    if ( $(rc).css('overflow-y') == 'scroll' ) {
      $(rc).css({
        'top': $('.request-card')[0].scrollHeight + $('.navbar')[0].scrollHeight
      });
    } else {
      $(rc).css({
        'height' : 'inherit'
      })
    }
  };

  $('.scrollable-content').show(function() {

    var midCol = $(this).parent(); // .request-middle-column
    var parentContainer = $('.request-container');
    var leftCol = $('.request-left-column');
    var footer = $('.request-footer');

    $(window).on('resize', function() {

      var leftColHeight = $('.request-card')[0].scrollHeight + $('.navbar')[0].scrollHeight;
      $(parentContainer).css({'height': $(footer)[0].offsetTop - $('.navbar')[0].scrollHeight})

      if ( $(midCol).css('overflow-y') == 'scroll' ) {
        $('.body-element').css('height',0);
        $(midCol).css({
          'position':'absolute',
          'top': leftColHeight,
          'bottom': 0,
          'height': 'initial'
        });
        $('.scrollable-content').addClass('mb-5');
        $('.comment-input').addClass('fixed-bottom');
      } else {

        $('.body-element').css('height','initial');
        $(midCol).css({
          'position':'relative',
          'top': 'initial',
          'bottom': 0,
          'height' : '100%'
        });
        $('.scrollable-content').removeClass('mb-5');
        $('.comment-input').removeClass('fixed-bottom');
      };
    }).resize();

    // resize after closing alert box
    $('#sitewide-alert').on('closed.bs.alert', function() {
      resizeAfterAlert();
    });

  });

// ADD RESPONSE TO UPDATING STATUS
  

});
