<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>${group.name}</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>${group.name}</h5>
           <div class="ibox-tools">
               <a class="collapse-link">
                   <i class="fa fa-chevron-up"></i>
               </a>
           </div>
       </div>
       <div class="ibox-content">
       	 <div class="row well">
	       	  <div class="form-group">
                <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchCode" name="searchCode">
                        <c:forEach items="${codeList}" var="list">
                        	<option value="${list.code }" <c:if test="${list.code eq code}">selected='selected' </c:if> >${list.name }</option>
                        </c:forEach>
                    </select>
                </div>
              </div>
          </div>

			<div class="row">
               <!-- dataTable start -->
<!--                <div class="table-responsive"> -->
				 <div class="ibox-content">
                    <div id="calendar"></div>
                </div>
<!-- 			  </div> -->
               <!-- dataTable end -->
   			</div>
        </div>
     </div>

</div>
<!-- Modal (reservation) start  -->
<div class="modal inmodal fade modal_reservation" id="modal_reservation" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="modal-title">${group.name}</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="reservationForm" id="reservationForm" >
	        <input type="hidden" id="id" name="id" value="0"/>
	        <input type="hidden" id="type" name="type" value="${type}"/>
			<input type="hidden" id="code" name="code" value="${code}"/>
	        <div class="modal-body">
	        	<div class="form-group"><label class="col-sm-3 control-label">제목<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="title" id="title" class="form-control"></div>
	            </div>
	            <div class="form-group">
	                <label class="col-sm-3 control-label">시작시간</label>
	                <div class="col-sm-9"><input type="text" name="start" id="start" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group">
	            	<label class="col-sm-3 control-label">종료시간</label>
	                <div class="col-sm-9 endTm"><input type="text" name="end" id="end" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">메모 </label>
	                <div class="col-sm-9"><textarea id="description" name="description" class="form-control"></textarea></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">예약자</label>
	                <div class="col-sm-9"><input type="text" name="capsName" id="capsName" class="form-control" value="${capsName}" readonly="readonly"></div>
	            </div>
	         </div>

	        <div class="modal-footer">
	        	<a class="btn btn-danger pull-left" id="btnDelete" style="display: none;">Delete</a>
	            <a class="btn btn-white" id="btnCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnSave">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<form name="searchParam" id="searchParam">
	<input type="hidden" id="searchType" name="searchType" value="${type}"/>
	<input type="hidden" id="searchCode" name="searchCode" value="${code}"/>
	<input type="hidden" id="fromDate" name="fromDate"/>
	<input type="hidden" id="toDate" name="toDate"/>
</form>



