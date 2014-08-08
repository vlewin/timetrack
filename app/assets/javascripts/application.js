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

$('body').tooltip({
  selector: '[data-toggle="tooltip"]',
  placement: 'bottom',
  container: 'body'
});

// Live clock
$(document).ready(function() {
  setInterval( function() {
    var seconds = new Date().getSeconds();
    $("#sec").html(( seconds < 10 ? "0" : "" ) + seconds);
  },1000);

  setInterval( function() {
    var minutes = new Date().getMinutes();
    $("#min").html(( minutes < 10 ? "0" : "" ) + minutes);
  },1000);

  setInterval( function() {
    var hours = new Date().getHours();
    $("#hour").html(( hours < 10 ? "0" : "" ) + hours);
  }, 1000);

  // Timetrack
  if($('#form .new_record').text() == 'true') {
    var now = timeNow();
    setStartTime(now[0], now[1]);
    setEndTime(now[0], now[1]);
    setDuration();
  }

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

  $('body').on('change', 'select', function(e) {
    setDuration()
  })

  function timeNow() {
    var hh = new Date().getHours();
    var mm = new Date().getMinutes();

    if (hh < 10) {
      hh = '0'+hh;
    }

    mm = ((mm)- (mm % 5));

    if (mm < 10) {
      mm = '0'+mm;
    }

    if (mm == 60) {
      mm = '00';
      hh +=1;
    }

    return [hh,mm];
  }

  function setStartTime(hh, mm) {
    console.log('setStartTime: ' + hh + ':' + mm)
    $('#timetrack_start_4i').val(hh)
    $('#timetrack_start_5i').val(mm)
  }

  function setEndTime(hh, mm) {
    hh = parseInt(hh) + 8;
    mm = parseInt(mm) + 30;

    if (mm >= 60) {
      mm = mm%60;
      hh +=1;
    }

    if (mm < 10) {
      mm = '0'+mm;
    }

    console.log('setEndTime: ' + hh + ':' + mm)

    $('#timetrack_finish_4i').val(hh)
    $('#timetrack_finish_5i').val(mm)
  }

  function setDuration() {
    var end_hh = $('#timetrack_finish_4i').val().toInt()
    var end_mm = $('#timetrack_finish_5i').val().toInt()
    var end = (end_hh * 60) + end_mm

    var start_hh = $('#timetrack_start_4i').val().toInt()
    var start_mm = $('#timetrack_start_5i').val().toInt()
    var start = (start_hh * 60) + start_mm

    var pause = 30;
    var diff = ((end - start) - pause) / 60;


    var hh = Math.floor(diff)
    var mm = Math.round((diff - Math.floor(diff)) * 60);

    if (mm < 10) {
      mm = '0'+mm;
    }

    var duration = hh + ' h ' + mm + ' min'

    $('duration').text(duration)
  }

})
