<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>연차관리</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>연차목록</h5>
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
                	<select class="form-control chosen" id="searchYear" name="searchYear">
                        <c:forEach var="i" begin="2016" end="2030" step="1">
                        	<option value="${i}">${i}년</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12">
                	<select class="form-control chosen" id="searchId" name="searchId">
                		<option value="all">전체</option>
                        <c:forEach var="list" items="${userList }">
                        	<option value="${list.id}">${list.capsName}</option>
                        </c:forEach>
                    </select>
                </div>
              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="annual_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th>등록여부</th>
			            <th>년도</th>
			            <th>ID</th>
			            <th>캡스ID</th>
			            <th>캡스성명</th>
			            <th>연차</th>
<!-- 			            <th>사용연차</th> -->
<!-- 			            <th>차감연차</th> -->
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
<div class="modal inmodal fade modal_annual" id="modal_annual" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title" id="annual_title">연차등록</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="annualForm" id="annualForm" action="">
	        <input type="hidden" name="chk" id="chk"/>
	        <div class="modal-body">
	        	<div class="form-group"><label class="col-sm-3 control-label">년도</label>
	                <div class="col-sm-9"><input type="text" name="year" id="year" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">ID</label>
	                <div class="col-sm-9"><input type="text" name="id" id="id" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">캡스성명(캡스ID)</label>
	                <div class="col-sm-9"><input type="text" name="capsName" id="capsName" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">연차<i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="availCount" id="availCount" class="form-control"></div>
	            </div>
	            <div class="form-group" style="display: none;"><label class="col-sm-3 control-label">사용연차</label>
	                <div class="col-sm-9"><input type="text" name="usedCount" id="usedCount" class="form-control" disabled="disabled""></div>
	            </div>
	            <div class="form-group" style="display: none;"><label class="col-sm-3 control-label">차감연차</label>
	                <div class="col-sm-9"><input type="text" name="deductCount" id="deductCount" class="form-control" disabled="disabled"></div>
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
    var annual_table;
    var clickRow;
    $(document).ready(function(){
    	annual_table = $('#annual_table').dataTable({
    		dom: '<"html5buttons"B>lTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '연차관리_'+moment().format('YYYYMMDDHHmmss')},
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
		, "aaSorting": [[ 2, "asc" ]]
   			,"autoWidth": false

		});



    	$('#searchYear').val(moment().format('YYYY'));
    	$('#searchYear, #searchId').change(function(){
    		annualList();
    	})

    	annualList();


    	$('#btnCancel').click(function(){
    		annualFormReset();
    	});
    	$('div.wrapper-content').on('click','table#annual_table tbody tr',function(){
    		 clickRow = annual_table.fnGetPosition(this);
    		if( clickRow != null){
    			var rowData = annual_table.fnGetData(this); // 선택한 데이터 가져오기
    			$.ajax({
    				url : "<c:url value='/management/annualDetailAjax'/>",
    				data : {searchYear : rowData[1],searchId : rowData[2]},
    				type : 'get',
    				dataType : 'json',
    				success : function(data){
    					$('#chk').val(data.chk);
    					$('#id').val(data.id);
    					$('#year').val(data.year);
    					$('#capsName').val(data.capsName+"("+data.capsId+")");
    					$('#availCount').val(data.availCount);
    					$('#usedCount').val(data.usedCount);
    					$('#deductCount').val(data.deductCount);
    					if(data.chk=='0000'){
        					$('#annual_title').text('연차등록');
    					}else{
    						$('#annual_title').text('연차수정');
    					}

    				}
    			});
    			$('#modal_annual').modal('show');

    		}
    	});


    	$('#btnSave').click(function(e){
       		e.preventDefault();
       		if($('#annualForm').valid()){
       			$.ajax({
       				url: "<c:url value='/management/annualEditAjax'/>",
       				data: $("#annualForm").serialize(),
       				type: 'POST',
       				dataType: 'json',
       				beforeSend: function () {
       		        },
       		        complete: function () {
       		        },
       				success: function(data){
       					fnClickUpdateRow(data);
       					annualFormReset();
       				}
       			});

       		};
       	});

    	$("#annualForm").validate({
    		rules: {
    			availCount: { required: true , number:true}
          }
    	});
    });


      function annualList(){
       	$.ajax({
			url: "<c:url value='/management/annualListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				annual_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				annual_table.fnDraw();
			}
		});
       }


    function fnClickAddRow(data){
    	if(data.chk=='0000'){
    		btnHtml = '<span class="label label-danger">미등록</span>';
    	}else{
    		btnHtml = '<span class="label label-primary">등록</span>';
    	}
    	var a = annual_table.fnAddData( [
					 btnHtml,data.year, data.id, data.capsId, data.capsName, data.availCount //, data.usedCount,data.deductCount
				], false);

    }
    function fnClickUpdateRow(data){
    	if(data.chk=='0000'){
    		btnHtml = '<span class="label label-danger">미등록</span>';
    	}else{
    		btnHtml = '<span class="label label-primary">등록</span>';
    	}
    	annual_table.fnUpdate( [
					btnHtml,data.year, data.id, data.capsId, data.capsName, data.availCount //, data.usedCount,data.deductCount
				], clickRow);
    }
    function annualFormReset(){
		$('#modal_annual em.invalid').hide();
    	$('#modal_annual .form-control').removeClass('invalid');

		$('#modal_annual').modal('hide');
    }
</script>
</body>