<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="row border-bottom">
<nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
<div class="navbar-header">
    <a class="navbar-minimalize minimalize-styl-2 btn btn-primary "><i class="fa fa-bars"></i> </a>
<!--     <form role="search" class="navbar-form-custom" action="search_results.html"> -->
<!--         <div class="form-group"> -->
<!--             <input type="text" placeholder="Search for something..." class="form-control" name="top-search" id="top-search"> -->
<!--         </div> -->
<!--     </form> -->
</div>
    <ul class="nav navbar-top-links navbar-right">
    	<li class="dropdown profile-element">
           <a data-toggle="dropdown" class="dropdown-toggle" href="#">
           <span class="text-muted text-xs block">${capsName} <c:if test="${authCd ne '003'}">(${deptName})</c:if> <b class="caret"></b></span> </a>
           <ul class="dropdown-menu animated fadeInRight m-t-xs">
               <li><a href="<c:url value="/user/profile"/>">내정보</a></li>
               <li><a href="<c:url value="/user/pwdChange"/>">비밀번호변경</a></li>
           </ul>
       </li>
        <li class="dropdown" id="scoreDropDown">
            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                <i class="fa fa-bar-chart-o"></i>
            </a>
            <div class="dropdown-menu dropdown-alerts" >
<!--             	<div class="space-25"></div> -->
            	<h4 class="ks-stat-title"><i class="fa fa-dashboard text-navy"></i>  근무기록통계</h4>
            	<ul class="folder-list m-b-md" style="padding: 0">
	                <li><i class="fa fa-check-square-o text-navy"></i> 대상기간  <span class="label label-primary pull-right arange"></span> </li>
	                <li><i class="fa fa-check-square-o text-navy"></i> 보유연차  <span class="label label-primary pull-right availCount"></span> </li>
	                <li><i class="fa fa-check-square-o text-navy"></i> 사용연차 <span class="label label-info pull-right usedCount"></span> </li>
	                <li class="instep"><i class="fa fa-caret-right"></i> 휴가  <span class="usedLeave badge badge-info">0</span>&nbsp; 반휴  <span class="usedHlLeave badge badge-info">0</span></li>
	                <li><i class="fa fa-check-square-o text-navy"></i> 차감연차 <span class="label label-danger pull-right subCount">0</span></li>
	                <li class="instep"><i class="fa fa-caret-right"></i> 지각  <span class="subLate badge label-danger">0</span> (단지각 <span class="subShort badge badge-warning">0</span>, 장지각 <span class="subLong badge badge-warning">0</span>)</li>
	                <li class="instep"><i class="fa fa-caret-right"></i> 근무시간미준수 <span class="subFailTm badge label-danger">0</span> 무단결근  <span class="subAbsence badge label-danger">0</span></li>
	                <li><i class="fa fa-check-square-o text-navy"></i> 잔여연차 <span class="label label-success pull-right currCount"></span> </li>
	                <li><i class="fa fa-check-square-o text-navy"></i> 이달 대체근무 가능일수  <span class="label label-primary pull-right currReplace"></span> </li>
                </ul>

            </div>
        </li>


        <li>
            <a href="<c:url value="/logout"/>">
                <i class="fa fa-sign-out"></i> Log out
            </a>
        </li>
<!--         <li> -->
<!--             <a class="right-sidebar-toggle"> -->
<!--                 <i class="fa fa-tasks"></i> -->
<!--             </a> -->
<!--         </li> -->
    </ul>

</nav>
</div>

<script>
$(document).ready(function(){


	$("#scoreDropDown").on("show.bs.dropdown", function(event){

		$.ajax({
			url : "<c:url value='/stat/scoreAjax'/>",
			type : 'POST',
			dataType : 'json',
			success : function(data){
				$('.folder-list .availCount').text(data.availCount);
				$('.folder-list .arange').text(data.startDt +" ~ " + data.endDt);
 				$('.folder-list .currCount').text(data.currCount);
 				//연차사용
 				$('.folder-list .usedCount').text(data.usedCount);
 				$('.folder-list .usedLeave').text(data.usedLeave);
 				$('.folder-list .usedHlLeave').text(data.usedHlLeave);
 				//연차차감
 				$('.folder-list .subCount').text(data.subCount);
 				$('.folder-list .subLate').text(data.subLate);
 				$('.folder-list .subShort').text(data.subShort+'회');
 				$('.folder-list .subLong').text(data.subLong+'회');
 				$('.folder-list .subFailTm').text(data.subFailTm);
 				$('.folder-list .subAbsence').text(data.subAbsence);
 				//잔여대체근무
 				$('.folder-list .currReplace').text(data.currReplace+'일');
			}
		});


    });

	$("#scoreDropDown").on("hide.bs.dropdown", function(event){
		$('.folder-list .label').text('0');
	});
})

</script>