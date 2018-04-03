<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>근태확인</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>근태확인</h5>
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
                	<div class="input-group date">
                    	<span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="searchDM" id="searchDM" readonly="readonly">
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchDept" name="searchDept">
                        <c:if test="${authCd eq '003' }">
                        <option value="all">부서_전체</option>
                        </c:if>
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

                <div class="col-lg-2 col-md-6 col-sm-12">
                 <button type="button" class="btn btn-w-m btn-primary" id="btnSearch" >검색</button>
                </div>
                <c:if test="${authCd eq '003' }">
	                <div class="col-lg-2 col-md-6 col-sm-12">
	                 <button type="button" class="btn btn-w-m btn-info" data-toggle="modal"  data-keyboard="false" data-backdrop="static" data-target="#modal_stat" id="btnStat" >통계생성</button>
	                </div>
	            </c:if>
              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="stat_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th>id</th>
			            <th>성명</th>
			            <th>부서</th>
			            <th>날짜</th>
			            <th>요일</th>
			            <th>휴일여부</th>
			            <th>출근시간</th>
			            <th>퇴근예정</th>
			            <th>퇴근시간</th>
			            <th>지각기준</th>
			            <th>기준근무시간</th>
			            <th>실제근무시간</th>
			            <th>휴가</th>
			            <th>반휴</th>
			            <th>공가</th>
			            <th>단지각</th>
			            <th>장지각</th>
			            <th>근무시간미달</th>
			            <th>결근</th>
			            <th>사후조정</th>
			            <th>Data Error</th>
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
<!-- Modal (stat) start  -->
<div class="modal inmodal fade modal_stat" id="modal_stat" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="modal-title">통계생성</h4>
	        </div>
	        <form class="form-horizontal" name="statForm" id="statForm" action="">
	        <div class="modal-body">
	        	<div class="form-group"><label class="col-sm-3 control-label">선택일 </label>
	                <div class="col-sm-9"><input type="text" name="searchDt" id="searchDt" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">DataError</label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="dataError" name="dataError">
	                		<option value="Y">예</option>
	                		<option value="N" selected="selected">아니오</option>
                    	</select>
	                </div>
	            </div>
	         </div>

	        <div class="modal-footer">
	            <a class="btn btn-white" id="btnCancelStat">Cancel</a>
	            <a class="btn btn-primary" id="btnCreateStat">생성</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (stat) end  -->



