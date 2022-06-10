<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>달콤스쿨 :: 달콤함을 배우다</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/dalcommschool.css">
		<script src="https://kit.fontawesome.com/351ed6665e.js" crossorigin="anonymous"></script>
		<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
		<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
	</head>
	<body>
		<header>
			<tiles:insertAttribute name="header"/>
		</header>
		<section>
			<tiles:insertAttribute name="content"/>
		</section>
	</body>
</html>