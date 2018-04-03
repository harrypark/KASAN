<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>지각통계</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>지각통계</h5>
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
                	<select class="form-control chosen" id="searchYear" name="searchYear">
                        <c:forEach var="i" begin="2016" end="2030" step="1">
                        	<option value="${i}">${i}년</option>
                        </c:forEach>
                    </select>
                </div>
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
                <c:if test="${authCd eq '003' }">
	                <div class="col-lg-2 col-md-6 col-sm-12">
	                 <button type="button" class="btn btn-w-m btn-info" id="btnStat" >통계생성</button>
	                </div>
	            </c:if>

              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="point_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th>년도</th>
			            <th>id</th>
			            <th>성명</th>
			            <th>부서</th>
			            <th>단지각</th>
			            <th>장지각</th>
			            <th>점수</th>
			            <th>메일발송횟수</th>
			            <th>마지막메일발송일</th>
			            <th>등록일</th>
			            <th>수정일</th>
<!-- 			            <th>메일수신인</th> -->
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
    var point_table;
    var clickRow;
    var memoLength=0;
    $(document).ready(function(){
    	point_table = $('#point_table').dataTable({
    		dom: '<"html5buttons"B>lTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: '지각통계_'+moment().format('YYYYMMDDHHmmss')},
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
    	"iDisplayLength": 25
    	,"bFilter" : false
		, "bPaginate": true
		//, "sPaginationType" : "bootstrap_full"
		, "bRetrieve": true
		, "bDeferRender": false
		, "aaSorting": [[ 1, "asc" ]]
   			,"autoWidth": false

		});

        $('#searchYear').val(moment().format('YYYY'));

    	getLatePointList();


        $('#btnSearch').click(function(){
        	getLatePointList();
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

		 function getLatePointList(){
	       	$.ajax({
				url: "<c:url value='/stat/getLatePointListAjax'/>",
				data: $("#searchParam").serialize(),
				type: 'POST',
				dataType: 'json',
				beforeSend: function () {
		        },
		        complete: function () {
		        },
				success: function(data){
					point_table.fnClearTable();
					for( var i=0; i<data.length; i++){
						fnClickAddRow(data[i]);
					}
					point_table.fnDraw();
				}
			});
	       }




    	$('#btnCancel').click(function(){
    		scoreInfoFormReset();
    	});

    	//통계생성
    	$('#btnStat').click(function(){
    		if (confirm("지각통계를 생성 하시겠습니까? 점수에 따라 해당 직원에게 메일이 발송될 수 있습니다.")){
    			$.ajax({
    					url: "<c:url value='/stat/lateStatUpdateAjax'/>",
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
    	                            timeOut: 10000
    	                        };
    						var result = '신규등록 :'+data[0]+' ,메일발송:'+data[1]+', 업데이트:'+data[2];

    	                    toastr.success(result,'지각점수가 생성 되었습니다.' );
    						getLatePointList();
    					}
    				});
    		}
    	})

    });

    function fnClickAddRow(data){
    	var mailCount = 0;
    	var lastMailSendDt = '-';
    	if(data.dashState == 'Y'){
    		mailCount = data.mailCount;
    		lastMailSendDt = data.lastMailSendDt;
    	}else{//파트너
    		mailCount = data.mailCount+"(파트너)";
    		lastMailSendDt = '-';
    	}
	   	var a = point_table.fnAddData( [
					data.year,data.id, data.capsName, data.deptName, data.shortLate,  data.longLate ,data.orgLatePoint
					,mailCount,lastMailSendDt ,data.crtdDt ,data.mdfyDt
				], false);

    }


    function scoreInfoFormReset(){
		$('#modal_scoreInfo em.invalid').hide();
    	$('#modal_scoreInfo .form-control').removeClass('invalid');

		$('#modal_scoreInfo').modal('hide');
    }
</script>
</body>