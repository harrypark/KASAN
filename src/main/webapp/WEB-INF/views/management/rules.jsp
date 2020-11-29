<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>규칙관리</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>규칙목록</h5>
           <div class="ibox-tools">
               <a class="collapse-link">
                   <i class="fa fa-chevron-up"></i>
               </a>
           </div>
       </div>
       <div class="ibox-content">
			<div class="row">
				<div class="tabs-container">
	                   <ul class="nav nav-tabs">
	                       <li class="active"><a data-toggle="tab" href="#tab-1" id="dailyRule">일(日) 기준 규칙</a></li>
	                       <li class=""><a data-toggle="tab" href="#tab-2" id="yearlyRule">년(年) 기준 규칙</a></li>
	                       <li class=""><a data-toggle="tab" href="#tab-3" id="etcRule">기타 규칙</a></li>
	                   </ul>
	                   <div class="tab-content">
	                       <div id="tab-1" class="tab-pane active">
	                           <div class="panel-body">
	                               <!-- dataTable start -->
	                               <div class="table-responsive">
					                    <table id="dailyRule_table" class="table table-striped table-bordered table-hover" >
					                    <thead>
					                    <tr>
					                        <th>적용시작일</th>
					                        <th>적용종료일</th>
					                        <th>장지각 시작<br/>(출근시간후)</th>
					                        <th>출근가능 시작시간</th>
					                        <th>출근가능 종료시간</th>
					                        <th>월 대체근무 <br/>가능일수</th>
					                        <th>대체근무 <br/>최대 가능 시간</th>
					                        <th>등록자</th>
					                        <th>등록일</th>
					                        <th>수정자</th>
					                        <th>수정일</th>
					                    </tr>
					                    </thead>
					                    <tbody>
					                    <!-- Daily Rule list here -->
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
					                    <table id="yearlyRule_table" class="table table-striped table-bordered table-hover" >
					                    <thead>
					                    <tr>
					                        <th>년도</th>
					                        <th>연차 차감 단지각 횟수</th>
					                        <th>연차 차감 장지각 횟수</th>
					                        <th>단지각 가중치</th>
					                        <th>장지각 가중치</th>
					                        <th>등록자</th>
					                        <th>등록일</th>
					                        <th>수정자</th>
					                        <th>수정일</th>
					                    </tr>
					                    </thead>
					                    <tbody>
					                    <!-- Yearly Rule List here -->
					                    </tbody>
					                    </table>
					              </div>
	                               <!-- dataTable end -->
	                           </div>
	                       </div>
	                       <div id="tab-3" class="tab-pane">
	                           <div class="panel-body">
	                               <!-- dataTable start -->

	                               <div class="row">
			                            <div class="col-sm-5"><i class="fa fa-gear"></i> 연차 마이너스값 신청 허용 관리</div>
										<div class="col-sm-2"><input type="radio" name="annualMinusUseYn" class="annualRule" value="Y"/> 허용함 </div>
										<div class="col-sm-2"><input type="radio" name="annualMinusUseYn" class="annualRule" value="N"/> 허용안함</div>
									</div>
									<div class="row" style="padding-top: 20px;">
			                            <div class="col-sm-5"><i class="fa fa-gear"></i> 연차 자동게산 적용 기준일</div>
										<div class="col-sm-2"><input type="text" name="annualApplyDt" id="annualApplyDt" class="form-control " readonly="readonly"></div>
										<div class="col-sm-1"><button type="button" class="btn btn-primary btn-sm l-p-5" id="lastSave">변경</button></div>
									</div>
					              </div>
	                               <!-- dataTable end -->

	                       </div>
	                   </div>


	             </div>
   			</div>
        </div>
     </div>

</div>

