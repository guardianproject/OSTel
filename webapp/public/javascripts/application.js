// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Modal window
// Copyright Jack Moore <jack@colorpowered.com>
// http://www.jacklmoore.com/notes/jquery-modal-tutorial

var modal = (function(){
	var
	method = {},
	$overlay,
	$modal,
	$content,
	$close;
	method.center = function () {
		var top, left;

		// center the window
		top = Math.max($(window).height() - $modal.outerHeight(), 0) / 2;
		left = Math.max($(window).width() - $modal.outerWidth(), 0) / 2;

		// account for scrolling
		$modal.css({
			top:top + $(window).scrollTop(),
			left:left + $(window).scrollLeft()
		});
	};
	
	// takes a settings object with content, width and height
	method.open = function (settings) {
		$content.empty().append(settings.content);
		
		$modal.css({
			width: settings.width || 'auto',
			height: settings.height || 'auto'
		})

		method.center();

		// bind the center method to the event with a key 'resize.modal'
		$(window).bind('resize.modal', method.center);
		$(window).bind('scroll.modal', method.center);

		$modal.show();
		$overlay.show();
	};

	method.close = function () {
		$modal.hide();
		$overlay.hide();
		$content.empty();
		// unbind the event key
		$(window).unbind('resize.modal');
		$(window).unbind('scroll.modal');
	};

	// define some strings to append to the DOM at runtime
	$overlay = $('<div id="overlay"><div/>');
	$modal = $('<div id="modal"><div/>');
	$content = $('<div id="content"><div/>');
	$close = $('<a href="#" id="close">close<a/>');

	$modal.hide();
	$overlay.hide();
	$modal.append($content, $close);

	// when the document is ready, call a function that appends the overlay and modal HTML as a child of the <body> element.
	$(document).ready(function(){
		$('body').append($overlay, $modal);
	});
	// override the default click method for the a tag
	$close.click(function(e){
		e.preventDefault();
		method.close();
	});

	return method;

}());

// add the text value of the selected suggestion radio button to the
// sip_username text field
$(function() {
  var $radButton = $("form#user_new input:radio");
  $radButton.click(function() {
    var $radChecked = $(':radio:checked');
    $("#sip_username").val($radChecked.next().text());
  });
});
