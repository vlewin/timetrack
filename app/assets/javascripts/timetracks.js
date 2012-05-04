$(document).ready(function() {
  $('a.clock').live('click', function(event) {
    event.preventDefault();
    console.log("Show form");

    var ajax = $.post("timetracks.js", function() {})

    ajax.complete(function() {  $("#timetrack").html(ajax.responseText); });
    return false;
  })

$('#i-want-html')
  .bind('ajax:success', function(evt, data, status, xhr){
    var $this = $(this);

    // Append response HTML (i.e. the comment partial or helper)
    $('#comments').append(xhr.responseText);

    // Clear out the form so it can be used again
    $this.find('input:text,textarea').val('');

    // Clear out the errors from previous attempts
    $this.find('.errors').empty();

  })

  .bind('ajax:error', function(evt, xhr, status, error){

    // Display the errors (i.e. an error partial or helper)
    $(this).find('.errors').html(xhr.responseText);

  });

  $('a.date-select').live('click', function(event) {
    event.preventDefault();
    console.log("Clicked");

    var ajax = $.get("timetracks.js", "date="+$(this).data("date"), function() {})
    
    ajax.complete(function() {  $("#timetrack").html(ajax.responseText); });
    return false;
  })
})
