////http://stackoverflow.com/questions/4269270/rails-3-setting-the-timezone-to-the-current-users-timezone

$(document).ready(function() {
  set_time_zone_offset()
})

function set_time_zone_offset() {
  var current_time = new Date();
  $.cookie('time_zone', current_time.getTimezoneOffset()*60);
}
