$(document).ready(function(){
	$('.main').click(function(e){
		e.stopPropagation();
		$('#main-nav').toggleClass('active');
	});

	('.main').click(function(){
		$('#main-nav').removeClass('active');
	});
});