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
  //
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

    var fullContainer = $('.request-container');
    var midCol =  $('.request-middle-column'); // .request-middle-column
    var leftCol = $('.request-left-column');

    $('.body-element').css('height',0);

    $(window).on('resize.scrollableContent', function() {

      // if .scrollable-content div does not exist in the DOM, remove listener
      if ($('.scrollable-content').length == 0) {
        $(window).off('resize.scrollableContent');
        return;
      }

      var leftColHeight = $('.request-card')[0].scrollHeight + $('.navbar')[0].scrollHeight;

      if ( $('.scrollable-content').css('overflow-y') == 'scroll' ) {
        $(fullContainer).css({
          'height': 'inherit'
        });
        $(midCol).css({
          'top': leftColHeight // adjust top of div to right below .request-card
        });
        $('.scrollable-content').css({
          'margin-bottom': '3em'
        })
      } else {
        $(fullContainer).css({
          'height': $('.comment-input')[0].offsetTop - $('.navbar')[0].scrollHeight}
        );
        $(midCol).css({
          'overflow': 'scroll',
          'top': '0' // reset to top of parent div in
        });
        $('.scrollable-content').css({
          'margin-bottom': 0
        });
      };

      $('.scrollable-content')[0].scrollTop = $('.comment-input')[0].offsetTop;
    }).resize();
    // ADD RESPONSE TO UPDATING STATUS
    $('.request-middle-column')[0].scrollTop = $('.comment-input')[0].offsetTop;

    // resize after closing alert box
    $('#sitewide-alert').on('closed.bs.alert', function() {
      // resizeAfterAlert();
    });

  });

  // ADD FORM INPUT ANIMATION
  $('.input-hr').show(function() {
    // find sibling input div above and add/remove class to alter 'underline'
  	$($(this)[0].previousElementSibling).focus(function(e) {
      	$($(this)[0].nextElementSibling).addClass('input-hr-focus');
      }).focusout(function(e) {
      	$($(this)[0].nextElementSibling).removeClass('input-hr-focus');
      });
  });

  // INCLUDE SECONDARY SUPPORT TO PROCESSED JS COMMENT INPUT
  $("#request_comment").on('ajax:success', function(data) {
    if ($('.empty-comments').length) {
      comments.find('.empty-comments').remove();
    };
    $('#comment_content').val('');
    $('.scrollable-content')[0].scrollTop = $('.request-middle-column')[0].scrollTop = $('.comment-input')[0].offsetTop;
  }).on('ajax:error', function(data) {
    alert("comment did not post");
  });

  // REMOVE COMMENT
  $('a[data-comment-id]').on('ajax:success', function(data) {
    // console.log('removing comment #' + commentId);
  }).on('ajax:error', function() {
    // console.log("error removing comment, please try again")
  });

  // UPDATE REQUEST STATUS TOGGLE
  $('div[id^="request_status_"] a').on('ajax:success', function(event) {
    var t = $(event.target);
    t.attr('data-status', status);
    // status variable is rendered by update_status.js upon successful patch
    if (status == 'active') {
        $(t.find('.toggle-holder')).removeClass('bg-success').addClass('bg-warning').find('.toggle-circle').removeClass('toggle-circle-on');
    } else {
      $(t.find('.toggle-holder')).removeClass('bg-warning').addClass('bg-success').find('.toggle-circle').addClass('toggle-circle-on');
    }
    t.find('span[title^="status"]').attr('title', "status: " + status)
    t.find('.request-label').text(status);
  }).on('ajax:error', function(event) {
    alert("error updating request status");
  });

});
