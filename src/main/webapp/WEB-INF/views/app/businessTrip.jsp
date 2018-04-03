<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>출장관리</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>출장관리</h5>
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
                 <div class="col-lg-3 col-md-6 col-sm-6">
                	<button class="btn btn-w-m btn-primary m-r-sm" type="button" data-toggle="modal"  data-keyboard="false" data-backdrop="static" data-target="#modal_businessTrip" style="margin-bottom: 0px;"> Add </button>
                </div>
              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="businessTrip_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			        	<th>ID</th>
			            <th>시작일</th>
			            <th>종료일</th>
			            <th>목적지(장소)</th>
			            <th>등록자</th>
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

<!-- Modal (businessTrip) start  -->
<div class="modal inmodal fade modal_businessTrip" id="modal_businessTrip" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">출장정보</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="businessTripForm" id="businessTripForm" action="">
	        <input type="hidden" id="id" name="id"/>
	        <div class="modal-body">
	        	<div class="form-group"><label class="col-sm-3 control-label">출장기간 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
<!-- 	                <input type="text" name="tripRange" id="tripRange" class="form-control trap" readonly="readonly"> -->
	                <div class="input-group input-daterange btrip-daterang">
					    <input type="text" class="form-control trap" id="startDt" name="startDt" readonly="readonly"/>
					    <span class="input-group-addon">to</span>
					    <input type="text" class="form-control trap" id="endDt" name="endDt" readonly="readonly">
					</div>

	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">목적지(장소) <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="destination" id="destination" class="form-control trap"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">메모 </label>
	                <div class="col-sm-9"><textarea id="memo" name="memo" class="form-control trap"></textarea></div>
	            </div>
	         </div>

	        <div class="modal-footer">
	        	<a class="btn btn-danger pull-left" id="btnDelete" style="display: none;">Delete</a>
	            <a class="btn btn-white" id="btnCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnSave">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (businessTrip) end  -->



