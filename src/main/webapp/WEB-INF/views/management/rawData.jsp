<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>Raw Data</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>Row Data</h5>
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
                <div class="col-lg-3 col-md-6 col-sm-12">
                    <select class="form-control chosen" id="searchUser" name="searchUser">
                        <option value="all">전체</option>
                        <c:forEach items="${ulist}" var="list">
                        	<option value="${list.selUserVal }">${list.selUserText }</option>
                        </c:forEach>
                    </select>
                </div>
<!--                 <div class="col-lg-3 col-md-6 col-sm-12"> -->
<!--                     <input type="text" placeholder="Search by UserName" class="input form-control" id="searchUserName"> -->
<!--                 </div> -->
                <div class="col-lg-3 col-md-6 col-sm-12">
                 <button type="button" class="btn btn-w-m btn-primary" id="btnSearch" >검색</button>
<!--                  <button type="button" class="btn btn-w-m btn-primary" id="btnReset" style="display: none;">초기화</button> -->
                </div>
              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="rawData_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th>AttDate</th>
			            <th>Gate</th>
			            <th>ID</th>
			            <th>UserName</th>
			            <th>Detail</th>
			            <th>Company</th>
			            <th>Team</th>
			            <th>Part</th>
			            <th>Grade</th>
			            <th>Card</th>
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
    var rawData_table;
    var clickRow;
    $(document).ready(function(){
    	rawData_table = $('#rawData_table').dataTable({
    		dom: '<"html5buttons"B>lTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                { extend: 'copy'},
                //{extend: 'csv'},
                {extend: 'excel', title: 'RawData_'+moment().format('YYYYMMDDHHmmss')},
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
		  "bFilter" : false
		, "bPaginate": true
		//, "sPaginationType" : "bootstrap_full"
		, "bRetrieve": true
		, "bDeferRender": true
		, "aaSorting": [[ 0, "asc" ]]
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
    });
   	$('#fromDate,#toDate').val(moment().format('YYYY-MM-DD'));
   	$('#fromDate').datepicker('setDate', moment().format('YYYY-MM-DD'));
	$('#toDate').datepicker('setDate', moment().format('YYYY-MM-DD'));

    	$('#btnSearch').click(function(){
    		getRawData();
    	})
    });

      function getRawData(){
       	$.ajax({
			url: "<c:url value='/management/rawDataListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				rawData_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				rawData_table.fnDraw();

			}
		});
       }


    function fnClickAddRow(data){
    	var a = rawData_table.fnAddData( [
					data.attDate, data.gate, data.id, data.userName, data.detail, data.company,data.team, data.part,data.grade,data.card
				], false);

    }




    </script>
</body>