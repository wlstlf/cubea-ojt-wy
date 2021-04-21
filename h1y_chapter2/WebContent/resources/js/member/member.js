function idCheck(id){
	
	var idReg = /^[a-z0-9]{5,20}$/;
	var check = true;
	
	if ( !idReg.test(id) ) {
		
		check = false;
		return check;
	}
	
	return check;
	
};


$(document).ready(function(){
	
	$("#idCheckButton").click(function(){
		
		var userId = $("#userId").val();
		var id = idCheck(userId);
		
		if ( userId != '' && id == true ){
		
			$.ajax({
				
				url : 'member_IdCheck_action.jsp?userId=' + userId,
				type : 'get',
				success : function(data) {
					
					var id = data.trim();
					
					if ( data == 1 ) {
						
						$(".idCheckBold").text("\"" + userId + "\" 는 현재 사용중인 ID 입니다 :(");
						$("#userId").css("border-color","#DC3545");
						$(".idCheck").css("color","#DC3545");
						$("#joinButton").attr("disabled", true);
						
					} else {
						
						$(".idCheckBold").text("\"" + userId + "\" 는 사용가능한 ID 입니다 :)");
						$("#userId").css("border-color","#198754");
						$(".idCheck").css("color","#198754");
						$("#idCheckYN").val('Y');
						$("#joinButton").attr("disabled", false);
						
					}
					
				},  error:function(request,status,error){
		             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		          }
				
			});
		} else {
			
			$(".idCheckBold").text("ID는 5~20자의 영문 소문자, 숫자만 사용 가능합니다 :(");
			$("#userId").css("border-color","#DC3545");
			$(".idCheck").css("color","#DC3545");
			$("#joinButton").attr("disabled", true);
			
			return false;
			
		}
	});
	
	
	$("#eMailSelectBox").change(function(){
		$("#eMailSelectBox option:selected").each(function(){
			
			if ( $(this).val() == 'self' ) {
				
				$("#eMailB").val('');
				$("#eMailB").attr("disabled", false);
				
			} else {
				
				$("#eMailB").val($(this).text());
				$("#eMailB").attr("disabled", true);
				
			}
			
		});
	});
	
});


function memberFormSubmit(){
	
	var passReg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
	var userId = $("#userId").val();
	var id = idCheck(userId);
	
	if ( $("#idCheckYN").val() == 'N' ) {
		
		alert("ID 중복체크를 해주세요 :(");
		$("#userId").focus();
		return false;
		
	}
	
	if ( userId == '' || id == false ) {
		
		alert("ID는 5~20자의 영문 소문자, 숫자만 사용 가능합니다 :(");
		$("#userId").focus();
		return false;
		
	}
	
	if ( !passReg.test($("#userPass").val()) ) {
		
		alert("비밀번호는 영문자,숫자,특수문자 1자 이상 조합하여 8~16자 사이로   입력해주세요!");
		$("#userPass").focus();
		return false;
		
	}
	
	if ( $("#userPass").val() != $("#userPassCheck").val() ) {
		
		alert("비밀번호가 일치하지 않습니다!");
		$("#userPassCheck").focus();
		return false;
		
	}
	
	if ( $("#userName").val() == '' ) {
		
		alert("이름을 입력해주세요!");
		$("#userName").focus();
		return false;
		
	}
	
	if ( $("#eMailF").val() == '' ) {
		
		alert("이메일을 입력해주세요!");
		$("#eMailF").focus();
		return false;
	
	}
	
	if ( $("#eMailB").val() == '' ){
		
		alert("이메일을 입력해주세요!");
		$("#eMailB").focus();
		return false;
		
	}
	
	$("#memberForm").attr("action","./member_action.jsp").submit();
	
}

function memberLogin() {
	
	if ( $("#loginUserId").val() == '' ) {
		
		alert("아이디를 입력해주세요 :(");
		$("#loginUserId").focus();
		return false
		
	}
	
 	if ( $("#loginUserPass").val() =='' ) {
 		
 		alert("비밀번호를 입력해주세요 :(");
		$("#loginUserPass").focus();
		return false
 		
 	}
 	
 	$("#loginForm").attr("action", "./member_login_action.jsp").submit();
	
}