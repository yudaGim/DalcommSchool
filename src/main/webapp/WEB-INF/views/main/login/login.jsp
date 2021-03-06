<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/dalcommschool.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/351ed6665e.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>달콤스쿨 로그인</title>

<style type="text/css">

	a{
		text-decoration: none;
	}
	
	.loginbox-social , .social-buttons{
		display: inline-block;
		margin: 0 auto;
	}
	
	.kakao, .naver, .google{
		float:left;
		width: 70px;
	  	height: 70px;
	  	padding: 5px;
	}
	
	.logo-img{ 
	    width: auto; height: auto;
	    max-width: 150px;
	    max-height: 150px;
	    text-align: center;
   		vertical-align: middle;
	} 
	
	.loginbox bg-white , .title {
		text-align: center;
	}

	img{
		display: block;
		margin: auto;
	}

</style>


<script type="text/javascript">

	function loginCheck() {
		if(!document.login.id.value){
			
			alert("아이디를 입력해 주세요");
			document.login.id.focus();
			return;
			
		} if (!document.login.pwd.value) {
			
			alert("비밀번호를 입력해 주세요");
			document.login.pwd.focus();
			return;
		}
		event.preventDefault();
		document.login.submit();
	}
</script>
</head>
<body>
		<br>
          <div class="loginbox-social">
			<div class="logo">
					<img src="${pageContext.request.contextPath}/img/main/login_logo.png" class="logo-img" alt="...">
			</div><br><br>

	<!-- 일반 로그인  -->

              <form name="login" method="post" action="${pageContext.request.contextPath}/login">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	               <div class="form-floating mb-3"> 
		                 <input type="text" name="id" id="id" class="form-control">
		             	<label for="id">아이디</label>
	               </div>
	               <div class="form-floating mb-3">
	                   <input type="password" name="pwd" id="pwd" class="form-control">
         		       <label for="pwd">비밀번호</label>
	               </div>
               <span>
				<c:if test="${message != null}">
					<div class="alert alert-danger" role="alert">
						${message}
					</div>	 
				</c:if>
               </span>
               <br>
               <div class="loginbox-forgot">
                   <a href="${pageContext.request.contextPath}/main/login/findIdForm">아이디</a>&ensp;/&ensp;
                   <a href="${pageContext.request.contextPath}/main/login/findPwdForm">비밀번호 찾기</a>
               </div><br>
               <div class="d-grid gap-2 col-6 mx-auto">
                   <input type="button" id="login" class="btn btn-primary btn-block btn-lg" value="로그인" onclick="loginCheck()">
               </div><br>
               <div class="loginbox-signup">
                   <a href="${pageContext.request.contextPath}/main/login/joinStudent">일반 회원가입</a>&ensp;or&ensp;
                   <a href="${pageContext.request.contextPath}/main/login/joinTeacher">강사 회원가입</a>
               </div><br>
              </form>
              </div>
</body>
</html>