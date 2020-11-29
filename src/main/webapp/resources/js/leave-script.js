 $(document).ready(function(){
	 leave_table = $('#leave_table').dataTable({
		 dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
         buttons: [
             { extend: 'copy'},
             //{extend: 'csv'},
             {extend: 'excel', title: '휴가_'+moment().format('YYYYMMDDHHmmss')},
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
		, "aaSorting": [[ 5, "asc" ]]
	  			,"autoWidth": false


		});
   	leave_table.fnSetColumnVis(0, false);//index hide
   	leave_table.fnSetColumnVis(1, false);//crtd_id
  	//$('div#tab-1 div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" data-toggle="modal" data-backdrop="static" type="button"  data-target="#modal_leave" data-backdrop="static"> Add </button>');

  	halfLeave_table = $('#halfLeave_table').dataTable({
  		dom: '<"html5buttons"B>lfTgt<"row"<"col-sm-5"i><"col-sm-7"p>>',
        buttons: [
            { extend: 'copy'},
            //{extend: 'csv'},
            {extend: 'excel', title: '반휴_'+moment().format('YYYYMMDDHHmmss')},
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
  	halfLeave_table.fnSetColumnVis(0, false);//index hide
  	halfLeave_table.fnSetColumnVis(1, false);//crtd_id
 	//$('div#tab-2 div.dataTables_filter').append('<button class="btn btn-w-m btn-primary m-r-sm" data-toggle="modal" data-backdrop="static" type="button"  data-target="#modal_halfLeave" data-backdrop="static"> Add </button>');



  	$('.search-daterange').datepicker({
    	format: 'yyyy-mm-dd',
   		language: "kr",
   		startDate: '2016-08-01',
        keyboardNavigation: false,
        forceParse: false,
        autoclose: true,
        todayHighlight: true
    }).on('hide', function(){
    	getList();
    });
   	$('#fromDate').val(moment().subtract(15, 'days').format('YYYY-MM-DD'));
   	$('#toDate').val(moment().add(15, 'days').format('YYYY-MM-DD'));
   	$('#fromDate').datepicker('setDate', moment().subtract(15, 'days').format('YYYY-MM-DD'));
	$('#toDate').datepicker('setDate', moment().add(15, 'days').format('YYYY-MM-DD'));

	searchDeptUser();
	$("#searchDept").change(function(){
		searchDeptUser('deptChange');
	})
	
	$('#searchUser').change(function(){
		getList();
	})


 })
 //휴가목록, 반휴목록 판단
 	function getList(){
	 $('ul#leaveTab li').each(function( index ) {
			if($(this).hasClass('active')){
			//console.log( index + ": " + $( this ).text() );
				if(index==0){
					getleave();
				}else if(index==1){
					gethalfLeave();
				}
			}
		})
 	}


	function halfLeaveFormReset(){
		$('#modal_halfLeave #hlDt').val(moment().format('YYYY-MM-DD'));
		$('#modal_halfLeave #hlDt').datepicker('update', moment().format('YYYY-MM-DD'));
		//$('#modal_halfLeave #hlDt').data('daterangepicker').setStartDate(moment().format('YYYY-MM-DD'));
		$('#modal_halfLeave #term').val('0.5');
		$('input:radio[name=offcial]:radio[value="N"]').prop("checked", true);
		$('#modal_halfLeave #memo').val('');

		$('.form-control').removeClass('invalid');

		$('#halfLeaveForm .hl').attr("disabled",false);
		$('#halfLeaveForm .curr').show();
		$("#btnhalfLeaveAdd").show();

		$("#btnhalfLeaveDelete").hide();

		$('#modal_halfLeave').modal('hide');
	}

	function fnClickAddRowhalfLeave(data){
		halfLeave_table.fnAddData( [
					data.id,data.crtdId,data.hlDt, data.term, data.offcial,data.crtdNm, data.crtdDt,data.mdfyId, data.mdfyDt
				], false);

	}
	function fnClickUpdateRowhalfLeave(data){
		halfLeave_table.fnUpdate( [
					data.id,data.crtdId,data.hlDt, data.term,  data.offcial,data.crtdNm, data.crtdDt,data.mdfyId, data.mdfyDt
				], clickRowhalfLeave);
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








