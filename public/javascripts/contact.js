$('form#contact_us').submit(function(){

  if( ! $('#contact_us_name').val() ){
    $('#contact_us_name').focus()
    $('#contact_us_name_required').slideDown()
    return false
  }else{
    $('#contact_us_name_required').slideUp()
  }
  email_re = /^[a-z0-9\._-]+@([a-z0-9][a-z0-9-_]*[a-z0-9-_]\.)+([a-z-_]+\.)?([a-z-_]+)$/
  if( ! $('#contact_us_email').val() ){
    $('#contact_us_email').focus()
    $('#contact_us_email_required').slideDown()
    return false
  }else if( ! $('#contact_us_email').val().match(email_re) ){
    $('#contact_us_email').focus()
    $('#contact_us_email_required').slideUp()
    $('#contact_us_email_invalid').slideDown()
    return false
  }else{
    $('#contact_us_email_required').slideUp()
    $('#contact_us_email_invalid').slideUp()
  }

  if( ! $('#contact_us_message').val() ){
    $('#contact_us_message').focus()
    $('#contact_us_message_required').slideDown()
    return false
  }else{
    $('#contact_us_message_required').slideUp()
  }

  var data = $(this).serialize()
  $(this).find('input, textarea, button').attr('disabled', true)
  var url = $(this).attr('action')
  var bt = $('#contact_us button')
  bt.html(bt.attr('data-wait'))
  $.post(url, data, function(result){
    //$('#send_button').attr('disabled', true)
    $('#contact_us').find('input, textarea, button').attr('disabled', false)
    if(result['ok']){
      $('#contact_us').find('input, textarea').val('')
      $('#contact_us_content').fadeOut()
      $('#contact_us_success').fadeIn()
    }else{
      $('#contact_us_content').fadeOut()
      $('#contact_us_failure').fadeIn()
    }
  }, 'json')
  return false
})

$('.send_another').click(function(){
  var bt = $('#contact_us button')
  bt.html(bt.attr('data-send'))
  $('#contact_us_success').hide()
  $('#contact_us_failure').hide()
  $('#contact_us_content').fadeIn()
  $('#contact_us_name').focus()
  return false
})