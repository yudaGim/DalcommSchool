<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css">
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
		
		<style type="text/css">
			.bootstrap-timepicker-widget.dropdown-menu {
    z-index: 1050!important;
}
			#scheduleUpdateForm h6 {display: none;}
		</style>
		<script>
			$(function() {
				
			})
		</script>
	</head>
	<body>
		<div id="allBookList">
		 	<table class="table">
		 		<thead>
		 			<tr>
		 				<th>
		 					수강 클래스
		 				</th>
		 				<th>
		 					수강일
		 				</th>
		 				<th>
		 					학생 아이디
		 				</th>
		 				<th>
		 					체험자 아이디
		 				</th>
		 				<th>
		 					체험자 전화번호
		 				</th>
		 				<th>
		 					수강 인원
		 				</th>
		 				<th>
		 					결제 금액
		 				</th>
		 				<th>
		 					수강 상태
		 				</th>
		 			</tr>
		 		</thead>
		 		<tbody>
		 			<c:forEach items="${list.content}" var="book">
		 				<tr>
		 					<td>${book.classes.className}</td>
		 					<td>${book.classSchedule.scheduleDate.toString().substring(0, 10)} ${book.classSchedule.startTime} ~ ${book.classSchedule.endTime}</td>
		 					<td>${book.student.studentId}</td>
		 					<td>${book.bookName}</td>
		 					<td>${book.bookPhone}</td>
		 					<td>${book.bookSeat}명</td>
		 					<td><fmt:formatNumber value="${book.totalPrice}" pattern="#,###" />원</td>
		 					<td>${book.bookState.bookStateName}</td>
		 				</tr>
		 			</c:forEach>
		 		</tbody>
		 	</table>
		</div>
		<nav aria-label="Page navigation example" id="pagenation">
			<ul class="pagination justify-content-center">
				<c:set var="doneLoop" value="false" />
				<c:if test="${(startPage-blockCount) > 0 and list.content.size() != 0}">
					<li class="page-item">
						<a class="page-link" href="${URL}?page=${startPage-1}">이전</a>
					</li>
				</c:if>
					<c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount<list.totalPages?(startPage-1)+blockCount:list.totalPages}'>
						<c:if test="${(i-1)>=list.getTotalPages()}">
							<c:set var="doneLoop" value="true" />
						</c:if>
						<c:if test="${not doneLoop}">
							<li class="page-item"><a class="page-link ${i==page?'active':'page'}" href="${URL}?page=${i}">${i}</a></li>
						</c:if>
					</c:forEach>
				<c:if test="${(startPage+blockCount) <= list.getTotalPages()}">
					<li class="page-item">
						<a class="page-link" href="${URL}?${location.search}page=${startPage+blockCount}">다음</a>
					</li>
				</c:if>
			</ul>
		</nav>
	</body>
</html>