<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row  border-bottom white-bg dashboard-header">
			 <div class="col-lg-4">
				<div class="panel panel-default">
	                 <div class="panel-heading" id="today">
	                 </div>
	                 <div class="panel-body today-time">

	                 	<h4><span class="text-info">${capsName}</span>님 안녕하세요.</h4>

	                 	<div class="row">
	                 		<div class="col-sm-6">
	                 			<span class="label label-warning"><i class="fa fa-sign-in"></i></span>출근시간 : <span id="userGoTime" class="text-success"></span>
	                 		</div>
	                 		<div class="col-sm-6">
	                 			<span class="label label-warning"><i class="fa fa-sign-out"></i></span>퇴근예정 : <span id="userOutTime" class="text-success"></span>
	                 		</div>
	                 	</div>
	                 </div>
	             </div>
             </div>
             <div class="col-lg-4">
                 <div class="panel panel-info" id="todayEvent">
	                 <div class="panel-heading">
	                     <i class="fa fa-info-circle"></i>	오늘 일정
	                 </div>
	                 <div class="panel-body">
	                     <table class="ks-dash-table table table-hover no-margins">
                             <tbody>
                             <c:choose>
                             	<c:when test="${empty todayEvent}">
                             		<tr><td colspan="3" style="border-top: none;">일정이 없습니다.</td></tr>
                             	</c:when>
                             	<c:otherwise>
                             		<c:forEach var="list" items="${todayEvent}">
                             			<tr class="tr-ks tr-${list.cssText}">
			                                 <td><span class="label label-${list.cssText}">${list.gubun}</span></button> </td>
			                                 <td>${list.term}</td>
			                                 <td>${list.info}</td>
			                             </tr>
                             		</c:forEach>
                             	</c:otherwise>
                             </c:choose>
                             </tbody>
                         </table>
	                 </div>
	             </div>
             </div>
			<div class="col-lg-4">
            	<div class="panel panel-success" id="tomorrowEvent">
	                 <div class="panel-heading">
	                    <i class="fa fa-info-circle"></i> 	내일 일정
	                 </div>
	                 <div class="panel-body">
	                     <table class="ks-dash-table table table-hover no-margins">
                             <tbody>
                             <c:choose>
                             	<c:when test="${empty tomorrowEvent}">
                             		<tr><td colspan="3" style="border-top: none;">일정이 없습니다.</td></tr>
                             	</c:when>
                             	<c:otherwise>
                             		<c:forEach var="list" items="${tomorrowEvent}">
                             			<tr class="tr-ks tr-${list.cssText}">
											<td><span class="label label-${list.cssText}">${list.gubun}</span> </td>
			                                 <td>${list.term}</td>
			                                 <td>${list.info}</td>
			                             </tr>
                             		</c:forEach>
                             	</c:otherwise>
                             </c:choose>
                             </tbody>
                         </table>
	                 </div>
	             </div>
            </div>

     </div>
     <div class="row dashboard-dept">
     <!-- 부서목록 -->
     <c:forEach items="${deptList}" var="list" varStatus="i">
     	<c:if test="${list.code eq deptCd }">
		    <div class="ibox float-e-margins dept_box" id="dept_box_${list.code}">
		       <div class="ibox-title-warning" id="dept_title_${list.code}">
		           <h5>${list.name} [<int${list.code}>0</int${list.code}>]</h5>
		           <div class="ibox-tools">
		               <a class="collapse-link">
		                   <i class="fa fa-chevron-up"></i>
		               </a>
		           </div>
		       </div>
		       <div class="p-tw-xs ibox-content user_content" id="dept_content_${list.code}">
					<div class="row">

					</div>
		         </div>
		       </div>
	       </c:if>
	    </c:forEach>
     <c:forEach items="${deptList}" var="list" varStatus="i">
	    <c:if test="${list.code ne deptCd }">
		    <div class="ibox float-e-margins dept_box user-box" id="dept_box_${list.code}">
		       <div class="ibox-title-warning" id="dept_title_${list.code}">
		           <h5>${list.name} [<int${list.code}>0</int${list.code}>]</h5>
		           <div class="ibox-tools">
		               <a class="collapse-link">
		                   <i class="fa fa-chevron-up"></i>
		               </a>
		           </div>
		       </div>
		       <div class="p-tw-xs ibox-content user_content" id="dept_content_${list.code}">
					<div class="row">

					</div>
		         </div>
		       </div>
	       </c:if>
	    </c:forEach>
	 </div>

</div>
<script src="<c:url value="/resources/js/dashboard-script.js"/>"></script>
<script>
    $(document).ready(function(){

		$('#today').text(getToday('${todayInfo.calDate1}','${todayInfo.calHolidayYn}','${todayInfo.calHolidayName}'));
		//getDeptList();
		getUserStateList();

		if($('body').hasClass("body-small")){
			$('.user-box .collapse-link').trigger('click');
			<c:if test="${empty todayEvent}">$('#todayEvent').hide();</c:if>
			<c:if test="${empty tomorrowEvent}">$('#tomorrowEvent').hide();</c:if>
		}

		$('table.ks-dash-table tbody tr.tr-ks').click(function(){
			//console.log($(this).attr('class'));

			if($(this).hasClass('tr-bt')){//go 출장관리
				location.href = '<c:url value="/app/businessTrip"/>';
			}else if($(this).hasClass('tr-le')){//go 휴가
				location.href = '<c:url value="/app/leave"/>';
			}else if($(this).hasClass('tr-hl')){//go 반휴
				location.href = '<c:url value="/app/leave"/>'+'?type=2';
			}else if($(this).hasClass('tr-wo')){//go 외근공지
				location.href = '<c:url value="/app/workoutSide"/>';
			}else if($(this).hasClass('tr-re')){//go 대체근무(대체)
				location.href = '<c:url value="/app/replace"/>';
			}else if($(this).hasClass('tr-su')){//go 대체근무(보충)
				location.href = '<c:url value="/app/replace"/>';
			}
		})

    })

    //부서목록
    function getDeptList(){
    	$.ajax({
			url : "<c:url value='/dashDeptListAjax'/>",
			//data : {searchId : rowData[0]},
			type : 'POST',
			dataType : 'json',
			success : function(data){
				dashDeptHtml(data,'${deptCd}');
			}
		});
    	getUserStateList();

    }

	//통계데이터
    function getUserStateList(){
    	$.ajax({
			url : "<c:url value='/dashUserStateAjax'/>",
			//data : {searchId : rowData[0]},
			type : 'POST',
			dataType : 'json',
			success : function(data){
				userStateHtml(data,'${id}');
			}
		});

    }







</script>