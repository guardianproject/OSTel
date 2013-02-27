
$(document).ready(function() {
	
	$('.close span, .button1 span, .tabs .nav li a span, .lightbox-image span ').css({opacity:'0'})
	$('.tabs .nav .selected a span').css({opacity:'1'})
	
	$('.close, .button1').hover(function(){
		$(this).find('span').stop().animate({opacity:'1'})							
	}, function(){
		$(this).find('span').stop().animate({opacity:'0'})							
	})
	
	$('.lightbox-image').hover(function(){
		$(this).find('span').stop().animate({opacity:'0.4'})							
	}, function(){
		$(this).find('span').stop().animate({opacity:'0'})							
	})
	
	$('.tabs .nav li a').hover(function(){
		$(this).find('span').stop().animate({opacity:'1'})							
	}, function(){
		if (!$(this).parent().hasClass('selected')) {
			$(this).find('span').stop().animate({opacity:'0'})							
		}
	})
	
	//tabs
	tabs.init();
	
	// prettyPhoto
		$("a[data-type^='prettyPhoto']").prettyPhoto({theme:'light_square'});
	
	//bg animate
	$('#bgSlider').bgSlider({
		duration:1200,
		pagination:'.pagination',
		preload:true,
		spinner:'.bg_spinner'
	})
		
 });