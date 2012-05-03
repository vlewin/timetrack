$(document).ready(function() {
  $('a.date-select').live('click', function(event) {
    event.preventDefault();
    console.log("Clicked");

    var ajax = $.get("timetracks.js", "date="+$(this).html(), function() {})
    
    ajax.complete(function() {  $("#timetrack").html(ajax.responseText); });
    return false;
  })
})
