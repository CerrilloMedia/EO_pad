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
      console.log(e);
      var requestID = e.currentTarget.id.match(/\d+/g)[0];
      var requestTargetBody = 'a[href="#request_body_' + requestID + '"]';
    	$(requestTargetBody).click();
    });

    // Utilize session storage for profile#show tab selection persistence

      $('a[data-toggle="tab"]').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
      });

      $('a[data-toggle="tab"]').on("shown.bs.tab", function (e) {
        var id = $(e.target)[0].dataset.target;
        sessionStorage.setItem('selectedTab', id)
      });

      var selectedTab = sessionStorage.getItem('selectedTab');
      if (selectedTab != null) {
        $('a[data-toggle="tab"][data-target="' + selectedTab + '"]').tab('show');
      };


});
