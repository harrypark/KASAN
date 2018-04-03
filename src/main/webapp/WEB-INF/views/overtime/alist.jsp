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
                	 <select class="form-control chosen" id="searchState" name="searchState">
                        <option value="all">결과_전체</option>
                        <c:forEach items="${otList}" var="list">
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



<!-- Page-Level Scripts -->
    <script>
    var overtime_table;
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
    	,"bFilter" : false
		, "bPaginate": true
		//, "sPaginationType" : "bootstrap_full"
		, "bRetrieve": true
		, "bDeferRender": false
		, "aaSorting": [[ 0, "desc" ]]
   			,"autoWidth": false

		});
    	//$('div#overtime_table_wrapper div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" type="button" data-toggle="modal"  data-keyboard="false" data-backdrop="static" data-target="#modal_overtime" style="margin-bottom: 0px;"> Add </button>');

    	$('#searchDM').val(moment().format('YYYY-MM'));
    	$('#searchDM').datepicker({
    		format: 'yyyy-mm',
            minViewMode: 1,
            todayBtn:false
        }).on('hide', function(e) {
        	//overtimeList();
        });

    	$('#btnSearch').click(function(){
    		overtimeList();
    	})


    	overtimeList();

    });

      function overtimeList(){
       	$.ajax({
			url: "<c:url value='/overtime/alistAjax'/>",
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




    </script>
</body>