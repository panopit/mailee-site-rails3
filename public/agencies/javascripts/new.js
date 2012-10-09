$.fn.typeWatch = function(c,w){
	// Options
	var options = {
		wait : w||1000,
		callback : c,
		highlight : true,
		captureLength : -1
	};

	function checkElement(timer, override) {
		var elTxt = jQuery(timer.el).val();
	
		// Fire if text > options.captureLength AND text != saved txt OR if override AND text > options.captureLength
		if ((elTxt.length > options.captureLength && elTxt.toUpperCase() != timer.text) 
		|| (override && elTxt.length > options.captureLength)) {
			timer.text = elTxt.toUpperCase();
			timer.cb(elTxt);
		}
	};
	
	function watchElement(elem) {			
		// Must be text or textarea
		if (elem.type.toUpperCase() == "TEXT" || elem.nodeName.toUpperCase() == "TEXTAREA") {

			// Allocate timer element
			var timer = {
				timer : null, 
				text : jQuery(elem).val().toUpperCase(),
				cb : options.callback, 
				el : elem, 
				wait : options.wait
			};

			// Set focus action (highlight)
			if (options.highlight) {
				jQuery(elem).focus(
					function() {
						this.select();
					});
			}

			// Key watcher / clear and reset the timer
			var startWatch = function(evt) {
				var timerWait = timer.wait;
				var overrideBool = false;
				
				if (evt.keyCode == 13 && this.type.toUpperCase() == "TEXT") {
					timerWait = 1;
					overrideBool = true;
				}
				
				var timerCallbackFx = function()
				{
					checkElement(timer, overrideBool)
				}
				
				// Clear timer					
				clearTimeout(timer.timer);
				timer.timer = setTimeout(timerCallbackFx, timerWait);				
									
			};
			
			jQuery(elem).keydown(startWatch);
      jQuery(elem).change(function(){ clearTimeout(timer.timer); });
		}
	};
	
	// Watch Each Element
	return this.each(function(index){
		watchElement(this);
	});
	
};






/*
$.fn.ok = function(){
  var icons = $(this).nextAll('.icons')
  icons.find('.ok_icon').fadeIn('fast')
  icons.find('.error_icon').hide()
  $(this).nextAll('.error_description').hide()
}

$.fn.error = function(msg){
  var icons = $(this).nextAll('.icons')
  icons.find('.error_icon').fadeIn('fast')
  icons.find('.ok_icon').hide()
  if(msg) $(this).nextAll('.error_description').html(msg).show()
}
*/

subdomain_ok = false
subdomain_changed = false
email_re = /^[a-z0-9._-]+@([a-z0-9][a-z0-9-_]*[a-z0-9-_].)+([a-z-_]+.)?([a-z-_]+)$/i

user_email  = $('#user_email')
password    = $('#user_password')
subdomain   = $('#client_subdomain')
b           = $('#send')
accept      = $('#accept')

check_all = function(){
  if( user_email_ok() && subdomain_ok && password_ok() && terms_ok() )
    b.removeClass('disabled').removeAttr('disabled')
  else
    b.addClass('disabled').attr('disabled', true)
}

password.pstrength()
on =  function() {
  $('#password_text_field').addClass('notice_field')
}
off = function() {
  $('#password_text_field').removeClass('notice_field')
}
password.caps(on,off);

//from_email_val = function(){ message_from_email.val( message_from_email.val().replace(/\s+/g,'') ); return message_from_email.val().toLowerCase() }
user_email_val = function(){ return user_email.val().replace(/\s+/g,'').toLowerCase() }
user_email_ok = function(){ return user_email_val().match(email_re) }
password_ok = function(){ return password.val().length > 5 }

accept.click(check_all)
terms_ok = function(){ return accept.is(':checked') }

invalid_domains = ['bol','terra','uol','mac','gmail','yahoo','ymail','locaweb','globo','aol']

user_email.keyup(function(){
  if( $('#email_text_field').hasClass('error_field') ){
    if(user_email_ok()){
      $('#email_messages .success_message').show()
      $('#email_messages .error_message').hide()
      $('#email_text_field').addClass('success_field').removeClass('error_field')
    }else{
      $('#email_text_field').addClass('error_field').removeClass('success_field')
      $('#email_messages .error_message').show()
      $('#email_messages .success_message').hide()
    }
    check_all()
  }
})

user_email.change(function(){
  if(user_email_ok()){
    $('#email_messages .success_message').show()
    $('#email_messages .error_message').hide()
    $('#email_text_field').addClass('success_field').removeClass('error_field')

    //Weird ie bug fix.
    if(!subdomain_changed && ! $.browser.msie){
      var domain = user_email_val().split(/@/).pop().split(/\./).shift()
      if( invalid_domains.indexOf(domain) == -1 ){
        subdomain.val( domain )
        check_subdomain()
      }
    }
  }else{
    $('#email_text_field').addClass('error_field').removeClass('success_field')
    $('#email_messages .error_message').show()
    $('#email_messages .success_message').hide()
    //user_email.error('E-mail inválido')
  }
  check_all()
})

