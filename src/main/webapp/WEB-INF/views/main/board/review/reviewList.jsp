<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	#reviewDetail-form fieldset{display: inline-block; border: 0;}
	 	
	.fa-star{font-size: 10px; color: #b3b3b3; text-shadow: 0 0 0 #b3b3b3;}
	.checked {color: #EB5353;}
	
	
 	
/* 수정하기 모달 폼 */

	#reviewUpdate-form .fa-star{font-size: 1em; color: #b3b3b3; text-shadow: 0 0 0 #b3b3b3;}

 	#reviewUpdate-form fieldset{ 
 		display: inline-block;
 		direction: rtl;
 		border: 0;
 	}
 	.star{font-size: 2em; color: transparent; text-shadow: 0 0 0 #b3b3b3;}
 	
 	#reviewUpdate-form i:hover{
 		color: #EB5353;
 	}
 	
 	#reviewUpdate-form label:hover~label i{
 		color: #EB5353;
 	}
 	
 	#reviewUpdate-form [type=radio]{ 
 		display: none;
 	}
 	
 	#reviewUpdate-form [type=radio]:checked~label i{ 
 		color: #EB5353;
 	}
</style>
<meta charset="UTF-8">
<title>메인페이지용 리뷰 리스트</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>

<script src="https://kit.fontawesome.com/351ed6665e.js" crossorigin="anonymous"></script>


<script type="text/javascript">