<!-- Modal (holiday) start  -->
<div class="modal inmodal fade modal_statInfo" id="modal_statInfo" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="modal-title">근태정보</h4>
	        </div>
	        <form class="form-horizontal" name="statInfoForm" id="statInfoForm" action="">
	        <input type="hidden" id="id" name="id" value="0"/>
	        <input type="hidden" id="stDt" name="stDt" value=""/>
	        <div class="modal-body">
	        	<div class="form-group">
	        		<label class="col-sm-2 control-label">날짜</label>
	                <div class="col-sm-4 stext m_stDt"></div>
	                <label class="col-sm-2 control-label">정보</label>
	                <div class="col-sm-4 stext m_dayInfo"></div>
	            </div>
	            <div class="form-group">
	        		<label class="col-sm-2 control-label">성명</label>
	                <div class="col-sm-4 stext m_name"></div>
	                <label class="col-sm-2 control-label">부서</label>
	                <div class="col-sm-4 stext m_dept"></div>
	            </div>
	            <div class="hr-line-dashed m_events"></div>
	            <div class="form-group m_events">
		            <div class="col-sm-12">
		            	<table class="table table-hover no-margins events_table">
                             <thead>
                             <tr>
                                 <th>이벤트</th>
                                 <th>기간</th>
                                 <th>정보</th>
                             </tr>
                             </thead>
                             <tbody>

                             </tbody>
                         </table>
		            </div>
	            </div>
	            <div class="hr-line-dashed m_events"></div>
	            <div class="form-group">
	        		<label class="col-sm-2 control-label">출근</label>
	                <div class="col-sm-4 stext m_goTm"></div>
	                <label class="col-sm-2 control-label">퇴근</label>
	                <div class="col-sm-4 stext m_outTm"></div>
	            </div>
	            <div class="form-group">
	        		<label class="col-sm-2 control-label">지각기준</label>
	                <div class="col-sm-4 stext m_lateTm"></div>
	                <label class="col-sm-2 control-label">퇴근예상</label>
	                <div class="col-sm-4 stext m_expOutTm"></div>
	            </div>
	            <div class="form-group">
	        		<label class="col-sm-2 control-label">근무시간</label>
	                <div class="col-sm-10 stext m_workTm"></div>
	            </div>
	            <div class="hr-line-dashed"></div>
	            <div class="form-group">
		            <div class="col-sm-12">
		            	<table class="table table-hover no-margins">
                             <thead>
                             <tr>
                                 <th>휴가</th>
                                 <th>반휴</th>
                                 <th>공가</th>
                                 <th>단지각</th>
                                 <th>장지각</th>
                                 <th>근무미달</th>
                                 <th>결근</th>
                             </tr>
                             </thead>
                             <tbody>
                             	<tr>
                             		<td class="m_stLeave"></td>
                             		<td class="m_stHlLeave"></td>
                             		<td class="m_stOffcial"></td>
                             		<td class="m_stShortLate"></td>
                             		<td class="m_stLongLate"></td>
                             		<td class="m_stFailWorkTm"></td>
                             		<td class="m_stAbsence"></td>
                             	</tr>
                             </tbody>
                         </table>
		            </div>
	            </div>
	            <div class="hr-line-dashed"></div>
	            <div class="form-group"><label class="col-sm-2 control-label">사후조정 </label>
	                <div class="col-sm-10">
	                	<label class="radio-inline">
							<input type="radio" name="stAdjust" id="m_stAdjust" value='Y'/>Y
						</label>
						<label class="radio-inline">
							<input type="radio" name="stAdjust" id="m_stAdjust" value='N'/>N
						</label>
	                </div>
	            </div>

	            <div class="form-group"><label class="col-sm-2 control-label">메모 </label>
	                <div class="col-sm-10"><textarea id="memo" name="memo" class="form-control"></textarea></div>
	            </div>
	         </div>

	        <div class="modal-footer">
	            <a class="btn btn-white" id="btnCancel">Cancel</a>
	            <a class="btn btn-primary" id="btnSave">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (holiday) end  -->


