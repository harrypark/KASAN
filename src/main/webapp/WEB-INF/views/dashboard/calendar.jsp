<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>일정캘린더</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>일정캘린더</h5>
           <div class="ibox-tools">
               <a class="collapse-link">
                   <i class="fa fa-chevron-up"></i>
               </a>
           </div>
       </div>
       <div class="ibox-content">
       	 <div class="row well">
       	 <form name="searchParam" id="searchParam">
	       	 <input type="hidden" id="fromDate" name="fromDate"/>
			 <input type="hidden" id="toDate" name="toDate"/>
		       	  <div class="form-group">
		       	  	<div class="col-lg-2 col-md-6 col-sm-12">
	                    <select class="form-control chosen" id="searchText" name="searchText">
	                        <option value="all">일정_전체</option>
	                        <option value="wo">외근</option>
	                        <option value="le">휴가</option>
	                        <option value="hl">반휴</option>
	                        <option value="re">대체(빠지는날)</option>
	                        <option value="su">대체(채우는날)</option>
	                        <option value="bt">출장</option>
	                    </select>
	                </div>
	                <div class="col-lg-2 col-md-6 col-sm-12">
	                	 <select class="form-control chosen" id="searchDept" name="searchDept">
	                        <option value="all">부서_전체</option>
	                        <c:forEach items="${deptList}" var="list">
	                        	<option value="${list.code }" <c:if test="${userDept eq list.code }">selected</c:if>>${list.name }</option>
	                        </c:forEach>
	                    </select>
	                </div>
	                <div class="col-lg-2 col-md-6 col-sm-12">
	                    <select class="form-control chosen" id="searchUser" name="searchUser">
	                        <option value="all">전체</option>
	                    </select>
	                </div>
	              </div>
           </form>
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




<!-- Page-Level Scripts -->
<script src="<c:url value="/resources/js/plugins/fullcalendar/fullcalendar.js"/>"></script>
<script src="<c:url value="/resources/js/plugins/fullcalendar/ko.js"/>"></script>
    <script>
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
               right: 'month,agendaWeek,agendaDay'
           },
           //firstDay:1,
           height:'auto',
           //minTime:minTime,
           //maxTime:maxTime,
           allDaySlot:true,
           defaultView:'month',
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
        	   
        	   /*
        	   element.popover({
       	          title: event.title+"("+event.capsName+")",
       	          content: moment(event.start).format("YYYY-MM-DD HH:mm") +"["+event.description+"]",
       	          trigger: 'click',//'hover'
       	          placement: 'top',
       	          container: 'body'
       	        });
				*/
                  //element.append( "<i class='fa fa-trash closeon'></i>" );
                  //element.find(".closeon").click(function() {
                  //	console.log(event._id);
                  //   $('#calendar').fullCalendar('removeEvents',event._id);
                  //});
              },
		   	eventClick: function(event, jsEvent, view) {
		   	    return false;
		   		/*
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
				*/
		   	 },


       });


      // .fullCalendar( 'addEvent', event )
		//init get event
       

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
    	
    	$('#searchText, #searchUser').change(function(){
    		getEventList();
    	})
    	
    	
        $('#searchDept').change(function(){
        	$.ajax({
   				url : "<c:url value='/management/getDeptUserAjax'/>",
   				data : {searchDept : $(this).val()},
   				type : 'POST',
   				dataType : 'json',
   				success : function(data){
   					$('#searchUser option').remove();
   					$('#searchUser').append('<option value="all">전체</option>');
   					for(var i=0; i<data.length;i++){
   						$('#searchUser').append('<option value="'+data[i].id+'">'+data[i].capsName+'('+data[i].deptName+')</option>');
   					}
   					
   					getEventList();

   				}
   			});
        })
   	 $('#searchDept').trigger('change');

        getEventList();

    });

	/** event list **/
	function getEventList(){
		var viewStartDate = $('#calendar').fullCalendar('getView').start;
  		var viewEndDate = $('#calendar').fullCalendar('getView').end;

  		$('#fromDate').val(moment(viewStartDate).format('YYYY-MM-DD HH:mm'));
  		$('#toDate').val(moment(viewEndDate).format('YYYY-MM-DD HH:mm'));

  		$.ajax({
			url : "<c:url value='/dashboard/getCalendarAjax'/>",
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
     		event.title=list[i].title +':';
     		event.allDay=list[i].allDay;
      		event.start = moment(list[i].start + "00:00").format('YYYY-MM-DD HH:mm');
      		if(list[i].allDay == true){
      			event.end = moment(list[i].end+" 23:59").add(1, 'days').format('YYYY-MM-DD HH:mm');	
      		}else{
      			event.end = moment(list[i].end+" 23:59").add(0, 'days').format('YYYY-MM-DD HH:mm');
      		}
      		    		
     		event.description = list[i].description;
     		event.crtdId=list[i].crtdId;
     		event.capsName=list[i].capsName;
     		
     		//console.log(list[i].code);
     		event.className='fc-'+list[i].code+'-event';
     		
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