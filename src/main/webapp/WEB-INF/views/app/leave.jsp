<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>휴가/반휴</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>휴가/반휴</h5>
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
                <div class="col-lg-3 col-md-6 col-sm-6">
                	<div class="input-group input-daterange search-daterange">
					    <input type="text" class="form-control trap" id="fromDate" name="fromDate" readonly="readonly"/>
					    <span class="input-group-addon">to</span>
					    <input type="text" class="form-control trap" id="toDate" name="toDate" readonly="readonly">
					</div>
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
                    <select class="form-control chosen" id="searchUser" name="searchUser">
                        <option value="all">전체</option>
                    </select>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
                	<button class="btn btn-w-m btn-primary m-r-sm" data-toggle="modal" data-backdrop="static" type="button"  data-target="#modal_leave" data-backdrop="static" id="btn1" style="display: none;"> Add </button>
                	<button class="btn btn-w-m btn-primary m-r-sm" data-toggle="modal" data-backdrop="static" type="button"  data-target="#modal_halfLeave" data-backdrop="static" id="btn2" style="display: none;"> Add </button>

                </div>
              </div>
              </form>
          </div>
			<div class="row">
				<div class="tabs-container">
	                   <ul class="nav nav-tabs" id="leaveTab">
	                       <li class="tab-1"><a data-toggle="tab" href="#tab-1" id="leave">휴가</a></li>
	                       <li class="tab-2"><a data-toggle="tab" href="#tab-2" id="halfLeave">반휴</a></li>
	                   </ul>
	                   <div class="tab-content">
	                       <div id="tab-1" class="tab-pane">
	                           <div class="panel-body">
	                               <!-- dataTable start -->
	                               <div class="table-responsive">
					                    <table id="leave_table" class="table table-striped table-bordered table-hover" >
					                    <thead>
					                    <tr>
					                        <th>ID</th>
					                        <th>등록자ID</th>
					                        <th>신청일</th>
					                        <th>기간(일)</th>
					                        <th>공가</th>
					                        <th>등록자</th>
					                        <th>등록일</th>
					                    </tr>
					                    </thead>
					                    <tbody>
					                    <!-- Leave list here -->
					                    </tbody>
					                    </table>
					              </div>
	                               <!-- dataTable end -->
	                           </div>
	                       </div>
	                       <div id="tab-2" class="tab-pane">
	                           <div class="panel-body">
	                           	<!-- dataTable start -->
	                               <div class="table-responsive">
					                    <table id="halfLeave_table" class="table table-striped table-bordered table-hover" >
					                    <thead>
					                    <tr>
					                        <th>ID</th>
					                        <th>등록자ID</th>
					                        <th>신청일</th>
					                        <th>기간(일)</th>
					                        <th>공가</th>
					                        <th>등록자</th>
					                        <th>등록일</th>
					                    </tr>
					                    </thead>
					                    <tbody>
					                    <!-- Halfleave List here -->
					                    </tbody>
					                    </table>
					              </div>
	                               <!-- dataTable end -->
	                           </div>
	                       </div>
	                   </div>
	             </div>
   			</div>
        </div>
     </div>

</div>

<!-- Modal (leave) start  -->
<div class="modal inmodal fade modal_leave" id="modal_leave" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">휴가</h4>
	            <p style="font-weight: 300; margin-bottom: 5px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	            <p style="font-weight: 500; margin-bottom: 0px;" class="text-info">대상기간: ${score.startDt} ~ ${score.endDt}</p>
	        </div>
	        <form class="form-horizontal" name="leaveForm" id="leaveForm" action="">
	        <input type="hidden" name="id" id="id" value="0"/>
	        <div class="modal-body">
	            <div class="form-group"><label class="col-sm-3 control-label">기간<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
