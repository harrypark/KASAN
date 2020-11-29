<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%@ taglib uri="http://www.springframerep.org/tags" prefix="spring"%> --%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>대체근무</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>대체근무</h5>
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
                <div class="col-lg-3 col-md-6 col-sm-6">
                	<div class="input-group input-daterange search-daterange">
					    <input type="text" class="form-control trap" id="fromDate" name="fromDate" readonly="readonly"/>
					    <span class="input-group-addon">to</span>
					    <input type="text" class="form-control trap" id="toDate" name="toDate" readonly="readonly">
					</div>
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
                    <select class="form-control chosen" id="searchUser" name="searchUser">
                        <option value="all">전체</option>
                    </select>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
<!--                 	<button class="btn btn-w-m btn-primary m-r-sm" data-toggle="modal"  data-keyboard="false" data-backdrop="static" type="button"  data-target="#modal_replace"  data-keyboard="false" data-backdrop="static"> Add </button> -->
                	<button class="btn btn-w-m btn-primary m-r-sm" id="addModal" data-keyboard="false" data-backdrop="static" type="button"  data-keyboard="false" data-backdrop="static"> Add </button>
                </div>
              </div>
              </form>
          </div>
			<div class="row">
				 <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="replace_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th>ID</th>
			            <th>등록자ID</th>
			            <th>빠지는날</th>
			            <th>시작시간</th>
			            <th>종료시간</th>
			            <th>채우는날</th>
			            <th>등록자</th>
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

<!-- Modal (replace) start  -->
<div class="modal inmodal fade modal_replace" id="modal_replace" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">

	            <h4 class="modal-title">대체근무정보</h4>
	            <p style="font-weight: 300; margin-bottom: 0px;"><i class="fa fa-check-circle-o text-danger"></i> 필수 입력 항목입니다.</p>
	        </div>
	        <form class="form-horizontal" name="replaceForm" id="replaceForm" action="">
	        <input type="hidden" id="id" name="id" value="0"/>
	        <input type="hidden" id="term" name="term" value="0"/>
	        <input type="hidden" id="inLunch" name="inLunch" value="N"/>
	        <div class="modal-body">
	        	<div class="form-group rep-info"><label class="col-sm-3 control-label"></label>
	                <div class="col-sm-9"><label class="control-label text-info">이달 남은 대체근무 신청가능 일수 : <span id="availReplaceCount"></span>회</label></div>
	            </div>
	            <div class="form-group rep-info hl-info"><label class="col-sm-3 control-label"></label>
	                <div class="col-sm-9"><label class="control-label text-danger"> <span id="replDtInfo"></span> 에는 반휴가 신청되어 있습니다. 다른날을 선택하세요.</label></div>
	            </div>
	        	<div class="form-group"><label class="col-sm-3 control-label">빠지는날 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="replDt" id="replDt" class="form-control rep" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">시작시간 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-3">
	                	<input type="text" class="form-control rep replStartTm" id="replStartTm" name="replStartTm"/>
	                </div>
	                 <div class="col-sm-6 rep-info">
	                		<label class="control-label text-info"><span id="replStartTm"></span> 부터 <span id="availReplaceHr"></span> 신청가능</label>
	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">종료시간 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-3">
	                	<input type="text" class="form-control rep replEndTm" id="replEndTm" name="replEndTm"/>
	                </div>
	                <div class="col-sm-6 rep-info">
	                		<label class="control-label text-info">점심시간은  자동으로 제외 됩니다.</label>
	                </div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">채우는날 <i class="fa fa-check-circle-o text-danger"></i></label>
	                <div class="col-sm-9"><input type="text" name="suppleDt" id="suppleDt" class="form-control su_rep" readonly="readonly"></div>
	            </div>
	            <div class="form-group"><label class="col-sm-3 control-label">메모 </label>
	                <div class="col-sm-9"><textarea id="memo" name="memo" class="form-control su_rep"></textarea></div>
	            </div>
	         </div>

	        <div class="modal-footer">
	        	<a class="btn btn-danger pull-left" id="btnDelete" style="display: none;">Delete</a>
	            <a class="btn btn-white" id="btnCancel">Cancel</a>
	            <a class="btn btn-primary registBt " id="btnAdd">Save</a>
	        </div>
			</form>
	    </div>

	</div>
</div>
<!-- Modal (replace) end  -->


<form name="deleteForm" id="deleteForm">
<input type="hidden" id="id" name="id">
</form>

<!-- Modal (replace) end  -->

