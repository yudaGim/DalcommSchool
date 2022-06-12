<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 후기 수정 폼입니다.</title>
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

    <!-- include summernote css/js -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    
<script type="text/javascript">
$(function(){
	alert(${review.reviewId} + "번 후기 수정폼입니다.")
})

$(document).ready(function() {
	$('#summernote').summernote({
		height: 300,
		minHeight: null,
		maxHeight: null,
		focus:true,
		lang: "ko-KR",
		placeholder: '최대 2048자까지 쓸 수 있습니다.',
		callbacks : {
			onImageUpload : function(files, editor, welEditable) {     
				for (var i = 0; i < files.length; i++) {
					sendFile(files[i], this);
				}
			}
		}
	
	});
});

function sendFile(file, editor) { //썸머노트 파일 첨부
	var form_data = new FormData();
	form_data.append('file', file);
	$.ajax({
		data : form_data,
		type : "POST",
		url : '${pageContext.request.contextPath}/resources/static/img/event',
		cache : false,
		contentType : false,
		enctype : 'multipart/form-data',
		processData : false,
		success : function(url) {
			$(editor).summernote('insertImage', url, function($image) {
				$image.css('width', "25%");
			});
		}
	});
}
</script>
</head>
<body>
클래스 후기 수정 폼입니다.

<form id="updateForm" enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/main/mypage/review/update?${_csrf.parameterName}=${_csrf.token}">
	<input type="hidden" name=reviewId value="${review.reviewId}">
	<table>
  		<tr>
	    	<th>글번호</th>
	    	<td>${review.reviewId}</td>
	  	</tr>
	  	<tr>
	    	<th>작성자</th>
	    	<td>${review.student.studentId}</td>
	  	</tr>
	  	<tr>
	    	<th>별점</th>
	    	<td>
	    		<fieldset>
				  <label for="recipient-name" class="col-form-label">별점</label>
			        <input type="radio" name="reviewRate" value="5" id="rate1"><label for="rate1" class="star"><i class="fa-solid fa-star fa-sm"></i></label>
			        <input type="radio" name="reviewRate" value="4" id="rate2"><label for="rate2" class="star"><i class="fa-solid fa-star fa-sm"></i></label>
			        <input type="radio" name="reviewRate" value="3" id="rate3"><label for="rate3" class="star"><i class="fa-solid fa-star fa-sm"></i></label>
			        <input type="radio" name="reviewRate" value="2" id="rate4"><label for="rate4" class="star"><i class="fa-solid fa-star fa-sm"></i></label>
			        <input type="radio" name="reviewRate" value="1" id="rate5"><label for="rate5" class="star"><i class="fa-solid fa-star fa-sm"></i></label>
				</fieldset>
	    	</td>
	  	</tr>
	  	<tr>
	    	<th>작성 날짜</th>
	    	<td>
	    		<fmt:parseDate value="${review.reviewInsertDate}" pattern="yyyy-mm-dd" var="insertDate"/>
	    		<fmt:formatDate value="${insertDate}" pattern="yyyy-mm-dd"/>
	    	</td>
	  	</tr>
	  	<tr>
	    	<th>수정 날짜</th>
	    	<td>
	    		<fmt:parseDate value="${review.reviewUpdateDate}" pattern="yyyy-mm-dd" var="updateDate"/>
	    		<fmt:formatDate value="${updateDate}" pattern="yyyy-mm-dd"/>
	    	</td>
	  	</tr>
	  	<tr>
	  		<th>사진 첨부</th>
	  		<input class="form-control" type="file" id="formFileMultiple" value="${review.reviewImg}" name="file" multiple>
	  	</tr>
	  	<tr>
	    	<th>내용</th>
	    	<td>
	    		 <textarea name="reviewContent" id="summernote" placeholder="후기를 자유롭게 입력해주세요. 욕설 / 비방은 관리자에 의한 비공개 처리 및 처벌될 수 있습니다.">${review.reviewContent}</textarea>	    	</td>
	  	</tr>
	</table>
	<input type="submit" id="updateBtn" value="수정하기">
	<a href="${pageContext.request.contextPath}/main/board/review/read/${review.reviewId}">취소</a>
</form>




<!--   <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
<!-- 	<div class="modal-dialog modal-dialog-centered"> -->
<!-- 		<div class="modal-content"> -->
<!-- 			<div class="modal-header"> -->
<!-- 				<h5 class="modal-title" id="exampleModalLabel">클래스 후기 등록</h5> -->
<!-- 				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 			</div> -->
<!-- 			<div class="modal-body"> -->
<%-- 				<form id="reviewUpdateForm" enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/main/board/review/update?${_csrf.parameterName}=${_csrf.token}"> --%>
<%-- 				<input type="hidden" name="classId" value="${classId}"> --%>
<!-- 					<fieldset> -->
<!-- 					  <label for="recipient-name" class="col-form-label">별점</label> -->
<!-- 				        <input type="radio" name="reviewRate" value="5" id="rate1"><label for="rate1" class="star"><i class="fa-solid fa-star fa-sm"></i></label> -->
<!-- 				        <input type="radio" name="reviewRate" value="4" id="rate2"><label for="rate2" class="star"><i class="fa-solid fa-star fa-sm"></i></label> -->
<!-- 				        <input type="radio" name="reviewRate" value="3" id="rate3"><label for="rate3" class="star"><i class="fa-solid fa-star fa-sm"></i></label> -->
<!-- 				        <input type="radio" name="reviewRate" value="2" id="rate4"><label for="rate4" class="star"><i class="fa-solid fa-star fa-sm"></i></label> -->
<!-- 				        <input type="radio" name="reviewRate" value="1" id="rate5"><label for="rate5" class="star"><i class="fa-solid fa-star fa-sm"></i></label> -->
<!-- 					</fieldset> -->
<!-- 					<div class="mb-3"> -->
<!--                         <label for="formFileMultiple" class="form-label">이미지 첨부</label> -->
<%--                         <input class="form-control" type="file" id="formFileMultiple" value="${review.reviewImg}" name="reviewImg" multiple> --%>
<!--                     </div> -->
<!-- 					<div class="mb-3"> -->
<!-- 						<label for="recipient-name" class="col-form-label">내용</label> -->
<%-- 						<textarea name="reviewContent" placeholder="후기를 자유롭게 입력해주세요." value="${review.reviewContent}"></textarea> --%>
<!-- 					</div> -->
<!-- 					<div class="modal-footer"> -->
<!-- 						<input type="submit" class="btn btn-primary" id="insertReview" value="후기 수정"> -->
<!-- 					</div> -->
<!-- 				</form> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!--   </div> -->


</body>
</html>