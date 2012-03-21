// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
  
$(function () {
  $('#calendar-footer input.auto').on("click", function() {
    var time = new Date();
    var hh = time.getHours();
    var mm = (time.getMinutes()<10)? '0'+Math.round(time.getMinutes()/10)*10 : Math.round(time.getMinutes()/10)*10;
    mm = Math.round(mm/10)*10
    
    console.log(mm)
    if(mm == 0) { mm = '00'}
    if(mm>55) {
      mm = '00'
      hh = hh+1;
    } 
    
    if($(this).val() == "0:00" || $(this).val() == "00:00") {
      $(this).val(hh + ':' + mm);
    }
  })
  
  var months = ["January","February", "March","April", "May", "June", "July", "August", "September", "October", "November", "December" ]
  var $month_select = $('#timestamp_date_2i');
  
  $('#calendar-header').delegate("#prev_month", "click", function() {
    
    $option = $month_select.find(':selected');
    
    var value = parseInt($option.val());
    $option.removeAttr("selected");
    
    if(value > 1) {
      $('#timestamp_date_2i').val(value-1);
    } else {
      console.info("switch year " + value);
      value = 0;
      $('#timestamp_date_2i').val(value);
    }
    
    $('#currentMonth').html(months[value]);
  });
  
  
  $('#calendar-header').delegate("#next_month", "click", function() {
    
    $option = $month_select.find(':selected');
    
    var value = parseInt($option.val());
    $option.removeAttr("selected");
    
    if(value < 12) {
      $('#timestamp_date_2i').val(value+1);
    } else {
      console.info("switch year");
      value = 12;
      $('#timestamp_date_2i').val(value);
    }
    
    $('#currentMonth').html(months[value]);
  });
  
  $('#calendar-dates li.day a.new').on("click", function(e) {
    $("#calendar-dates li").removeClass("active")
    $(this).parents('li').addClass("active");
    $('#dayname span.d').html($(this).html());
    $('#timestamp_date_3i').val($(this).html());
    
    $.get("/timestamps/new", "date="+$(this).data("date"), function(form) {
      $("#calendar-footer").html(form)
    })
    
    return false;
    
  });
  
  $('#calendar li a').on('hover', function() {
    $('#calendar li.day a').popover({
      trigger : 'hover',
      delay: 100,
      placement : 'top'
    })
  })
  
  
  



  
  
});

  
