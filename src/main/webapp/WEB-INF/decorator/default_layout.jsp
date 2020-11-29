<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
response.setHeader("Cache-Control", "no-cache");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>근태관리 | 가산</title>

    <link href="<c:url value="/resources/css/bootstrap.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/font-awesome/css/font-awesome.css"/>" rel="stylesheet">

    <link href="<c:url value="/resources/css/plugins/jQueryUI/jquery-ui.css"/>" rel="stylesheet">

    <!-- Toastr style -->
    <link href="<c:url value="/resources/css/plugins/toastr/toastr.min.css"/>" rel="stylesheet">

    <!-- Gritter -->
    <link href="<c:url value="/resources/js/plugins/gritter/jquery.gritter.css"/>" rel="stylesheet">

    <link href="<c:url value="/resources/css/animate.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/style.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/kasan.css"/>" rel="stylesheet">

    <link href="<c:url value="/resources/css/plugins/dataTables/datatables.min.css"/>" rel="stylesheet">

<%--     <link href="<c:url value="/resources/css/plugins/daterangepicker/daterangepicker2.css"/>" rel="stylesheet"> --%>
    <link href="<c:url value="/resources/css/plugins/datapicker/datepicker3.css"/>" rel="stylesheet">
<!-- 	<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" /> -->
    <link href="<c:url value="/resources/css/plugins/clockpicker/clockpicker.css"/>" rel="stylesheet">

    <link href="<c:url value="/resources/css/plugins/fullcalendar/fullcalendar.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/plugins/fullcalendar/fullcalendar.print.css"/>" rel='stylesheet' media='print'>

     <!-- Mainly scripts -->
    <script src="<c:url value="/resources/js/jquery-2.1.1.js"/>"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/resources/js/plugins/metisMenu/jquery.metisMenu.js"/>"></script>
    <script src="<c:url value="/resources/js/plugins/slimscroll/jquery.slimscroll.min.js"/>"></script>
    <script src="<c:url value="/resources/js/kasan.js"/>"></script>


    <!-- Custom and plugin javascript -->
    <script src="<c:url value="/resources/js/inspinia.js"/>"></script>
    <script src="<c:url value="/resources/js/plugins/pace/pace.min.js"/>"></script>

    <!-- jQuery UI -->
    <script src="<c:url value="/resources/js/plugins/jquery-ui/jquery-ui.min.js"/>"></script>

    <script src="<c:url value="/resources/js/plugins/dataTables/datatables.min.js"/>"></script>

    <script src="<c:url value="/resources/js/plugins/jquery-validate/jquery.validate.js"/>"></script>

    <!-- Date range use moment.js same as full calendar plugin -->
	<script src="<c:url value="/resources/js/moment.js"/>"></script>
	<!-- Data picker -->
	<script src="<c:url value="/resources/js/plugins/datapicker/bootstrap-datepicker.js"/>"></script>
	<script src="<c:url value="/resources/js/plugins/datapicker/bootstrap-datepicker.kr.js"/>"></script>
	<!-- Date range picker -->
<%-- 	<script src="<c:url value="/resources/js/plugins/daterangepicker/daterangepicker2.js"/>"></script> --%>
	<!-- Clock picker -->
    <script src="<c:url value="/resources/js/plugins/clockpicker/clockpicker.js"/>"></script>
<%-- 	<script src="<c:url value="/resources/js/plugins/timepicker/jquery.timepicker.js"/>"></script> --%>

	<script src="<c:url value="/resources/js/plugins/jQueryTimeAutocomplete/jquery.timeAutocomplete.js"/>"></script>
	<script src="<c:url value="/resources/js/plugins/jQueryTimeAutocomplete/formatters/24hr.js"/>"></script>


	   <!-- Toastr -->
    <script src="<c:url value="/resources/js/plugins/toastr/toastr.min.js"/>"></script>
    <script>
    <c:if test="${empty capsName}">
    	location.href='<c:url value="/login"/>';
    </c:if>

    </script>

</head>

<body>
    <div id="wrapper">
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse" id="side_menu">

                    <div class="nav-header">
