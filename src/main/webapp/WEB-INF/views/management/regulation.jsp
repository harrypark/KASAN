<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<body>
<!-- title start -->
<div class="row wrapper border-bottom white-bg">
    <div class="col-lg-9">
        <h2>사규관리</h2>
    </div>
</div>
<!-- title end -->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
       <div class="ibox-title">
           <h5>사규관리</h5>
           <div class="ibox-tools">
               <a class="collapse-link">
                   <i class="fa fa-chevron-up"></i>
               </a>
           </div>
       </div>
       <div class="ibox-content">
       	 <div class="row well">
	       	  <form id="uploadForm" name="uploadForm" enctype="multipart/form-data" method="post">
	       	  <div class="form-group">
                <div class="col-lg-3 col-md-6 col-sm-12">
                	<label for="file" class="input input-file">
						<input name="file" id="file" type="file">
					</label>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12">
                	<a class="btn btn-sm btn-success disabled" id="btnUpload"> 사규등록 </a>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12">
                	가장 최신 데이터가 적용됩니다.
                </div>
              </div>
              </form>
          </div>

			<div class="row">
               <!-- dataTable start -->
               <div class="table-responsive">
			        <table id="regulation_table" class="table table-striped table-bordered table-hover" >
			        <thead>
			        <tr>
			            <th>ID</th>
			            <th>파일명</th>
			            <th>크기</th>
			            <th>등록자</th>
			            <th>등록일</th>
			            <th>삭제</th>
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
<!-- fileForm은 default_layout 사용 -->
<!-- <form id="fileForm" method="post"> -->
<!-- 	<input type="hidden" id="fileId" name="fileId" /> -->
<!-- </form> -->




<!-- Page-Level Scripts -->
    <script>
    var agent = navigator.userAgent.toLowerCase();

    $(document).ready(function(){
    	regulationList();
    	//pdf 파일 선택
		$('#file').change(function(){
			var ext = $(this).val().split('.').pop().toLowerCase();
		    if($.inArray(ext, ['pdf']) == -1) {
		    	alert('PDF 파일만 가능합니다.');
		    	 var agent = navigator.userAgent.toLowerCase();
				 if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
				 	$(this).replaceWith( $("#file").clone(true) );
				 }else {
				 	$(this).val("");
				 }
			 $('#fileName').val('');
		    }else{
		      $('#fileName').val($(this).val());
		    }
		    buttonCheck();
		})

    	$('#btnUpload').click(function(e) {
        	var form=$("#uploadForm")[0];
			//var formData = new FormData(form);
			var formData = new FormData();
			formData.append("file", $("input[name=file]")[0].files[0]);
			formData.append("dbTp", $("#dbTp").val());

            $.ajax({
                url: "<c:url value='/management/fileUpload'/>",
                type: "post",
                dataType: "json",
                data: formData,
                // cache: false,
                processData: false,
                contentType: false,
                success: function(data) {
                	regulationTableHtml(data,'prepend');
                	toastr.options = {
                        closeButton: true,
                        progressBar: true,
                        showMethod: 'slideDown',
                        timeOut: 4000
                    };
                    toastr.success('', '파일이 등록 되었습니다.');
                    $('#btnUpload').addClass("disabled");
                    //file비우기
                    if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
    				 	$(this).replaceWith( $("#file").clone(true) );
    				 }else {
    					 $("#file").val("");
    				 }

                }, error: function(jqXHR, textStatus, errorThrown) {}
            });
            return false;

        });


    	//file 삭제
    	$('table#regulation_table tbody').on('click','.delBtn',function(){
    		if(confirm("정말 삭제 하시겠습니까?")){
	    		var fileId=$(this).attr('id').split('_')[1];
	    		$.ajax({
	    			url: "<c:url value='/management/fileDeleteAjax'/>",
	    			type: 'POST',
	    			data: {fileId:fileId},
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
	                        toastr.success('', '파일이 삭제 되었습니다.');
	    				$('#file_'+fileId).remove();

	    			}
	    		});
    		}

    	})
    	//download
    	$('table#regulation_table tbody').on('click','.downBtn',function(){
    		var fileId=$(this).attr('id').split('_')[1];
    		var url = "<c:url value='/management/fileDownloadAjax'/>";
			var form = $("#fileForm");
			$("input:hidden[id=fileId]", form).val(fileId);
			form.attr("action", url);
			form.attr("target", "downloadFrame");
			form.get(0).submit();

    	})



    });

  //upload button 활성화 체크
	function buttonCheck(){
		if($('#file').val() !=''){
			$('#btnUpload').removeClass("disabled");
		}else{
			$('#btnUpload').addClass("disabled");
		}

	}


      function regulationList(){
       	$.ajax({
			url: "<c:url value='/management/regulationListAjax'/>",
			type: 'POST',
			dataType: 'json',
			beforeSend: function () {
	        },
	        complete: function () {
	        },
			success: function(data){
				for( var i=0; i<data.length; i++){
					regulationTableHtml(data[i],'append');
				}

			}
		});
       }
      function regulationTableHtml(data,type){

    	  var delBtn = '<button class="btn btn-danger btn-sm delBtn" id="del_'+data.fileId+'" type="button">삭제</button>';
    	  var downBtn = '<button class="btn btn-success btn-sm downBtn" id="down_'+data.fileId+'" type="button">Download</button>';

    	  var sb = new StringBuffer();
    	  sb.append('<tr id="file_'+data.fileId+'">');
    	  sb.append('    <td>'+data.fileId+'</td>');
    	  sb.append('    <td>'+data.orgName+' ' +downBtn+'</td>');
    	  sb.append('    <td>'+data.size+'bytes </td>');
    	  sb.append('    <td>'+data.crtdId+'</td>');
    	  sb.append('    <td>'+data.crtdDt+'</td>');
    	  sb.append('    <td>'+delBtn+'</td>');
    	  sb.append('</tr>');

		if(type=='append'){
    	  $('table#regulation_table tbody').append(sb.toString());
		}else{
    	  $('table#regulation_table tbody').prepend(sb.toString());
		}

      }




</script>
</body>