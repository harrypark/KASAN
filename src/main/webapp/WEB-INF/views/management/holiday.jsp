<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>달력관리</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>달력</h5>
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
                <div class="col-lg-3 col-md-6 col-sm-12">
                	<div class="input-group date">
                    	<span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="searchDM" id="searchDM">
                    </div>
                </div>
              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="holiday_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th>년월일</th>
			            <th>요일</th>
			            <th>주말여부</th>
			            <th>공휴일여부</th>
			            <th>공휴일명</th>
			            <th>Data Error</th>
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

<!-- Modal (holiday) start  -->
<div class="modal inmodal fade modal_holiday" id="modal_holiday" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">공휴일등록</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="holidayForm" id="holidayForm" action="">
	        <div class="modal-body">
	        	<div class="form-group"><label class="col-sm-3 control-label">년월일</label>
	                <div class="col-sm-9"><input type="text" name="calDate1" id="calDate1" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">요일</label>
	                <div class="col-sm-9"><input type="text" name="calWeekName" id="calWeekName" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">공휴일여부 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="calHolidayYn" name="calHolidayYn">
	                		<option value="Y">예</option>
	                		<option value="N">아니오</option>
                    	</select>
	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">공휴일명 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="calHolidayName" id="calHolidayName" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">DataError <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="dataError" name="dataError">
	                		<option value="Y">예</option>
	                		<option value="N">아니오</option>
                    	</select>
	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">메모 </label>
	                <div class="col-sm-9"><textarea id="memo" name="memo" class="form-control"></textarea></div>
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



<!-- Page-Level Scripts -->
    <script>
    var holiday_table;
    var clickRow;
    $(document).ready(function(){
    	holiday_table = $('#holiday_table').dataTable({
    		dom: '<"html5buttons"B>lTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '달력관리_'+moment().format('YYYYMMDDHHmmss')},
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
        }).on('hide', function(e) {
        	holidayList();
        });

    	holidayList();


    	$('#btnCancel').click(function(){
    		holidayFormReset();
    	});
    	$('div.wrapper-content').on('click','table#holiday_table tbody tr',function(){
    		 clickRow = holiday_table.fnGetPosition(this);
    		if( clickRow != null){
    			var rowData = holiday_table.fnGetData(this); // 선택한 데이터 가져오기
    			//console.log(rowData[0]);
    			//$('#modal_group #groupKey').attr("disabled",true);
     			//$("#btnGroupAdd").removeClass('registBt').addClass('modifyBt');
    			$.ajax({
    				url : "<c:url value='/management/holidayDetailAjax'/>",
    				data : {searchDate : rowData[0]},
    				type : 'POST',
    				dataType : 'json',
    				success : function(data){
    					$('#calDate1').val(data.calDate1);
    					$('#calWeekName').val(data.calWeekName);
    					$('#calHolidayYn').val(data.calHolidayYn);
    					$('#calHolidayName').val(data.calHolidayName);
    					$('#dataError').val(data.dataError);
    					$('#memo').val(data.memo);

    					calHolidaycheck(data.calHolidayYn);
    					if(editPossibleDataErrorCheck(data.calDate1)){
    						$('#dataError').prop('disabled',false);
    					}else{
    						$('#dataError').prop('disabled',true);
    					}

    				}
    			});
    			$('#modal_holiday').modal('show');

    		}
    	});

    	$('#calHolidayYn').change(function(){
    		calHolidaycheck($(this).val());
    	});

    	$('#btnSave').click(function(e){
       		e.preventDefault();
       		if($('#holidayForm').valid()){
       			$.ajax({
       				url: "<c:url value='/management/holidayEditAjax'/>",
       				data: $("#holidayForm").serialize(),
       				type: 'POST',
       				dataType: 'json',
       				beforeSend: function () {
       		        },
       		        complete: function () {
       		        },
       				success: function(data){
       					fnClickUpdateRow(data);
       					holidayFormReset();
       				}
       			});
       		};
       	});

    	$("#holidayForm").validate({
    		rules: {
    			calHolidayName: { required: true }
          }
    	});
    });
    	function calHolidaycheck(val){
    		if(val=='Y'){
				$('#calHolidayName').attr("disabled",false);
			}else{
				$('#calHolidayName').attr("disabled",true);
			}
    	}

      function holidayList(){
       	$.ajax({
			url: "<c:url value='/management/holidayListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				holiday_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				holiday_table.fnDraw();
			}
		});
       }


    function fnClickAddRow(data){
    	var a = holiday_table.fnAddData( [
					data.calDate1, data.calWeekName+"("+data.calWeekPart+")", data.calWeekendYn, data.calHolidayYn, data.calHolidayName,data.dataError,data.mdfyId,data.mdfyDt
				], false);

    }
    function fnClickUpdateRow(data){
    	holiday_table.fnUpdate( [
					data.calDate1, data.calWeekName+"("+data.calWeekPart+")", data.calWeekendYn, data.calHolidayYn, data.calHolidayName,data.dataError,data.mdfyId,data.mdfyDt
				], clickRow);
    }
    function editPossibleDataErrorCheck(checkDate){ //checkDate (YYYY-MM-DD)
		var currDate = moment();
		var checkDate = moment(checkDate,'YYYY-MM-DD');
		var res = currDate.diff(checkDate,'days');
		console.log(res);
		if(res<=0){
			return true;
		}else{
			return false;
		}
	}
    function holidayFormReset(){
		$('#modal_holiday em.invalid').hide();
    	$('#modal_holiday .form-control').removeClass('invalid');

		$('#modal_holiday').modal('hide');
    }
</script>
</body>