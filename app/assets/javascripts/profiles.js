// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$( document ).on('turbolinks:load', function() {
    //
    // $('a[href^="#request_body_"]').on('click', function(e){
    //   e.preventDefault();
    //   console.log(e);
    //   $('[aria-expanded="true"]').each(function() {
    //     $(this).toggle();
    //   });
    // });

    $('div[id^="request_header"]').click(function(e) {
      var requestID = e.currentTarget.id.match(/\d+/g);
    	var requestTarget = 'a[href="#request_body_' + requestID + '"]';
    	$(requestTarget).click();
    });

    

});
