<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정 페이지입니다</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<style type="text/css">

	.message{display: none}

	.pwdCheck_success {
		font-size: 14px;
		color: #00944a;
		display: none;
		padding: 20px;
	}
	.pwdCheck_Fail {
		font-size: 14px;
		color: #f85656;
		display: none;
		padding: 20px;
		
	}
	
	span{
		font-size: 14px;
		padding: 4px 10px;
		color: #f85656;
	
	}


</style>
<script type="text/javascript">



$(function(){
	
	/*
	비밀번호 형식 체크
	*/
	$("#newUserPwd").focusout(function(){
		isValidPwd();
	})
	
	function isValidPwd(){
		var id = $("#newUserPwd").val();
		
		var isNum = id.search(/[0-9]/g); //숫자 있는지 확인. 있으면 index 리턴. 없으면 -1. -> -1이면 안됨.
		var isLow = id.search(/[a-z]/g); //영소문자 있는지 확인. index 리턴. -> -1이면 안됨.
		var isUp = id.search(/[A-Z]/g); //영대문자 있는지 확인. 있으면 index 리턴. 없으면 -1. -> -1이면 안됨.
		var isSpace = id.search(/\s/); //공백 있는지 확인. 없으면 -1. -> -1 리턴해야함.
		var specialChar = id.search(/[~!@#$%^&*?\|=]/gi); //특수문자 있는지 확인. -> -1리턴해야함
		var isKorean = id.search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi); // -1리턴해야함.
		
		if(id.length<8){ //길이 체크
			$("#notValidPwd").css("display", "inline-block");
			return false;
		}else if(isNum<0 || isUp<0 || isLow<0 || isSpace!=-1 || specialChar!=-1 || isKorean!=-1){ //숫자, 영대문자, 공백, 특수문자, 한글 체크
			$("#notValidPwd").css("display", "inline-block");
			return false;
		}else{
			$("#notValidPwd").css("display", "none");
			return true;
		}
	}
	
	$("#newUserPwd").keyup(function(){
		isSamePwd = false;
		})
	
	isSamePwd = false;
	
	$("#newUserPwd2").focusout(function(){
		let pwd1 = $("#newUserPwd").val();
		let pwd2 = $("#newUserPwd2").val();
		
		if(pwd1!="" && pwd2!=""){
			if(pwd1 == pwd2){
				$('.pwdCheck_Fail').css("display", "none");
				$('.pwdCheck_success').css("display", "inline-block");
				isSamePwd = true;
			}else{
				$('.pwdCheck_success').css("display", "none");
				$('.pwdCheck_Fail').css("display", "inline-block");
				isSamePwd = false;
			}
		}else if(pwd1 != "" && pwd2 == ""){
			$('.pwdCheck_success').css("display", "none");
			$('.pwdCheck_Fail').css("display", "none");
			isSamePwd = false;
		}else{
			$('.pwdCheck_success').css("display", "none");
			$('.pwdCheck_Fail').css("display", "none");
			isSamePwd = false;
		}
	})
	
	$("#newUserPwd2").focusout(function(){
		let pwd1 = $("#newUserPwd").val();
		let pwd2 = $("#newUserPwd2").val();
		
		if(pwd1=="" && pwd2!=""){
			$('.pwdCheck_Fail').css("display", "inline-block");
			isSamePwd = false;
		}
		
	})
	
	/*
	 비밀번호 일치 여부 확인
	 */
	$("#updatePwdForm").submit(function(event){	
		if(!isSamePwd){
			swal("비밀번호 일치 여부를 확인해주세요.")
			event.preventDefault();
		}
		
		let pwd = $("#userPwd").val();
		let newPwd = $("#newUserPwd").val();
		
		if(pwd==newPwd){
			swal("새로운 비밀번호는 기존 비밀번호와 달라야합니다.")
			event.preventDefault();
		}
		
		if(!isValidPwd()){
			swal("비밀번호를 형식에 맞게 입력해주세요.");
			event.preventDefault();
		}
		
		swal("비밀번호 변경 완료! \n 다시 로그인 해 주세요.");

	})
	
})

</script>
</head>
<body>
		
<div id="sidebarHeader"><h3>비밀번호 수정</h3></div>
<h6>*기존 비밀번호와 새로운 비밀번호는 달라야합니다.</h6><br><br><hr>
	<form method="post" id="updatePwdForm" action="${pageContext.request.contextPath}/main/login/updatePwd">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	  
	  <table id="classTable">
	    
	    <tr>
			<!-- 기존 비밀번호 -->
			<td>
				<div class="row g-3">
				<div class="col-md-2">
	  				</div>
				<div class="col-md-8">
					<div class="form-floating mb-3">
						<input type="password" id="userPwd" name="userPwd" placeholder="현재 비밀번호" class="form-control" required/>
						<label for="studentPwd">기존 비밀번호</label>
					</div>
				</div>
				<div class="col-md-2">
				</div>
				</div>	
			</td>
		</tr>
	  	<tr>

	    <tr>
			<!-- 비밀번호 -->
			<td>
				<div class="row g-3">
				<div class="col-md-2">
	  				</div>
				<div class="col-md-8">
					<div class="form-floating mb-3">
						<input type="password" id="newUserPwd" name="newUserPwd" placeholder="새 비밀번호" class="form-control" required/>
						<label for="studentPwd">비밀번호</label>
							<span id="notValidPwd" class="message"><i class="fa-solid fa-circle-exclamation"></i>&ensp;공백 없이 영소문자,대문자,숫자를 조합하여 8글자 이상으로 입력해주세요</span>
					</div>
				</div>
				<div class="col-md-2">
				</div>
				</div>	
			</td>
		</tr>
	  	<tr>
	  		<!-- 비밀번호 확인  -->
	  		<td>
	  			<div class="row g-3">
	  			<div class="col-md-2">
  				</div>
				<div class="col-md-8">
		  		<div class="form-floating mb-3">
			  		<input type="password" id="newUserPwd2" name="newUserPwd2" class="form-control" placeholder="새 비밀번호 확인" required="required"/><br>
			  		<label for="studentPwd2">새 비밀번호 확인</label>
		  		</div>
		  		</div>
			  		<div class="col-md-2">
			  				<span id="pwdCheck_success" class="pwdCheck_success"><i class="fa-solid fa-circle-check fa-2xl"></i></span>
						    <span id="pwdCheck_Fail" class="pwdCheck_Fail"><i class="fa-solid fa-triangle-exclamation fa-2xl"></i></span>
					</div>
				</div>	
	  		</td>
	  	</tr>
	  	<tr>

	  </table>
	  
	  	<div class=".col-6 .col-sm-4 text-center">
	  		<input type="submit" id="submitBtn" class="btn btn-primary" value="확인">
	  	</div>
	  	
	</form>

</div>	
</body>
</html>