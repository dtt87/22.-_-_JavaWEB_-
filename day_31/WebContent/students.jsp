<%@page import="com.atguigu.javaweb.mvc.Student"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<% 
		List<Student> stus = (List<Student>)request.getAttribute("students");
	%>
	 
	<table border="1" cellpadding="10" cellspacing="0">
	
		<tr>
			<th>FlowId</th>
			<th>Type</th>
			<th>IdCard</th>
			<th>ExamCard</th>
			<th>StudentName</th>
			<th>Location</th>
			<th>Grade</th>
			<th>Delete</th>
		</tr>
		
		<% 
			for(Student student: stus){
		%>
				<tr>
					<td><%= student.getFlowId() %></td>
					<td><%= student.getType() %></td>
					<td><%= student.getIdCard() %></td>
					<td><%= student.getExamCard() %></td>
					<td><%= student.getStudentName() %></td>
					<td><%= student.getLocation() %></td>
					<td><%= student.getGrade() %></td>
					<td><a href="deleteStudent?flowId=<%=student.getFlowId() %>">Delete</a></td>
				</tr>
		<%		
			}
		%>
	
	</table>
	
</body>
</html>