<!--                     	<span>KASAN근태관리</span> -->
                    </div>
                    <ul class="nav metismenu" id="side-menu">
                    	<c:if test="${authCd ne '003'}">
	                    <li>
	                        <a href="<c:url value="/dashboard"/>" class="menu"><i class="fa fa-th-large"></i> <span class="nav-label">대시보드 </span></a>
	                    </li>
	                    <li>
	                        <a href="<c:url value="/dashboard/calendar"/>" class="menu"><i class="fa fa-calendar"></i> <span class="nav-label">일정캘린더 </span></a>
	                    </li>
	                    <li>
	                        <a href="<c:url value="/dashboard/private"/>" class="menu"><i class="fa fa-search"></i> <span class="nav-label">일정검색</span></a>
	                    </li>
	                    </c:if>
	                    <c:choose>
	                    	<c:when test="${authCd ne '003'}">
		                    <li>
		                        <a href="<c:url value="/app/workoutSide"/>" class="menu"><i class="fa fa-briefcase"></i> <span class="nav-label">외근공지 </span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/app/leave"/>" class="menu"><i class="fa fa-refresh"></i> <span class="nav-label">휴가반휴</span>  </a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/app/replace"/>" class="menu"><i class="fa fa-exchange"></i> <span class="nav-label">대체근무</span>  </a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/app/businessTrip"/>" class="menu"><i class="fa fa-plane"></i> <span class="nav-label">출장관리 </span></a>
		                    </li>
		                    <c:if test="${authCd eq '001'}">
		                    <li>
		                        <a href="<c:url value="/stat/uDailyStat"/>" class="menu"><i class="fa fa-bar-chart-o"></i><span class="nav-label">근태확인 </span></a>
		                    </li>
		                    </c:if>
		                    <c:if test="${authCd eq '002'}">
		                    <li>
		                        <a href="<c:url value="/stat/mDailyStat"/>" class="menu"><i class="fa fa-bar-chart-o"></i><span class="nav-label">근태확인 </span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/stat/mScoreStat"/>" class="menu"><i class="fa fa-bar-chart-o"></i> <span class="nav-label">근태점수 </span></a>
		                    </li>
		                    </c:if>
		                    <li>
		                        <a href="<c:url value="/overtime/ulist"/>" class="menu"><i class="fa fa-clock-o"></i> <span class="nav-label">야근신청 </span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/reservation/meeting_room/001/list/"/>" class="menu"><i class="fa fa-slideshare"></i> <span class="nav-label">회의실예약 </span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/reservation/business_car/001/list/"/>" class="menu"><i class="fa fa-car"></i> <span class="nav-label">업무차량예약</span></a>
		                    </li>
		                    <li>
		                        <a href="javascript:regulationDown();" class="menu"><i class="fa fa-file-pdf-o"></i> <span class="nav-label">사규보기 </span></a>
		                    </li>
	                    	</c:when>
	                    	<c:otherwise>
	                    	<li>
		                        <a href="<c:url value="/stat/aDailyStat"/>" class="menu"><i class="fa fa-bar-chart-o"></i> <span class="nav-label">근태확인</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/stat/aScoreStat"/>" class="menu"><i class="fa fa-bar-chart-o"></i> <span class="nav-label">근태점수 </span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/stat/lateStat"/>" class="menu"><i class="fa fa-bar-chart-o"></i> <span class="nav-label">지각통계 </span></a>
		                    </li>
	                    	<li>
		                        <a href="<c:url value="/overtime/alist"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">야근신청</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/management/user"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">직원관리</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/management/sendMail"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">메일관리</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/management/managerDept"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">매니져-부서관리</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/management/deptDepts"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">부서-부서관리</span></a>
		                    </li>
<!-- 		                    <li> -->
<%-- 		                        <a href="<c:url value="/management/annual"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">연차관리</span></a> --%>
<!-- 		                    </li> -->
		                    <li>
		                        <a href="<c:url value="/management/autoAannual"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">자동연차관리</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/management/rules"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">규칙관리</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/management/holiday"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">달력관리</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/management/code"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">코드관리</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/management/rawData"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">Raw Data</span></a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/management/regulation"/>" class="menu"><i class="fa fa-desktop"></i> <span class="nav-label">사규관리</span></a>
		                    </li>
	                    	</c:otherwise>
	                    </c:choose>
	                </ul>

            </div>
        </nav>

        <div id="page-wrapper" class="gray-bg dashbard-1">
        <!-- navi start -->
        <jsp:include page="include_navi.jsp"/>
        <!-- navi end -->
         <div id="content"><sitemesh:write property='body'/></div>
        </div>
    </div>
    <iframe name="downloadFrame" style="display:none;"></iframe>
    <form id="fileForm" method="post">
		<input type="hidden" id="fileId" name="fileId" />
	</form>




    <script>
    var contextRoot = '<c:url value="/"/>';

        $(document).ready(function() {

        	checkURL();
			/*
        	$('#side-menu li.a').click(function(){
        		console.log(location.hash);
        	});


            setTimeout(function() {
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeOut: 4000
                };
                toastr.success('Responsive Admin Theme', 'Welcome to INSPINIA');

            }, 1300);

			*/


        });

        function regulationDown(){
    		var url = "<c:url value='/management/fileDownloadAjax'/>";
    		var form = $("#fileForm");
    		$("input:hidden[id=fileId]", form).val(-1);
			form.attr("action", url);
			form.attr("target", "downloadFrame");
			form.get(0).submit();
        }


    </script>
</body>
</html>
