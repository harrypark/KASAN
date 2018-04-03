

/*
 * 오늘 날짜 구하기
 */
function getToday(day,holidayYn,holidayName){
	var today = moment(day).format('YYYY-MM-DD');
	var week = moment(today).format('ddd');
	switch (week) {
	  case 'Mon'  : week='(월)'; break;
	  case 'Tue'  : week='(화)'; break;
	  case 'Wed'  : week='(수)'; break;
	  case 'Thu'  : week='(목)'; break;
	  case 'Fri'  : week='(금)'; break;
	  case 'Sat'  : week='(토)'; break;
	  case 'Sun'  : week='(일)'; break;
	  default   : week=''; break;
	}
	var holiday ="";
	if(holidayYn == 'Y'){
		holiday = " - " +holidayName;
	}

	//console.log(week);
	return moment(today).format('YYYY년 MM월 DD일') + ' ' + week + holiday;
}

function userStateHtml(data,userId){
	var userList = data.userList;
	var eventList = data.eventList;
	$('.user_content .row').html('');//init

	for(var i=0 ; i <userList.length ; i++){
		if(userList[i].id==userId){
			if (typeof userList[i].calHereGo != "undefined"){
				$("#userGoTime").text(userList[i].calHereGo.substr(11,5));
			}else{
				$("#userGoTime").text('출근미정');
			}
			if (typeof userList[i].expHereOut != "undefined"){
				$("#userOutTime").text(userList[i].expHereOut.substr(11,5));
			}else{
				$("#userOutTime").text('퇴근미정');
			}
		}

		var sb = new StringBuffer();
		sb.append('<div class="p-w-xss col-lg-2 col-md-4 col-xs-6 '+userList[i].deptCd+'" id="user_'+userList[i].id+'">');
		sb.append('<div class="contact-box dash-contact-box">');
		sb.append('<div class="p-w-xss col-sm-12">');

		var userName = userList[i].capsName;

		if(typeof userList[i].insideTel !="undefined"  && userList[i].insideTel !=''){
			if($('body').hasClass("body-small")){//모바일에서 전화걸기 링크
				userName = userName + '<a href="tel:'+userList[i].insideTel+'">('+userList[i].insideTel+')</a>';
			}else{
				userName = userName + '('+userList[i].insideTel+')';
			}
		}
		var state = "";

		var expTime = exptext(userList[i].calHereGo,'go') +'~'+ exptext(userList[i].expHereOut,'out');
		if(userList[i].inOffice==true){
			state = '<span class="badge badge-info" style="margin-left:10px;" data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" title="재실" data-content="'+ expTime +'">재실</span></h3>';
		}else{
			state = '<span class="badge badge-warrning" style="margin-left:10px;" data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" title="부재" data-content="'+ expTime +'">부재</span></h3>';
		}


		if(userList[i].dashState=='Y'){
			sb.append('	<h3><strong>'+userName+'</strong>'+state);
		}else{
			sb.append('	<h3><strong>'+userName+'</strong>');
		}

//		sb.append('	<div>퇴근예상:'+subtext(userList[i].calHereGo)+'~'+subtext(userList[i].expHereOut)+'</div>');
//		sb.append('	<div>진짜시간:'+subtext(userList[i].calHereGo)+'~'+subtext(userList[i].hereOut)+'</div>');
//		sb.append('	<div>지각기준:'+subtext(userList[i].lateTm)+' diff:'+userList[i].diffLateMin+'('+userList[i].late+')</div>');
//		sb.append('	<div>근무시간:'+userList[i].calWorkTmMin+' - '+userList[i].workTmMin+'  ='+userList[i].diffWorkTmMin+'('+userList[i].failWorkTm+')</div>');


		sb.append('	<p></p>');
        sb.append('</div>');
        sb.append('<div class="clearfix"></div>');
        sb.append('</div>');
        sb.append('</div>');
       // console.log(sb.toString());
        $('#dept_content_'+ userList[i].deptCd+' .row').append(sb.toString());
        //부서 인원수
        $('int'+ userList[i].deptCd).text($('.'+userList[i].deptCd).length);


	}

	for(var i=0 ; i < eventList.length; i++){
		var sb = new StringBuffer();
		var content = eventList[i].term + ' <br/>' + eventList[i].info;
		var contentHtml = '<span class="label label-'+eventList[i].cssText+'" data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" title="'+eventList[i].gubun+'" data-content="'+ content +'">'+eventList[i].gubun+'</span>';
		sb.append(contentHtml);
		$('#user_'+ eventList[i].id +' div.contact-box p').append(sb.toString())
	}
	$('[data-toggle="popover"]').popover({html:"true"});



}

