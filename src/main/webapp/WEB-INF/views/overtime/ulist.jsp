<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>야근신청</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>신청목록</h5>
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
                    	<span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="searchDM" id="searchDM">
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchState" name="searchState">
                        <option value="all">결과_전체</option>
                        <c:forEach items="${otList}" var="list">
                        	<option value="${list.code }">${list.name }</option>
                        </c:forEach>
                    </select>
                </div>

              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="overtime_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			        	<th>ID</th>
			            <th>신청일</th>
			            <th>성명</th>
			            <th>부서</th>
			            <th>퇴근예정시간</th>
			            <th>퇴근시간</th>
			            <th>초과근무</th>
			            <th>신청결과</th>
			            <th>기타</th>
			            <th>등록일</th>
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

<!-- Modal (overtime) start  -->
<div class="modal inmodal fade modal_overtime" id="modal_overtime" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">야근신청</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="overtimeForm" id="overtimeForm" action="">
	        <input type="hidden" name="id" id="id" value="0"/>
	        <div class="modal-body">
	        	<div class="form-group"><label class="col-sm-3 control-label">신청일 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="reqDt" id="reqDt" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">신청결과 </label>
	                <div class="col-sm-9"><input type="text" name="resultNm" id="resultNm" class="form-control" readonly="readonly">
	            	<input type="hidden" name="result" id="result" value="0">
	            	</div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">불가사유</label>
	                <div id="reason" class="col-sm-9 control-label text-danger" style="text-align: left;">불가</div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">퇴근예정시간 </label>
	                <div class="col-sm-9"><input type="text" name="expOutTm" id="expOutTm" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">퇴근시간 </label>
	                <div class="col-sm-9"><input type="text" name="outTm" id="outTm" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">초과근무시간 </label>
	                <div class="col-sm-9"><input type="text" name="overtimeHM" id="overtimeHM" class="form-control" readonly="readonly"></div>
	                <input type="hidden" name="overtimeMin" id="overtimeMin" value="0">
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
<!-- Modal (overtime) end  -->

