function addAttachInput(){
	
	let fileInputSize = $("#attachInputDiv").children("div").length;
	
	$("#attachInputDiv").append(
	
			"<div class='d-flex text-muted pt-3' id='inputFileDiv_" + (fileInputSize+1) +"'>" +
				"<input type='file' id='upload_" + (fileInputSize+1) + "' name='upload_" + (fileInputSize+1) +"'>" +
				"<button class='btn btn-outline-dark btn-sm' id='deleteInput_" + (fileInputSize+1) +"'" +
				" onclick='deleteInput(" + (fileInputSize+1) + ")'>삭제</button>" +
			"<div/>"
			
	);
	
}

function deleteInput(index) {
	
	$("#inputFileDiv_" + index).remove();
	
}