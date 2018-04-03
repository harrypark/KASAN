     <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>비밀번호변경</h2>
    </div>
</div>
<!-- title end -->
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <!-- Personal Information start -->
             	<div class="ibox">
               	<div class="ibox-content">
               	<form class="form-horizontal" name="pwdForm" id="pwdForm" action="">
               	<input type="hidden" id="id" name="id" value="${id }"/>
               		<div class="form-group"><label class="col-sm-2 control-label">현재 비밀번호 <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="password" name="oldPassword" id="oldPassword" class="form-control"></div>
		            </div>
		            <div class="form-group"><label class="col-sm-2 control-label">변경 비밀번호 <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="password" name="newPassword" id="newPassword" class="form-control"></div>
		            </div>
		            <div class="form-group"><label class="col-sm-2 control-label">변경 비밀번호 <i class="fa fa-check-circle-o text-danger"></i></label>
		                <div class="col-sm-5"><input type="password" name="confirmNewPassword" id="confirmNewPassword" class="form-control" ></div>
		            </div>
		            <div class="hr-line-dashed"></div>
		            <div class="form-group">
		                <div class="col-sm-7 text-center"><a id="btnChange" class="btn btn-primary m-b">변경</a></div>
		            </div>

              	</form>

                 </div>
              </div>
	  <!-- Personal Information end -->
            </div>
        </div>
    </div>





<script>

var passwordSize = 8;
$(document).ready(function(){
	$('#btnChange').click(function(){
		if($("#pwdForm").valid()){
			pwdChange();
		}
	})



  	$("#pwdForm").validate({
  	// rules
   	    rules: {
   	    	oldPassword: {
   	    		required: true
   	    	},
   	    	newPassword: {
   	            required: true,
   	            minlength: passwordSize
   	        },
   	     confirmNewPassword: {
   	            required: true,
   	            minlength: passwordSize,
   	         	equalTo: "#newPassword"
   	            //passwordMatch: true // set this on the field you're trying to match
   	        }
   	    },
   	    messages: {
   	    	oldPassword: {
   	    		required: "현재 비밀번호를 입력 하세요."
   	    	},
   	    	newPassword: {
   	            required: "변경 할 비밀번호를 입력 하세요.",
   	            minlength: "비밀번호는 "+passwordSize+"자이상 입력하세요."
   	        },
   	     confirmNewPassword: {
   	            required: "변경 할 비밀번호를 한번더 입력 하세요.",
   	            minlength: "비밀번호는 "+passwordSize+"자이상 입력하세요.",
   	         	equalTo: "신규 비밀번호가 일치 하지 않습니다." // custom message for mismatched passwords
   	        }
   	    }
  	})

  	function pwdChange(){
		$.ajax({
			url: "<c:url value='/user/pwdChangeAjax'/>",
			data: $("#pwdForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				if(data == 'success'){
					alert("비밀번호가 변경 되었습니다.");
				}else{
					alert("비밀번호가 변경에 실패 했습니다.");
				}
			}
		});

	}


})
  </script>


</body>
</html>