<!-- 	                <input type="text" name="leaveRange" id="leaveRange" class="form-control leave" readonly="readonly"> -->
						<div class="input-group input-daterange leave-daterange">
						    <input type="text" class="form-control trap" id="startDt" name="startDt" readonly="readonly"/>
						    <span class="input-group-addon">to</span>
						    <input type="text" class="form-control trap" id="endDt" name="endDt" readonly="readonly">
						</div>
	                </div>
	            </div>
	            <div class="form-group">
	            	<label class="col-sm-3 control-label">신청(일)</label>
	                <div class="col-sm-3"><input type="text" name="term" id="term" class="form-control" value="1" readonly="readonly"></div>
	            	<label class="col-sm-3 control-label curr">신청가능(일)</label>
	                <div class="col-sm-3 curr"><input type="text" name="curr" id="curr" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">공가여부</label>
	                <div class="col-sm-9"><input type="radio" name="offcial" class="leave" value="Y">예 &nbsp;&nbsp;<input type="radio" name="offcial" class="leave" value="N" checked="checked">아니오</div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">메모 </label>
	                <div class="col-sm-9"><textarea id="memo" name="memo" class="form-control leave"></textarea></div>
	            </div>
	         </div>

	        <div class="modal-footer">
	        	<a class="btn btn-danger pull-left" id="btnLeaveDelete" style="display: none;">Delete</a>
	            <a class="btn btn-white" id="btnleaveCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnleaveAdd">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (leave) end  -->

<!-- Modal (halfLeave) start  -->
<div class="modal inmodal fade modal_halfLeave" id="modal_halfLeave" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">반휴</h4>
	            <p style="font-weight: 300; margin-bottom: 10px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	            <p style="font-weight: 600; margin-bottom: 5px;" class="text-info"><i class="fa fa-check-circle-o text-info"></i> 반휴 신청시 출근시간은 15:00 이전이며,<br/> 메모란에 근무예정시간을 반드시 기재하시기 바랍니다.</p>
	            <p style="font-weight: 500; margin-bottom: 0px;" class="text-info">대상기간: ${score.startDt} ~ ${score.endDt}</p>
	        </div>
	        <form class="form-horizontal" name="halfLeaveForm" id="halfLeaveForm" >
	        <div class="modal-body">
	        	<div class="form-group rep-info re-info"><label class="col-sm-3 control-label"></label>
	                <div class="col-sm-9"><label class="text-danger"> <span id="hlDtInfo"></span> 에는 대체근무가 신청되어 있습니다. <br/>다른날을 선택하세요.</label></div>
	            </div>
	        	<div class="form-group"><label class="col-sm-3 control-label">신청일<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="hlDt" id="hlDt" class="form-control hl" readonly="readonly"></div>
	            </div>
	            <div class="form-group">
	                <label class="col-sm-3 control-label">신청(일)</label>
	                <div class="col-sm-3"><input type="text" name="term" id="term" class="form-control hl" value="0.5" readonly="readonly"></div>
	            	<label class="col-sm-3 control-label curr">신청가능(일)</label>
	                <div class="col-sm-3 curr"><input type="text" name="curr" id="curr" class="form-control hl" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">공가여부</label>
	                <div class="col-sm-9"><input type="radio" name="offcial" class="hl" value="Y">예 &nbsp;&nbsp;<input type="radio" name="offcial" class="leave" value="N" checked="checked">아니오</div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">메모 </label>
	                <div class="col-sm-9"><textarea id="memo" name="memo" class="form-control hl" placeholder="근무예정시간을 기재하세요. ex) 12:00 ~ 14:00"></textarea></div>
	            </div>

	         </div>

	        <div class="modal-footer">
	        	<a class="btn btn-danger pull-left" id="btnhalfLeaveDelete" style="display: none;">Delete</a>
	            <a class="btn btn-white" id="btnhalfLeaveCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnhalfLeaveAdd">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<form name="deleteForm" id="deleteForm">
<input type="hidden" id="id" name="id">
<input type="hidden" id="startDt" name="startDt">


</form>

