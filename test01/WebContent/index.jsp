<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
</head>
<body>
<%
	pageContext.setAttribute("name", "장인범");
%>
<h1>${name } 메인 페이지</h1>
<%@ include file = "menu.jsp" %>
</body>
</html>