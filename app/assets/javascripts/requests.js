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

  var reloadListeneronRequest = function() {
    $('div[id^="request_block"]').on('click','div[id^="request_header"] > span',function(e) {
      $(e.target).parent().next().find('a[href^="#toggle_"]').click();
    });
  };

  // UPDATE REQUEST STATUS TOGGLE
  var updateToggle = function() {

    var target = 'div[id^="request_status_"] a';

    $(target).on('ajax:success', function(event) {

      var t = $(event.target);
      t.attr('data-status', request.status);
      // render css to toggle and update status in view
      var toggleStatus = function() {
        if (request.status == 'active') {
          $(t.find('.toggle-holder')).removeClass('bg-success').addClass('bg-warning').find('.toggle-circle').removeClass('toggle-circle-on');
        } else {
          $(t.find('.toggle-holder')).removeClass('bg-warning').addClass('bg-success').find('.toggle-circle').addClass('toggle-circle-on');
        }
        t.find('span[title^="status"]').attr('title', "status: " + request.status)
        t.find('.request-label').text(request.status);
      };
      // fire once at load time
      toggleStatus();

      // update DOM for sidebar request content
      $("#requests-window").show(function(){

          toggleStatus();
          // fade out request & process the new DOM update
          $("#request_block_" + request.id).animate({'opacity': 0}, 400).slideUp('300',function() {

            // record # of siblings in view
            var siblings = $(this).siblings().length;

            var nodeParent = $(this).parent()[0].id;

            var tabReference = $('a[href="#'+ nodeParent + '"]');

            console.log(tabReference);

            // remove hidden node from DOM
            $(this).remove();

            // updated html post removal
            var newDomNodeHtml = $('#'+nodeParent).html();

            // update DOM
            $("#taskTab").html(request.sidebar);

            // render new partial and update with new DOM data
            $('#requests-window').html(request.requests);

            if (siblings) {
              $('#requests-window').html(request.requests).find('#'+nodeParent).html(newDomNodeHtml);
            }

            reloadListeneronRequest();

            // set current tab view into sessionStorage
            $('a[data-toggle="tab"]').on("shown.bs.tab", function (e) {
              var id = $(e.target)[0].dataset.target;
              sessionStorage.setItem('selectedTab', id);
              sessionStorage.setItem('selectedTab', id);
            });

            // reload currently opened active tab from sessionStorage
            var selectedTab = sessionStorage.getItem('selectedTab');
            if (selectedTab != null) {
              if (siblings == 0) {
                $('a[data-toggle="tab"][data-target="' + selectedTab + '"]').tab('show');;
              } else {
                $('a[data-toggle="tab"][data-target="' + selectedTab + '"]').addClass("active show");;
                $(selectedTab).addClass("active show");
              }
            };
            updateToggle();
          });
      });

    }).on('ajax:error', function(event) {
      alert("error updating request status");
    });
  };

  updateToggle();

});
