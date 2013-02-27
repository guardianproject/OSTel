var fl;
$(document).ready(function() {

	var w_img=2800, h_img=1700;
	var w,new_w,h, new_h, num;
	var h_cont=1000, h_cont_new=1000;
	setWidth();
	setHeight();
	w=new_w;h=new_h;
	setSize();
	function setWidth(){
		new_w=$(window).width();
	}
	function setHeight(){
		new_h=$(window).height();
	}
	function setSize(){
		if ((w/w_img) > (h/h_img)) {
			w_img_new=w+20;
			h_img_new=~~((w+20)*h_img/w_img);
		} else {
			h_img_new=h+20;	
			w_img_new=~~((h+20)*w_img/h_img);
		}
		$('#bgSlider img').css({width:w_img_new, height:h_img_new});
		if (h>h_cont) {
			m_top=~~((h-h_cont)/2);
		} else m_top=0
		$('.box').stop().animate({paddingTop:m_top+20},1000, 'easeOutCirc');
		h_cont_new=h_cont
	}
	setInterval(setNew,1);
	function setNew(){
		setWidth();
		setHeight();
		if (fl) {h_cont=800;} else {h_cont=1000;}
		if ((w!=new_w)||(h!=new_h)||(h_cont_new!=h_cont)) {
			w=new_w;h=new_h;
			setSize();
		}
	}
})