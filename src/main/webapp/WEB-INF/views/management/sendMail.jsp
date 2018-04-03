<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>메일관리</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>메일관리</h5>
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
                       <li class="active"><a data-toggle="tab" href="#tab-1" id="sendType">발송관리</a></li>
                       <li class=""><a data-toggle="tab" href="#tab-2" id="mailContent">지각메일내용</a></li>
                       <li class=""><a data-toggle="tab" href="#tab-3" id="mailDefault">지각메일기본수신인</a></li>
                   </ul>
                   <div class="tab-content">
                       <div id="tab-1" class="tab-pane active">
                           <div class="panel-body">
                               <!-- dataTable start -->
				               <div class="table-responsive">
							        <table id="rawData_table" class="table table-striped table-bordered table-hover" >
								        <thead>
								        <tr>
								        	<th style="width: 20px;"></th>
								            <th>Type</th>
								            <th>설명</th>
								        </tr>
								        </thead>
								        <tbody>
								        	<tr>
								        		<td><input type="radio" name="mailType" class="mailType" value="A"/></td>
								        		<td>발송 하지 않음 </td>
								        		<td>메일을 발송하지 않는다.</td>
								        	</tr>
								        	<tr>
								        		<td><input type="radio" name="mailType" class="mailType" value="B"/></td>
								        		<td>개발자에게만 발송</td>
								        		<td>테스트단계에서 사용하고 개발자에게는 발송.</td>
								        	</tr>
								        	<tr>
								        		<td><input type="radio" name="mailType" class="mailType" value="C"/></td>
								        		<td>매니져 발송</td>
								        		<td>부서를 관리하는 메니져에게만 발송</td>
								        	</tr>
								        	<tr>
								        		<td><input type="radio" name="mailType" class="mailType" value="D"/></td>
								        		<td>매니져 + 관리부서 발송</td>
								        		<td>부서를 관리하는 메니져와 해당 부서의 상황을 알고 있어야 하는 관리부서에 속한 모든 직원에게  발송.</td>
								        	</tr>
								        	<tr>
								        		<td><input type="radio" name="mailType" class="mailType" value="E"/></td>
								        		<td>전체발송</td>
								        		<td>재직중인 직원 전체 에게 발송.</td>
								        	</tr>

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
				                    <table id="content_table" class="table table-striped table-bordered table-hover" >
				                    <thead>
				                    <tr>
				                        <th>id</th>
				                        <th>종류</th>
				                        <th>내용</th>
				                        <th>등록일</th>
				                        <th>수정일</th>
				                    </tr>
				                    </thead>
				                    <tbody>
				                    <!-- content List here -->
				                    </tbody>
				                    </table>
				              </div>
                               <!-- dataTable end -->
                           </div>
                       </div>
                       <div id="tab-3" class="tab-pane">
                           <div class="panel-body">
                           <div class="row">
	                            <div class="col-sm-12"><i class="fa fa-info-circle"></i> 여러명 등록시 ,(콤마)로 구분합니다. ex) user1@gmail.com,user2@gmail.com</div>
							</div>
                           	<!-- dataTable start -->
                               <div class="table-responsive">
				                    <table class="table table-striped table-bordered table-hover" >
				                    <colgroup>
				                    	<col width="150px;"/><col width="*"/>
				                    </colgroup>
					                    <thead>
						                    <tr>
						                        <th>종류</th>
						                        <th>Email</th>
						                    </tr>
					                    </thead>
					                    <tbody>
						                    <tr>
						                    	<td>지각안내메일</td>
						                    	<td><input type="text" name="lateDefaultAddr" id="lateDefaultAddr" style="width: 400px;"/> <button type="button" class="btn btn-primary btn-sm l-p-5" id="lateSave">변경</button></td>
						                    </tr>
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
<!-- Modal (mailContent) start  -->
<div class="modal inmodal fade modal_mailContent" id="modal_mailContent" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">메일내용</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="mailContentForm" id="mailContentForm" action="">
	        <input type="hidden" id="id" name="id"/>
	        <div class="modal-body">
	            <div class="form-group"><label class="col-sm-3 control-label">종류 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="type" id="type" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">내용 <i class="fa fa-check-circle-o text-danger"></i> </label>
	                <div class="col-sm-9"><textarea id="content" name="content" class="form-control"></textarea></div>
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
<!-- Modal (mailContent) end  -->


