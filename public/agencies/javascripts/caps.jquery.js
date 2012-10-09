(function($) {
	
	$.fn.caps = function(on,off) {
		
		if (on)  $.extend($.fn.caps.defaults, {on:on});
		if (off) $.extend($.fn.caps.defaults, {off:off});
		

		$(this).bind("on", $.fn.caps.defaults.on);
		$(this).bind("off", $.fn.caps.defaults.off);

		return $(this).keypress(function(e){ check(e); });
	};

	
	// The actual check:
	function check(e)
	{

		var ascii	= e.which;
		var shift_key	= e.shiftKey;
    var target = $('#'+e.target.id)
		if( (65 <= ascii) && (ascii <= 90) && !shift_key)
      $.fn.caps.defaults.on( target )
		else if( ascii != 8 )
      $.fn.caps.defaults.off( target )

		
	}
	
	// Public definition of defaults for easy overriding:
	$.fn.caps.defaults = {
		on:	  function() {},
		off:  function() {}
	};
	
})(jQuery);