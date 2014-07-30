$(document).ready(function() {
  $('body').tooltip({
    selector: '[data-toggle="tooltip"]',
    placement: 'bottom',
    container: 'body'
  });

  $('body').on('click', 'a.date-select', function(e) {
    e.preventDefault();
    $(this).popover('hide')
    var ajax = $.get("timetracks.js", "date="+$(this).data("date"), function() {})
    ajax.complete(function() {  $("#timetrack").html(ajax.responseText); });
  })

  $('body').on('click', '#timetrack-form button.now', function(e) {
    e.preventDefault();
    var time = new Date();
    var hh = (time.getHours() < 10)? "0" + time.getHours() : time.getHours()
    var mm = (time.getMinutes() < 10)? "0" + time.getMinutes() : time.getMinutes()
    $(this).parent().find('input[type=text]').val(hh + ':' + mm)
  })

  $('body').on('click', '#timetrack-form button.destroy', function(e) {
    e.preventDefault();
    $.ajax({
      url: "/timetracks/" + $(this).data("id"),
      type: "DELETE",
    });

    return false;
  })

  $('body').on('mouseenter', 'a.date-select', function() {
    $('#calendar a.date-select').popover({
      trigger : 'hover',
      delay: 250,
      placement : 'bottom'
    })
  })
})