<!-- Modal (dailyRule) start  -->
<div class="modal inmodal fade modal_dailyRule" id="modal_dailyRule" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">일(日) 기준 규칙</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="dailyRuleForm" id="dailyRuleForm" action="">
	        <input type="hidden" name="id" id="id" value="0"/>
	        <div class="modal-body">
	            <div class="form-group"><label class="col-sm-3 control-label">적용시작일 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="applyStartDt" id="applyStartDt" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">적용종료일<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="applyEndDt" id="applyEndDt" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">장지각 시작<br/>(출근시간후) <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="longLateRule" name="longLateRule">
	                		<option value="00">00분</option>
	                		<option value="10">10분</option>
	                		<option value="20">20분</option>
	                		<option value="30">30분</option>
	                		<option value="40">40분</option>
	                		<option value="50">50분</option>
	                		<option value="60">60분</option>
                    	</select>
	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">출근가능시간 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-4">
	                	<div class=" input-group clockpicker" data-autoclose="true">
                              <input type="text" class="form-control work" id="goStartTm" name="goStartTm" readonly="readonly"/>
                              <span class="input-group-addon">
                                  <span class="fa fa-clock-o"></span>
                              </span>
                          </div>
	                </div>
	                <div class="col-sm-4">
                          <div class=" input-group clockpicker" data-autoclose="true">
                              <input type="text" class="form-control work" id="goEndTm" name="goEndTm" readonly="readonly"/>
                              <span class="input-group-addon">
                                  <span class="fa fa-clock-o"></span>
                              </span>
                          </div>
	                </div>
	            </div>
	             <div class="form-group"><label class="col-sm-3 control-label">월대체근무<br/>가능일수<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="monthReplaceCount" id="monthReplaceCount" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">대체근무<br/>최대가능시간<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="maxReplaceHr" id="maxReplaceHr" class="form-control"></div>
	            </div>
	         </div>

	        <div class="modal-footer">
	            <a class="btn btn-white" id="btnDailyRuleCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnDailyRuleAdd">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (dailyRule) end  -->

<!-- Modal (yearlyRule) start  -->
<div class="modal inmodal fade modal_yearlyRule" id="modal_yearlyRule" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">년(年) 기준 규칙</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="yearlyRuleForm" id="yearlyRuleForm" action="">


	        <div class="modal-body">
	        	<div class="form-group"><label class="col-sm-3 control-label">적용년도<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="applyYear" id="applyYear" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">연차차감<br/>단지각횟수<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="shortLateCount" id="shortLateCount" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">연차차감<br/>장지각횟수<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="longLateCount" id="longLateCount" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">단지각 가중치<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="shortLateWeight" id="shortLateWeight" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">장지각 가중치<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="longLateWeight" id="longLateWeight" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">변경범위<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
						<select class="form-control chosen" id="updateType" name="updateType">
	                		<option value="1">이후 년도 모두 변경</option>
	                		<option value="2">선택된 년도만 변경</option>
                    	</select>
					</div>
	            </div>
	         </div>

	        <div class="modal-footer">
	            <a class="btn btn-white" id="btnYearlyRuleCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnYearlyRuleAdd">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (yearlyRule) end  -->
<!-- Date range use moment.js same as full calendar plugin -->
<script src="<c:url value="/resources/js/moment.js"/>"></script>
<!-- Data picker -->
<%-- <script src="<c:url value="/resources/js/plugins/datapicker/bootstrap-datepicker.js"/>"></script> --%>

