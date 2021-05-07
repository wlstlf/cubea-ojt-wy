const bId = $("#bId").val();

// 댓글 등록
function getReplyCreate(parentId) {
	
	let content = "";
	let replyLevel = "";
	
	if ( parentId != null ) {
		content = $("#reComment_" + parentId).val();
		replyLevel = 1;
		parentId = parentId;
		
	} else {
		content = $("#comment").val();
		replyLevel = '0';
		parentId = '0';
	}
	
	$.ajax({
		
		url : "board_reply_action.jsp?CRUD=C&b_Id=" + bId,
		type : "POST",
		data : "content=" + content + "&rLv=" + replyLevel + "&pId=" + parentId,
		success : function() {
			
			getReplyList();	
			
		}, error:function(request,status,error){
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
		
	});
	
}

// 댓글 수정
function getReplyUpdate(replyId){
	
	let content = $("#replyUpdate_" + replyId).val();
	
	if( confirm("댓글을 수정하시겠습니까?!") == true ) {
	
		$.ajax({
			
			url : "board_reply_action.jsp?CRUD=U&r_Id=" + replyId,
			type : "POST",
			data : "content=" + content,
			success : function() {
				
				getReplyList();
				
			}, error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
			
		});
	}
}

function getReplyDelete(replyId) {
	
	if ( confirm("댓글을 삭제하시겠습니까?") == true ) {
	
		$.ajax({
			
			url : "board_reply_action.jsp?CRUD=D&r_Id=" + replyId,
			type : "GET",
			success : function() {
				
				getReplyList();
				
			}, error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
			
		});
	
	}
	
}

// 댓글 목록
function getReplyList(){
	
	$.ajax({
		
		url : "board_reply_action.jsp?CRUD=R&b_Id=" + bId,
		type : "GET",
		success : function(data) {
		
			$("#commentListForm").html(data);
			// 대댓글 입력창 숨기기
			$("div[id*='hiddenReply_']").hide();
			$("span[id*='replyUpdateInput_']").hide();
			$("span[id*='recommentUpdateInput_']").hide();
			
		}, error:function(request,status,error){
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
	});
	
}

$(document).ready(function (){
	
	getReplyList();
	
});


function showReplyBtn(replyId) {
	
	$("#hiddenReply_" + replyId).toggle();
	$("div[id*=hiddenReply_]").not($("#hiddenReply_" + replyId)).hide();
	
}

function replyUpdateBtn(replyId) {
	
	// b태그
	$("#replyContent_" + replyId).toggle();
	// span 태그
	$("#replyUpdateInput_" + replyId).toggle();
	// span 태그
	$("#recommentUpdateInput_" + replyId).toggle();
	// span 태그
	$("#recommentContent_" + replyId).toggle();
	
}

function upDownSubmit(replyId, UD) {
	
	$.ajax({
		
		url : "reply_updown_action.jsp",
		type : "POST",
		data : "r_Id=" + replyId + "&UD=" + UD,
		success : function(result) {
			
			if( result.trim() == 1 ) alert("이미 참여하셨습니다.");
			
			getReplyList();
			
		}, error:function(request,status,error){
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
		
	});
	
	
}