<script src="<c:url value="/resources/js/dashboard-script.js"/>"></script>
<!-- Page-Level Scripts -->
    <script>
    var stat_table;
    var clickRow;
    var memoLength=0;
    $(document).ready(function(){
    	stat_table = $('#stat_table').dataTable({
    		dom: '<"html5buttons"B>lTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '근태기록_'+moment().format('YYYYMMDDHHmmss')},
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
    	"iDisplayLength": 100
    	,"bFilter" : false
		, "bPaginate": true
		//, "sPaginationType" : "bootstrap_full"
		, "bRetrieve": true
		, "bDeferRender": false
		, "aaSorting": [[ 0, "asc" ]]
   			,"autoWidth": false

		});

		$('#searchDM').val(moment().format('YYYY-MM'));
    	$('#searchDM').datepicker({
    		format: 'yyyy-mm',
            minViewMode: 1,
            todayBtn:false
        })

    	$('#searchDt').val(moment().subtract(1, 'days').format('YYYY-MM-DD'));
    	$('#searchDt').datepicker({
    		format: 'yyyy-mm-dd',
    		language: "kr",
    		startDate: '2016-08-01',
    		endDate: moment().subtract(1, 'days').format('YYYY-MM-DD'),
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            todayHighlight: true
        })

    	getDailyStatList();

        $('#btnCancelStat').click(function(){
    		statFormReset();
    	});

        $('#btnSearch').click(function(){
        	getDailyStatList();
        })

        $('#modal_stat').on('shown.bs.modal', function () {
     	   checkCalendarDataError($('#searchDt').val());
        })

        $('#searchDt').change(function(){
        	checkCalendarDataError($('#searchDt').val());
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

				}
			});
        })
		$('#searchDept').trigger('change');

    	function statFormReset(){
    		$('#modal_stat em.invalid').hide();
        	$('#modal_stat .form-control').removeClass('invalid');
        	$('#statForm #searchDt').val(moment().subtract(1, 'days').format('YYYY-MM-DD'));
        	$('#statForm #dataError').val('N');

    		$('#modal_stat').modal('hide');
    	}

        function checkCalendarDataError(searchDt){
        	$.ajax({
				url : "<c:url value='/stat/checkCalendarDataErrorAjax'/>",
				data : {searchDt : searchDt},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#dataError').val(data);

				}
			});
        }

        <c:if test="${authCd eq '003' }">
		$('#btnCreateStat').click(function(){
			var searchDt=$('#searchDt').val();
			var dataError=$('#dataError').val();
			var confirmStr = searchDt+'일 통계를 다시 생성 하시겠습니까?\n기존자료는 모두 삭제 됩니다.';

			if (confirm(confirmStr)){
				$.ajax({
    				url : "<c:url value='/stat/manualCreateAjax'/>",
    				data : {searchDt : searchDt,dataError:dataError},
    				type : 'POST',
    				dataType : 'json',
    				success : function(data){
    					statFormReset();
    					$('#searchDM').val(searchDt.substr(0,7));
    					$('#searchDM').datepicker('setStartDate', searchDt.substr(0,7));
    					$('#searchDept').val('all');
    					$('#searchUser').val('all');
    					$('#btnSearch').trigger('click');


    				}
    			});
			}
		})
		</c:if>


		 function getDailyStatList(){
	       	$.ajax({
				url: "<c:url value='/stat/getDailyStatListAjax'/>",
				data: $("#searchParam").serialize(),
				type: 'POST',
				dataType: 'json',
				beforeSend: function () {
		        },
		        complete: function () {
		        },
				success: function(data){
					stat_table.fnClearTable();
					for( var i=0; i<data.length; i++){
						fnClickAddRow(data[i],'add');
					}
					stat_table.fnDraw();
				}
			});
	       }




    	$('#btnCancel').click(function(){
    		statInfoFormReset();
    	});
    	$('div.wrapper-content').on('click','table#stat_table tbody tr',function(){
    		 clickRow = stat_table.fnGetPosition(this);
    		if( clickRow != null){
    			var rowData = stat_table.fnGetData(this); // 선택한 데이터 가져오기
    			$.ajax({
    				url : "<c:url value='/stat/getUserStatDetailAjax'/>",
    				data : {searchUser:rowData[0],searchDt : rowData[3]},
    				type : 'POST',
    				dataType : 'json',
    				success : function(data){
						setStatInfoModal(data);
    				}
    			});
    			$('#modal_statInfo').modal('show');

    		}
    	});

    	$('#calHolidayYn').change(function(){
    		calHolidaycheck($(this).val());
    	});

    	$('#btnSave').click(function(e){
       		if(memoLength == $('#memo').val().length){
       			alert("메모(조정사유)를 입력해 주세요.");
       			return;
       		}
    		e.preventDefault();
       		if($('#statInfoForm').valid()){
       			$.ajax({
       				url: "<c:url value='/stat/adjustAjax'/>",
       				data: $("#statInfoForm").serialize(),
       				type: 'POST',
       				dataType: 'json',
       				beforeSend: function () {
       		        },
       		        complete: function () {
       		        },
       				success: function(data){
						fnClickAddRow(data,'update');
       					statInfoFormReset();
       				}
       			});
       		};
       	});

    	$("#statInfoForm").validate({
    		rules: {
    			memo: { required: true }
          }
    	});
    });


	function setStatInfoModal(data){
		var events = data.events;
		var data = data.stat;
		$('#statInfoForm #id').val(data.id);
		$('#stDt').val(data.stDt);

		$('.m_stDt').text(data.stDt + '('+data.weekName+')');

	    var dayInfo = data.dataErrorYn=='Y'?'<span class="label label-danger">DataErr</span>':'';
	    var holidayYn = data.holidayYn=='Y'?'<span class="label label-info">휴일</span>':'';
		$('.m_dayInfo').html(dayInfo +'&nbsp;'+ holidayYn);
		$('.m_name').text(data.capsName);
		$('.m_dept').text(data.deptName);

		$('.m_goTm').text('').text(data.goTm);
		$('.m_outTm').text('').text(data.outTm);
		$('.m_lateTm').text('').text(data.lateTm);
		$('.m_expOutTm').text('').text(data.expOutTm);
		$('.m_workTm').text('').text(minToHour(data.calWorkTmMin) +' - '+ minToHour(data.workTmMin) +' = '+ minToHour(data.calWorkTmMin-data.workTmMin));


		$('.m_stLeave').html(data.stLeave?'<span class="label label-warning">'+data.stLeave+'</span>':data.stLeave);
		$('.m_stHlLeave').html(data.stHlLeave?'<span class="label label-warning">'+data.stHlLeave+'</span>':data.stHlLeave);
		$('.m_stOffcial').html(data.stOffcial=='Y'?'<span class="label label-info">'+data.stOffcial+'</span>':data.stOffcial);
    	$('.m_stFailWorkTm').html(data.stFailWorkTm?'<span class="label label-warning">'+data.stFailWorkTm+'</span>':data.stFailWorkTm);
    	$('.m_stShortLate').html(data.stShortLate?'<span class="label label-warning">'+data.stShortLate+'</span>':data.stShortLate);
		$('.m_stLongLate').html(data.stLongLate?'<span class="label label-warning">'+data.stLongLate+'</span>':data.stLongLate);
		$('.m_stAbsence').html(data.stAbsence?'<span class="label label-warning">'+data.stAbsence+'</span>':data.stAbsence);
		$('input:radio[value="'+data.stAdjust+'"]').prop("checked", true) ;
		if (typeof data.memo =="undefined") {
			$('#memo').val('');
			memoLength=0;
		}else{
			$('#memo').val(data.memo);
			memoLength=data.memo.length;
		}

		if(events.length > 0 ){
			$('.m_events').show();
			$('.events_table tbody').empty();
			for(var i=0; i<events.length;i++){
				var eStr ='';
				eStr = '<tr>';
				eStr +=		 '<td>'+events[i].gubun+'</td>';
				eStr +=		 '<td>'+events[i].term+'</td>';
				eStr +=		 '<td>'+events[i].info+'</td>';
				eStr +=	 '</tr>';
				$('.events_table tbody').append(eStr);
			}

		}else{
			$('.m_events').hide();
			$('.events_table tbody').empty();
		}

	}


    function fnClickAddRow(data,type){
    	var leave = data.stLeave?'<span class="label label-warning">'+data.stLeave+'</span>':data.stLeave;
		var hlLeave = data.stHlLeave?'<span class="label label-warning">'+data.stHlLeave+'</span>':data.stHlLeave;
		var offcial = data.stOffcial=='Y'?'<span class="label label-info">'+data.stOffcial+'</span>':data.stOffcial;
    	var failWorkTm = data.stFailWorkTm?'<span class="label label-warning">'+data.stFailWorkTm+'</span>':data.stFailWorkTm;
    	var shortLate = data.stShortLate?'<span class="label label-warning">'+data.stShortLate+'</span>':data.stShortLate;
		var longLate = data.stLongLate?'<span class="label label-warning">'+data.stLongLate+'</span>':data.stLongLate;
		var absence= data.stAbsence?'<span class="label label-warning">'+data.stAbsence+'</span>':data.stAbsence;
		var dataErrorYn= data.dataErrorYn=='Y'?'<span class="label label-danger">'+data.dataErrorYn+'</span>':data.dataErrorYn;
		var adjust= data.stAdjust=='Y'?'<span class="label label-info">'+data.stAdjust+'</span>':data.stAdjust;


		if(type=='add'){
    	var a = stat_table.fnAddData( [
					data.id, data.capsName, data.deptName,data.stDt, data.weekName, data.holidayYn,data.goTm,data.expOutTm,data.outTm
					,data.lateTm,minToHour(data.workTmMin),minToHour(data.calWorkTmMin), leave,hlLeave,offcial,shortLate,longLate
					,failWorkTm, absence,adjust,dataErrorYn
				], false);
		}else if(type=='update'){
    	stat_table.fnUpdate( [
				data.id, data.capsName, data.deptName,data.stDt, data.weekName, data.holidayYn,data.goTm,data.expOutTm,data.outTm
				,data.lateTm,minToHour(data.workTmMin),minToHour(data.calWorkTmMin), leave,hlLeave,offcial,shortLate,longLate
				,failWorkTm, absence,adjust,dataErrorYn
    	     				], clickRow);
		}
    }

    function fnClickUpdateRow(data){
    	holiday_table.fnUpdate( [
					data.calDate1, data.calWeekName+"("+data.calWeekPart+")", data.calWeekendYn, data.calHolidayYn, data.calHolidayName,data.dataError,data.mdfyId,data.mdfyDt
				], clickRow);
    }

    function statInfoFormReset(){
		$('#modal_statInfo em.invalid').hide();
    	$('#modal_statInfo .form-control').removeClass('invalid');

		$('#modal_statInfo').modal('hide');
    }
</script>
</body>