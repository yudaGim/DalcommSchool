<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<meta charset="UTF-8">

<script type="text/javascript">
	$(function(){
		
	 $("input[value=수정하기]").click(function(){
		   
		   $("#requestForm").attr("action", "${pageContext.request.contextPath}/admin/board/event/eventUpdate");
		   $("#requestForm").submit();
		   
	   })
	
	   $("input[value=삭제하기]").click(function(){
		
			   $("#requestForm").attr("action", "${pageContext.request.contextPath}/admin/board/event/eventDelete");
			   $("#requestForm").submit();
		  	alert("삭제되었습니다.")
	   })
	   
	})
</script>


<title>Insert title here</title>
</head>
<body>
	
	<h1>이벤트 상세 페이지 입니다</h1>
	
<table align="center" cellpadding="5" cellspacing="2" width="600" border='1'>
    <tr>
        <td width="1220" height="20" colspan="4" bgcolor="#00cc00">
            <p align="center"><font color="white" size="3"><b>
             게시물 자세히보기</b></font></p>
        </td>
    </tr>
    <tr>
        <td width="100" height="20" >
            <p align="right"><b><span style="font-size:9pt;">글번호</span></b></p>
        </td>
        <td width="450" height="20" colspan="3">
        	<span style="font-size:9pt;"><b>${event.eventNo}</b></span>
        </td>
    </tr>
    <tr>
        
        <td width="100" height="20" >
			<p align="right"><b><span style="font-size:9pt;">조회수</span></b></p>
		</td>
        <td width="100" height="20">
			<p><b><span style="font-size:9pt;"></span>${requestScope.event.eventViews}</b></p>
		</td>
    </tr>
    <tr>
        <td width="100" height="20">
            <p align="right"><b><span style="font-size:9pt;">제목</span></b></p>
        </td>
        <td width="450" height="20" colspan="3">
        	<span style="font-size:9pt;"><b>${requestScope.event.eventTitle}</b></span>
        </td>
    </tr>
    <tr>
		<td width="100" height="200" valign="top">
            <p align="right"><b><span style="font-size:9pt;">내용</span></b></p>
        </td>
		<!-- 브라우저에 글 내용을 뿌려줄 때는 개행문자(\n)가 <br>태그로 변환된 문자열을 보여줘야 한다. -->
        <td width="450" height="200" valign="top" colspan="3">
		<img alt="" src="${pageContext.request.contextPath}/img/event/${requestScope.event.eventImg}">
        <span style="font-size:9pt;"><b><pre>${requestScope.event.eventContent}</pre></b></span></td>
    </tr>
    
      <tr>
        <td height="20" colspan="2" align="center" valign="middle">
        <!-- 관리자 버튼 권한-->
        <div sec:authorize="hasRole('ROLE_ADMIN')">
			<!-- 수정시 필요한 데이터들을 hidden으로 숨겨놓고 폼 데이터로 보내준다. -->
			<form name="requestForm" method="post" id="requestForm">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> <!-- csrf token 전송 -->
				<input type=hidden name="eventNo" value="${event.eventNo}">
				<input type=button value="수정하기" >
				<input type=button value="삭제하기" >
			</form>
		</div>
		</td>
		<span style="font-size:9pt;">&lt;<a href="${pageContext.request.contextPath}/admin/board/event/eventList">목록으로</a>&gt;</span>
    </tr>
    </table>

</body>
</html>