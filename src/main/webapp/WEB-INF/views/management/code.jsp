<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>코드관리</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>코드목록</h5>
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
	                       <li class="active"><a data-toggle="tab" href="#tab-1" id="codeGroup">코드그룹</a></li>
	                       <li class=""><a data-toggle="tab" href="#tab-2" id="codeData">코드데이터</a></li>
	                   </ul>
	                   <div class="tab-content">
	                       <div id="tab-1" class="tab-pane active">
	                           <div class="panel-body">
	                               <!-- dataTable start -->
	                               <div class="table-responsive">
					                    <table id="codeGrp_table" class="table table-striped table-bordered table-hover" >
					                    <thead>
					                    <tr>
					                        <th>No</th>
					                        <th>그룹명</th>
					                        <th>그룹코드</th>
					                        <th>등록자</th>
					                        <th>등록일</th>
					                        <th>수정자</th>
					                        <th>수정일</th>
					                    </tr>
					                    </thead>
					                    <tbody>
					                    <!-- code group list here -->
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
					                    <table id="codeData_table" class="table table-striped table-bordered table-hover" >
					                    <thead>
					                    <tr>
					                        <th>No</th>
					                        <th>그룹명</th>
					                        <th>그룹코드</th>
					                        <th>코드명</th>
					                        <th>코드키</th>
					                        <th>순서</th>
					                        <th>사용</th>
					                        <th>등록자</th>
					                        <th>등록일</th>
					                        <th>수정자</th>
					                        <th>수정일</th>
					                    </tr>
					                    </thead>
					                    <tbody>
					                    <!-- code data List here -->
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

<!-- Modal (codeGroup) start  -->
<div class="modal inmodal fade modal_group" id="modal_group" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">코드그룹</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="codeGroupForm" id="codeGroupForm" action="">
	        <input type="hidden" name="id" id="id" value="0"/>
	        <div class="modal-body">
	            <div class="form-group"><label class="col-sm-3 control-label">그룹명 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="name" required="required" id="name" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">그룹코드<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="groupKey" required="required" id="groupKey" class="form-control"></div>
	            </div>
	         </div>

	        <div class="modal-footer">
	            <a class="btn btn-white" id="btnGroupCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnGroupAdd">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (codeGroup) end  -->

<!-- Modal (codeData) start  -->
<div class="modal inmodal fade modal_data" id="modal_data" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">코드데이터</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="codeDataForm" id="codeDataForm" action="">
	        <input type="hidden" name="id" id="id" value="0"/>
	        <div class="modal-body">
	            <div class="form-group"><label class="col-sm-3 control-label">그룹코드 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="groupKey" name="groupKey">
                    	</select>
	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">코드명<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="name" required="required" id="name" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">코드순서<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="ord" required="required" id="ord" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">사용<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
	                	<select class="form-control chosen" id="uesYn" name="useYn">
	                		<option value="Y">사용</option>
	                		<option value="N">미사용</option>
                    	</select>
	                </div>
	            </div>
	         </div>

	        <div class="modal-footer">
	            <a class="btn btn-white" id="btnDataCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnDataAdd">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (codeData) end  -->
<!-- Date range use moment.js same as full calendar plugin -->
<script src="<c:url value="/resources/js/moment.js"/>"></script>
<!-- Data picker -->
<script src="<c:url value="/resources/js/plugins/datapicker/bootstrap-datepicker.js"/>"></script>

