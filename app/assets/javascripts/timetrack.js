var Timetrack = function() {
    var timetrack = {};

    timetrack.init = function() {
      this.setStart();
      this.setEnd();
      this.updateSelectOptions();
      this.setDuration();
      this.setPause();
    }

    timetrack.update = function() {
      this.updateSelectOptions();
      this.setDuration();
      this.setPause();
    }

    timetrack.now = function() {
      var hr = new Date().getHours();
      var min = new Date().getMinutes();

      if (min == 60) {
        min = '00';
        hr +=1;
      } else {
        min = min.round5();
      }

      return [hr,min];
    }

    timetrack.start = function() {
      var time = this.now()
      return [time[0].toTime(), time[1].toTime()]
    };

    timetrack.end = function() {
      var start_hr = $('#timetrack_start_4i').val();
      var start_min = $('#timetrack_start_5i').val();

      var hr_max = $('#timetrack_finish_4i').find('option').last().val();
      var min_max = $('#timetrack_finish_5i').find('option').last().val();

      hr = parseInt(start_hr) + 8;
      min = parseInt(start_min) + 30;

      if(hr >= hr_max) {
        hr = hr_max.toInt();
        min = min_max.toInt();
      }

      if (min >= 60) {
        min = min%60;
        hr +=1;
      }

      min = min.round5();

      return [hr.toTime(), min.toTime()];
    };

    // § 4 ArbZG. (http://www.gesetze-im-internet.de/arbzg/__4.html)
    timetrack.pause = function() {
      difference = this.difference()

      // < 6 hours => 0 minutes
      if(difference < 6) {
        return 0;
      // 6 - 9 hours => 30 minutes
      } else if(difference > 6 && difference < 9) {
        return 30;
      // > 9 hours => 45 minutes
      } else if(difference >= 9) {
        return 45;
      } else {
        console.error("Cann't calculate pause")
        return 0;
      }
    };

    // Time difference without pause
    timetrack.difference = function() {
      var end_hr = $('#timetrack_finish_4i').val().toInt()
      var end_min = $('#timetrack_finish_5i').val().toInt()
      var end = (end_hr * 60) + end_min

      var start_hr = $('#timetrack_start_4i').val().toInt()
      var start_min = $('#timetrack_start_5i').val().toInt()
      var start = (start_hr * 60) + start_min

      var diff = (end - start) / 60;

      var hr = Math.round(diff)
      var min = Math.round((diff - Math.floor(diff)) * 60).toTime();

      return diff;
    };

    // Time difference with pause
    timetrack.balance = function() {
      return this.difference()
    }

    // Time difference in words
    timetrack.duration = function() {
      balance = this.balance()

      var hr = Math.floor(balance)
      var min = (balance - hr) * 60

      if(min >= 60) {
        hr += 1;
        min = min%60;
      } else {
        min = Math.round(min)
      }

      return hr + ' hr ' + min.toTime() + ' min'
    }


    // jQuery methods
    timetrack.updateSelectOptions = function() {
      var $start_hr = $('#timetrack_start_4i');
      var $start_min = $('#timetrack_start_5i');

      var $end_hr = $('#timetrack_finish_4i');
      var $end_min = $('#timetrack_finish_5i');

      var end = this.end();

      $end_hr.find('option').each(function() {
        var value = $(this).val().toInt();
        var start = $start_hr.val().toInt();

        // console.log(value)
        // console.log(start)

        if(value < start) {
          $(this).prop('disabled', true);
        } else {
          $(this).prop('disabled', false);
        }
      });

      if($start_hr.val().toInt() == $end_hr.val().toInt()) {
        $end_min.find('option').each(function() {
          var value = $(this).val().toInt();
          var start = $start_min.val().toInt();

          if(value < start) {
            $(this).prop('disabled', true);
          } else {
            $(this).prop('disabled', false);
          }
        });
      } else {
        $end_min.find('option').each(function() {
            $(this).prop('disabled', false);
        });
      }
    }

    timetrack.setStart = function() {
      var start = this.start();

      $('#timetrack_start_4i').val(start[0])
      $('#timetrack_start_5i').val(start[1])
    }

    timetrack.setEnd = function() {
      var end = this.end();

      $('#timetrack_finish_4i').val(end[0])
      $('#timetrack_finish_5i').val(end[1])
    }

    timetrack.setDuration = function() {
      $('duration').text(this.duration())
    }

    timetrack.setPause = function() {
      $('pause').text(this.pause())
    }

    return timetrack;
};

