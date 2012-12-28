;(function($,undefined){
	var _timer=[],
		_fw=window._fw=$.fn._fw=function(_){
			var i,name=[]
			for(i in _)
				if(_.hasOwnProperty(i))
					name.push(i)
			$(this).each(function(){
				for(var i=0,opt;i<name.length;i++)
					if(_fw.meth[name[i]])						
						opt=$.extend(clone(_fw.meth[name[i]]),_[name[i]]),
						opt.init.call($(this).data(name[i],opt),opt)
			})
			return this
		},
		_meth=_fw.meth={},
		_hlp=_fw.hlp={
			clone:function(obj){
				if(!obj||typeof obj!=typeof {})
					return obj
				if(obj instanceof Array)
					return [].concat(obj)
				var tmp=new obj.constructor(),
					i
				for(i in obj)
					if(obj.hasOwnProperty(i))
						tmp[i]=clone(obj[i])
				return tmp
			},
			srlz:function(str){
				if(!str)
					return {}
				str=str.split(/[\/&]/)
				for(var i=0,tmp,ret={};i<str.length;i++)
					if(str[i])
						tmp=str[i].split('='),
						ret[tmp[1]?tmp[0]:i]=tmp[1]?tmp[1]:tmp[0]
				return ret
			},
			dStr:function(obj){
				var key,
					ret=''
				for(key in obj)
					if(obj.hasOwnProperty(key))
						if(key/1==''/1)
							ret+=!ret?obj[key]+'/':obj[key]
						else
							ret+=!ret?key+'='+obj[key]+'&':key+'='+obj[key]
				return ret
			}
		},
		clone=_hlp.clone
		
$.fn.extend({
	bgSlider:function(opt){
		opt=opt||{}
		opt={bgSlider:opt}
		this._fw(opt)
	}
})

$.extend(_fw.meth,{
	bgSlider:{
			slideshow:false,
			duration:1500,
			easing:'',
			preload:false,
			pagination:false,
			pagActiveCl:'current',
			pagEv:'click',
			pagArea:'a',
			current:0,
			currN:0,
			method:'fit',
			altCSS:{},
			padding:0,
			preload:false,
			spinner:false,
			minSpinnerWait:150,
			preloadFu:function(){
				var opt=this,
					img=$('<img>')
							.css({position:'absolute',left:'-999%'})
							.appendTo('body'),
					num=opt.images.length
				;(function(){
					if(num)
						img	.load(arguments.callee)
							.attr({src:opt.images[--num]})
					else
						img.remove()					
				})()
			},
			pagsFu:function(){
				var opt=this,
					pags=opt.pags=$(opt.pagination+' li')
				if(!opt.images)
					opt.images=[],
					pags.each(function(i){
						opt.images.push($('a',this).attr('href'))
					})
				pags.find(opt.pagArea).each(function(i){
					$(this).data({num:i})
				})
				pags.parent()
					.delegate(opt.pagination+':not(.'+opt.pagActiveCl+')'+(opt.pagArea?' '+opt.pagArea:''),opt.pagEv,function(){
						var th=$(this)
						opt.changeFu(th.data('num'))
						opt.pags.not(th.parent().addClass(opt.pagActiveCl)).removeClass(opt.pagActiveCl)	;
						Cufon.replace('.pagination li', { fontFamily: 'Ubuntu', hover:true });
						return false
					})
			},
			preFu:function(){
				var opt=this
				opt.img
					.css({
						position:'absolute',
						left:0,
						top:0
						})
					.css(opt.altCSS)
					.attr({src:opt.images[opt.current]})					
				opt.img.each(function(){
					var _f=function(){
								opt.resizeFu()
								opt.img.data({width:opt.img.width(),height:opt.img.height()})						
							}
					if(this.complete)
						_f()
					else
						$(this)
							.load(_f)
				})
					
				opt.holder
					.css({
						position:'fixed',
						left:0,
						right:0,
						top:0,
						bottom:0,
						zIndex:-1
						})
					.append(opt.img)
				if(opt.spinner)
					opt.spinner.hide()
			},
			resizeFu:function(){
				var opt=this,
					img=opt.img,
					w=opt.wi,
					h=opt.he,
					l=img.css('left'),
					t=img.css('top'),
					bw=document.body.offsetWidth-opt.padding,
					bh=document.body.offsetHeight,
					k=w/h
				
			},
			changeFu:function(n){
				var opt=this
				if(n==opt.currN)
					return false
				opt.currN=n
				opt.showFu(opt.images[n])
			},
			nextFu:function(){
				var opt=this,
					n=opt.currN
				opt.changeFu(++n<opt.images.length?n:n=0)
				opt.pags.eq(n).addClass(opt.pagActiveCl).siblings().removeClass(opt.pagActiveCl)
			},
			prevFu:function(){
				var opt=this,
					n=opt.currN
				opt.changeFu(--n>=0?n:n=opt.images.length-1)
				opt.pags.eq(n).addClass(opt.pagActiveCl).siblings().removeClass(opt.pagActiveCl);
				Cufon.replace('.pagination li', { fontFamily: 'Ubuntu', hover:true });
			},
			showFu:function(src){
				var opt=this,
					clone=opt.clone=opt.img.clone(true)
				if(opt.slideshow)
					clearInterval(_timer[0])
				clone
					.css({
						 opacity:0,
						 left:0,
						 top:0
						 })
					.appendTo(opt.holder)	
					.width(opt.img.width())
					.load(function(){
						var th=$(this)
						opt.holder.find('>*').stop()						
						setTimeout(function(){
							opt.spinner.hide()
							opt.wi=th.width()
							opt.he=th.height()
							clone
								.stop()
								.animate({
										opacity:1
										},{
										duration:opt.duration,
										easing:opt.easing,
										complete:function(){
											var tmp=opt.holder.find('img')
											opt.img=$(this)
											tmp.not(tmp.last()).remove()
											opt.resizeFu()
										}
										})
						},opt.minSpinnerWait)
					})
					.attr({src:src})
					opt.spinner.show()
					if(opt.slideshow)
						_timer[0]=setInterval(function(){
							opt.nextFu()
						},opt.slideshow)
			},
			init:function(opt){
				var holder=opt.holder=this,
					img=opt.img=$('<img>')
				if(opt.pagination)
					opt.pagsFu()
				if(opt.spinner)
					opt.spinner=$(opt.spinner)
				opt.preFu()
				if(opt.preload)
					opt.preloadFu()
				window.onresize=function(){
					opt.resizeFu()
				}
				if(opt.slideshow)
					_timer[0]=setInterval(function(){
						opt.nextFu()
					},opt.slideshow)
				holder.data({opt:opt})
			}
		}
})
})(jQuery)
