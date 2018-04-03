<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:choose>
	<c:when test="${empty id}">
		<c:redirect url="/login"/>
	</c:when>
	<c:otherwise>
		<c:redirect url="/dashboard"/>
	</c:otherwise>
</c:choose>





<!DOCTYPE html>
<html>
<head>
<title></title>


</head>
<body>
	<div>
		<a href="<c:url value="/dashboard"/>"> Go Dashboard</a>
	</div>
<script type="text/javascript">
	$(document).ready(function(){
		//console.log("index");
		//location.href='<c:url value="/dashboard"/>';
	})
</script>
</body>
</html>