$(function(){
	
	$(".reviewContent").click(function(){
		
		$.ajax({
			url:"${pageContext.request.contextPath}/main/board/review/read",
			type: "post",
			data:{"${_csrf.parameterName}": "${_csrf.token}",
				  "reviewId" : $(this).val()	
			},
			dataType:"json",
// 				alert(result.reviewImg.toString());
			success:function(result){
				let text = "";
				let rate = result.reviewRate;
				if(rate==1) {
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text +=	'<i class="fa-solid fa-star fa-sm"></i>';
					text += '<i class="fa-solid fa-star fa-sm"></i>';
					text += '<i class="fa-solid fa-star fa-sm"></i>';
					text += '<i class="fa-solid fa-star fa-sm"></i>';
				}else if(rate==2){
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm"></i>';
					text += '<i class="fa-solid fa-star fa-sm"></i>';
					text += '<i class="fa-solid fa-star fa-sm"></i>';
				}else if(rate==3){
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm"></i>';
					text += '<i class="fa-solid fa-star fa-sm"></i>';
				}else if(rate==4){
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm"></i>';
				}else if(rate==5){
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
					text += '<i class="fa-solid fa-star fa-sm checked"></i>';
				}
				
// 				let image = result.reviewImg.toString();
// 				let str="";
// 				if(image!=null){
// 					str+= '<img alt="" src="${pageContext.request.contextPath}/img/classReview/${requestScope.review.reviewImg}">';
// 				}
// 				$("#reviewDetail-form th:eq(6)").after(str);
				
				$("#reviewDetail-form #reviewRate").html(text);
				
				$("#reviewDetail-form #reviewId").html(`\${result.reviewId}`); //span, div 같은 태그에는 .html 속성으로 부여.
				$("#reviewDetail-form #studentId").html(`\${result.studentId}`);
				$("#reviewDetail-form #reviewInsertDate").html(`\${result.reviewInsertDate.toString().substring(0, 10)}`);
				$("#reviewDetail-form #reviewUpdateDate").html(`\${result.reviewUpdateDate.toString().substring(0, 10)}`);
				$("#reviewDetail-form #className").html(`\${result.className}`);
				$("#reviewDetail-form #reviewImg").html(`\${result.reviewImg}`);
				$("#reviewDetail-form #reviewContent").html(`\${result.reviewContent}`);
			},
			error: function(err){
				alert(err + "에러 발생");
			}
		})
	})
	
	$("#updateBtn").click(function(){
		
		$.ajax({
			url: "${pageContext.request.contextPath}/review/updateForm",
			type: "post",
			data:{"${_csrf.parameterName}": "${_csrf.token}",
				  "reviewId" : $("#reviewDetail-form #reviewId").html()	
			},
			dataType:"json",
			success:function(result){
// 				alert(result);
				$("#reviewUpdate-form #reviewId").html(`\${result.reviewId}`);
				$("#reviewUpdate-form .reviewId").val(`\${result.reviewId}`);
				$("#reviewUpdate-form #studentId").html(`\${result.studentId}`);
				$("#reviewUpdate-form #className").html(`\${result.className}`);
				$("#reviewUpdate-form #reviewContent").html(`\${result.reviewContent}`);
			},
			error:function(err){
				alert(err + "에러 발생");
			}
		})
	})
	
// 	$("#deleteBtn").click(function(){
		
// 		$.ajax({
// 			url: "${pageContext.request.contextPath}/review/delete",
// 			type: "post",
// 			data: {"${_csrf.parameterName}": "${_csrf.token}",
// 				  "reviewId" : $("#reviewDetail-form #reviewId").html()	
// 			},
// 			success: function(){
// 				alert($("#reviewDetail-form #reviewId").html() + "번 후기가 삭제되었습니다.")
// 			},
// 			error:function(err){
// 				alert(err + "에러 발생");
// 			}
// 		})
// 	})
	
})
</script>
<script type="text/javascript">
function deleteReview(deleteOk){
	alert("일반 닫기");
	deleteOk.action = "${pageContext.request.contextPath}/review/delete";
	deleteOk.method="post";
	deleteOk.submit();
}
</script>
</head>
<body>
	
	<table>
		  <thead>
		    <tr>
		      <th>아이디</th>
		      <th>별점</th>
		      <th>클래스 이름</th>
		      <th>내용</th>
		      <th>작성 날짜</th>
		      <th>블라인드 유무</th>
		    </tr>
		  </thead>
		  <tbody>
		    <c:choose>
		      <c:when test="${requestScope.classReviews.content==null}">
		        <tr>
		          <th colspan="7">
		            <span>등록된 후기가 없습니다.</span>
		          </th>
		        </tr>
		      </c:when>
		      <c:otherwise>
		        <c:forEach items="${classReviews.content}" var="review">
		          <div id="review">
		          <tr>
		          	<input type="hidden" class="reviewId" name="reviewId" value="${review.reviewId}">
		            <td><span>${review.student.studentId}</span></td>
		            <td>
				    	<fieldset>
						  <c:choose>
						  	<c:when test="${review.reviewRate==1}">
						  		<i class="fa-solid fa-star fa-sm checked"></i>
						  		<i class="fa-solid fa-star fa-sm"></i>
						        <i class="fa-solid fa-star fa-sm"></i>
						        <i class="fa-solid fa-star fa-sm"></i>
						        <i class="fa-solid fa-star fa-sm"></i>
						  	</c:when>
						  	<c:when test="${review.reviewRate==2}">
						  		<i class="fa-solid fa-star fa-sm checked"></i>
						  		<i class="fa-solid fa-star fa-sm checked"></i>
						        <i class="fa-solid fa-star fa-sm"></i>
						        <i class="fa-solid fa-star fa-sm"></i>
						        <i class="fa-solid fa-star fa-sm"></i>
						  	</c:when>
						  	<c:when test="${review.reviewRate==3}">
						  		<i class="fa-solid fa-star fa-sm checked"></i>
						  		<i class="fa-solid fa-star fa-sm checked"></i>
						        <i class="fa-solid fa-star fa-sm checked"></i>
						        <i class="fa-solid fa-star fa-sm"></i>
						        <i class="fa-solid fa-star fa-sm"></i>
						  	</c:when>
						  	<c:when test="${review.reviewRate==4}">
						  		<i class="fa-solid fa-star fa-sm checked"></i>
						  		<i class="fa-solid fa-star fa-sm checked"></i>
						        <i class="fa-solid fa-star fa-sm checked"></i>
						        <i class="fa-solid fa-star fa-sm checked"></i>
						        <i class="fa-solid fa-star fa-sm"></i>
						  	</c:when>
						  	<c:when test="${review.reviewRate==5}">
						  		<i class="fa-solid fa-star fa-sm checked"></i>
						  		<i class="fa-solid fa-star fa-sm checked"></i>
						        <i class="fa-solid fa-star fa-sm checked"></i>
						        <i class="fa-solid fa-star fa-sm checked"></i>
						        <i class="fa-solid fa-star fa-sm checked"></i>
						  	</c:when>
						  </c:choose>
						</fieldset>
					</td>
		            <td><span>${review.classes.className}</span></td>
		            <td>
		            	<c:choose>
		            		<c:when test="${review.reviewBlindState eq 'true'}">
		            			<a>이 후기는 비공개 상태입니다.</a>
		            		</c:when>
		            		<c:when test="${review.reviewBlindState eq 'false'}">
		            			<button class="reviewContent" data-bs-toggle="modal" data-bs-target="#exampleModal" value="${review.reviewId}">${review.reviewContent}</button>
		            		</c:when>
		            	</c:choose>
		            </td>