function subtext(str){
	if (typeof str =="undefined") return null;

}

function exptext(str,type){
	if (typeof str =="undefined"){
		if(type=='go'){
			return '출근미정';
		}else{
			return '퇴근미정';
		}
		return null;
	}else{
		return str.substr(11,5);
	}
}



/*
* btrip : 출장정보
*/
function addUserLabelInfo(list,type){
	//console.log(list.length);
	for(var i=0; i<list.length ; i++){
		var sb = new StringBuffer();
		if(type=='workout'){
			content = list[i].startTm + (list[i].hereGoYn=='Y'?'(현출)':'') + ' ~ ' + list[i].endTm + (list[i].hereOutYn=='Y'?'(현퇴)':'') + ' <br/>' + detailInfoSubString(list[i].destination,10);
    		//console.log(content);
    		sb.append('<span class="label label-wo" data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" title="외근" data-content="'+ content +'">외근</span>');
		}else if(type == 'btrip'){
    		content = list[i].startDt + ' ~ ' + list[i].endDt + ' <br/>' + detailInfoSubString(list[i].destination,10);
    		//console.log(content);
    		sb.append('<span class="label label-bt" data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" title="출장" data-content="'+ content +'">출장</span>');
    	}else if(type=='leave'){
			content = list[i].leDt + ' <br/>' + detailInfoSubString(list[i].memo,10);
    		sb.append('<span class="label label-le" data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" title="휴가" data-content="'+ content +'">휴가</span>');
    	}else if(type=='hlLeave'){
    		content = list[i].hlDt + ' <br/>' + detailInfoSubString(list[i].memo,10);
    		sb.append('<span class="label label-hl" data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" title="반휴" data-content="'+ content +'">반휴</span>');
    	}else if(type=='repl'){
    		content = list[i].replStartTm + ' ~ ' + list[i].replEndTm + ' <br/>' + detailInfoSubString(list[i].memo,10);
    		sb.append('<span class="label label-re" data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" title="빠지는날" data-content="'+ content +'">빠지는날</span>');
    	}else if(type=='supple'){
    		content = list[i].termHM + ' <br/>' + detailInfoSubString(list[i].memo,10);
    		sb.append('<span class="label label-su" data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" title="채우는날" data-content="'+ content +'">채우는날</span>');
    	}
		$('#user_'+ list[i].crtdId +' div.contact-box p').append(sb.toString())

	}
	 $('[data-toggle="popover"]').popover({html:"true"});
}

function detailInfoSubString(text, len){
	if(text != null && text.length > len){
		text=  text.substring(0,len) + '...';
	}
	if(text.length==0){
		return '';
	}
	return '(' +text+')';
}


function dashDeptHtml(list,deptCd){
	//console.log(deptCd);

	for(var i=0 ; i<list.length ;i++){
	  var sb = new StringBuffer();
	  sb.append('<div class="ibox float-e-margins user-box" id="dept_box_'+list[i].code+'">');
	  sb.append('     <div class="ibox-title" id="dept_title_'+list[i].code+'">');
	  sb.append('         <h5>'+list[i].name+'</h5>');
	  sb.append('         <div class="ibox-tools"><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></div></div>');
	  sb.append('     <div class="ibox-content user_content" id="dept_content_'+list[i].code+'">');
	  sb.append('		<div class="row"></div>');
	  sb.append('		</div>');
	  sb.append('</div>');

	  if(i==0){
		  $('.dashboard-dept').append(sb.toString());
	  }else{
		  if(list[i].code==deptCd){
			  $('.dashboard-dept').prepend(sb.toString());
		  }else{
			  $('.dashboard-dept').append(sb.toString());
		  }
	  }
	}


}



