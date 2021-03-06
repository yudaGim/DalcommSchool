<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>정산하기 폼</title>
<!--Bootstrap CSS-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/dalcommschool.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script type="text/javascript">
	$(function() {
		//swal(1);
		$("#adjustPrice").keyup(function(){
			let adjustPrice = parseInt($(this).val())
			let adjustable = parseInt($("#adjustable").val())
			
			 if(adjustPrice  >  adjustable){
				swal("정산 가능 총액보다 금액이 큽니다.");
				$(this).val(adjustable);
				return false;
			}
		})
		
		//정산신청시 값 비워져있으면 swal 창 띄우기
		$("#adjust-insert-btn").click(function() {
			let adjustPrice = $(".adjustPrice").val();
			let bank = $(".bank").val();
			let depositor = $(".depositor").val();
			let account = $(".account").val();
			
			if(adjustPrice==""){
				swal("정산 신청 금액을 적어주세요");
				return false;
			}else if(bank==""){
				swal("은행을 적어주세요");
				return false;
			}else if(depositor==""){
				swal("예금주 이름을 적어주세요");
				return false;
			}else if(account==""){
				swal("계좌번호를 적어주세요");
				return false;
			}
				
		});
		
		
	});//ready 끝

</script>

</head>
<body>

<div>
<!--정산하기-->
    	<sec:authorize access="isAuthenticated()">
 		<sec:authentication property="principal" var="teacher"/>
     	<form name="adjust-teacher-insert" method="post" id="adjust-teacher-insert" action="${pageContext.request.contextPath}/applyAdjust">
     	<input type=hidden name="${_csrf.parameterName}" value="${_csrf.token}">
     	<input type=hidden name="teacherId" value="${teacher.teacherId}" id="teacherId">
     	<!-- <input type=hidden name="teacherId" value="Tkim1234" id="teacherId">-->
     	<input type=hidden name="adjustStateId" value="1" id="adjustStateId"> 
     		<table  id="classTable">
      			<tr>
					<td>
						<div class="form-floating mb-3">
						  	<input type="text" class="form-control" placeholder="정산 가능 총액" value="<fmt:formatNumber type="number" maxFractionDigits="3" value="${adjustable}"/>원" readonly="readonly">
						  	<input type="hidden" class="form-control" id="adjustable" name="adjustable" value="${adjustable}" readonly="readonly">
						  	<label for="adjustable">정산 가능 총액</label>
						</div>
					</td>
      			</tr>
      			<tr>
					<td>
						<div class="form-floating mb-3">
							<input type="number" class="form-control" id="adjustPrice" placeholder="정산 신청 금액" name="adjustPrice">
							<label for="adjustPrice">정산 신청 금액</label>
						</div>
					</td>
      			</tr>
      			<tr>
					<td>
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="bank" placeholder="정산 받으실 은행" name="bank">
							<label for="bank">정산 받으실 은행</label>
						</div>
					</td>
      			</tr>
      			<tr>
      				<td>
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="depositor" placeholder="예금주" name="depositor">
							<label for="depositor">예금주</label>
						</div>
					</td>
      			</tr>
      			<tr>
      				<td>
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="account" placeholder="계좌번호" name="account">
							<label for="account">계좌번호</label>
						</div>
					</td>
      			</tr>
      			
      			<tr>
      				<td>
						<div class="d-grid gap-2">
							<input class="btn btn-primary" type="submit" id="adjust-insert-btn" value="정산 신청하기">
						</div>
					</td>
      			</tr>
     		</table>
            
            
     	 </form>
     	 </sec:authorize>
</div>
</body>
</html>