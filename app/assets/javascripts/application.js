// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/alert
//= require twitter/bootstrap/tooltip
//= require twitter/bootstrap/popover
//= require_tree .

var timetrack = Timetrack();

// Live clock
function liveClock() {
  setInterval( function() {
    var hours = new Date().getHours();
    $("#hr").html(( hours < 10 ? "0" : "" ) + hours);
  }, 1000);

  setInterval( function() {
    var minutes = new Date().getMinutes();
    $("#min").html(( minutes < 10 ? "0" : "" ) + minutes);
  },1000);

  setInterval( function() {
    var seconds = new Date().getSeconds();
    $("#sec").html(( seconds < 10 ? "0" : "" ) + seconds);
  },1000);
}


$(document).ready(function() {
  liveClock();

  $('body').tooltip({
    selector: '[data-toggle="tooltip"]',
    placement: 'bottom',
    container: 'body'
  });

  // Timetrack
  $('body').on('click', 'a.date-select', function(e) {
    e.preventDefault();
    $(this).popover('hide')
    var ajax = $.get("timetracks.js", "date="+$(this).data("date"), function() {})
    ajax.complete(function() { $("#timetrack").html(ajax.responseText); });
  })

  $('body').on('click', '#timetrack-form button.destroy', function(e) {
    e.preventDefault();
    $.ajax({
      url: "/timetracks/" + $(this).data("id"),
      type: "DELETE",
    });

    return false;
  })

  if($('#form .new_record').text() == 'true') {
    timetrack.init();
  } else {
    timetrack.updateSelectOptions();
  }

  $('body').on('change', 'select.timetrack_start', function(e) {
    timetrack.setEnd();
    timetrack.update();
  })

  $('body').on('change', 'select.timetrack_finish', function(e) {
    timetrack.update();
  })
})