<!-- Page-Level Scripts -->
    <script>
    var overtime_table;
    var clickRow;
    var map = new Map();
    <c:forEach items="${otList}" var="list">
		map.put("${list.code }","${list.name }");
	</c:forEach>

    $(document).ready(function(){
    	overtime_table = $('#overtime_table').dataTable({
    		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '야근신청_'+moment().format('YYYYMMDDHHmmss')},
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
    	"iDisplayLength": 50
    	,"bFilter" : true
		, "bPaginate": true
		//, "sPaginationType" : "bootstrap_full"
		, "bRetrieve": true
		, "bDeferRender": false
		, "aaSorting": [[ 0, "desc" ]]
   			,"autoWidth": false

		});
    	$('div#overtime_table_wrapper div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" type="button" data-toggle="modal"  data-keyboard="false" data-backdrop="static" data-target="#modal_overtime" style="margin-bottom: 0px;"> Add </button>');

    	$('#searchDM').val(moment().format('YYYY-MM'));
    	$('#searchDM').datepicker({
    		format: 'yyyy-mm',
            minViewMode: 1,
            todayBtn:false
        }).on('hide', function(e) {
        	overtimeList();
        });


    	$('#searchState').change(function(){
    		overtimeList();
    	})

    	overtimeList();
		$('#overtimeForm #reqDt').val(moment().format('YYYY-MM-DD'));
    	$('#reqDt').datepicker({
    		format: 'yyyy-mm-dd',
    		language: "kr",
    		startDate: moment().subtract(30, 'days').format('YYYY-MM-DD'),
    		endDate: moment().format('YYYY-MM-DD'),
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            todayHighlight: true
        }).on('hide', function(e) {
        	$(this).blur();
        	if($(this).val()==''){
 	        	$(this).val(moment().format('YYYY-MM-DD'));
 	        }

       	//getReqDateCheck($(this).val());
        });



    	overtimeFormReset();

    	$('#btnCancel').click(function(){
    		overtimeFormReset();
    	});


    	$('#reqDt').datepicker().on('changeDate', function(e) {
    		getReqDateCheck($(this).val());
        });
    	$('#modal_overtime').on('shown.bs.modal', function (event) {
    		getReqDateCheck($("#reqDt").val());
  		})

		$('#btnSave').click(function(e){
	   		e.preventDefault();
	   		if($('#overtimeForm').valid()){
   				registOvertime();
	   		};
	   	});
    	$("#overtimeForm").validate({
    		rules: {
    			reqDt: { required: true }

          }
    	});
    });

    function getReqDateCheck(reqDt){
    	$.ajax({
			url: "<c:url value='/overtime/reqDateCheckAjax'/>",
			data: {searchDt:reqDt},
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
					if(data.duplicateReq == true){
						overtimeFromClean()
						$('#reason').text(reqDt +" 이미 신청하셨습니다.");
						return;
					}
					if(data.holidayYn == true ){
						overtimeFromClean()
						$('#reason').text(reqDt +" 휴일은 신청 할수 없습니다.");
						return;
					}
					if(data.dataErrorYn == true ){
						overtimeFromClean();
						$('#reason').text(reqDt +" 데이터 오류 입니다. 관리자에게 문의 하세요.");
						return;
					}
					if(moment().format('YYYY-MM-DD')==reqDt){
						overtimeFromClean();
						$('#reason').text("통계생성 전 입니다.");
						$('#resultNm').val(map.get("003"));
						$('#result').val('003');
						$('#btnSave').show();
						return;
					}
					if(data.result=='nodata'){
						overtimeFromClean();
						$('#reason').text('관리자 확인이 필요합니다.');
						return;
					}

					overtimeFromSet(data);
			}
		});

    }

    function overtimeFromClean(){
    	$('#expOutTm').val('');
		$('#outTm').val('');
		$('#overtimeHM').val('');
		$('#overtimeMin').val('0');
		$('#result ,#resultNm').val('');
		$('#reason').text('');
		$('#btnSave').hide();

    }

    function overtimeFromSet(data){
    	if(data == null){
    		$('#expOutTm').val('');
			$('#outTm').val('');
			$('#overtimeHM').val('');
			$('#overtimeMin').val('0');
			$('#resultNm').val('').val(map.get("003"));
			$('#result').val('').val('003');
			$('#reason').val('');
			$('#btnSave').show();
    	}else{
    		$('#expOutTm').val('').val(data.expOutTm);
			$('#outTm').val('').val(data.outTm);
			$('#overtimeHM').val('').val(minToHour(data.overtimeMin));
			$('#overtimeMin').val('').val(data.overtimeMin);
			$('#resultNm').val('').val(map.get(data.result));
			if(data.result=='002'){
				$('#reason').text('조건미달 (19:00이후 퇴근, 2h이상).');
				$('#btnSave').hide();
    		}else{
    			$('#reason').text('');
    			$('#btnSave').show();
    		}
			$('#result').val('').val(data.result);

    	}

    }


      function overtimeList(){
       	$.ajax({
			url: "<c:url value='/overtime/ulistAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				overtime_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				overtime_table.fnDraw();
			}
		});
       }


    function fnClickAddRow(data){
    	var a = overtime_table.fnAddData( [
					data.id, data.reqDt, data.name,data.deptNm,data.expOutTm, data.outTm, minToHour(data.overtimeMin),map.get(data.result),data.memo,data.crtdDt
				], true);

    }

    function overtimeFormReset(){

    	$('#reqDt').val(moment().format('YYYY-MM-DD'));
    	$("#reqDt").datepicker('setDate', moment().format('YYYY-MM-DD'));
    	overtimeFromClean();
    	$('label.error').hide();
    	$('.form-control').removeClass('error');
    	$('#resultNm').val(map.get("003"));
    	$('#result').val('003');
    	$('#btnSave').show();

		$('#modal_overtime').modal('hide');
    }

    function registOvertime(){
			$.ajax({
				url: "<c:url value='/overtime/insertAjax'/>",
				data: $("#overtimeForm").serialize(),
				type: 'POST',
				dataType: 'json',
				beforeSend: function () {
		        },
		        complete: function () {
		        },
				success: function(data){
						fnClickAddRow(data);
						overtimeFormReset();
				}
			});
	}

    function editovertime(){
		$.ajax({
			url: "<c:url value='/management/overtimeEditAjax'/>",
			data: $("#overtimeForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				fnClickUpdateRow(data);
				overtimeFormReset();
			}
		});
}



    </script>
</body>