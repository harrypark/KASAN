<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>직원관리</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>직원목록</h5>
           <div class="ibox-tools">
               <a class="collapse-link">
                   <i class="fa fa-chevron-up"></i>
               </a>
           </div>
       </div>
       <div class="ibox-content">
       	 <div class="row well">
	       	  <form id="searchParam" name="searchParam">
	       	  <div class="form-group">
                <div class="col-lg-2 col-md-6 col-sm-12">
                	<input type="text" placeholder="성명  or email" class="input form-control" name="searchText" id="searchText"/>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchDept" name="searchDept">
                        <option value="all">부서_전체</option>
                        <c:forEach items="${deptList}" var="list">
                        	<option value="${list.code }">${list.name }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchPosition" name="searchPosition">
                        <option value="all">직급_전체</option>
                        <c:forEach items="${positionList}" var="list">
                        	<option value="${list.code }">${list.name }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchState" name="searchState">
                        <option value="all">상태_전체</option>
                        <c:forEach items="${stateList}" var="list">
                        	<option value="${list.code }">${list.name }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchAuth" name="searchAuth">
                        <option value="all">권한_전체</option>
                        <c:forEach items="${authList}" var="list">
                        	<option value="${list.code }">${list.name }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                 <button type="button" class="btn btn-w-m btn-primary" id="btnSearch" >검색</button>
<!--                  <button type="button" class="btn btn-w-m btn-primary" id="btnReset" style="display: none;">초기화</button> -->
                </div>
              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="user_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th>ID</th>
			            <th>캡스ID</th>
			            <th>캡스성명</th>
			            <th>로그인ID</th>
			            <th>부서</th>
			            <th>직급</th>
			            <th>이메일</th>
			            <th>상태</th>
			            <th>권한</th>
			            <th>상태표시</th>
			            <th>내선번호</th>
			            <th>입사일</th>
			            <th>등록자</th>
			            <th>등록일</th>
			            <th>수정자</th>
			            <th>수정일</th>
			        </tr>
			        </thead>
			        <tbody>
			        <!-- Data list here -->
			        </tbody>
			        </table>
			  </div>
               <!-- dataTable end -->
   			</div>
        </div>
     </div>

</div>

<!-- Modal (user) start  -->
<div class="modal inmodal fade modal_user" id="modal_user" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">직원관리</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.
	                            	<br/>캡스ID, 캡스성명은 정확하게 입력하세요.
	            </p>
	        </div>
	        <form class="form-horizontal" name="userForm" id="userForm" action="">
	        <input type="hidden" name="id" id="id" value="0"/>
	        <div class="modal-body">
	        	<div class="form-group"><label class="col-sm-3 control-label">캡스ID <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="capsId" id="capsId" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">캡스성명 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="capsName" id="capsName" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">로그인ID <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="loginId" id="loginId" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">부서  <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="deptCd" name="deptCd">
	                        <option value="">선택</option>
	                        <c:forEach items="${deptList}" var="list">
	                        	<option value="${list.code }">${list.name }</option>
	                        </c:forEach>
	                    </select>
	                </div>
	            </div>
	             <div class="form-group"><label class="col-sm-3 control-label">직급  <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="positionCd" name="positionCd">
	                        <option value="">선택</option>
	                        <c:forEach items="${positionList}" var="list">
	                        	<option value="${list.code }">${list.name }</option>
	                        </c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">email<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="email" id="email" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">상태  <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-3">
	                	<select class="form-control chosen" id="stateCd" name="stateCd">
	                        <option value="">선택</option>
	                        <c:forEach items="${stateList}" var="list">
	                        	<option value="${list.code }">${list.name }</option>
	                        </c:forEach>
	                    </select>
	                </div>
	                <label class="col-sm-3 control-label">휴직적용일  <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-3" id="applyDt">
	                	<input type="text" name="stateApplyDt" id="stateApplyDt" class="form-control" disabled="disabled">
	                </div>
	            </div>
