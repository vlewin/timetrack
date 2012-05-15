$(document).ready(function() {
  $('a.date-select').live('click', function(event) {
    event.preventDefault();
    var ajax = $.get("timetracks.js", "date="+$(this).data("date"), function() {})
    ajax.complete(function() {  $("#timetrack").html(ajax.responseText); });
    return false;
  })

  $('#timetrack-form button.now').live('click', function(event) {
    event.preventDefault();
    var $input = $(this).parent().find('input[type=text]');
    var time = new Date();
    $input.val(time.getHours() + ':' + time.getMinutes())
  })

  $('#calendar a.date-select').on('hover', function() {
    $('#calendar a.date-select').popover({
      trigger : 'hover',
      delay: 100,
      placement : 'top'
    })
  })

})
