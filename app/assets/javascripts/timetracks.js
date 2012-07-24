$(document).ready(function() {
  $('a.date-select').live('click', function(e) {
    e.preventDefault();
    $(this).popover('hide')
    var ajax = $.get("timetracks.js", "date="+$(this).data("date"), function() {})
    ajax.complete(function() {  $("#timetrack").html(ajax.responseText); });
  })

  $('#timetrack-form button.now').live('click', function(e) {
    e.preventDefault();
    var time = new Date();
    var hh = (time.getHours() < 10)? "0" + time.getHours() : time.getHours()
    var mm = (time.getMinutes() < 10)? "0" + time.getMinutes() : time.getMinutes()
    $(this).parent().find('input[type=text]').val(hh + ':' + mm)
  })

  $('#timetrack-form button.destroy').live('click', function(e) {
    e.preventDefault();
    $.ajax({
      url: "/timetracks/" + $(this).data("id"),
      type: "DELETE",
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
