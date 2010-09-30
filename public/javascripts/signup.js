$(document).ready(function(){

	referrer = $.cookie('referrer')
	if(referrer) {
		mailee_signup_path = mailee_signup_path + '/?referrer=' + referrer
	}	
	
	$('<iframe width="100%" height="180px" scrolling="no" frameborder=0 style="background-color: transparent;" allowtransparency="true" />').src(mailee_signup_path).appendTo(".signup_wrapper");

})
