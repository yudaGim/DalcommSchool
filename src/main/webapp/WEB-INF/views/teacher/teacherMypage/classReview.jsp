<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강사 마이페이지용 리뷰 리스트</title>

<style type="text/css">
fieldset input[type=radio]{display: none;}
fieldset input[type=radio]:checked~label{text-shadow: 0 0 0 #EB5353;}
fieldset{display: inline-block; direction: rtl; border: 0;}
	
.star{font-size: 2em; color: transparent; text-shadow: 0 0 0 #b3b3b3;}
.star:hover{text-shadow: 0 0 0 #EB5353;} 
.star:hover~label{text-shadow: 0 0 0 #EB5353;} 
	
textarea{width:100%; height:6.25em; resize:none;} 
</style>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/351ed6665e.js" crossorigin="anonymous"></script>
</head>
<body>
<h2>내 클래스 후기 리스트!</h2>
	 <table>
	  <thead>
	    <tr>
		  <th>클래스 이름</th>
		  <th>아이디</th>
	      <th>내용</th>
	      <th>별점</th>
	      <th>작성 날짜</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:choose>
	      <c:when test="${empty requestScope.classReviews}" >
	        <tr>
	          <th>
	            <span>등록된 후기가 없습니다.</span>
	          </th>
	        </tr>
	      </c:when>
	      <c:otherwise>
	        <c:forEach items="${classReviews.content}" var="review">
	          <div id="review">
	          <tr>
	            <td><span>${review.classes.className}</span>
	            <td><span>${review.student.studentId}</span></td>
				<td><a href="${pageContext.request.contextPath}/main/board/review/read/${review.reviewId}" id="readReview" >${review.reviewContent}</a></td>
	            <td><span>${review.reviewRate}</span></td>
	            <input type="hidden" name="reviewId" value="${reviewId}">
	            <td><span><fmt:parseDate value="${review.reviewInsertDate}" pattern="yyyy-mm-dd" var="parseDate"/></span></td>
	            <td><span><fmt:formatDate value="${parseDate}" pattern="yyyy-mm-dd"/></span></td>
	          </tr>
			  </div>
	        </c:forEach>
	      </c:otherwise>
	    </c:choose>
</tbody>
</table>

	<!-- 페이징 처리 -->
	<div>
	  <nav class="pagination-container">
	    <div class="pagination">
	      <c:set var="doneLoop" value="false"/>
	      		<c:if test="${(startPage-blockCount)>0 }">
	      		  <a class="pagination-newer" href="${pageContext.request.contextPath}/main/board/review/teacher?nowPage=${startPage-1}">이전</a>	      		
	      		</c:if>
	      		
	      		<span class="pagination-inner">
	      		  <c:forEach var='i' begin="${startPage}" end="${(startPage-1)+blockCount}">
	      		    
	      		    <c:if test="${(i-1)>=classReviews.getTotalPages()}">
	      		      <c:set var="doneLoop" value="true"/>
	      		    </c:if>
	      		    <c:if test="${not doneLoop}">
	      		      <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/main/board/review/teacher?nowPage=${i}">${i}</a>
	      		    </c:if>
	      		    
	      		  </c:forEach>
	      		</span>
	      		
	      		<c:if test="${(startPage+blockCount)<=classReviews.getTotalPages()}">
	      		  <a class="pagination-older" href="${pageContext.request.contextPath}/main/board/review/teacher?nowPage=${startPage+blockCount}">다음</a>
	      		</c:if>
	    </div>
	  
	  </nav>
	</div>

</body>
</html>