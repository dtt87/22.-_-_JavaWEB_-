<%@page import="com.atguigu.javaweb.mvc.TokenProcessor"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<a href="listAllStudents">List All Students</a>
	
	<% 
		Connection connection = null;
	%>
	
	<%= TokenProcessor.getInstance().generateToken(request) %>
	
</body>
</html>