<!-- Modal (halfLeave) end  -->
<script src="<c:url value="/resources/js/leave-script.js"/>"></script>

<!-- Page-Level Scripts -->
<script>
var leave_table;
var halfLeave_table
var clickRowleave;
var clickRowhalfLeave;
var annualMinusUseYn = '${annualMinusUseYn}';
   $(document).ready(function(){
	   //console.log(annualMinusUseYn);
	   var param = '${param.type}';
	   //console.log(param);
	   if(param == '2'){//반휴선택
		   $('.tab-2').addClass('active');
		   $('#tab-2').addClass('active');
		   $('#btn2').show();
		   gethalfLeave();
	   }else{//휴가선택
		   $('.tab-1').addClass('active');
		   $('#tab-1').addClass('active');
		   $('#btn1').show();
		   getleave();
	   }

	   $('.tab-1').click(function(){
		   $('#btn1').show();
		   $('#btn2').hide();
	   })
	   $('.tab-2').click(function(){
		   $('#btn2').show();
		   $('#btn1').hide();
	   })


	   $('.leave-daterange').datepicker({
	    	format: 'yyyy-mm-dd',
	   		language: "kr",
	   		startDate: 'today',
	   		endDate:'${score.endDt}',
           keyboardNavigation: false,
           forceParse: false,
           autoclose: true,
           todayHighlight: true
	    });

		$('#leaveForm #startDt, #leaveForm #endDt').val(moment().format('YYYY-MM-DD'));
		$('#leaveForm #startDt').datepicker('setDate', moment().format('YYYY-MM-DD'));
		$('#leaveForm #endDt').datepicker('setDate', moment().format('YYYY-MM-DD'));

		checkLeaveDayCount();

	   $('#leave').click(function(){
			getleave();
		});
		$('#halfLeave').click(function(){
			gethalfLeave();
		})

		/* 휴가등록 modal 달력에 영향을 준다.
		$('#leaveForm #startDt, #leaveForm #endDt').datepicker().on('show', function(e) {
			var startDt = $('#leaveForm #startDt').val();
	    	var endDt = $('#leaveForm #endDt').val();
			$('#leaveForm #startDt').datepicker('setDate', startDt);
			$('#leaveForm #endDt').datepicker('setDate', endDt);

		});
		*/
		$('#leaveForm #startDt, #leaveForm #endDt').datepicker().on('hide', function(e) {
			if($(this).val()==''){
 	        	$(this).val(moment().format('YYYY-MM-DD'));
 	        }

	    	//같은 년도인지 체크(년단위 신청가능)
// 	    	var startDt = $('#leaveForm #startDt').val();
// 	    	var endDt = $('#leaveForm #endDt').val();

// 			if(moment(startDt).format('YYYY') != moment(endDt).format('YYYY')){
// 				alert('휴가(연차)는 같은 연도 단위로 신청하세요.');
// 				$('#leaveForm #startDt').val(moment(startDt).format('YYYY-MM-DD'));
// 				$('#leaveForm #endDt').val(moment(startDt.substr(0,4)+'-12-31').format('YYYY-MM-DD'));
// 				$('#leaveForm #startDt').datepicker('setDate', moment(startDt).format('YYYY-MM-DD'));
// 				$('#leaveForm #endDt').datepicker('setDate', moment(startDt.substr(0,4)+'-12-31').format('YYYY-MM-DD'));

// 			}

			checkLeaveDayCount();

			checkAvailableAnnual('le');
	    });



   //휴가신청모달 open 가능 연차 체크
   $('#modal_leave').on('shown.bs.modal', function () {
	   checkAvailableAnnual('le');
   })



   function checkAvailableAnnual(type){
	   var searchDt=null;
	   if(type == 'hl'){
		   searchDt=$('#hlDt').val();
	   }
	   $.ajax({
			url : "<c:url value='/app/checkAvailableAnnualAjax'/>",
			type : 'POST',
			data : {searchDt:searchDt},
			dataType : 'json',
			success : function(data){
				if(data.result == 'fail'){
					alert('휴가(연차) 정보가 없습니다.');
					if(type=='le'){
						leaveFormReset();
					}else{
						halfLeaveFormReset();
					}


				}else{
					if(type=='le'){
						$('#modal_leave #curr').val(data.currCount);
					}else{
						$('#modal_halfLeave #curr').val(data.currCount);

						if(data.hasRe == 'yes'){
							$('.re-info').show();
							$('#hlDtInfo').text(searchDt);
							$('#btnhalfLeaveAdd').addClass('disabled');
						}else{
							$('.re-info').hide();
							$('#hlDtInfo').text('');
							$('#btnhalfLeaveAdd').removeClass('disabled');
						}
					}
				}
			}
		});
   }



	//add leave
	$('#btnleaveAdd').click(function(e){
		e.preventDefault();
		var offcial = $('#leaveForm :radio[name="offcial"]:checked').val();
		//console.log(offcial);
		if(offcial=='N' && annualMinusUseYn == 'N'){
			var c = $('#leaveForm #curr').val();
			var t = $('#leaveForm #term').val();

			if(t=='0' || parseFloat(c) < parseFloat(t)){
				alert('신청 가능일을 확인 하세요.');
				return;
			}


		}
		//같은 년도인지 체크(년단위 신청가능)
// 		var startDt = $('#leaveForm #startDt').val();
//     	var endDt = $('#leaveForm #endDt').val();


// 		if(moment(startDt).format('YYYY') != moment(endDt).format('YYYY')){
// 			alert('휴가(연차)는 같은 연도 단위로 신청하세요.');
// 			return;
// 		}

		if($('#leaveForm').valid()){
			if($(this).hasClass('registBt')){
				registleave();
			}else{
				editleave();
			}
		};
	});

	$("#leaveForm").validate({
		rules: {
			startDt: { required: true },
			endDt: { required: true },
			term: { required: true,number:true },
			offcial: { required: true }

	  }
	});

	$('div.tab-content').on('click','table#leave_table tbody tr',function(){
		 clickRowleave = leave_table.fnGetPosition(this);
		if( clickRowleave != null){
			var rowData = leave_table.fnGetData(this); // 선택한 데이터 가져오기
			if(rowData[1] != '${info.id}') return; //자신의 Id가 이니면 Exit

			//console.log(rowData[0]);
			if(deletePossibleCheck(rowData[2])){
   				$("#btnLeaveDelete").show();
   			}
			$('#leaveForm .leave').attr("disabled",true);
			$('#leaveForm .curr').hide();
			$("#btnleaveAdd").hide();

			$.ajax({
				url : "<c:url value='/app/leaveDetailAjax'/>",
				data : {searchId : rowData[0]},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#leaveForm #id').val(data.id);
					$('#leaveForm #term').val(data.term);
					$('#leaveForm #startDt').val(data.leDt);
					$('#leaveForm #endDt').val(data.leDt);

					$('#leaveForm input:radio[name=offcial]:radio[value="'+data.offcial+'"]').prop("checked", true);

					$('#leaveForm #memo').val(data.memo);

					$('#deleteForm #id').val(data.id);
					$('#deleteForm #startDt').val(data.startDt);

				}
			});
			$('#modal_leave').modal('show');

		}
	});

	$('#btnLeaveDelete').click(function(e){
		var leDt = $('#leaveForm #startDt').val();
		//console.log(leDt);
		if(deletePossibleCheck(leDt)==false){
			alert('지난 데이터는 삭제할 수 없습니다.');
			return;
		}
		if (confirm("삭제 하시겠습니까?")){
			$.ajax({
					url: "<c:url value='/app/leaveDeleteAjax'/>",
					data: $("#deleteForm").serialize(),
					type: 'POST',
					dataType: 'json',
					beforeSend: function () {
			        },
			        complete: function () {
			        },
					success: function(data){
						if(data==1){
		  					getleave();
		  					leaveFormReset();
						}else{
							alert("삭제 오류 발생.");
						}
					}
				});
		}
	});






	/** Half Leave ***********************************************************************************************************/


	$('#hlDt').datepicker({
		startDate: 'today',
		endDate: '${score.endDt}'
    }).val(moment().format('YYYY-MM-DD'));

	 //반휴신청모달 open 가능 연차 체크
   $('#modal_halfLeave').on('shown.bs.modal', function () {
	   checkAvailableAnnual('hl');
   })
	//반휴 날짜변경시 해당년도 연차정보 체크
   $('#hlDt').datepicker().on('changeDate', function(e) {
    	checkAvailableAnnual('hl');
    });


	//add halfLeave
	$('#btnhalfLeaveAdd').click(function(e){
		e.preventDefault();
		var offcial = $('#halfLeaveForm :radio[name="offcial"]:checked').val();
		//console.log(offcial);
		if(offcial=='N' && annualMinusUseYn == 'N'){
			var c = $('#halfLeaveForm #curr').val();
			var t = $('#halfLeaveForm #term').val();
			if(parseFloat(c) < parseFloat(t)){
				alert('신청 가능일을 확인 하세요.');
				return;
			}
		}


		if($('#halfLeaveForm').valid()){
			if($(this).hasClass('registBt')){
				registhalfLeave();
			}else{
				//edithalfLeave();
			}
		};
	});

	$("#halfLeaveForm").validate({
		rules: {
			hlDt: { required: true },
			offcial: {  required: true },
			memo: {  required: true }
	  },messages: {
		  hlDt: { required: "신청일을 선택하세요." },
		  offcial: {  required: "공가여부를 체크하세요." },
		  memo: {  required: "근무예정시간을 기재하세요. ex) 12:00 ~ 14:00" }
	  }

	});


	$('div.tab-content').on('click','table#halfLeave_table tbody tr',function(){
		 clickRowhalfLeave = halfLeave_table.fnGetPosition(this);
		if( clickRowhalfLeave != null){
			var rowData = halfLeave_table.fnGetData(this); // 선택한 데이터 가져오기
			if(rowData[1] != '${info.id}') return; //자신의 Id가 이니면 Exit
			//console.log(rowData[0]);
			if(deletePossibleCheck(rowData[2])){
   				$("#btnhalfLeaveDelete").show();
   			}
			$('#halfLeaveForm .hl').attr("disabled",true);
			$('#halfLeaveForm .curr').hide();
			$("#btnhalfLeaveAdd").hide();

			$.ajax({
				url : "<c:url value='/app/halfLeaveDetailAjax'/>",
				data : {searchId : rowData[0]},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#modal_halfLeave #id').val(data.id);
					$('#modal_halfLeave #hlDt').val(data.hlDt);
					$('#modal_halfLeave #term').val(data.term);
					$('#modal_halfLeave input:radio[name=offcial]:radio[value="'+data.offcial+'"]').prop("checked", true);
					$('#modal_halfLeave #memo').val(data.memo);

					$('#deleteForm #id').val(data.id);
					$('#deleteForm #startDt').val(data.hlDt);
				}
			});
			$('#modal_halfLeave').modal('show');

		}
	});

	$('#btnhalfLeaveDelete').click(function(e){
		var startDt = $('#hlDt').val();
		if(deletePossibleCheck(startDt)==false){
			alert('지난 데이터는 삭제할 수 없습니다.');
			return;
		}
		if (confirm("삭제 하시겠습니까?")){
			$.ajax({
					url: "<c:url value='/app/halfLeaveDeleteAjax'/>",
					data: $("#deleteForm").serialize(),
					type: 'POST',
					dataType: 'json',
					beforeSend: function () {
			        },
			        complete: function () {
			        },
					success: function(data){
						if(data==1){
						//halfLeave_table.fnDeleteRow(clickRowhalfLeave);
						gethalfLeave();
						halfLeaveFormReset();
						}else{
							alert("삭제 오류 발생.");
						}
					}
				});
		}
	});




	//add cancel
	$('#btnleaveCancel').click(function(e){
		//e.preventDefault();
		leaveFormReset();
	});
	$('#btnhalfLeaveCancel').click(function(e){
		//e.preventDefault();
		halfLeaveFormReset();
	});


});
   function getleave(){
		$.ajax({
			url: "<c:url value='/app/leaveListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				leave_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRowleave(data[i]);
				}
				leave_table.fnDraw();
			}
		});
	 }


	function gethalfLeave(){
		$.ajax({
			url: "<c:url value='/app/halfLeaveListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				halfLeave_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRowhalfLeave(data[i]);
				}
				halfLeave_table.fnDraw();
			}
		});
	 }


	function registhalfLeave(){
	   $.ajax({
			url: "<c:url value='/app/halfLeaveInsertAjax'/>",
			data: $("#halfLeaveForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				/*
				반휴와 채우는 날 중복 신청 허용(대신 지각 체크는 하지 않고, 근무시간만 밚(4시간)+채우는 시간으로 설정)
				2016-12-20 채변리사님 요청
				if(data.hlSuppDuplicate == true){
					alert("반휴와 채우는날은 함께 사용할수 없습니다.다른 날짜을 선택해주세요.");
					return;
				}
				*/

// 				fnClickAddRowhalfLeave(data);
// 				halfLeave_table.fnDraw();
				gethalfLeave();
				halfLeaveFormReset();
			}
		});
	}

	function registleave(){
		   $.ajax({
				url: "<c:url value='/app/leaveInsertAjax'/>",
			data: $("#leaveForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
// 				for( var i=0; i<data.length; i++){
// 					fnClickAddRowleave(data[i]);
// 				}
// 				leave_table.fnDraw();
				getleave();
				leaveFormReset();
				}
			});
	   }





	function fnClickAddRowleave(data){
		leave_table.fnAddData( [
					data.id,data.crtdId,data.leDt,  data.term, data.offcial, data.crtdNm, data.crtdDt,data.mdfyId, data.mdfyDt
				], false);
	}

	function checkLeaveDayCount(){
		   $.ajax({
				url : "<c:url value='/app/checkLeaveDayCountAjax'/>",
				data : $("#leaveForm").serialize(),
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#leaveForm #term').val(data);
				}
			});
	   }


	function leaveFormReset(){
		$('#leaveForm #startDt, #leaveForm #endDt').val(moment().format('YYYY-MM-DD'));
		$('#leaveForm #startDt').datepicker('setDate', moment().format('YYYY-MM-DD'));
		$('#leaveForm #endDt').datepicker('setDate', moment().format('YYYY-MM-DD'));


		checkLeaveDayCount();
		$('input:radio[name=offcial]:radio[value="N"]').prop("checked", true);
		$('#leaveForm #memo').val('');

		$('label.error').hide();
 		$('.form-control').removeClass('error');

		$('#leaveForm .leave').attr("disabled",false);
		$('#leaveForm .curr').show();
		$("#btnleaveAdd").show();
		$("#btnLeaveDelete").hide();

		$('#modal_leave').modal('hide');
	}

	 function searchDeptUser(type){
	   	$.ajax({
				url : "<c:url value='/management/getDeptUserAjax'/>",
				data : {searchDept : $('#searchDept').val()},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#searchUser option').remove();
					$('#searchUser').append('<option value="all">전체</option>');
					for(var i=0; i<data.length;i++){
						$('#searchUser').append('<option value="'+data[i].id+'">'+data[i].capsName+'('+data[i].deptName+')</option>');
					}

					if(type == 'deptChange'){
						getList();
					}
				}
			});
	   }


 </script>
 </body>