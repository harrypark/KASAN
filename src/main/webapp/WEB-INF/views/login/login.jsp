<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>근태관리 | Login</title>

	<link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/font-awesome/css/font-awesome.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/css/animate.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/css/style.css"/>" rel="stylesheet">

</head>

<body class="gray-bg">

    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <div>

                <h1 class="logo-name">KASAN</h1>

            </div>
<!--             <h3>Welcome to IN+</h3> -->
<!--             <p>Perfectly designed and precisely prepared admin theme with over 50 pages with extra new web app views. -->
<!--                 Continually expanded and constantly improved Inspinia Admin Them (IN+) -->
<!--             </p> -->
<!--             <p>Login in. To see it in action.</p> -->
            <form class="m-t" role="form" name="loginForm" id="loginForm">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="아이디" required name="loginId" id="loginId">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="비밀번호" required name="loginPwd" id="loginPwd">
                </div>
                <button type="submit" id="btnLogin" class="btn btn-primary block full-width m-b">로그인</button>

<!--                 <a href="#"><small>Forgot password?</small></a> -->
<!--                 <p class="text-muted text-center"><small>Do not have an account?</small></p> -->
<!--                 <a class="btn btn-sm btn-white btn-block" href="register.html">Create an account</a> -->
            </form>
            <p class="m-t"> <small>COPYRIGHT©2016 KASAN ALL RIGHTS RESERVED.</small> </p>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="<c:url value="/resources/js/jquery-2.1.1.js"/>"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>



	<script src="<c:url value="/resources/js/plugins/jquery-validate/jquery.validate.js"/>"></script>

	<script>
	$(document).ready(function(){


		$('#btnLogin').click(function(e){
			//e.preventDefault();
			$("#loginForm").valid();
		})

	  	$("#loginForm").validate({
	  	// rules
	   	    rules: {
	   	    	loginId: {
	   	    		required: true
	   	    	},
	   	    	loginPwd: {
	   	            required: true
	   	        }
	   	    },
	  		submitHandler: function(form) {
				//console.log('submit');
// 				if($('#loginId').val() != 'admin'){
// 					alert('작업중. 관리자만 로그인 가능 합니다.');
// 					return;
// 				}
				$.ajax({
					url: "<c:url value='/loginCheckAjax'/>",
					data: $("#loginForm").serialize(),
					type: 'POST',
					dataType: 'json',
					beforeSend: function () {
			        },
			        complete: function () {
			        },
					success: function(data){
						console.log(data);
						if(data.isLogin){
							if(data.isFirstLogin){
								alert("첫번째 방문, 비밀번호를 변경하세요.");
								location.href='<c:url value="/user/pwdChange"/>';
							}else{
								location.href='<c:url value="/index"/>';
							}
						}else{
							alert("로그인 정보를 확인하세요.")
						}

					}
				});
	  	     }
	  	})
	})

	function loginFailAlert(){
		html='<div class="alert alert-danger alert-dismissable">';
	    html=html+'   <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>';
	    html=html+'   Your email and password didn\'t match. Please try again <br/>(make sure your caps lock is off)</div>';
	    $('p.loginfail').html(html);
	}

	</script>
</body>

</html>
