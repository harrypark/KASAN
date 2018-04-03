<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>자동연차관리</h2>
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
	       	  <input type="hidden" id="searchOption" name="searchOption" value="curr"/>
	       	  <div class="form-group">
<!-- 	       	  	<div class="col-lg-2 col-md-6 col-sm-12"> -->
<!--                 	 <select class="form-control chosen" id="searchOption" name="searchOption"> -->
<!--                         <option value="curr">현재연차</option> -->
<!--                         <option value="all">과거연차포함</option> -->
<!--                     </select> -->
<!--                 </div> -->
                <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchDept" name="searchDept">
                        <option value="all">부서_전체</option>
                        <c:forEach items="${deptList}" var="list">
                        	<option value="${list.code }">${list.name }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                	<input type="text" placeholder="성명 " class="input form-control" name="searchText" id="searchText"/>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchState" name="searchState">
                        <option value="all">상태_전체</option>
                        <c:forEach items="${stateList}" var="list">
                        	<c:if test="${list.code ne '003' }">
                        		<option value="${list.code }">${list.name }</option>
                        	</c:if>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                 <button type="button" class="btn btn-w-m btn-primary" id="btnSearch" >검색</button>
                </div>
                 <c:if test="${authCd eq '003' }">
	                <div class="col-lg-2 col-md-6 col-sm-12">
	                 <button type="button" class="btn btn-w-m btn-info" id="btnAnnualCreate" >연차계산</button>
	                </div>
	            </c:if>
              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="annual_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th rowspan="2">ID</th>
			            <th rowspan="2">캡스ID</th>
			            <th rowspan="2">캡스성명</th>
			            <th rowspan="2">부서</th>
			            <th rowspan="2">상태</th>
			            <th rowspan="2">입사일</th>
			            <th rowspan="2">입사년차</th>
			            <th colspan="6" class="text-center">연차</th>

			            <th rowspan="2">수정일</th>
			        </tr>
			        <tr>
			        	<th>Type</th>
			            <th>자동계산(A)</th>
			            <th>보정(B)</th>
			            <th>사용가능(A+B)</th>
			            <th>시작일</th>
			            <th>종료일</th>
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

<!-- Modal (comPenAnnual) start  -->
<div class="modal inmodal fade modal_group" id="modal_comPenAnnual" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">연차보정</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="comPenAnnualForm" id="comPenAnnualForm" action="">
	        <input type="hidden" name="id" id="id" value="0"/>
	        <div class="modal-body">
	            <div class="form-group"><label class="col-sm-3 control-label">캡스성명</label>
	            	<div class="col-sm-9"><input type="text" name="name" id="name" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">연차시작일</label>
	                <div class="col-sm-9"><input type="text" name="startDt" id="startDt" class="form-control"  readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">연차종료일</label>
	                <div class="col-sm-9"><input type="text" name="endDt" id="endDt" class="form-control"  readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">연차보정 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="comAnnual" id="comAnnual" class="form-control"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">메모 <i class="fa fa-check-circle-o text-danger"></i> </label>
	                <div class="col-sm-9"><textarea id="memo" name="memo" class="form-control leave"></textarea></div>
	            </div>
	         </div>

	        <div class="modal-footer">
	            <a class="btn btn-white" id="btnComPenAnnualCancel">Cancel</a>
	            <a class="btn btn-primary registBt" id="btnComPenAnnualSave">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (comPenAnnual) end  -->



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
		, "aaSorting": [[ 0, "asc" ]]
   			,"autoWidth": false

		});

    	$('#btnSearch').click(function(){
    		annualList();
    	})

    	annualList();



    	$('#btnAnnualCreate').click(function(){
    		if(confirm("오늘 날짜기준으로 연차를 자동 계산 합니다.\n 실행 하시겠습니까?")){

	    		$.ajax({
	    			url: "<c:url value='/management/autoAnnualManualCreateAjax'/>",
	    			type: 'POST',
	    			//data: {fileId:fileId},
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
	                        toastr.success('', '연차가 계산 되었습니다.');
	                        annualList();

	    			}
	    		});
    		}
    	});

    	$('div.wrapper-content').on('click','table#annual_table tbody tr',function(){
   		 clickRow = annual_table.fnGetPosition(this);
   		if( clickRow != null){
   			var rowData = annual_table.fnGetData(this); // 선택한 데이터 가져오기
   			//console.log(rowData);
   			$.ajax({
   				url : "<c:url value='/management/getUserComPenAnnualAjax'/>",
   				data : {id : rowData[0], startDt: rowData[11], endDt:rowData[12]},
   				type : 'POST',
   				dataType : 'json',
   				success : function(data){
   					$("#id").val(data.id);
   					$('#name').val(rowData[2]);
   					$('#startDt').val(data.startDt);
   					$('#endDt').val(data.endDt);
   					$('#comAnnual').val(data.comAnnual);
   					$('#memo').val(data.memo);
   				}
   			});
   			$('#modal_comPenAnnual').modal('show');

   		}
   	});

   	$('#btnComPenAnnualCancel').click(function(e){
   		//e.preventDefault();
   		comPenAnnualFormReset();
   	});

   	$('#btnComPenAnnualSave').click(function(e){
   		e.preventDefault();
   		if($('#comPenAnnualForm').valid()){
   			editComPenAnnual();
   		};
   	});


   	$("#comPenAnnualForm").validate({
		rules: {
			comAnnual: { required: true, number:true },
			memo: { required: true }
      }
	});


});

	function editComPenAnnual(){

		 $.ajax({
	 			url: "<c:url value='/management/editComPenAnnualAjax'/>",
	 			data: $("#comPenAnnualForm").serialize(),
	 			type: 'POST',
	 			dataType: 'json',
	 			beforeSend: function () {
	 	        },
	 	        complete: function () {
	 	        },
	 			success: function(data){
	 				fnClickUpdateRowData(data);
	 				comPenAnnualFormReset();
	 			}
	 		});
	}

      function annualList(){
       	$.ajax({
			url: "<c:url value='/management/autoAnnualListAjax'/>",
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


    	var a = annual_table.fnAddData( [
			 data.id, data.capsId, data.capsName, data.deptName, data.stateName, data.hireDt, data.year, data.type,data.autoAnnual,comPenAnnualLabel(data.comAnnual),data.availCount, data.startDt,data.endDt,data.mdfyDt //, data.usedCount,data.deductCount
			], false);

    }

    function fnClickUpdateRowData(data){
    	annual_table.fnUpdate( [
			data.id, data.capsId, data.capsName, data.deptName, data.stateName, data.hireDt, data.year, data.type,data.autoAnnual,comPenAnnualLabel(data.comAnnual),data.availCount, data.startDt,data.endDt,data.mdfyDt
		], clickRow);
    }

    function comPenAnnualLabel(comAnnaul){
    	var label_color ="success";
    	var cpa = parseFloat(comAnnaul);

    	if(cpa != 0){
    		if(cpa < 0){
    			label_color ="danger";
    		}
    		cpa = '<span class="label label-'+label_color+'">'+cpa+'</span>';
    	}
    	return cpa;
    }

    function comPenAnnualFormReset(){
    	$('#modal_comPenAnnual #id').val('0');
    	$('#modal_comPenAnnual #name').val('');
    	$('#modal_comPenAnnual em.invalid').hide();
    	$('#modal_comPenAnnual .form-control').removeClass('invalid');


		$('#modal_comPenAnnual').modal('hide');
    }

</script>
</body>