function modifySubmit(){
	
	if ( $('#title').val() == '' ){
		
		alert("제목을 입력해주세요!");
		$('#title').focus();
		return false;
		
	}
		
	if ( $('#writer').val() == '' ){
		
		alert("작성자를 입력해주세요!");
		$('#writer').focus();
		return false;
		
	}
	
	if ( $('#content').val() == '' ){
		
		alert("내용을 입력해주세요!");
		$('#content').focus();
		return false;
		
	}
	
	$("#modifyForm").submit();
	
}

function attachDelete(index) {
	
	if( $("#attachArr_" + index).val() != '' ) {
		
		$("#attachFileName_" + index).css( "color" , "" );
		$("#attachFileName_" + index).css( "text-decoration" , "" );
		$("#attachDeleteBtn_" + index).attr('class','btn btn-outline-dark btn-sm');
		$("#attachDeleteBtn_" + index).text("삭제");
		$("#attachArr_" + index).val("");
		
	} else if ( $("#attachArr_" + index).val() == '' ) {
		
		$("#attachFileName_" + index).css( "color" , "#565656" );
		$("#attachFileName_" + index).css( "text-decoration" , "line-through" );
		$("#attachDeleteBtn_" + index).attr('class','btn btn-outline-success btn-sm');
		$("#attachDeleteBtn_" + index).text("복원");
		$("#attachArr_" + index).val(index);
		
	}
	
}