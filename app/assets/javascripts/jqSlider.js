(function($){
  $.fn.jqSlider = function(options){
    var $this = $(this);
    var defaults = {
      'link' : 'cs_link',
      'back' : 'cs_back',
      'container' : 'cs_container',
      'page' : 'cs_page',
      'delay' : 100,
      'speed' : 200
    }

    var opts = $.extend(defaults, options);

    return this.each(function(){
      $this.css({'overflow': 'hidden'});

      var $pages = $this.find('.' + opts.page);
      var $container = $this.find('.' + opts.container);

      var width = $pages.first().width();
      var number = $pages.length;

      $container.width(number * width)
      $pages.each(function() { $(this).css({'float':'left', 'width':(100/number)+'%'})})

      var $links = $this.find('a.' + opts.link);
      var $back_links = $this.find('a.' + opts.back);

      $links.each(function() {
        if($(this).data("remote") === true) {
//          $(this).bind("ajax:beforeSend", function(et, e) {
//          do something
//          })

          $(this).bind("ajax:complete", function(object, xhr) {
            if($(this).data("target") === undefined) {
              $pages.last().html(xhr.responseText);
              // FIXME set location hash
//              window.location.hash = location.pathname.substr(2, .length);
              forward(true);
            } else {
              $('.' + $(this).data("target")).html(xhr.responseText);
              forward(true);
            }
          })
        } else {

          $(this).live("click", function(e) {
            e.preventDefault();
            forward(true);
          });
        }
      })

      $back_links.live('click', function(e) {
        if(location.hash.length > 0) {
          console.log(window.location.search)
          console.log(window.location.pathname)
          history.pushState("", document.title, window.location.pathname + window.location.search);
        }
        e.preventDefault();
        backward(true);
      })

      forward = function(animation) {
        if(animation) {
          $container.stop().delay(opts.delay).animate({
              'margin-left': -width
          }, opts.speed);
        } else {
          $container.css('margin-left', -width);
        }
      }

      forward = function(animation) {
        if(animation) {
          $container.stop().delay(opts.delay).animate({
              'margin-left': -width
          }, opts.speed);
        } else {
          $container.css('margin-left', -width);
        }
      }

      backward = function(animation) {
        if(animation) {
          $container.stop().animate({
            'margin-left': 0
          }, opts.speed);
        } else {
          $container.css('margin-left', 0);
        }
      }

      redirect = function() {
        try {
          var hash = location.hash.substr(1, location.hash.length);
          if (hash.length > 0 && hash.match(/[0-9]+/)) {
            $.ajax({
              url      : location.pathname + '/' + hash,
              type     : 'GET',
              dataType : 'script'
            }).complete(function(xhr) {
              $pages.last().html(xhr.responseText);
              forward(false);
            });
          }
        } catch(err) { }
      }

      redirect();

    });
  };
})(jQuery);


//(function ($) {

//    jqSliderClass = function (el, opts) {

//      var config = {
//        'ajax' : false,
//        'link' : 'cs_link',
//        'back' : 'cs_back_link',
//        'container' : 'cs_pages',
//        'page' : 'cs_page',
//        'width' : '1170'
//      }
//      $.extend(config, jqSliderClass, opts)

//      var $base = $(el);

//      this.init = function() {
//        $base.css({'overflow': 'hidden'});
//        this.pages = $base.find('.' + config.page);
//        this.pages.each(function() {
//          $(this).css({'background':'#ccc', 'float':'left', 'width' : config.width})
//        })

//        console.log(config.container)
//        console.log(this.pages.length * config.width)
//        this.container = $base.find('.' + config.container);
//        this.container.width(this.pages.length;);

//        this.redirect(this);
//        this.bind(this);

//        return true;
//      },

//      this.show = function(object, location) {
//        if(location == 'first') {
//          this.container.stop().animate({
//            'margin-left': 0
//          }, 200);
//        } else {
//          this.container.stop().animate({
//            'margin-left': (-object.width)
//          }, 200);
//        }
//      },

//      this.redirect = function(object) {
//        try {
//            var hash = location.hash.substr(1, location.hash.length);
//              console.log(object.pages[1])
//            if (hash.match(/[0-9]+/) && location.pathname == '/playgrounds' && hash.length > 0) {
//              $.ajax({
//                url      : location.pathname + '/' + hash,
//                type     : 'GET',
//                dataType : 'script'
//              }).complete(function(xhr) {
//                $(object.pages[1]).html(xhr.responseText);
//                object.show(object, "#details");
//              });
//            }
//          } catch(err) {  }


//      },

//      this.bind = function(object) {
//        $base.find('a.' + config.link).on('click', function(e) {
//          object.show(object, 'some');
//        })

//        $base.find('a.' + config.back).on('click', function(e) {
//          object.show(object, 'first');
//        })
//      }
//    };

//    $.fn.jqSlider = function (options) {
//      var opts = $.extend({}, $.fn.jqSlider.defaults, options);

//      return this.each(function () {
//        var instance = new jqSliderClass($(this), opts);
//        instance.init();
//      });
//    }

//    $.fn.jqSlider.defaults = {
//        animationSpeed: 200
//    };


//})(jQuery);
