$(function () {
//  var months = ["January","February", "March","April", "May", "June", "July", "August", "September", "October", "November", "December" ]
//  var $month_select = $('#timestamp_date_2i');
//  
//  $('#calendar-header').delegate("#prev_month", "click", function() {
//    
//    $option = $month_select.find(':selected');
//    
//    var value = parseInt($option.val());
//    $option.removeAttr("selected");
//    
//    if(value > 1) {
//      $('#timestamp_date_2i').val(value-1);
//    } else {
//      console.info("switch year " + value);
//      value = 0;
//      $('#timestamp_date_2i').val(value);
//    }
//    
//    $('#currentMonth').html(months[value]);
//  });
//  
//  
//  $('#calendar-header').delegate("#next_month", "click", function() {
//    
//    $option = $month_select.find(':selected');
//    
//    var value = parseInt($option.val());
//    $option.removeAttr("selected");
//    
//    if(value < 12) {
//      $('#timestamp_date_2i').val(value+1);
//    } else {
//      console.info("switch year");
//      value = 12;
//      $('#timestamp_date_2i').val(value);
//    }
//    
//    $('#currentMonth').html(months[value]);
//  });
//  
//  $('#calendar-dates li.day').on("click", function() {
//    $("#calendar-dates li").removeClass("active")
//    $(this).addClass("active");
//    $('#dayname span.d').html($(this).html());
//    $('#timestamp_date_3i').val($(this).html());
//  });
//  
//  $('#calendar li a').on('hover', function() {
//    $('#calendar li.day a').popover({
//      trigger : 'hover',
//      delay: 100,
//      placement : 'top'
//    })
//  })
})
