<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% response.setStatus(200); %>
<% response.setStatus(400); %>
<% response.setStatus(500); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	alert(`${exception.message}`)
	history.back()
</script>
</head>
<body>

</body>
</html>