<!-- Page-Level Scripts -->
    <script>
    var content_table;
    var clickRow;
	var currValue='';
    $(document).ready(function(){
    	content_table = $('#content_table').dataTable({
    		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '메일내용_'+moment().format('YYYYMMDDHHmmss')},
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
    	$('div#content_table_wrapper div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" type="button" data-toggle="modal"  data-keyboard="false" data-backdrop="static" data-target="#modal_mailContent" style="margin-bottom: 0px;"> Add </button>');

    	getSendType();

    	$('#sendType').click(function(){
    		getSendType();
    	});
    	$('#mailContent').click(function(){
    		getMailContent();
    	});
    	$('#mailDefault').click(function(){
    		getMailDefault();
    	});



    	$('.mailType').click(function(){
    		var clickValue = $(this).val();
    		if(currValue != clickValue){
    			if(confirm("메일발송 방법을 변경 하시겠습니까?")){
    				updateSendType(clickValue);
    			}else{
    				$(".mailType:radio[value='"+ currValue +"']").prop("checked", true) ;
    			}
    		}
    	});

    	// mailContent
    	$('#btnCancel').click(function(){
    		mailContentFormReset();
    	});

    	$("#mailContentForm").validate({
    		rules: {
    			type: { required: true, maxlength:20 }
    			,content: { required: true }
          }
    	});

    	$('#btnSave').click(function(e){
       		e.preventDefault();
       		if($('#mailContentForm').valid()){
       			if($(this).hasClass('registBt')){
       				registMailContent();
       			}else{
       				updateMailContent();
       			}
       		};
       	});

    	$('div.wrapper-content').on('click','table#content_table tbody tr',function(){
	   		 clickRow = content_table.fnGetPosition(this);
	   		if( clickRow != null){
	   			var rowData = content_table.fnGetData(this); // 선택한 데이터 가져오기
      			$("#btnSave").removeClass('registBt').addClass('modifyBt');

	   			$.ajax({
	   				url : "<c:url value='/management/getMailContentDetailAjax'/>",
	   				data : {searchId : rowData[0]},
	   				type : 'POST',
	   				dataType : 'json',
	   				success : function(data){
	   					$('#mailContentForm #id').val(data.id);
	   					$('#mailContentForm #type').val(data.type);
	   					$('#mailContentForm #content').val(data.content);
	   				}
	   			});
	   			$('#modal_mailContent').modal('show');

	   		}
	   	});

    	function registMailContent(){
    		$.ajax({
   				url: "<c:url value='/management/mailContentInsertAjax'/>",
   				data: $("#mailContentForm").serialize(),
   				type: 'POST',
   				dataType: 'json',
   				beforeSend: function () {
   		        },
   		        complete: function () {
   		        },
   				success: function(data){
   					fnClickAddRow(data);
   					content_table.fnDraw();
   					mailContentFormReset();
   				}
   			});
    	}

    	function updateMailContent(){
    		$.ajax({
   				url: "<c:url value='/management/mailContentEditAjax'/>",
   				data: $("#mailContentForm").serialize(),
   				type: 'POST',
   				dataType: 'json',
   				beforeSend: function () {
   		        },
   		        complete: function () {
   		        },
   				success: function(data){
   					fnClickUpdateRow(data);
   					content_table.fnDraw();
   					mailContentFormReset();
   				}
   			});
    	}

    	$('#lateSave').click(function(){
    		$.ajax({
    			url: "<c:url value='/management/updateMailDefaultAjax'/>",
    			data:{lateDefaultAddr:$('#lateDefaultAddr').val()},
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
                    toastr.success('', '메일주소가 변경 되었습니다.');

    			}
    		});
    	})




    });

    function getMailContent(){
    	$.ajax({
			url: "<c:url value='/management/getMailContentListAjax'/>",
			//data: $("#searchParam").serialize(),
			type: 'GET',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				content_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				content_table.fnDraw();
			}
		});
    }

    function fnClickAddRow(data){
    	var a = content_table.fnAddData( [data.id, data.type, data.content,data.crtdDt,data.mdfyDt], true);

    }
    function fnClickUpdateRow(data){
    	content_table.fnUpdate( [data.id, data.type, data.content,data.crtdDt,data.mdfyDt], clickRow);
    }

    function mailContentFormReset(){
    	$('#mailContentForm #id').val(0);
		$('#mailContentForm #type').val('');
		$('#mailContentForm #content').val('');

		$('#modal_mailContent em.invalid').hide();
    	$('#modal_mailContent .form-control').removeClass('invalid');

    	$("#btnSave").removeClass('modifyBt').addClass('registBt').show();

		$('#modal_mailContent').modal('hide');
    }

    function getSendType(){
       	$.ajax({
			url: "<c:url value='/management/getMailSendTypeAjax'/>",
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				currValue = data;
				$(".mailType:radio[value='"+ currValue +"']").prop("checked", true) ;

			}
		});
       }
    function updateSendType(val){

    		$.ajax({
    			url: "<c:url value='/management/updateMailSendTypeAjax'/>",
    			data:{sendType:val},
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
                    toastr.success('', '메일발송 방법이 변경 되었습니다.');
    				currValue = val;
    				$(".mailType:radio[value='"+ val +"']").attr("checked", true) ;

    			}
    		});
    }

    function getMailDefault(){
    	$.ajax({
			url: "<c:url value='/management/getMailDefaultAjax'/>",
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				$('#lateDefaultAddr').val(data);

			}
		});
    }





    </script>
</body>