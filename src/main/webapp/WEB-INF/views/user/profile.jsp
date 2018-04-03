     <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>내정보</h2>
    </div>
</div>
<!-- title end -->
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <!-- Personal Information start -->
             	<div class="ibox">
               	<div class="ibox-content">
               	<form class="form-horizontal" name="userForm" id="userForm" action="">
               		<div class="form-group"><label class="col-sm-7 control-label text-info">정보 변경은 관리자에게 문의 하세요.</label>

		            </div>
               		<div class="form-group"><label class="col-sm-2 control-label">캡스ID <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="text" name="capsId" id="capsId" class="form-control" readonly="readonly" value="${user.capsId }"></div>
		            </div>
		            <div class="form-group"><label class="col-sm-2 control-label">캡스성명 <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="text" name="capsName" id="capsName" class="form-control" readonly="readonly" value="${user.capsName}"></div>
		            </div>
		            <div class="form-group"><label class="col-sm-2 control-label">로그인ID <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="text" name="loginId" id="loginId" class="form-control" readonly="readonly" value="${user.loginId}"></div>
		            </div>
		            <div class="form-group"><label class="col-sm-2 control-label">부서 <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="text" name="deptName" id="deptName" class="form-control" readonly="readonly" value="${user.deptName}"></div>
		            </div>
		            <div class="form-group"><label class="col-sm-2 control-label">직급 <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="text" name="positionName" id="positionName" class="form-control" readonly="readonly" value="${user.positionName}"></div>
		            </div>
		            <div class="form-group"><label class="col-sm-2 control-label">email <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="text" name="email" id="email" class="form-control" readonly="readonly" value="${user.email}"></div>
		            </div>
		            <div class="form-group"><label class="col-sm-2 control-label">상태 <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="text" name="stateName" id="stateName" class="form-control" readonly="readonly" value="${user.stateName}"></div>
		            </div>
		            <div class="form-group"><label class="col-sm-2 control-label">권한 <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="text" name="authName" id="authName" class="form-control" readonly="readonly" value="${user.authName}"></div>
		            </div>
		            <div class="hr-line-dashed"></div>


              	</form>

                 </div>
              </div>
	  <!-- Personal Information end -->
            </div>
        </div>
    </div>
<script>
$(document).ready(function(){

})

</script>


</body>
</html>
