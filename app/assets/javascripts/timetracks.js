$(document).ready(function() {
  $('a.date-select').live('click', function(e) {
    e.preventDefault();
    $(this).popover('hide')
    var ajax = $.get("timetracks.js", "date="+$(this).data("date"), function() {})
    ajax.complete(function() {  $("#timetrack").html(ajax.responseText); });
  })

  $('#timetrack-form button.now').live('click', function(e) {
    e.preventDefault();
    var $input = $(this).parent().find('input[type=text]');
    var time = new Date();
    $input.val(time.getHours() + ':' + time.getMinutes())
  })

  $('#timetrack-form button.destroy').live('click', function(e) {
    e.preventDefault();
    $.ajax({
      url: "/timetracks/" + $(this).data("id"),
      type: "DELETE",
    }).done(function(xhr) {
       console.log(xhr)
       window.location.href = "/";
    });

    return false;
  })

  $('#calendar a.date-select').live('hover', function() {
    $('#calendar a.date-select').popover({
      trigger : 'hover',
      delay: 250,
      placement : 'bottom'
    })
  })

})