<!-- 	            <div class="form-group"><label class="col-sm-3 control-label">휴직 시작일 <i class="fa fa-check-circle-o text-danger"></i></label> -->
<!-- 	                <div class="col-sm-9"><input type="text" name="stateApplyDt" id="stateApplyDt" class="form-control""></div> -->
<!-- 	            </div> -->
	            <div class="form-group"><label class="col-sm-3 control-label">권한  <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="authCd" name="authCd">
	                        <option value="">선택</option>
	                        <c:forEach items="${authList}" var="list">
	                        	<option value="${list.code }">${list.name }</option>
	                        </c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">상태표시  <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="dashState" name="dashState">
                        	<option value="Y">Yes</option>
                        	<option value="N">No</option>
	                    </select>
	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">내선번호 </label>
	                <div class="col-sm-9"><input type="text" name="insideTel" id="insideTel" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">입사일 <i class="fa fa-check-circle-o text-danger"></i> </label>
	                <div class="col-sm-9"><input type="text" name="hireDt" id="hireDt" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">비밀번호초기화 </label>
	                <div class="col-sm-9"><a id="btnPassword" class="btn btn-primary m-b">초기화</a></div>
	            </div>
	         </div>

	        <div class="modal-footer">
	            <a class="btn btn-white" id="btnCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnSave">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (user) end  -->
<!-- Date range use moment.js same as full calendar plugin -->
<script src="<c:url value="/resources/js/moment.js"/>"></script>
<!-- Data picker -->
<%-- <script src="<c:url value="/resources/js/plugins/datapicker/bootstrap-datepicker.js"/>"></script> --%>


<!-- Page-Level Scripts -->
    <script>
    var user_table;
    var clickRow;
    $(document).ready(function(){
    	user_table = $('#user_table').dataTable({
    		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '직원관리_'+moment().format('YYYYMMDDHHmmss')},
                //{extend: 'pdf', title: 'ExampleFile'},
                {extend: 'print',
                 customize: function (win){
                        $(win.document.body).addClass('white-bg');
                        $(win.document.body).css('font-size', '10px');
                        $(win.document.body).find('table')
                                .addClass('compact')
                                .css('font-size', 'inherit');
                }
                }
            ],
    	"iDisplayLength": 10
    	,"bFilter" : true
		, "bPaginate": true
		//, "sPaginationType" : "bootstrap_full"
		, "bRetrieve": true
		, "bDeferRender": false
		, "aaSorting": [[ 0, "asc" ]]
   			,"autoWidth": false

		});
    	$('div#user_table_wrapper div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" type="button" data-toggle="modal"  data-keyboard="false" data-backdrop="static" data-target="#modal_user" style="margin-bottom: 0px;"> Add </button>');

    	userList();

    	$('#btnSearch').click(function(){
    		userList();
    	});
    	$('#btnCancel').click(function(){
    		userFormReset();
    	});

    	$('#stateCd').change(function(){
    		if($(this).val() == '003'){
    			alert('퇴직으로 변경하면 근태통계에서 제외되고, capsId도 변경됩니다. \n 원복도 불가능합니다.');
    		}
    	})


    	$('div.wrapper-content').on('click','table#user_table tbody tr',function(){
    		 clickRow = user_table.fnGetPosition(this);
    		if( clickRow != null){
    			var rowData = user_table.fnGetData(this); // 선택한 데이터 가져오기
    			//console.log(rowData[0]);
     			$("#btnSave").removeClass('registBt').addClass('modifyBt');
    			$.ajax({
    				url : "<c:url value='/management/userDetailAjax'/>",
    				data : {searchId : rowData[0]},
    				type : 'POST',
    				dataType : 'json',
    				success : function(data){
    					$('#userForm #id').val(data.id);
    					$('#capsId').val(data.capsId).attr("disabled",true);
    					$('#capsName').val(data.capsName).attr("disabled",true);
    					$('#loginId').val(data.loginId).attr("disabled",true);
    					$('#deptCd').val(data.deptCd);
    					$('#positionCd').val(data.positionCd);
    					$('#email').val(data.email);
    					$('#stateCd').val(data.stateCd);
						if(data.stateCd == '003'){//퇴직은 상태 변경불가
							$('#stateCd').attr("disabled",true);
							$('#btnSave').hide();
    					}
						$('#stateApplyDt').val('').attr("disabled",true);
						if(data.stateCd == '002'){//휴직
							$('#stateApplyDt').val(data.stateApplyDt).attr("disabled",false);
    					}
    					$('#authCd').val(data.authCd);
    					$('#dashState').val(data.dashState);
    					$('#insideTel').val(data.insideTel);
    					$('#hireDt').val(data.hireDt);

    				}
    			});
    			$('#modal_user').modal('show');

    		}
    	});

    	$('#modal_user').on('show.bs.modal', function (event) {
    		//console.log($("#btnSave").hasClass('registBt'));
    		if($("#btnSave").hasClass('registBt')){
        		$("#availAnnualCnt").val('0').attr("disabled",false);
    		}else{
        		$("#availAnnualCnt").val('0').attr("disabled",true);
    		}
  		})

		$('#btnSave').click(function(e){
	   		e.preventDefault();
	   		if($('#userForm').valid()){
	   			if($(this).hasClass('registBt')){
	   				registUser();
	   			}else{
	   				editUser();
	   			}
	   		};
	   	});

    	$('#stateApplyDt, #hireDt').datepicker({
    		format: 'yyyy-mm-dd',
    		language: "kr",
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            todayHighlight: true
        })
