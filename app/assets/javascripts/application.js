// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require cocoon
//= require_tree .

$( document ).on('turbolinks:load', function() {


// timeout FUNCTION, set utilize
  $('#timeout-clock').show( function() {
    window.sessionStorage.setItem('timeout',parseInt(document.getElementById('timeout-clock').innerHTML));

    function timedown() {

      if (window.sessionStorage.getItem('timeout_ID')) {
        clearTimeout(window.sessionStorage.getItem('timeout_ID'));
      };

      var timeout_clock = document.getElementById('timeout-clock');

      if (timeout_clock) {
        time = sessionStorage.getItem('timeout');

        if (time > 0) {
          window.sessionStorage.setItem('timeout', time - 1);
          timeout_clock.innerHTML = (time - 1) + " sec";

            // console.log(timeOutID);
            var timeOutID = setTimeout(timedown, 1000);
            window.sessionStorage.setItem('timeout_ID',timeOutID);

        } else {
          // redirect to self and trigger server side Devise session timeout check
          console.log("logging off due to inactivity");
          window.location = window.location.href;
        };

      };
    };

    timedown();
  });

  // Navigation mobile-menu toggle
  $('#navToggle').on('click', function() {
    $('#overlay').fadeToggle('fast',function() {
    });
  });

  $('#overlay').on('click', function() {
    $('#navToggle').click();
  });

  // ENABLE TOOLTIP
  $('[data-toggle="tooltip"]').tooltip({
  });

  // ANIMATE INPUTS ON FOCUS
  $('.input-hr').show(function() {
    // find sibling input div above and add/remove class to alter 'underline'
  	$($(this)[0].previousElementSibling).focus(function(e) {
      	$($(this)[0].nextElementSibling).addClass('input-hr-focus');
      }).focusout(function(e) {
      	$($(this)[0].nextElementSibling).removeClass('input-hr-focus');
      });
  });

});