<!-- Page-Level Scripts -->
<script src="<c:url value="/resources/js/plugins/fullcalendar/fullcalendar.js"/>"></script>
<script src="<c:url value="/resources/js/plugins/fullcalendar/ko.js"/>"></script>
    <script>


    //가능한 시간 배열
    var timeArray = ['00:00','00:30','01:00','01:30','02:00','02:30','03:00','03:30','04:00','04:30','05:00','05:30','06:00','06:30','07:00','07:30','08:00','08:30','09:00','09:30','10:00','10:30','11:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00','16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30','21:00','21:30','22:00','22:30','23:00','23:30','24:00'];
    var lastTimeIndex = timeArray.length-1;
    var minTime = '00:00:00';
    var maxTime = '24:00:00';

    var groupKey = '${group.groupKey}'.toLowerCase();
    if(groupKey == 'meeting_room'){
    	minTime = '07:00';
        maxTime = '21:00';
        lastTimeIndex = timeArray.indexOf(maxTime);
    }
	//console.log("lastTimeIndex:"+lastTimeIndex);
    $(document).ready(function(){
    	$('#searchCode').change(function(){
    		var moveUrl = '<c:url value="/reservation/"/>' + groupKey + '/' + $(this).val() +'/list';
			//console.log(moveUrl);
    		location.href = moveUrl;
    	})


    	/* initialize the calendar
        -----------------------------------------------------------------*/
       var date = new Date();
       var d = date.getDate();
       var m = date.getMonth();
       var y = date.getFullYear();

       $('#calendar').fullCalendar({
           header: {
               left: 'prev,next today',
               center: 'title',
               right: 'agendaWeek,agendaDay'
           },
           //firstDay:1,
           height:'auto',
           minTime:minTime,
           maxTime:maxTime,
           allDaySlot:false,
           defaultView:'agendaWeek',
           editable: false,
           droppable: false, // this allows things to be dropped onto the calendar
           dayClick: function(date, jsEvent, view) {
        	//event 예약하기위한 modal show
        	eventSeletDayTimeLimit(date);
            //alert('Current view: ' + view.name);
           },
           eventRender: function(event, element) {
        	   if(event.description!=''){
        		   element.find('.fc-title').append("(" + event.capsName + ") ").append("<br/>[" + event.description + "] ");
        	   }else{
        		   element.find('.fc-title').append("(" + event.capsName + ") ");
        	   }

                  //element.append( "<i class='fa fa-trash closeon'></i>" );
                  //element.find(".closeon").click(function() {
                  //	console.log(event._id);
                  //   $('#calendar').fullCalendar('removeEvents',event._id);
                  //});
              },
		   	eventClick: function(event, jsEvent, view) {
		   	    $('#id').val(event.id);
		   		$('#title').val(event.title);
		   	 	$('#start').val(event.start.format("YYYY-MM-DD HH:mm"));
		   	 	$('.endTm').html('<input type="text" name="end" id="end" class="form-control" readonly="readonly">');
		   	 	$('#end').val(event.end.format("YYYY-MM-DD HH:mm"));
		   		$('#description').val(event.description);
				$('#capsName').val(event.capsName);
		   		//console.log(event.crtdId +' ${id}');
				if(event.crtdId == '${id}'){
					$("#btnSave").removeClass('registBt').addClass('modifyBt').show();
					$("#btnDelete").show();
				}else{
					$("#btnSave").hide();
					$("#btnDelete").hide();
				}
		   	 	$('#modal_reservation').modal('show');

		   	 },


       });
		//modal hide
       $('#btnCancel').click(function(e){
	   		//e.preventDefault();
	   		reservationFormReset();
	   	});

       $('#btnSave').click(function(e){
	   		e.preventDefault();
	   		if($('#reservationForm').valid()){
	   			if($(this).hasClass('registBt')){
	   				$.ajax({
	   					url : "<c:url value='/reservation/insertAjax'/>",
	   					data : $("#reservationForm").serialize(),
	   					type : 'POST',
	   					dataType : 'json',
	   					success : function(data){
	   						updateEvent(data,'regist');
	   					}
	   				});
	   			}else{
	   				$.ajax({
	   					url : "<c:url value='/reservation/updateAjax'/>",
	   					data : $("#reservationForm").serialize(),
	   					type : 'POST',
	   					dataType : 'json',
	   					success : function(data){
	   						updateEvent(data,'edit');
	   					}
	   				});
	   			}
	   		};
	   	});

       $('#btnDelete').click(function(e){
    	   if (confirm("삭제 하시겠습니까?")){
	    	   var id= $('#id').val();
	    	   $.ajax({
					url : "<c:url value='/reservation/deleteAjax'/>",
					data : $("#reservationForm").serialize(),
					type : 'POST',
					dataType : 'json',
					success : function(data){
						if(data ==1){
							$('#calendar').fullCalendar( 'removeEvents', id);
						}
						reservationFormReset();
					}
				});
    	   }
       })

       $("#reservationForm").validate({
	   		rules: {
	   			title: { required: true, maxlength:50 }
		    	,start: { required: true }
		    	,end: { required: true }
		    	,description: { maxlength:300 }
	         }
	   	});


      // .fullCalendar( 'addEvent', event )
		//init get event
       getEventList();

     //prev month click event
       $('body').on('click', 'button.fc-prev-button', function() {
      	 getEventList();
     	 });
     //next month click event
     	$('body').on('click', 'button.fc-next-button', function() {
     		getEventList();
     	 });
     	$('body').on('click', 'button.fc-month-button', function() {
     		getEventList();
     	 });
     	$('body').on('click', 'button.fc-agendaWeek-button', function() {
     		getEventList();
     	 });
     	$('body').on('click', 'button.fc-agendaDay-button', function() {
     		getEventList();
     	 });
    	//today month click event
     	$(".fc-today-button").click(function() {
     		getEventList();
     	});

    });

    function updateEvent(data,mode){

    	var event = Object();
 		event.id=data.id;
 		event.title=data.title;
 		event.start = moment(data.start).format('YYYY-MM-DD HH:mm');
 		event.end = moment(data.end).format('YYYY-MM-DD HH:mm');
 		event.description = data.description;
 		event.capsName=data.capsName;
 		event.crtdId=data.crtdId;
 		event.allDay=false;
 		if('${id}'==data.crtdId){
 			event.className='fc-me-event';
 		}
 		//console.log(event);
 		if(mode=='regist'){
			$('#calendar').fullCalendar('renderEvent',event);
 		}else{
 			$('#calendar').fullCalendar( 'removeEvents', data.id);
 		    //$('#calendar').fullCalendar('refresh');
 		    $('#calendar').fullCalendar('renderEvent',event);
 		}
		reservationFormReset();
    }



    //시간 선택시 종료시간 계산후 modal show
    function eventSeletDayTimeLimit(date){
    	var seletDay = date.format('YYYY-MM-DD');
   		var startTm = date.format('HH:mm');
   		var selectLastTimeIndex = lastTimeIndex;

   		$('#start').val(date.format('YYYY-MM-DD HH:mm'));
   		$('#title, #description').val('');

   		$.ajax({
			url : "<c:url value='/reservation/getSeletDayTimeLimitAjax'/>",
			data : $("#reservationForm").serialize(),
			type : 'GET',
			dataType : 'json',
			success : function(data){
				if(data!=null){
					selectLastTimeIndex=timeArray.indexOf(moment(data.start).format('HH:mm'));
				}
				var sb = new StringBuffer();
		         sb.append('<select id="end" name="end" class="form-control">');
		         for(var i=timeArray.indexOf(startTm)+1;i<=selectLastTimeIndex;i++){
		      	 	if(timeArray[i]=='24:00'){
		      	 		tempTm = moment(seletDay, "YYYY-MM-DD").add(1, 'days').format("YYYY-MM-DD") + ' 00:00';
		      	 	}else{
		      	 		tempTm = seletDay + ' ' + timeArray[i];
		      	 	}

		     		sb.append('<option value="'+ tempTm +'">'+ tempTm +'</option>');
		         }
		         sb.append('</select>');
		         $('.endTm').html(sb.toString());
		         $('#modal_reservation').modal('show');

			}
		});


    }


	/** event list **/
	function getEventList(){
		var viewStartDate = $('#calendar').fullCalendar('getView').start;
  		var viewEndDate = $('#calendar').fullCalendar('getView').end;

  		$('#fromDate').val(moment(viewStartDate).format('YYYY-MM-DD HH:mm'));
  		$('#toDate').val(moment(viewEndDate).format('YYYY-MM-DD HH:mm'));

  		$.ajax({
			url : "<c:url value='/reservation/getListAjax'/>",
			data : $("#searchParam").serialize(),
			type : 'GET',
			dataType : 'json',
			success : function(data){
				eventListSetting(data);
			}
		});
	}
	//ajax event setting
     function eventListSetting(list){

     	var eventsArray = new Array();
     	for(var i=0 ; i <list.length;i++){
     		var event = Object();
     		event.id=list[i].id;
     		event.title=list[i].title;
     		event.start = moment(list[i].start).format('YYYY-MM-DD HH:mm');
     		event.end = moment(list[i].end).format('YYYY-MM-DD HH:mm');
     		event.description = list[i].description;
     		event.crtdId=list[i].crtdId;
     		event.capsName=list[i].capsName;
     		event.allDay=false;
     		if('${id}'==list[i].crtdId){
     			event.className='fc-me-event';
     		}
     		eventsArray.push(event);
     	}
     	$('#calendar').fullCalendar( 'removeEvents' );
     	$('#calendar').fullCalendar( 'addEventSource', eventsArray );
     }

     function reservationFormReset(){
    	$('#id').val('0');
 		$('#title, #description').val('');
 		$("#btnSave").removeClass('modifyBt').addClass('registBt');
 		$('#capsName').val('${capsName}');
     	$('label.error').hide();
     	$('.form-control').removeClass('error');

 		$('#modal_reservation').modal('hide');
     }




    </script>
</body>