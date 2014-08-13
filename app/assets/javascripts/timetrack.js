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
      var hh = new Date().getHours();
      var mm = new Date().getMinutes();

      if (mm == 60) {
        mm = '00';
        hh +=1;
      } else {
        mm = mm.round5();
      }

      return [hh,mm];
    }

    timetrack.start = function() {
      var time = this.now()
      return [time[0].toTime(), time[1].toTime()]
    };

    timetrack.end = function() {
      var start_hh = $('#timetrack_start_4i').val();
      var start_mm = $('#timetrack_start_5i').val();

      var hh_max = $('#timetrack_finish_4i').find('option').last().val();
      var mm_max = $('#timetrack_finish_5i').find('option').last().val();

      hh = parseInt(start_hh) + 8;
      mm = parseInt(start_mm) + 30;

      if(hh >= hh_max) {
        hh = hh_max.toInt();
        mm = mm_max.toInt();
      }

      if (mm >= 60) {
        mm = mm%60;
        hh +=1;
      }

      mm = mm.round5();

      return [hh.toTime(), mm.toTime()];
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
      var end_hh = $('#timetrack_finish_4i').val().toInt()
      var end_mm = $('#timetrack_finish_5i').val().toInt()
      var end = (end_hh * 60) + end_mm

      var start_hh = $('#timetrack_start_4i').val().toInt()
      var start_mm = $('#timetrack_start_5i').val().toInt()
      var start = (start_hh * 60) + start_mm

      var diff = (end - start) / 60;

      var hh = Math.round(diff)
      var mm = Math.round((diff - Math.floor(diff)) * 60).toTime();

      return diff;
    };

    // Time difference with pause
    timetrack.balance = function() {
      return this.difference()
      // return (this.difference() - this.pause()/60)
    }

    // Time difference in words
    timetrack.duration = function() {
      balance = this.balance()

      var hh = Math.floor(balance)
      var mm = (balance - hh) * 60

      if(mm >= 60) {
        hh += 1;
        mm = mm%60;
      } else {
        mm = Math.round(mm)
      }

      return hh + ' h ' + mm.toTime() + ' min'
    }


    // jQuery methods
    timetrack.updateSelectOptions = function() {
      var $start_hh = $('#timetrack_start_4i');
      var $start_mm = $('#timetrack_start_5i');

      var $end_hh = $('#timetrack_finish_4i');
      var $end_mm = $('#timetrack_finish_5i');

      var end = this.end();

      $end_hh.find('option').each(function() {
        var value = $(this).val().toInt();
        var start = $start_hh.val().toInt();

        if(value < start) {
          $(this).prop('disabled', true);
        } else {
          $(this).prop('disabled', false);
        }
      });

      if($start_hh.val().toInt() == $end_hh.val().toInt()) {
        $end_mm.find('option').each(function() {
          var value = $(this).val().toInt();
          var start = $start_mm.val().toInt();

          if(value < start) {
            $(this).prop('disabled', true);
          } else {
            $(this).prop('disabled', false);
          }
        });
      } else {
        $end_mm.find('option').each(function() {
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

