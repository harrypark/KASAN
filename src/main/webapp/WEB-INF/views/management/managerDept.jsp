<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>매니져-부서관리</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>매니져목록</h5>
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
                	<input type="text" placeholder="성명 " class="input form-control" name="searchText" id="searchText"/>
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
                 <button type="button" class="btn btn-w-m btn-primary" id="btnSearch" >검색</button>
<!--                  <button type="button" class="btn btn-w-m btn-primary" id="btnReset" style="display: none;">초기화</button> -->
                </div>
              </div>
              </form>
          </div>
          <div class="row">
          	<div class="col">
				<div class="panel panel-info">
                     <div class="panel-heading">
                         	<i class="fa fa-info-circle"></i> 부서별 관리 매니져 숫자
                     </div>
                     <div class="panel-body dept-manager-count">
	          			<c:forEach items="${deptList}" var="list">
	                          	${list.name }<span class="badge m-r-md" id="dept_${list.code }">0</span>
	                    </c:forEach>
                     </div>

                 </div>
			</div>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="user_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th>ID</th>
			            <th>캡스ID</th>
			            <th>캡스성명</th>
			            <th>부서</th>
			            <th>직급</th>
			            <th>관리부서</th>
			            <th>상태</th>
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

<!-- Modal (user) start  -->
<div class="modal inmodal fade modal_user" id="modal_user" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">매니져-부서관리</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.
	            </p>
	        </div>
	        <form class="form-horizontal" name="userForm" id="userForm" action="">
	        <input type="hidden" name="id" id="id" value="0"/>
	        <input type="hidden" name="mdeptCd" id="mdeptCd" value=""/>
	        <div class="modal-body">
	        	<div class="form-group"><label class="col-sm-3 control-label">캡스ID <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="capsId" id="capsId" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">캡스성명 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="capsName" id="capsName" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">부서 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="deptName" id="deptName" class="form-control" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">관리부서  <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9">
                       <c:forEach items="${deptList}" var="list" varStatus="i">
                       	<input type="checkbox" name="dept_cd" value="${list.code }">${list.name }
                       	<c:if test="${i.count mod 2 eq 0 }">
                       	<br/>
                       	</c:if>
                       </c:forEach>
	                </div>
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
<!-- Modal (user) end  -->
<!-- Date range use moment.js same as full calendar plugin -->
<script src="<c:url value="/resources/js/moment.js"/>"></script>
<!-- Data picker -->
<script src="<c:url value="/resources/js/plugins/datapicker/bootstrap-datepicker.js"/>"></script>


<!-- Page-Level Scripts -->
    <script>
    var user_table;
    var clickRow;
    var deptMap = new Map();
    $(document).ready(function(){
    	user_table = $('#user_table').dataTable({
    		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '메니쟈부서관리_'+moment().format('YYYYMMDDHHmmss')},
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
    	,"bFilter" : false
		, "bPaginate": true
		//, "sPaginationType" : "bootstrap_full"
		, "bRetrieve": true
		, "bDeferRender": false
		, "aaSorting": [[ 0, "asc" ]]
   			,"autoWidth": false

		});
    	//$('div#user_table_wrapper div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" type="button" data-toggle="modal"  data-keyboard="false" data-backdrop="static" data-target="#modal_user" style="margin-bottom: 0px;"> Add </button>');

    	<c:forEach items="${deptList}" var="list">
    		deptMap.put("${list.code }", "${list.name }");
        </c:forEach>


        deptManagerCount();
    	managerList();

    	$('#btnSearch').click(function(){
    		managerList();
    	});
    	$('#btnCancel').click(function(){
    		userFormReset();
    	});
    	$('div.wrapper-content').on('click','table#user_table tbody tr',function(){
    		 clickRow = user_table.fnGetPosition(this);
    		if( clickRow != null){
    			var rowData = user_table.fnGetData(this); // 선택한 데이터 가져오기
    			//console.log(rowData[0]);
     			$("#btnSave").removeClass('registBt').addClass('modifyBt');
    			$.ajax({
    				url : "<c:url value='/management/managerDetailAjax'/>",
    				data : {searchId : rowData[0]},
    				type : 'POST',
    				dataType : 'json',
    				success : function(data){
    					$('#id').val(data.id);
    					$('#capsId').val(data.capsId);
    					$('#capsName').val(data.capsName);
    					$('#deptName').val(data.deptName);
    					$('#authCd').val(data.authCd);
    					if(typeof data.mdeptCd =="undefined"){

    					}else{
    						var splitCode = data.mdeptCd.split(",");
        					for (var idx in splitCode) {
        						$("input[name=dept_cd][value=" + splitCode[idx] + "]").prop("checked", true);
        					}
    					}


    				}
    			});
    			$('#modal_user').modal('show');

    		}
    	});

    	$('#modal_user').on('show.bs.modal', function (event) {

  		})

		$('#btnSave').click(function(e){
	   		e.preventDefault();
	   		if($('#userForm').valid()){
	   			var deptCds =$.map($("#userForm input:checkbox:checked"), function (n, i) {
	   			    return n.value;
	   			}).join(',');
	   		    $('#mdeptCd').val(deptCds);
	   			editUser();
	   		};
	   	});



    	$("#userForm").validate({
    		rules: {
    			capsId: { required: true }
          }
    	});
    });


      function managerList(){
       	$.ajax({
			url: "<c:url value='/management/managerListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				user_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				user_table.fnDraw();
			}
		});
       }

    function fnClickAddRow(data){
    	var a = user_table.fnAddData( [
					data.id, data.capsId, data.capsName, data.deptName, data.positionName,parsDeptName(data.mdeptCd),data.stateName
				], true);

    }
    function fnClickUpdateRow(data){
    	user_table.fnUpdate( [
					data.id, data.capsId, data.capsName, data.deptName, data.positionName,parsDeptName(data.mdeptCd),data.stateName
				], clickRow);
    }

    function parsDeptName(mdeptCds){
    	if (typeof mdeptCds =="undefined") return '-';

    	var deptArray = new Array();
    	var cds = mdeptCds.split(',');
    	for(var i=0 ; i<cds.length ; i++){
    		deptArray[i]= deptMap.get(cds[i]);
    	}
    	return deptArray.join(',');
    }

    function userFormReset(){
    	$('#id').val('0');
		$('#capsId').val('');
		$('#capsName').val('');
		$("input[name=dept_cd]:checkbox").each(function() {
			$(this).prop('checked', false) ;
		});
		$('#mdeptCd').val('');
		$("#btnSave").removeClass('modifyBt').addClass('registBt');

    	$('label.error').hide();
    	$('.form-control').removeClass('error');

		$('#modal_user').modal('hide');
    }

    function deptManagerCount(){
    	$.ajax({
			url : "<c:url value='/management/deptManagerCountAjax'/>",
			type : 'POST',
			dataType : 'json',
			success : function(data){
				$('.dept-manager-count .badge').removeClass('badge-danger');
				if(data.length>0){
					for(var i=0; i<data.length;i++){
						$('#dept_'+data[i].code).text(data[i].count);
						if(data[i].count==0){
							$('#dept_'+data[i].code).addClass('badge-danger');
						}
					}
				}
			}
		});
    }


    function editUser(){
		$.ajax({
			url: "<c:url value='/management/managerEditAjax'/>",
			data: $("#userForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
					fnClickUpdateRow(data);
					userFormReset();
					deptManagerCount();
			}
		});
}



    </script>
</body>