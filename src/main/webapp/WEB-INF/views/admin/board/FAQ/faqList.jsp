<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/dalcommschool.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
a{
		text-decoration: none;
	}
	table,th,td{
		text-align: center;
	}
</style>

</head>
<body>

<div class="main-content">
	
	<h5> 고객센터 > 자주 묻는 질문 </h5>
	
	
	<form action="${pageContext.request.contextPath}/admin/board/FAQ/faqSearch" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <input type="text" id="keyword" name="keyword">
   	  <input type="submit" id="search" value="검색">
    </form>
    
    <hr><!-- 구분선 -->

	
	 <table class="table">
        <thead>
            <tr>
             <th>글번호</th>
             <th>작성자</th>
             <th>글제목</th>
             <th>카테고리</th>
             <th>작성일</th>
            
            </tr>
        </thead>
	
	<tbody>
	<c:choose>
	<c:when test="${empty requestScope.faqlist}">
		<tr>
          <th colspan="10">
          <span> 조회가능한 이벤트가 없습니다.</span>
          </th>
       </tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${requestScope.faqlist.content}" var="faq">
			<tr>
				<td>
					${faq.faqNo}
				</td>
				<td>
					관리자
				</td>
				<td>
				<a href="${pageContext.request.contextPath}/admin/board/FAQ/faqRead/${faq.faqNo}">
				   ${faq.faqTitle}
				   <c:set var="today" value="<%=LocalDateTime.now().minusDays(1)%>"/>
				  <c:if test="${faq.faqInsertDate >= today}">
				  	<span class="badge rounded-pill bg-primary">new</span>
				  </c:if>
				  <c:if test="${faq.faqImg != null}">
					<i class="fa fa-file-image-o" aria-hidden="true"></i>
				</c:if>
				</a>
				</td>
				<td>
					${faq.faqCategory.faqCategoryName}
				</td>
				<td>
					<fmt:parseDate value="${faq.faqInsertDate}" pattern="yyyy-mm-dd" var="parseDate" scope="page"/>
					<fmt:formatDate value="${parseDate}" pattern="yyyy-mm-dd"/>
				</td>
				
			</tr>		
			</c:forEach>
		</c:otherwise>
	</c:choose>
</tbody>
</table>

<hr>
<%-- <div style="text-align: center">
		<!--  블럭당  -->
 <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		  <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/board/FAQ/faqList?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		  
			    <c:if test="${(i-1)>=faqlist.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/board/FAQ/faqList?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=faqlist.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/board/FAQ/faqList?nowPage=${startPage+blockCount}">&nbsp;NEXT</a>
		 </c:if>
		</div>
	</nav>  
</div> --%>

		<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">
	<c:set var="doneLoop" value="false"/>
		  <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
	      	<li class="page-item">
		      <a class="page-link" href="${pageContext.request.contextPath}/admin/board/FAQ/faqList?nowPage=${startPage-1}">이전</a>
		  	</li>
		  </c:if>
		
	  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		    <c:if test="${(i-1)>=faqlist.getTotalPages()}">
		       <c:set var="doneLoop" value="true"/>
		    </c:if> 
			  <c:if test="${not doneLoop}" >
			  <li class="page-item">
			         <a class="page-link ${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/board/FAQ/faqList?nowPage=${i}">${i}</a> 
			  </li>
			  </c:if>
		</c:forEach>
				
		 <c:if test="${(startPage+blockCount)<=faqlist.getTotalPages()}">
	     <li class="page-item">
		     <a class="page-link" href="${pageContext.request.contextPath}/admin/board/FAQ/faqList?nowPage=${startPage+blockCount}">다음</a>
		 </li>
		 </c:if>
		</ul>
	</nav> 


	<div align=right>
		<a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/board/FAQ/write" role="button">글쓰기</a></div>
	</div>
	

</body>

</html>