<!-- Page-Level Scripts -->
    <script>
    var businessTrip_table;
    var clickRow;
    $(document).ready(function(){
    	businessTrip_table = $('#businessTrip_table').dataTable({
    		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '외근공지_'+moment().format('YYYYMMDDHHmmss')},
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
		, "bDeferRender": true
		, "aaSorting": [[ 0, "desc" ]]
   			,"autoWidth": false

		});
    	businessTrip_table.fnSetColumnVis(0, false);
    	//$('div#businessTrip_table_wrapper div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" type="button" data-toggle="modal"  data-keyboard="false" data-backdrop="static" data-target="#modal_businessTrip" style="margin-bottom: 0px;"> Add </button>');

    	$('.search-daterange').datepicker({
        	format: 'yyyy-mm-dd',
       		language: "kr",
       		startDate: '2016-08-01',
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            todayHighlight: true
        }).on('hide', function(){
        	businessTripList();
        });
       	$('#fromDate').val(moment().subtract(15, 'days').format('YYYY-MM-DD'));
       	$('#toDate').val(moment().add(15, 'days').format('YYYY-MM-DD'));
       	$('#fromDate').datepicker('setDate', moment().subtract(15, 'days').format('YYYY-MM-DD'));
    	$('#toDate').datepicker('setDate', moment().add(15, 'days').format('YYYY-MM-DD'));


	    $('.btrip-daterang').datepicker({
	    	format: 'yyyy-mm-dd',
    		language: "kr",
    		startDate: 'today',
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            todayHighlight: true
	    });

 		$('#startDt').datepicker('update', moment().format('YYYY-MM-DD'));
 		$('#endDt').datepicker('update', moment().format('YYYY-MM-DD'));
 		$('#startDt, #endDt').val(moment().format('YYYY-MM-DD'));

 		$('#startDt, #endDt').datepicker().on('hide', function(e) {
 	        if($(this).val()==''){
 	        	$(this).val(moment().format('YYYY-MM-DD'));
 	        }
 	    });

 		/* 출장등록 modal 달력에 영향을 준다.
 		$('#startDt, #endDt').datepicker().on('show', function(e) {
			var startDt = $('#startDt').val();
	    	var endDt = $('#endDt').val();
			$('#startDt').datepicker('setDate', startDt);
			$('#endDt').datepicker('setDate', endDt);

		});
		*/

    	//$('#outDt').val(moment().format('YYYY-MM-DD'));
    	businessTripFormReset();
    	businessTripList();


    	$('#btnCancel').click(function(){
    		businessTripFormReset();
    	});
    	$('div.wrapper-content').on('click','table#businessTrip_table tbody tr',function(){
    		 clickRow = businessTrip_table.fnGetPosition(this);
    		if( clickRow != null){
    			var rowData = businessTrip_table.fnGetData(this); // 선택한 데이터 가져오기
        		if(editPossibleCheck(rowData[1])){
        			$("#btnDelete").show();
        		}
       			$('#businessTripForm .trap').attr("disabled",true);
       			$("#btnSave").removeClass('registBt').addClass('modifyBt').hide();

    			$.ajax({
    				url : "<c:url value='/app/businessTripDetailByIdAjax'/>",
    				data : {searchId : rowData[0]},
    				type : 'POST',
    				dataType : 'json',
    				success : function(data){
    					$('#businessTripForm #id').val(data.id);
    					$('#businessTripForm #tripRange').val(data.tripRange);
    					$('#startDt').val(data.startDt);
    					$('#endDt').val(data.endDt);

    					$('#businessTripForm #destination').val(data.destination);
    					$('#businessTripForm #memo').val(data.memo);

    				}
    			});
    			$('#modal_businessTrip').modal('show');

    		}
    	});


    	$('#btnSave').click(function(e){
       		e.preventDefault();
       		if($('#businessTripForm').valid()){
       			if($(this).hasClass('registBt')){
       				registBusinessTrip();
       			}else{
       				//editBusinessTrip();
       			}
       		};
       	});

    	function registBusinessTrip(){
    		$.ajax({
   				url: "<c:url value='/app/businessTripInsertAjax'/>",
   				data: $("#businessTripForm").serialize(),
   				type: 'POST',
   				dataType: 'json',
   				beforeSend: function () {
   		        },
   		        complete: function () {
   		        },
   				success: function(data){
   					fnClickAddRow(data);
   					businessTrip_table.fnDraw();
   					businessTripFormReset();
   				}
   			});
    	}
		/*
    	function editBusinessTrip(){
    		var startDt = $('#tripRange').val().split('~')[0].trim();
    		if(editPossibleCheck(startDt)==false){
    			alert('지난 데이터는 수정할 수 없습니다.');
    			return;
    		}
    		$.ajax({
   				url: "<c:url value='/app/businessTripEditAjax'/>",
   				data: $("#businessTripForm").serialize(),
   				type: 'POST',
   				dataType: 'json',
   				beforeSend: function () {
   		        },
   		        complete: function () {
   		        },
   				success: function(data){
   					fnClickUpdateRow(data);
   					businessTripFormReset();
   				}
   			});
    	}
		*/

    	$('#btnDelete').click(function(e){

    		var startDt = $('#startDt').val();
    		if(editPossibleCheck(startDt)==false){
    			alert('지난 데이터는 삭제할 수 없습니다.');
    			return;
    		}
	    	if (confirm("삭제 하시겠습니까?")){
	    		$.ajax({
	   				url: "<c:url value='/app/businessTripDeleteAjax'/>",
	   				data: $("#businessTripForm").serialize(),
	   				type: 'POST',
	   				dataType: 'json',
	   				beforeSend: function () {
	   		        },
	   		        complete: function () {
	   		        },
	   				success: function(data){
	   					if(data==1){
		   					businessTrip_table.fnDeleteRow(clickRow);
		   					businessTripFormReset();
	   					}else{
	   						alert("삭제 오류 발생.");
	   					}
	   				}
	   			});
    		}
    	});

    	$("#businessTripForm").validate({
    		rules: {
    			startDt: { required: true }
    			,endDt: { required: true }
    			,destination: { required: true }

          }
    	});
    });

      function businessTripList(){
       	$.ajax({
			url: "<c:url value='/app/getUserBusinessTripListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				businessTrip_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				businessTrip_table.fnDraw();
			}
		});
       }

	function editPossibleCheck(appDate){ //appDate (YYYY-MM-DD)
		var currDate = moment();
		var appDate = moment(appDate,'YYYY-MM-DD');
		var res = currDate.diff(appDate,'days');
		//console.log(res);
		if(res<=0){
			return true;
		}else{
			return false;
		}
	}

    function fnClickAddRow(data){
    	var a = businessTrip_table.fnAddData( [
					data.id, data.startDt,data.endDt, data.destination,data.crtdId,data.crtdDt,data.mdfyId,data.mdfyDt
				], false);

    }
    function fnClickUpdateRow(data){
    	businessTrip_table.fnUpdate( [
					data.id, data.startDt,data.endDt, data.destination,data.crtdId,data.crtdDt,data.mdfyId,data.mdfyDt
				], clickRow);
    }
    function businessTripFormReset(){
    	$('#businessTripForm #id').val(0);
		$('#startDt, #endDt').val(moment().format('YYYY-MM-DD'));
		$('#startDt, #endDt').datepicker('setDate', moment().format('YYYY-MM-DD'));
		$('#businessTripForm #destination').val('');
		$('#businessTripForm #memo').val('');
		$('#businessTripForm .trap').attr("disabled",false);
		$("#btnDelete").hide();

		$('#modal_businessTrip em.invalid').hide();
    	$('#modal_businessTrip .form-control').removeClass('invalid');

    	$("#btnSave").removeClass('modifyBt').addClass('registBt').show();

		$('#modal_businessTrip').modal('hide');
    }
</script>
</body>