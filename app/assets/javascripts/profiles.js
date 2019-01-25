// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$( document ).on('turbolinks:load', function() {

  var reloadListeneronRequest = function() {
    $('div[id^="request_block"]').on('click','div[id^="request_header"] > span',function(e) {
      $(e.target).parent().next().find('a[href^="#toggle_"]').click();
    });
  };

  reloadListeneronRequest();

  // Utilize session storage for profile#show tab selection persistence

  $('a[data-toggle="tab"]').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  }).on("shown.bs.tab", function (e) {
    var id = $(e.target)[0].dataset.target;
    sessionStorage.setItem('selectedTab', id);
    // console.log(sessionStorage);
  });


  var selectedTab = sessionStorage.getItem('selectedTab');
  if (selectedTab != null) {
    $('a[data-toggle="tab"][data-target="' + selectedTab + '"]').tab('show');
  };


});
