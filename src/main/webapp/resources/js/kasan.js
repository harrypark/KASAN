/*
 * String Buffer
 */
var StringBuffer = function() {
    this.buffer = new Array();
}

StringBuffer.prototype.append = function(obj) {
     this.buffer.push(obj);
}


StringBuffer.prototype.toString = function(){
     return this.buffer.join("");
}

/*
 * HashMap
 */
Map = function(){
	  this.map = new Object();
	 };
	 Map.prototype = {
	     put : function(key, value){
	         this.map[key] = value;
	     },
	     get : function(key){
	         return this.map[key];
	     },
	     containsKey : function(key){
	      return key in this.map;
	     },
	     containsValue : function(value){
	      for(var prop in this.map){
	       if(this.map[prop] == value) return true;
	      }
	      return false;
	     },
	     isEmpty : function(key){
	      return (this.size() == 0);
	     },
	     clear : function(){
	      for(var prop in this.map){
	       delete this.map[prop];
	      }
	     },
	     remove : function(key){
	      delete this.map[key];
	     },
	     keys : function(){
	         var keys = new Array();
	         for(var prop in this.map){
	             keys.push(prop);
	         }
	         return keys;
	     },
	     values : function(){
	      var values = new Array();
	         for(var prop in this.map){
	          values.push(this.map[prop]);
	         }
	         return values;
	     },
	     size : function(){
	       var count = 0;
	       for (var prop in this.map) {
	         count++;
	       }
	       return count;
	     }
	 };


 function minToHour(min){
		var buho = min<0?'-':'';
		var hh=0;

		if(min<0){
			hh = Math.floor(-1*min/60)
		}else{
			hh = Math.floor(min/60)
		}


		var mm = min%60;
		if(mm < 0) mm=mm*-1;

		return buho +' ' + hh+'h '+ mm+'m';
}


 // CHECK TO SEE IF URL EXISTS
function checkURL() {
	// get the url by removing the hash
	var url = location.href;
	//console.log("url:"+url);

	var currUrl  = currUrlSubString(url,'/');
	//console.log(currUrl);

	// Do this if url exists (for page refresh, etc...)
	if (currUrl) {
		// remove all active class
		$('ul#side-menu li.active').removeClass("active");
		// match the url and add the active class
		//$('nav li:has(a[href="' + currUrl + '"])').addClass("active");
		$('ul#side-menu li').each(function(){
			if(currUrlSubString($(this).find("a.menu").attr('href'),'/')==currUrl){
				$(this).addClass("active");
			};
		})


		//loadURL(url, container);
	} else {
		// grab the first URL from nav
		$this = $('nav > div > ul > li:first-child > a[href!="#"]');

		// update hash
		//window.location.hash = $this.attr('href');
		//url= window.location.hash.replace(/^#/, '');
		//console.log(url);
		//loadURL(url, container);
		//$('nav li.active').removeClass("active");
		// match the url and add the active class
		//$('nav li:has(a[href="' + url + '"])').addClass("active");

	}

}

function currUrlSubString(url,hash){
	var start = url.lastIndexOf(hash);
	var end   = url.length;

	return url.substring(start+1,end);

}



/*
 * 현재 사용 안함.


var msg_404='<div class="middle-box text-center animated fadeInDown">';
	msg_404 +='<h1>404</h1>';
	msg_404 +='<h3 class="font-bold">Page Not Found</h3>';
	msg_404 +='<div class="error-desc">';
	msg_404 +='Sorry, but the page you are looking for has note been found. Try checking the URL for error, then hit the refresh button on your browser or try found something else in our app.';
	msg_404 +='</div>';
	msg_404 +='</div>';
function loadURL(url, container) {
	$.ajax({
		type : "POST",
		url : url,
		dataType : 'html',
		cache : false, // (warning: this will cause a timestamp and
						// will call the request twice)
		beforeSend : function() {
			// localStorage.clear();
	//         					if (intervalArray.length > 0) {
	//         						for (var i = 0; i < intervalArray.length; i++) {
	//         							eval('clearInterval(' + intervalArray[i] + ')');// 반복작업
	//         																			// 멈춘다.
	//         						}
	//         						intervalArray.length = 0;
	//         					}

	//         					$('#loading').show();
			container.html('');
		},
		success : function(data) {
			container.html(data);
			//$('#loading').hide();
		},

		error : function(xhr, ajaxOptions, thrownError) {
			container.html(msg_404);
			//$('#loading').hide();
		},
		async : false
});

// console.log("ajax request sent");
}
*/