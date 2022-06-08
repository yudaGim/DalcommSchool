<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<head> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<meta charset="UTF-8"> 
<script type="text/javascript">

</script>
<title>Insert title here</title>
<head>
<h1>FAQ 리스트</h1>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/board/FAQ/faqCategoryList?faqCategoryId">전체공개</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/admin/board/FAQ/faqCategoryList?faqCategoryId=1">예약</a>
        </li>
        <li class="nav-item">
           <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/admin/board/FAQ/faqCategoryList?faqCategoryId=2">결제</a>
        </li>
      </ul>
      <form class="d-flex" action="${pageContext.request.contextPath}/admin/board/FAQ/fAQSearch" method="post">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" id="keyword" name="keyword">
        <button class="btn btn-outline-success" type="submit" id="search">Search</button>
      </form>
    </div>
  </div>
</nav>

<form action="${pageContext.request.contextPath}/admin/board/Notice/noticeSearch" method="post">
	       <input type="text" id="keyword" name="keyword">
     	  <input type="submit" id="search" value="검색">
    </form>
<hr>

<div class="accordion accordion-flush" id="accordionFlushExample">

	<c:forEach items="${requestScope.faqlist}" var="faq">
		<c:choose>

			<c:when test="${faq.faqCategoryId==1}">
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-headingOne">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#flush-collapseOne${faq.faqNo}"
							aria-expanded="false" aria-controls="flush-collapseOne">
							${faq.faqTitle}</button>
					</h2>
					<div id="flush-collapseOne${faq.faqNo}"
						class="accordion-collapse collapse"
						aria-labelledby="flush-headingOne"
						data-bs-parent="#accordionFlushExample">
						<div class="accordion-body">
							<a
								href="${pageContext.request.contextPath}/admin/board/FAQ/faqRead/${faq.faqNo}">
								${faq.faqContent}
								<p>
							</a>
						</div>

					</div>
				</div>
			</c:when>

			<c:when test="${faq.faqCategoryId==2}">
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-headingOne">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#flush-collapseOne${faq.faqNo}"
							aria-expanded="false" aria-controls="flush-collapseOne">
							${faq.faqTitle}</button>
					</h2>
					<div id="flush-collapseOne${faq.faqNo}"
						class="accordion-collapse collapse"
						aria-labelledby="flush-headingOne"
						data-bs-parent="#accordionFlushExample">
						<div class="accordion-body">
							<a
								href="${pageContext.request.contextPath}/admin/board/FAQ/faqRead/${faq.faqNo}">
								${faq.faqContent}
								<p>
							</a>
						</div>

					</div>
				</div>
			</c:when>
			<c:otherwise>
			
			</c:otherwise>
		</c:choose>

	</c:forEach>



</div>


<button type="button" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/admin/board/FAQ/write'">등록하기</button>
<button type="button" class="btn btn-danger" onclick="">삭제</button>
</head>
</body>

</html>