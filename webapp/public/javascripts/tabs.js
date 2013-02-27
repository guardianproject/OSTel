/* ------------------------------------------------------------------------
	Do it when you're ready dawg!
------------------------------------------------------------------------- */

	

	tabs = {
  init : function(){
   $('.tabs').each(function(){

    var th=$(this),
     tContent=$('.tab-content',th),
     navA=$('.nav a',th)

    tContent.not(tContent.eq(0)).hide()

    navA.click(function(){
     	var th=$(this),
      	tmp=th.attr('href')
     	tContent.not($(tmp.slice(tmp.indexOf('#'))).fadeIn(1000)).hide()
	 	$(th).parent().addClass('selected').siblings().removeClass('selected').find('span').stop().animate({opacity:'0'},600);
	 	Cufon.refresh();
    	return false;
    });
   });

  }
 }