<!-- Page-Level Scripts -->
<script>
var codeGrp_table;
var codeData_table
var clickRowGroup;
var clickRowData;
   $(document).ready(function(){

   	codeGrp_table = $('#codeGrp_table').dataTable({
   		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
        buttons: [
            { extend: 'copy'},
            //{extend: 'csv'},
            {extend: 'excel', title: '코드그룹_'+moment().format('YYYYMMDDHHmmss')},
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
//    	codeGrp_table.fnSetColumnVis(0, false);//index hide
   	$('div#tab-1 div.dataTables_filter').append('<button class="btn btn-w-m btn-primary" data-toggle="modal"  data-keyboard="false" data-backdrop="static" type="button"  data-target="#modal_group"  data-keyboard="false" data-backdrop="static"> Add </button>');

   	codeData_table = $('#codeData_table').dataTable({
   		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
        buttons: [
            { extend: 'copy'},
            //{extend: 'csv'},
            {extend: 'excel', title: '코드데이터_'+moment().format('YYYYMMDDHHmmss')},
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
  	$('div#tab-2 div.dataTables_filter').append('<button class="btn btn-w-m btn-primary" data-toggle="modal"  data-keyboard="false" data-backdrop="static" type="button"  data-target="#modal_data"  data-keyboard="false" data-backdrop="static"> Add </button>');


	getCodeGroup();

	$('#codeGroup').click(function(){
		getCodeGroup();
	});
	$('#codeData').click(function(){
		getCodeData();
		getCodeGeoupSelect();
	})



	//add group
   	$('#btnGroupAdd').click(function(e){
   		e.preventDefault();
   		if($('#codeGroupForm').valid()){
   			if($(this).hasClass('registBt')){
   				registCodeGroup();
   			}else{
   				editCodeGroup();
   			}
   		};
   	});

	$("#codeGroupForm").validate({
		rules: {
			name: { required: true },
			groupKey: {  required: true },
      }
	});

	//add data
   	$('#btnDataAdd').click(function(e){
   		e.preventDefault();
   		if($('#codeDataForm').valid()){
   			if($(this).hasClass('registBt')){
   				registCodeData();
   			}else{
   				editCodeData();
   			}
   		};
   	});

	$("#codeDataForm").validate({
		rules: {
			groupKey: { required: true },
			name: { required: true },
			ord: {  required: true ,number: true},
      }
	});

	$('div.tab-content').on('click','table#codeGrp_table tbody tr',function(){
		 clickRowGroup = codeGrp_table.fnGetPosition(this);
		if( clickRowGroup != null){
			var rowData = codeGrp_table.fnGetData(this); // 선택한 데이터 가져오기
			//console.log(rowData[0]);
			$('#modal_group #groupKey').attr("disabled",true);
 			$("#btnGroupAdd").removeClass('registBt').addClass('modifyBt');

			$.ajax({
				url : "<c:url value='/management/codeGroupDetailAjax'/>",
				data : {id : rowData[0]},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#modal_group #id').val(data.id);
					$('#modal_group #name').val(data.name);
					$('#modal_group #groupKey').val(data.groupKey);
				}
			});
			$('#modal_group').modal('show');

		}
	});

	$('div.tab-content').on('click','table#codeData_table tbody tr',function(){
		 clickRowData = codeData_table.fnGetPosition(this);
		if( clickRowData != null){
			var rowData = codeData_table.fnGetData(this); // 선택한 데이터 가져오기
			//console.log(rowData[0]);
			$('#modal_data #groupKey').attr("disabled",true);
 			$("#btnDataAdd").removeClass('registBt').addClass('modifyBt');

			$.ajax({
				url : "<c:url value='/management/codeDataDetailAjax'/>",
				data : {id : rowData[0]},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#modal_data #id').val(data.id);
					$('#modal_data #groupKey').val(data.groupKey);
					$('#modal_data #name').val(data.name);
					$('#modal_data #ord').val(data.ord);
					$('#modal_data #useYn').val(data.useYn);
				}
			});
			$('#modal_data').modal('show');

		}
	});




	//add cancel
	$('#btnGroupCancel').click(function(e){
		//e.preventDefault();
		groupFormReset();
	});
	$('#btnDataCancel').click(function(e){
		//e.preventDefault();
		dataFormReset();
	});


 });

   function registCodeGroup(){
	   $.ajax({
			url: "<c:url value='/management/codeGroupInsertAjax'/>",
			data: $("#codeGroupForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				//console.log(data.isDuplicate);
				if(data.isDuplicate == true){
					alert("이미 사용중인 그룹키 입니다.");
				}else{
					fnClickAddRowCodeGroup(data);
					codeGrp_table.fnDraw();
					groupFormReset();
				}
			}
		});
   }

   function editCodeGroup(){
	   $.ajax({
			url: "<c:url value='/management/codeGroupEditAjax'/>",
			data: $("#codeGroupForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				fnClickUpdateRowCodeGroup(data);
				codeGrp_table.fnDraw();
				groupFormReset();
			}
		});
   }

    function groupFormReset(){
    	$('#modal_group #id').val('0');
    	$('#modal_group #name').val('');
    	$('#modal_group #groupKey').val('').attr("disabled",false);
		$('#modal_group em.invalid').hide();
    	$('#modal_group .form-control').removeClass('invalid');
    	$("#btnGroupAdd").removeClass('modifyBt').addClass('registBt');

		$('#modal_group').modal('hide');
    }

    function getCodeGroup(){
    	$.ajax({
			url: "<c:url value='/management/codeGroupListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				codeGrp_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRowCodeGroup(data[i]);
				}
				codeGrp_table.fnDraw();
			}
		});
     }

    function fnClickAddRowCodeGroup(data){
    	codeGrp_table.fnAddData( [
					data.id, data.name, data.groupKey, data.crtdId, data.crtdDt,data.mdfyId, data.mdfyDt
				], false);

    }
    function fnClickUpdateRowCodeGroup(data){
    	codeGrp_table.fnUpdate( [
					data.id, data.name, data.groupKey, data.crtdId, data.crtdDt,data.mdfyId, data.mdfyDt
				], clickRowGroup);
    }



    function getCodeData(){
    	$.ajax({
			url: "<c:url value='/management/codeDataListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				codeData_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRowCodeData(data[i]);
				}
				codeData_table.fnDraw();
			}
		});
     }

    function getCodeGeoupSelect(){
    	$.ajax({
			url: "<c:url value='/management/codeGroupListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				var shtml ='<option value="">선택</option>';
				for( var i=0; i<data.length; i++){
					shtml += '<option value="'+data[i].groupKey+'">'+data[i].name+'</option>';
				}
				$('#modal_data #groupKey').html(shtml);

			}
		});
    }

    function registCodeData(){
 	   $.ajax({
 			url: "<c:url value='/management/codeDataInsertAjax'/>",
 			data: $("#codeDataForm").serialize(),
 			type: 'POST',
 			dataType: 'json',
 			beforeSend: function () {
 	        },
 	        complete: function () {
 	        },
 			success: function(data){
 				fnClickAddRowCodeData(data);
 				codeData_table.fnDraw();
 				dataFormReset();
 			}
 		});
    }

    function editCodeData(){
 	   $.ajax({
 			url: "<c:url value='/management/codeDataEditAjax'/>",
 			data: $("#codeDataForm").serialize(),
 			type: 'POST',
 			dataType: 'json',
 			beforeSend: function () {
 	        },
 	        complete: function () {
 	        },
 			success: function(data){
 				fnClickUpdateRowCodeData(data);
 				dataFormReset();
 			}
 		});
    }

    function dataFormReset(){
    	$('#modal_data #id').val('0');
    	$('#modal_data #name').val('');
    	$('#modal_data #groupKey').val('').attr("disabled",false);;;
		$('#modal_data #name').val('');
		$('#modal_data #ord').val('');
		$('#modal_data #useYn').val('Y');
		$('#modal_data em.invalid').hide();
    	$('#modal_data .form-control').removeClass('invalid');
    	$("#btnDataAdd").removeClass('modifyBt').addClass('registBt');

		$('#modal_data').modal('hide');
    }

    function fnClickAddRowCodeData(data){
    	codeData_table.fnAddData( [
					data.id, data.groupName, data.groupKey,data.name,data.code,data.ord,data.useYn, data.crtdId, data.crtdDt,data.mdfyId, data.mdfyDt
				], false);

    }
    function fnClickUpdateRowCodeData(data){
    	codeData_table.fnUpdate( [
					data.id, data.groupName, data.groupKey,data.name,data.code,data.ord,data.useYn, data.crtdId, data.crtdDt,data.mdfyId, data.mdfyDt
				], clickRowData);
    }









 </script>
 </body>