<%-- 		            <td><a href="${pageContext.request.contextPath}/main/board/review/read/${review.reviewId}" class="reviewContent">${review.reviewContent}</a></td> --%>
		            <td>
		            	<span><fmt:parseDate value="${review.reviewInsertDate}" pattern="yyyy-mm-dd" var="parseDate"/></span>
		            	<span><fmt:formatDate value="${parseDate}" pattern="yyyy-mm-dd"/></span>
		            </td>
		          </tr>
				  </div>
		        </c:forEach>
		      </c:otherwise>
		    </c:choose>
		  </tbody>
		</table>
	
		
	<!---------------------상세보기 모달 ------------------------------->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">후기 상세보기</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      
		      	<form id="reviewDetail-form">
			        <table id="table">
						<tr>
					    	<th>글번호</th>
					    	<td>
					    	  <div id="reviewId" ></div>
					    	</td>
					  	</tr>
					  	<tr>
					    	<th>작성자</th>
					    	<td>
					    	  <div id="studentId"></div>
					    	</td>
					  	</tr>
					  	<tr>
					    	<th>클래스 이름</th>
					    	<td>
					    	  <div id="className"></div>
					    	</td>
					  	</tr>
					  	<tr>
					    	<th>작성 날짜</th>
					    	<td>
					    	  <div id="reviewInsertDate"></div>
					    	</td>
					  	</tr>
					  	<tr>
					    	<th>수정 날짜</th>
					    	<td>
					    	  <div id="reviewUpdateDate"></div>
					    	</td>
					  	</tr>
					  	<tr>
					    	<th>별점</th>
					    	<td>
					    	  <div id="reviewRate"></div>
					    	</td>
					  	</tr>
					  	<tr>
					    	<th rowspan="2">후기</th>
					    	<td>
					    	  <div><img alt="" src=""></div>
					    	</td>
					    </tr>
					    <tr>
					    	<th>후기</th>
					    	<td>
					    	 <div id="reviewContent"></div>
					    	</td>
					  	</tr>
					</table>
				</form>
			
			
		  	  
			
		      </div> <!-- modal body 끝 -->
		      
		      <div class="modal-footer">
		      <form id="detail-requestForm">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateModal" class="updateBtn" id="updateBtn" value="${review.reviewId}" >수정하기</button>
		      	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deleteModal" class="deleteBtn" value="${review.reviewId}" >삭제하기</button>
		      </form>
		      </div>
		    </div>
		  </div>
		</div>
	
	<!--------------------- 수정하기 모달-------------------->
	
	<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">후기 수정하기</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        
	        <form id="reviewUpdate-form" enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/main/mypage/review/update?${_csrf.parameterName}=${_csrf.token}">
				<input type="hidden" class="reviewId" name="reviewId">
				<table>
			  		<tr>
				    	<th>글번호</th>
				    	<td>
				    	  <div id="reviewId" name="reviewId"></div>
				    	</td>
				  	</tr>
				  	<tr>
				    	<th>작성자</th>
				    	<td>
				    	  <div id="studentId"></div>
				    	</td>
				  	</tr>
				  	<tr>
				    	<th>클래스 이름</th>
				    	<td>
				    	  <div id="className"></div>
				    	</td>
				  	</tr>
				  	<tr>
				    	<th>별점</th>
				    	<td>
				    		<fieldset id="update-star">