//         .on('hide', function(e) {
//         	$(this).blur();
//         	if($(this).val()==''){
//  	        	$(this).val(moment().format('YYYY-MM-DD'));
//  	        }
//         });

		$('#stateCd').change(function(){
			var val = $(this).val();
			if(val == '002'){
				$('#stateApplyDt').val('').attr('disabled',false);
				alert('휴직상태로 변경하고 저장하시면,적용일 이후 통계 데이터는 모두 삭제 됩니다.');
			}else{
				$('#applyDt label.error').hide();
		    	$('#applyDt .form-control').removeClass('error');
				$('#stateApplyDt').val('').attr('disabled',true);
			}
		})

    	$("#userForm").validate({
    		rules: {
    			capsId: { required: true }
		    	,capsName: { required: true }
		    	,loginId: { required: true }
		    	,deptCd: { required: true }
		    	,positionCd: { required: true }
		    	,email: { required: true, email:true }
		    	,stateCd: { required: true }
		    	,stateApplyDt: { required: true }
		    	,authCd: { required: true }
		    	,hireDt: { required: true }
		    	,availAnnualCnt: { required: true, number:true }
          }
    	});


    	$('#btnPassword').click(function(){
    		if (confirm("비밀번호를 초기화 하시겠습니까?")){
    			$.ajax({
    				url: "<c:url value='/management/userPwdInitAjax'/>",
    				data: $("#userForm").serialize(),
    				type: 'POST',
    				dataType: 'json',
    				beforeSend: function () {
    		        },
    		        complete: function () {
    		        },
    				success: function(data){
    					if(data == 'success'){
    						alert("비밀번호가 초기화 되었습니다.")
    					}
    				}
    			});

    		}
    	})




    });


      function userList(){
       	$.ajax({
			url: "<c:url value='/management/userListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				user_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				user_table.fnDraw();
			}
		});
       }


    function fnClickAddRow(data){
    	var a = user_table.fnAddData( [
					data.id, data.capsId, data.capsName,data.loginId, data.deptName, data.positionName,data.email,data.stateName,data.authName,data.dashState,data.insideTel,data.hireDt,data.crtdId,data.crtdDt,data.mdfyId,data.mdfyDt
				], true);

    }
    function fnClickUpdateRow(data){
    	user_table.fnUpdate( [
					data.id, data.capsId, data.capsName,data.loginId, data.deptName, data.positionName,data.email,data.stateName,data.authName,data.dashState,data.insideTel,data.hireDt,data.crtdId,data.crtdDt,data.mdfyId,data.mdfyDt
				], clickRow);
    }
    function userFormReset(){
    	$('#id').val('0');
		$('#capsId').val('').attr("disabled",false);
		$('#capsName').val('').attr("disabled",false);
		$('#loginId').val('').attr("disabled",false);
		$('#deptCd').val('');
		$('#positionCd').val('');
		$('#email').val('');
		$('#stateCd').val('').attr("disabled",false);
		$('#stateApplyDt').val('').attr('disabled',true)
		$('#authCd').val('');
		$('#insideTel').val('');
		$('#hireDt').val('');
		$('#dashState').val('Y');
		$("#btnSave").removeClass('modifyBt').addClass('registBt');
		$("#availAnnualCnt").val('0').attr("disabled",false);
		$('#btnSave').show();


    	$('label.error').hide();
    	$('.form-control').removeClass('error');

		$('#modal_user').modal('hide');
    }

    function registUser(){
    	if($('#stateCd').val() == '003'){
    		alert('신규직원을 퇴직상태로 등록 할 수 없습니다.');
    		return;
    	}
		$.ajax({
			url: "<c:url value='/management/userInsertAjax'/>",
			data: $("#userForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				if(data.isDuplicateCaps == true){
					alert("이미 사용중인 캡스정보 입니다.");
				}else if(data.isDuplicateLoginId == true){
					alert("이미 사용중인 로그인ID 입니다.");
				}else{
					//console.log(data);
					fnClickAddRow(data);
					userFormReset();
				}
			}
		});
	}

    function editUser(){
		$.ajax({
			url: "<c:url value='/management/userEditAjax'/>",
			data: $("#userForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				fnClickUpdateRow(data);
				userFormReset();
			}
		});
}



    </script>
</body>