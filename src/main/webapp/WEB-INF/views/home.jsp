<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:choose>
	<c:when test="${empty id}">
		<c:redirect url="/login"/>
	</c:when>
	<c:otherwise>
		<c:redirect url="/index"/>
	</c:otherwise>
</c:choose>
<html>
<head>
	<title>Home</title>
</head>
<body>

</body>
</html>