<!-- Page-Level Scripts -->
<script>
//minToHour
var replace_table;
var clickRow;
var availStartTm = moment('${replace.replStartTm}', 'HH:mm');
var tempStartTm = moment('${replace.replStartTm}', 'HH:mm');
var availReplaceCount;
var availReplaceMin;
   $(document).ready(function(){
	   replace_table = $('#replace_table').dataTable({
		   dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
           buttons: [
               { extend: 'copy'},
               //{extend: 'csv'},
               {extend: 'excel', title: '대체근무_'+moment().format('YYYYMMDDHHmmss')},
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
	   	replace_table.fnSetColumnVis(0, false);//index hide
	   	replace_table.fnSetColumnVis(1, false);//crtd id
	  	//$('div#replace_table_wrapper div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" data-toggle="modal"  data-keyboard="false" data-backdrop="static" type="button"  data-target="#modal_replace"  data-keyboard="false" data-backdrop="static"> Add </button>');

	   	$('.search-daterange').datepicker({
        	format: 'yyyy-mm-dd',
       		language: "kr",
       		startDate: '2016-08-01',
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            todayHighlight: true
        }).on('hide', function(){
        	getReplace();
        });
       	$('#fromDate').val(moment().subtract(15, 'days').format('YYYY-MM-DD'));
       	$('#toDate').val(moment().add(15, 'days').format('YYYY-MM-DD'));
       	$('#fromDate').datepicker('setDate', moment().subtract(15, 'days').format('YYYY-MM-DD'));
    	$('#toDate').datepicker('setDate', moment().add(15, 'days').format('YYYY-MM-DD'));

	  	
	  	getReplace();

	  	
	  	$('#suppleDt').datepicker({
    		startDate: 'today',
    		endDate :  new moment().add(30,'days').format("YYYY-MM-DD")
        });
	  	
	  	$('#replDt').datepicker({
    		startDate: 'today',
    		endDate :  new moment().add(30,'days').format("YYYY-MM-DD")
        }).on('hide', function(e) {
        	checkAvailableReplaceInfo();
        });

	  	replaceFormReset();
        

        $('#replDt, #suppleDt').datepicker().on('hide', function(e) {
        	$(this).blur();
        	if($(this).val()==''){
 	        	$(this).val(moment().format('YYYY-MM-DD'));
 	        }
 	    });

        $('input.replStartTm, input.replEndTm').timeAutocomplete({
		    formatter: '24hr',
		    auto_value:false
		});

        $('#replStartTm, #replEndTm').change(function(){
        	if($(this).val().substr(0,2)=='12'){
        		$(this).val('13:00');
        	}
        });

	/*
   //대체근무 모달 open 신청가능횟수 체크
   $('#modal_replace').on('shown.bs.modal', function () {
	   checkAvailableReplaceInfo();
   })
	*/
	$('#addModal').click(function(){
		checkAvailableReplaceInfo();
		$('#modal_replace').modal('show');
	})




	//add replace
	$('#btnAdd').click(function(e){
		e.preventDefault();

		if($(this).hasClass('registBt')){

			var replStartTm = moment($('#replStartTm').val(), 'HH:mm');
			var replEndTm = moment($('#replEndTm').val(), 'HH:mm');
			var replDt =  moment($('#replDt').val(), 'YYYY-MM-DD');
			var suppleDt= moment($('#suppleDt').val(), 'YYYY-MM-DD');

			var lunchStart = moment('12:00', 'HH:mm');
			var lunchEnd = moment('13:00', 'HH:mm');

			//var maxReplaceMi = Number('${dr.maxReplaceHr}')*60;

			//시작시간 8시이전
			if(replStartTm.isBefore(availStartTm)){
				alert("대체근무 신청 가능시간을 확인  하세요.");
				return;
			}
			if(!replStartTm.isBefore(replEndTm)){
				alert("종료시간은 시작시간 이후로 선택하세요.");
				return;
			}
			//최대시간인지
			var term = replEndTm.diff(replStartTm, 'minutes');
			//console.log('원래:'+term);
			if(replStartTm.isBefore(lunchStart) && replEndTm.isAfter(lunchEnd)){
				term = (term - 60 < 0?0:term - 60);
				//점심포함
				$('#inLunch').val('Y');
				//console.log('차감1:'+term);
			}
			if($('#replEndTm').val()=='13:00'){
				term = (term - 60 < 0?0:term - 60);
				//점심포함
				$('#inLunch').val('Y');
				//console.log('차감2:'+term);
			}

			if(term > availReplaceMin){
				alert("최대 신청 가능시간은 "+ minToHour(availReplaceMin) +" 입니다.(점심시간제외.)");
				return;
			}
			/*--------------------------------------
			 * 채우는날이은 빠지는날이후
			 * 2016-12-02 조건삭제 요청으로 삭제
			 -------------------------------------*/
			/*
			 if(suppleDt.isBefore(replDt)){
				alert("채우는날은 빠지는날 이후만 가능합니다.");
				return;
			}
			*/
			$('#term').val(term);

			if($('#replaceForm').valid()){
				registReplace();
			}
		}else{
			if($('#replaceForm').valid()){
				editReplace();
			}
		}
	})

   $('#btnCancel').click(function(){
	   replaceFormReset();
   })

	$("#replaceForm").validate({
		rules: {
			replDt: { required: true },
			replStartTm: { required: true },
			replEndTm: { required: true},
			suppleDt: { required: true }

	  }
	});

	$('div.wrapper-content').on('click','table#replace_table tbody tr',function(){
		 clickRow = replace_table.fnGetPosition(this);
		if( clickRow != null){
			var rowData = replace_table.fnGetData(this); // 선택한 데이터 가져오기
			if(rowData[1] != '${info.id}') return; //자신의 Id가 이니면 Exit
			
			$('#replaceForm .rep, #replaceForm .su_rep').attr("disabled",true);
			$("#btnAdd").hide();
			//console.log(rowData[0]);
			//삭제가능체크 - 빠지는날이 지났는가?
			if(deletePossibleCheck(rowData[2]) && deletePossibleCheck(rowData[5])){
   				$("#btnDelete").show();
   			}

			//수정가능체크 - 채우는날이 지났는가?
			if(editPossibleCheck(rowData[5])){
	   			$('#replaceForm .su_rep').attr("disabled",false);
	   			$("#btnAdd").removeClass('registBt').addClass('modifyBt').show();
   			}

			$(".rep-info").hide();

			$.ajax({
				url : "<c:url value='/app/replaceDetailAjax'/>",
				data : {searchId : rowData[0]},
				type : 'POST',
				dataType : 'json',
				success : function(data){
						$('#replaceForm #id').val(data.id);
						$('#replaceForm #replDt').val(data.replDt);
	
						$('#replaceForm #replStartTm').val(data.replStartTm);
						$('#replaceForm #replEndTm').val(data.replEndTm);
						$('#replaceForm #suppleDt').val(data.suppleDt);
						//수정시 등록일 기준으로 30일 동안만 수정가능 [20180626]
						//$('#suppleDt').datepicker('setStartDate', editSupplyStartDt(data.replDt,data.suppleDt));
						$('#suppleDt').datepicker('setStartDate', moment(data.crtdDt).format('YYYY-MM-DD'));
						$('#suppleDt').datepicker('setEndDate', moment(data.crtdDt).add(30, 'days').format('YYYY-MM-DD'));
	
						$('#replaceForm #memo').val(data.memo);
						$('#replaceForm #id').val(data.id);
						$('#deleteForm #id').val(data.id);
						$('#modal_replace').modal('show');
				}
			});
			

		}
	});

	$('#btnDelete').click(function(e){
		var startDt = $('#replDt').val();
		if(deletePossibleCheck(startDt)==false){
			alert('지난 데이터는 삭제할 수 없습니다.');
			return;
		}
		if (confirm("삭제 하시겠습니까?")){
			$.ajax({
					url: "<c:url value='/app/replaceDeleteAjax'/>",
					data: $("#deleteForm").serialize(),
					type: 'POST',
					dataType: 'json',
					beforeSend: function () {
			        },
			        complete: function () {
			        },
					success: function(data){
						if(data==1){
	  					//replace_table.fnDeleteRow(clickRow);
	  					getReplace();
	  					replaceFormReset();
						}else{
							alert("삭제 오류 발생.");
						}
					}
				});
		}
	});

	searchDeptUser();
	$("#searchDept").change(function(){
		searchDeptUser('deptChange');
	})
	
	$('#searchUser').change(function(){
		getReplace();
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
				
				if(type == 'deptChange'){
					getReplace();
				}
			}
		});
   }
   
	function checkAvailableReplaceInfo(){
		 $.ajax({
				url : "<c:url value='/app/checkAvailableReplaceInfoAjax'/>",
				data: {searchDt:$('#replDt').val()},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					
					availReplaceCount = data.currCount;
					$('#modal_replace #availReplaceCount').text(availReplaceCount);
					availReplaceMin = data.todayMin;
					$('#modal_replace #availReplaceHr').text(minToHour(availReplaceMin));

					availStartTm = moment(data.availStartTm, 'HH:mm');
					$('#modal_replace #replStartTm').text(data.availStartTm);

					$('#modal_replace #replStartTm').val(moment(availStartTm).format('HH:mm'));
					if(moment(availStartTm).format('HH:mm') != moment(tempStartTm).format('HH:mm')){
						//console.log('다르다');
						$('#modal_replace #replStartTm').attr("readonly",true);
					}else{
						//console.log('같다');
						$('#modal_replace #replStartTm').attr("readonly",false);
					}
					$('#modal_replace #replEndTm').val(moment(availStartTm).add(1,'hours').format('HH:mm'));
					
					if(data.hasHl == 'yes'){
						$('.hl-info').show();
						$('#replDtInfo').text($('#replDt').val());
						$('#btnAdd').addClass('disabled');
					}else{
						$('.hl-info').hide();
						$('#replDtInfo').text('');
						$('#btnAdd').removeClass('disabled');
					}


				}
			});
	}



	function registReplace(){
		   $.ajax({
				url: "<c:url value='/app/replaceInsertAjax'/>",
			data: $("#replaceForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){

				if(data.availReplaceCountOver == true){
					alert("이달 대체근무 가능일을 모두 사용하셨습니다.");
					return;
				}
				/*
				반휴와 채우는 날 중복 신청 허용(대신 지각 체크는 하지 않고, 근무시간만 밚(4시간)+채우는 시간으로 설정)
				2016-12-20 채변리사님 요청

				if(data.hlSuppDuplicate == true){
					alert("반휴와 채우는날은 함께 사용할수 없습니다.다른 채우는날을 선택해주세요.");
					return;
				}
				*/

				//fnClickAddRow(data);
				//replace_table.fnDraw();
				getReplace();
				replaceFormReset();
				}
			});
	   }
	function editReplace(){
		   $.ajax({
				url: "<c:url value='/app/replaceEditAjax'/>",
			data: $("#replaceForm").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				//fnClickUpdateRow(data);
				//replace_table.fnDraw();
				getReplace();
				replaceFormReset();
				}
			});
	   }


	function getReplace(){
		$.ajax({
			url: "<c:url value='/app/replaceListAjax'/>",
			data: $("#searchParam").serialize(),
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				replace_table.fnClearTable();
				for( var i=0; i<data.length; i++){
					fnClickAddRow(data[i]);
				}
				replace_table.fnDraw();
			}
		});
	 }


	function fnClickAddRow(data){
		replace_table.fnAddData( [
					data.id,data.crtdId,data.replDt, data.replStartTm,data.replEndTm, data.suppleDt, data.crtdNm, data.crtdDt,data.mdfyId, data.mdfyDt
				], false);

	}
	function fnClickUpdateRow(data){
		replace_table.fnUpdate( [
					data.id,data.crtdId,data.replDt, data.replStartTm,data.replEndTm, data.suppleDt, data.crtdNm, data.crtdDt,data.mdfyId, data.mdfyDt
				], clickRow);
	}


	function replaceFormReset(){
		$('#replaceForm .rep,#replaceForm .su_rep').attr("disabled",false);
		$('#modal_replace #replStartTm').val(moment(availStartTm).format('HH:mm'));
		if(moment(availStartTm).format('HH:mm') != moment(tempStartTm).format('HH:mm')){
			$('#modal_replace #replStartTm').attr("readonly",true);
		}else{
			$('#modal_replace #replStartTm').attr("readonly",false);
		}
		$('#modal_replace #replEndTm').val(moment(availStartTm).add(1,'hours').format('HH:mm'));
		$('#modal_replace #replDt').val(moment().format('YYYY-MM-DD'));

		$('#modal_replace #suppleDt').val(moment().add(1, 'days').format('YYYY-MM-DD'));
		$('#suppleDt').datepicker('setStartDate', 'today');
		$('#modal_replace #inLunch').val('N');
		$('#modal_replace #memo').val('');
		$('#modal_replace #id').val('0');
		$('#modal_replace #term').val('0');

		$('.form-control').removeClass('error');
		$("#btnAdd").removeClass('modifyBt').addClass('registBt').show();

		$("#btnDelete").hide();




		$(".rep-info").show();


		$('#modal_replace').modal('hide');
	}




	function deletePossibleCheck(appDate){ //appDate (YYYY-MM-DD)
		var currDate = moment();
		var appDate = moment(appDate,'YYYY-MM-DD');
		var res = currDate.diff(appDate,'days');
		//console.log(res);
		if(res<=0){
			return true;
		}else{
			return false;
		}
	}

	function editPossibleCheck(suppDate){
		return deletePossibleCheck(suppDate);
	}

	//수정시 빠지는날의시작날짜게산
	function editSupplyStartDt(repl,supple){
		var replDt =  moment(repl, 'YYYY-MM-DD');
		var suppleDt= moment(supple, 'YYYY-MM-DD');
		var today= moment(moment().format('YYYY-MM-DD'),'YYYY-MM-DD');

		if(replDt.isBefore(today)){
			return moment().format('YYYY-MM-DD');

		}else{
			return moment().format('YYYY-MM-DD');
			//return moment(repl, 'YYYY-MM-DD').add(1, 'days').format('YYYY-MM-DD');
		}

	}



 </script>
 </body>