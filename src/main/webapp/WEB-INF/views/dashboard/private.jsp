<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>일정검색</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>일정검색</h5>
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
                	<div class="input-group input-daterange search-daterange">
					    <input type="text" class="form-control trap" id="fromDate" name="fromDate" readonly="readonly"/>
					    <span class="input-group-addon">to</span>
					    <input type="text" class="form-control trap" id="toDate" name="toDate" readonly="readonly">
					</div>
                </div>
                
                <div class="col-lg-2 col-md-6 col-sm-12">
                    <select class="form-control chosen" id="searchText" name="searchText">
                        <option value="all">일정_전체</option>
                        <option value="wo">외근</option>
                        <option value="le">휴가</option>
                        <option value="hl">반휴</option>
                        <option value="re">대체(빠지는날)</option>
                        <option value="su">대체(채우는날)</option>
                        <option value="bt">출장</option>
                    </select>
                </div>
                 <div class="col-lg-2 col-md-6 col-sm-12">
                	 <select class="form-control chosen" id="searchDept" name="searchDept">
                        <option value="all">부서_전체</option>
                        <c:forEach items="${deptList}" var="list">
                        	<option value="${list.code }" <c:if test="${userDept eq list.code }">selected</c:if>>${list.name }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                    <select class="form-control chosen" id="searchUser" name="searchUser">
                        <option value="all">전체</option>
                    </select>
                </div>
              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="private_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			        	<th>구분</th>
			        	<th>부서</th>
			            <th>성명</th>
			            <th>시작일</th>
			            <th>종료일</th>
			            <th>장소</th>
			            <th>메모</th>
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
    var private_table;
//     var clickRow;
//     var woAvailStartTm = moment('${wotm.startTm}', 'HH:mm');
//     var woAvailEndTm = moment('${wotm.endTm}', 'HH:mm');
    $(document).ready(function(){

    	private_table = $('#private_table').dataTable({
    		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '일정검색_'+moment().format('YYYYMMDDHHmmss')},
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

    	$('.search-daterange').datepicker({
        	format: 'yyyy-mm-dd',
       		language: "kr",
       		startDate: '2016-08-01',
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            todayHighlight: true
        }).on('hide', function(){
        	privateList();
        });
       	$('#fromDate').val(moment().subtract(15, 'days').format('YYYY-MM-DD'));
       	$('#toDate').val(moment().add(15, 'days').format('YYYY-MM-DD'));
       	$('#fromDate').datepicker('setDate', moment().subtract(15, 'days').format('YYYY-MM-DD'));
    	$('#toDate').datepicker('setDate', moment().add(15, 'days').format('YYYY-MM-DD'));

    	//privateList();


    	
    	searchDeptUser('first');
    	$("#searchDept").change(function(){
    		searchDeptUser('deptChange');
    	})
    	
    	$('#searchText, #searchUser').change(function(){
    		privateList();
    	})
    	
    });
    
    function searchDeptUser(type){
    	$.ajax({
			url : "<c:url value='/management/getDeptUserAjax'/>",
			data : {searchDept : $('#searchDept').val()},
			type : 'POST',
			dataType : 'json',
			success : function(data){
				$('#searchUser option').remove();
				$('#searchUser').append('<option value="all">전체</option>');
				for(var i=0; i<data.length;i++){
					$('#searchUser').append('<option value="'+data[i].id+'">'+data[i].capsName+'('+data[i].deptName+')</option>');
				}
				if(type == 'first'){
					$('#searchUser').val('${userId}');
					privateList();
				}
				
				if(type == 'deptChange'){
					privateList();
				}
			}
		});
    }

      function privateList(){
       	$.ajax({
			url: "<c:url value='/dashboard/getPrivateAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				private_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				private_table.fnDraw();
			}
		});
       }

	
    function fnClickAddRow(data){
    	var a = private_table.fnAddData( [
    		'<span class="label label-'+data.code+'">'+data.type+'</span>', data.deptName, data.capsName,data.start, data.end, data.destination, data.description,data.crtdDt], false);

    }
    
    
</script>
</body>