password.keyup(function(){
  if( $('#password_text_field').hasClass('error_field') ){
    if(password_ok()){
      $('#password_messages .success_message').show()
      $('#password_messages .error_message').hide()
      $('#password_text_field').addClass('success_field').removeClass('error_field')
    }else{
      $('#password_text_field').addClass('error_field').removeClass('success_field')
      $('#password_messages .error_message').show()
      $('#password_messages .success_message').hide()
    }
    check_all()
  }
})

password.change(function(){
  if(password_ok()){
    $('#password_messages .success_message').show()
    $('#password_messages .error_message').hide()
    $('#password_text_field').addClass('success_field').removeClass('error_field')
  }else{
    $('#password_text_field').addClass('error_field').removeClass('success_field')
    $('#password_messages .error_message').show()
    $('#password_messages .success_message').hide()
  }
  check_all()
})

check_subdomain = function(){
  subdomain_ok = false
  check_all()
  $('#subdomain_messages .loading').show()
  $('#subdomain_messages .success_message').hide()
  $('#subdomain_messages .error_message').hide()
  
  subdomain_changed = true
  $.ajax({url:'http://mailee.me/signup/check_subdomain', data:{subdomain:subdomain.val()},type:'get', dataType:'json', success:
    function(r){
      $('#subdomain_messages .loading').hide()
      if(r.ok){
        subdomain_ok = true
        $('#subdomain_text_field').addClass('success_field').removeClass('error_field')
        $('#subdomain_messages .success_message').show()
        $('#subdomain_messages .error_message').hide()

      }else{
        $('#subdomain_text_field').addClass('error_field').removeClass('success_field')
        $('#subdomain_messages .error_message').show()
        $('#subdomain_messages .success_message').hide()
        subdomain_ok = false
      }
      check_all()
    }
  })
}
subdomain.change( check_subdomain ).typeWatch( check_subdomain );


$('#signup-form').delegate('#show_password', 'click', function() {
  $("<input>").attr({id: password.attr("id"), type: "text", name: password.attr("name")}).val(password.val()).addClass(password.attr("class")).insertAfter(password);
  password.remove();
  password = $('#user_password')
  $(this).hide()
  $('#hide_password').show()
  return false;
});

$('#signup-form').delegate("#hide_password",'click', function() {
  $("<input>").attr({id: password.attr("id"), type: "password", name: password.attr("name")}).val(password.val()).addClass(password.attr("class")).insertAfter(password);
  password.remove();
  password = $('#user_password')
  $(this).hide()
  $('#show_password').show()
  return false;
});

/// FROM SHARED/FORM
$('input, textarea').focus(function(){
  $('.text_field').removeClass('focused_field')
  $(this).parents('.text_field').addClass('focused_field')
})

$('.text_field').click(function(e){
  if(e.target.tagName == 'INPUT' || e.target.tagName == 'TEXTAREA'){
    $('.text_field').removeClass('focused_field')
    $(this).addClass('focused_field')
  }else $(this).find('input:first, textarea:first').focus()
})

$.fn.ok = function(){
  var icons = $(this).nextAll('.icons')
  icons.find('.ok_icon').fadeIn('fast')
  icons.find('.error_icon').hide()
  $(this).nextAll('.error_description').hide()
}

$.fn.error = function(msg){
  var icons = $(this).nextAll('.icons')
  icons.find('.error_icon').fadeIn('fast')
  icons.find('.ok_icon').hide()
  if(msg) $(this).nextAll('.error_description').html(msg).show()
}

$(function(){

  // user_email.focus()

  $('form').submit(function(){
    // Weird chrome bug fix...
    if( b.attr('disabled') ) return false
    $(this).find('img#load_submit').show()
    $(this).find('input[type=submit]').addClass('disabled').attr('disabled', true)
    $(this).find('#cancel_link').hide()
  })

  plans = $('.plans_slider_dots')
  panels = $('.price_panel')

  plans.click(function(){
    curr = $('.plans_slider_dots.current')
    curr.removeClass('current')
    //$('.price_panel').eq( parseInt(curr.attr('rel')) ).fadeOut('fast')
    panels.eq( parseInt(curr.attr('rel')) ).fadeOut('fast') //.hide()

    nu = $(this)
    nu.addClass('current')
//alert( 'curr = ' + parseInt(curr.attr('rel')) + ' --  nu = ' + parseInt(nu.attr('rel')) )
    //$('.price_panel').eq( parseInt(nu.attr('rel')) ).fadeIn('fast')
    panels.eq( parseInt(nu.attr('rel')) ).fadeIn('fast') //.show()
    //$( panels[ parseInt(nu.attr('rel')) ] ).show()
  })

})

$("#accept").focus(function(){
  $("#accept_and_signup").addClass('focused_accept')
})
$("#accept").blur(function(){
  $("#accept_and_signup").removeClass('focused_accept')
})