<!-- Page-Level Scripts -->
<script>
var dailyRule_table;
var yearlyRule_table
var clickRowDailyRule;
var clickRowYearlyRule;
   $(document).ready(function(){

   	dailyRule_table = $('#dailyRule_table').dataTable({
   		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
        buttons: [
            { extend: 'copy'},
            //{extend: 'csv'},
            {extend: 'excel', title: '일기준규칙_'+moment().format('YYYYMMDDHHmmss')},
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
		  "bFilter" : true
		, "bPaginate": true
		//, "sPaginationType" : "bootstrap_full"
		, "bRetrieve": true
		, "bDeferRender": false
		, "aaSorting": [[ 0, "desc" ]]
	  			,"autoWidth": false

		});
//    	dailyRule_table.fnSetColumnVis(0, false);//index hide
   	$('div#tab-1 div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" data-toggle="modal"  data-keyboard="false" data-backdrop="static" type="button"  data-target="#modal_dailyRule"  data-keyboard="false" data-backdrop="static"> Add </button>');

   	yearlyRule_table = $('#yearlyRule_table').dataTable({
   		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
        buttons: [
            { extend: 'copy'},
            //{extend: 'csv'},
            {extend: 'excel', title: '년기준규칙_'+moment().format('YYYYMMDDHHmmss')},
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
		  "bFilter" : true
		, "bPaginate": true
		//, "sPaginationType" : "bootstrap_full"
		, "bRetrieve": true
		, "bDeferRender": false
		, "aaSorting": [[ 0, "asc" ]]
				,"autoWidth": false
		});
  	//$('div#tab-2 div.dataTables_filter').append('<button class="btn btn-w-m btn-primary" data-toggle="modal"  data-keyboard="false" data-backdrop="static" type="button"  data-target="#modal_yearlyRule"  data-keyboard="false" data-backdrop="static"> Add </button>');

  	$('.clockpicker').clockpicker();

	getDailyRule();
	dailyRuleFormReset();

	$('#dailyRule').click(function(){
		getDailyRule();
	});
	$('#yearlyRule').click(function(){
		getYearlyRuleData();
	})
	$('#etcRule').click(function(){
		getAnnualRule();
	})


	$('#annualApplyDt').datepicker({
    })




	//add group
   	$('#btnDailyRuleAdd').click(function(e){
   		e.preventDefault();
   		if($('#dailyRuleForm').valid()){
   			if($(this).hasClass('registBt')){
   				registDailyRule();
   			}else{
   				editDailyRule();
   			}
   		};
   	});

	$("#dailyRuleForm").validate({
		rules: {
			applyStartDt: { required: true },
			applyEndDt: { required: true },
			longLateRule: { required: true },
			goStartTm: { required: true },
			goEndTm: { required: true },
			monthReplaceCount: { required: true, number:true },
			maxReplaceHr: { required: true , number:true},

      }
	});

	//add data
   	$('#btnYearlyRuleAdd').click(function(e){
   		e.preventDefault();
   		if($('#yearlyRuleForm').valid()){
   			if($(this).hasClass('registBt')){
   				//registYearlyRule();
   			}else{
   				editYearlyRule();
   			}
   		};
   	});

	$("#yearlyRuleForm").validate({
		rules: {
			applyYear: { required: true },
			shortLateCount: { required: true , number:true},
			longLateCount: {  required: true ,number: true},
			shortLateWeight: { required: true , number:true},
			longLateWeight: {  required: true ,number: true},
      }
	});

	$('div.tab-content').on('click','table#dailyRule_table tbody tr',function(){
		 clickRowDailyRule = dailyRule_table.fnGetPosition(this);
		if( clickRowDailyRule != null){
			var rowData = dailyRule_table.fnGetData(this); // 선택한 데이터 가져오기
			//console.log(rowData[0]);
			$("#btnDailyRuleAdd").removeClass('registBt').addClass('modifyBt');

			$.ajax({
				url : "<c:url value='/management/dailyRuleDetailAjax'/>",
				data : {fromDate : rowData[0],toDate : rowData[1]},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#modal_dailyRule #applyStartDt').val(data.applyStartDt);
					$('#modal_dailyRule #applyEndDt').val(data.applyEndDt);
					$('#modal_dailyRule #longLateRule').val(data.longLateRule);
					$('#modal_dailyRule #goStartTm').val(data.goStartTm);
					$('#modal_dailyRule #goEndTm').val(data.goEndTm);
					$('#modal_dailyRule #monthReplaceCount').val(data.monthReplaceCount);
					$('#modal_dailyRule #maxReplaceHr').val(data.maxReplaceHr);

				}
			});
			$('#modal_dailyRule').modal('show');

		}
	});

	$('div.tab-content').on('click','table#yearlyRule_table tbody tr',function(){
		 clickRowYearlyRule = yearlyRule_table.fnGetPosition(this);
		if( clickRowYearlyRule != null){
			var rowData = yearlyRule_table.fnGetData(this); // 선택한 데이터 가져오기
			//console.log(rowData[0]);
 			$("#btnYearlyRuleAdd").removeClass('registBt').addClass('modifyBt');

			$.ajax({
				url : "<c:url value='/management/yearlyRuleDetailAjax'/>",
				data : {searchYear : rowData[0]},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#modal_yearlyRule #applyYear').val(data.applyYear);
					$('#modal_yearlyRule #shortLateCount').val(data.shortLateCount);
					$('#modal_yearlyRule #longLateCount').val(data.longLateCount);
					$('#modal_yearlyRule #shortLateWeight').val(data.shortLateWeight);
					$('#modal_yearlyRule #longLateWeight').val(data.longLateWeight);
					$('#modal_yearlyRule #updateType').val('1');
				}
			});
			$('#modal_yearlyRule').modal('show');

		}
	});




	//add cancel
	$('#btnDailyRuleCancel').click(function(e){
		//e.preventDefault();
		//alert("1");
		dailyRuleFormReset();
	});
	$('#btnYearlyRuleCancel').click(function(e){
		//e.preventDefault();
		yearlyRuleFormReset();
	});


	// annualRule change
	$('.annualRule').click(function(){
		var clickValue = $(this).val();
		if(currValue != clickValue){
			if(confirm("연차 마이너스값 신청 허용을  변경 하시겠습니까?")){
				updateAnnualRule(clickValue);
			}else{
				$(".annualRule:radio[value='"+ currValue +"']").prop("checked", true) ;
			}
		}
	})

	$('#lastSave').click(function(){
		updateAnnualApplyDt();
	})



 });

   function registDailyRule(){
	   $.ajax({
			url: "<c:url value='/management/dailyRuleInsertAjax'/>",
			data: $("#dailyRuleForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				//console.log(data);
				if(data.duplicate==true){
					alert("내일부터 적용 될 규칙이 존재 합니다.");
				}else{
					getDailyRule();
				}
				dailyRuleFormReset();
			}
		});
   }

   function editDailyRule(){
	   $.ajax({
			url: "<c:url value='/management/dailyRuleEditAjax'/>",
			data: $("#dailyRuleForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				fnClickUpdateRowDailyRule(data);
				dailyRule_table.fnDraw();
				dailyRuleFormReset();
			}
		});
   }

    function dailyRuleFormReset(){
    	$('#modal_dailyRule #applyStartDt').val(moment().add(1, 'days').format('YYYY-MM-DD'));
    	$('#modal_dailyRule #applyEndDt').val('9999-12-31');
    	$('#modal_dailyRule #longLateRule').val('00');
		$('#modal_dailyRule #goStartTm').val('08:00');
		$('#modal_dailyRule #goEndTm').val('10:00');
		$('#modal_dailyRule #monthReplaceCount').val('2');
		$('#modal_dailyRule #maxReplaceHr').val('4');
    	$('#modal_dailyRule .form-control').removeClass('invalid');
    	$("#btnDailyRuleAdd").removeClass('modifyBt').addClass('registBt');

		$('#modal_dailyRule').modal('hide');
    }

    function getDailyRule(){
    	$.ajax({
			url: "<c:url value='/management/dailyRuleListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				dailyRule_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRowDailyRule(data[i]);
				}
				dailyRule_table.fnDraw();
			}
		});
     }

    function fnClickAddRowDailyRule(data){
    	dailyRule_table.fnAddData( [
					data.applyStartDt, data.applyEndDt, data.longLateRule, data.goStartTm, data.goEndTm, data.monthReplaceCount, data.maxReplaceHr, data.crtdId, data.crtdDt,data.mdfyId, data.mdfyDt
				], false);

    }
    function fnClickUpdateRowDailyRule(data){
    	dailyRule_table.fnUpdate( [
					data.applyStartDt, data.applyEndDt, data.longLateRule, data.goStartTm, data.goEndTm, data.monthReplaceCount, data.maxReplaceHr, data.crtdId, data.crtdDt,data.mdfyId, data.mdfyDt
				], clickRowDailyRule);
    }



    function getYearlyRuleData(){
    	$.ajax({
			url: "<c:url value='/management/yearlyRuleListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				yearlyRule_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRowYearlyRule(data[i]);
				}
				yearlyRule_table.fnDraw();
			}
		});
     }

    function editYearlyRule(){
 	   $.ajax({
 			url: "<c:url value='/management/yearlyRuleEditAjax'/>",
 			data: $("#yearlyRuleForm").serialize(),
 			type: 'POST',
 			dataType: 'json',
 			beforeSend: function () {
 	        },
 	        complete: function () {
 	        },
 			success: function(data){
 				if($('#updateType').val()=='1'){
 					getYearlyRuleData();
 				}else{
 					fnClickUpdateRowYearlyRule(data);
 				}
 				yearlyRuleFormReset();
 			}
 		});
    }

    function yearlyRuleFormReset(){

		$('#modal_yearlyRule #applyYear').val('');
		$('#modal_yearlyRule #shortLateCount').val('');
		$('#modal_yearlyRule #longLateCount').val('');
		$('#modal_yearlyRule #shortLateWeight').val('');
		$('#modal_yearlyRule #longLateWeight').val('');
		$('#modal_yearlyRule #updateType').val('1');
		$('#modal_yearlyRule em.invalid').hide();
    	$('#modal_yearlyRule .form-control').removeClass('invalid');
    	$("#btnYearlyRuleAdd").removeClass('modifyBt').addClass('registBt');

		$('#modal_yearlyRule').modal('hide');
    }

    function fnClickAddRowYearlyRule(data){
    	yearlyRule_table.fnAddData( [
					data.applyYear, data.shortLateCount, data.longLateCount,data.shortLateWeight, data.longLateWeight,data.crtdId, data.crtdDt,data.mdfyId, data.mdfyDt
				], false);

    }
    function fnClickUpdateRowYearlyRule(data){
    	yearlyRule_table.fnUpdate( [
					data.applyYear, data.shortLateCount, data.longLateCount,data.shortLateWeight, data.longLateWeight,data.crtdId, data.crtdDt,data.mdfyId, data.mdfyDt
				], clickRowYearlyRule);
    }



    function getAnnualRule(){
       	$.ajax({
			url: "<c:url value='/management/getAnnualRuleAjax'/>",
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				currValue = data.rule;
				$(".annualRule:radio[value='"+ currValue +"']").prop("checked", true) ;

				if(typeof data.applyDt != "undefined"){
				$('#annualApplyDt').val(data.applyDt);
				}

			}
		});
       }
    function updateAnnualRule(val){

    		$.ajax({
    			url: "<c:url value='/management/updateAnnualRuleAjax'/>",
    			data:{rule:val},
    			type: 'POST',
    			dataType: 'json',
    			beforeSend: function () {
    	        },
    	        complete: function () {
    	        },
    			success: function(data){
    				toastr.options = {
                            closeButton: true,
                            progressBar: true,
                            showMethod: 'slideDown',
                            timeOut: 4000
                        };
                    toastr.success('', '연차 마이너스값 신청 허용이 변경 되었습니다.');
    				currValue = val;
    				$(".annualRule:radio[value='"+ val +"']").attr("checked", true) ;

    			}
    		});
    }

    function updateAnnualApplyDt(){
    	var annualApplyDt = $('#annualApplyDt').val();
    	if(annualApplyDt == null || annualApplyDt==''){
    		alert("연차 자동게산 적용 기준일을 선택해 주세요.");
    		return;
    	}
    	$.ajax({
			url: "<c:url value='/management/updateAnnualApplyDtAjax'/>",
			data:{applyDt:annualApplyDt},
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				toastr.options = {
                        closeButton: true,
                        progressBar: true,
                        showMethod: 'slideDown',
                        timeOut: 4000
                    };
                toastr.success('', '연차 자동게산 적용 기준일이 변경 되었습니다.');

			}
		});
    }







 </script>
 </body>