<!-- 							  <label for="recipient-name" class="col-form-label">별점</label> -->
						        <input type="radio" name="reviewRate" value="5" id="rate1"><label for="rate1"><i class="fa-solid fa-star fa-sm"></i></label>
						        <input type="radio" name="reviewRate" value="4" id="rate2"><label for="rate2"><i class="fa-solid fa-star fa-sm"></i></label>
						        <input type="radio" name="reviewRate" value="3" id="rate3"><label for="rate3"><i class="fa-solid fa-star fa-sm"></i></label>
						        <input type="radio" name="reviewRate" value="2" id="rate4"><label for="rate4"><i class="fa-solid fa-star fa-sm"></i></label>
						        <input type="radio" name="reviewRate" value="1" id="rate5"><label for="rate5"><i class="fa-solid fa-star fa-sm"></i></label>
							</fieldset>
				    	</td>
				  	</tr>
				  	<tr>
				  		<th>사진 첨부</th>
				  		<input class="form-control" type="file" id="formFileMultiple" value="${review.reviewImg}" name="file" multiple>
				  	</tr>
				  	<tr>
				    	<th>내용</th>
				    	<td>
				    		 <textarea name="reviewContent" id="reviewContent" placeholder="후기를 자유롭게 입력해주세요. 욕설 / 비방은 관리자에 의한 비공개 처리 및 처벌될 수 있습니다.">${review.reviewContent}</textarea>	    	</td>
				  	</tr>
				</table>

	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <input type="submit" id="updateBtn" value="저장하기">
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
		</form>
	    </div>
	  </div>
	</div>

<!---------------------------------- 삭제 확인 모달 -------------------------------------->

	<div class="modal fade" id="deleteModal" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="staticBackdropLabel">후기 삭제</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		       정말 삭제하시겠습니까?
		      </div>
		      <div class="modal-footer">
<!-- 		      <form id="delete-requestForm"> -->
<!-- 		      <input type="hidden" name="reviewId" id="reviewId"> -->
		        <button type="button" class="btn btn-primary" id="deleteBtn" onclick="deleteReview(deleteOk)">삭제</button>
<!-- 		        <button type="button" class="btn btn-primary" id="deleteBtn">아작스로 삭제</button> -->
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		      </form>
		      </div>
		    </div>
		  </div>
		</div>
	
		
	<!-- 페이징 처리 -->
		<div>
		  <nav class="pagination-container">
		    <div class="pagination">
		      <c:set var="doneLoop" value="false"/>
		      		<c:if test="${(startPage-blockCount)>0 }">
		      		  <a class="pagination-newer" href="${pageContext.request.contextPath}/main/review/list?nowPage=${startPage-1}">이전</a>	      		
		      		</c:if>
		      		
		      		<span class="pagination-inner">
		      		  <c:forEach var='i' begin="${startPage}" end="${(startPage-1)+blockCount}">
		      		    
		      		    <c:if test="${(i-1)>=classReviews.getTotalPages()}">
		      		      <c:set var="doneLoop" value="true"/>
		      		    </c:if>
		      		    <c:if test="${not doneLoop}">
		      		      <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/main/review/list?nowPage=${i}">${i}</a>
		      		    </c:if>
		      		    
		      		  </c:forEach>
		      		</span>
		      		
		      		<c:if test="${(startPage+blockCount)<=classReviews.getTotalPages()}">
		      		  <a class="pagination-older" href="${pageContext.request.contextPath}/main/review/list?nowPage=${startPage+blockCount}">다음</a>
		      		</c:if>
		    </div>
		  
		  </nav>
		</div>
	

</body>
</html>