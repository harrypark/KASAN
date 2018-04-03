<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>근태점수</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>근태점수</h5>
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
                	 <select class="form-control chosen" id="searchDept" name="searchDept">
                        <c:if test="${authCd eq '003' }">
                        <option value="all">부서_전체</option>
                        </c:if>
                        <c:forEach items="${deptList}" var="list">
                        	<option value="${list.code }">${list.name }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 col-sm-12">
                    <select class="form-control chosen" id="searchUser" name="searchUser">
                        <option value="all">전체</option>
                    </select>
                </div>

                <div class="col-lg-2 col-md-6 col-sm-12">
                 <button type="button" class="btn btn-w-m btn-primary" id="btnSearch" >검색</button>
                </div>

              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="score_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th rowspan="2">id</th>
			            <th rowspan="2">성명</th>
			            <th rowspan="2">부서</th>
			            <th rowspan="2">입사일</th>
			            <th rowspan="2">연차시작일</th>
			            <th rowspan="2">연차종료일</th>
			            <th rowspan="2">연차</th>
			            <th colspan="2" style="text-align: center;">사용연차</th>
			            <th colspan="3" style="text-align: center;">차감연차</th>
			            <th rowspan="2">잔여연차</th>
			            <th rowspan="2">이달 대체근무가능일수</th>
			        </tr>
			        <tr>
			            <th>휴가</th>
			            <th>반휴</th>
			            <th>지각</th>
			            <th>근무시간미준수</th>
			            <th>무단결근</th>
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

<script src="<c:url value="/resources/js/dashboard-script.js"/>"></script>
<!-- Page-Level Scripts -->
    <script>
    var score_table;
    var clickRow;
    var memoLength=0;
    $(document).ready(function(){
    	score_table = $('#score_table').dataTable({
    		dom: '<"html5buttons"B>lTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '근태점수_'+moment().format('YYYYMMDDHHmmss')},
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

        $('#searchYear').val(moment().format('YYYY'));

    	getScoreList();


        $('#btnSearch').click(function(){
        	getScoreList();
        })


        $('#searchDept').change(function(){
        	$.ajax({
				url : "<c:url value='/management/getDeptUserAjax'/>",
				data : {searchDept : $(this).val()},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					$('#searchUser option').remove();
					$('#searchUser').append('<option value="all">전체</option>');
					for(var i=0; i<data.length;i++){
						$('#searchUser').append('<option value="'+data[i].id+'">'+data[i].capsName+'('+data[i].deptName+')</option>');
					}

				}
			});
        })
		$('#searchDept').trigger('change');

		 function getScoreList(){
	       	$.ajax({
				url: "<c:url value='/stat/getScoreListAjax'/>",
				data: $("#searchParam").serialize(),
				type: 'POST',
				dataType: 'json',
				beforeSend: function () {
		        },
		        complete: function () {
		        },
				success: function(data){
					score_table.fnClearTable();
					for( var i=0; i<data.length; i++){
						fnClickAddRow(data[i]);
					}
					score_table.fnDraw();
				}
			});
	       }


    });

    function fnClickAddRow(data){
    	var late =  data.subLate+' (단지각 '+data.subShort+'회, 장지각'+data.subLong+'회)';
	   	var a = score_table.fnAddData( [
					data.id, data.capsName, data.deptName,data.hireDt,data.startDt,data.endDt, data.availCount,  data.usedLeave ,data.usedHlLeave
					,late,data.subFailTm ,data.subAbsence ,data.currCount , data.currReplace
				], false);

    }

</script>
</body>