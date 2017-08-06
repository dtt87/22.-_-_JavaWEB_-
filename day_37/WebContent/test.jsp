<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.atguigu.javaweb.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="atguigu" uri="http://atguigu.com/myTag/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<atguigu:testJspFragment>hello: ${param.name }</atguigu:testJspFragment>
	
	<br><br>
	hello: <%= request.getParameter("name") %>
	
	<br><br>
	<atguigu:printUpper time="10">
		abcdefh
	</atguigu:printUpper>
	
	<br><br>
	<% 
		List<Customer> customers = new ArrayList<Customer>();
	
		customers.add(new Customer(1, "AAA"));
		customers.add(new Customer(2, "BBB"));
		customers.add(new Customer(3, "CCC"));
		customers.add(new Customer(4, "DDD"));
		customers.add(new Customer(5, "EEE"));
		
		request.setAttribute("customers", customers);
		
		Map<String, Customer> customerMap = new HashMap<String, Customer>();
		customerMap.put("a", customers.get(0));
		customerMap.put("b", customers.get(1));
		customerMap.put("c", customers.get(2));
		customerMap.put("d", customers.get(3));
		customerMap.put("e", customers.get(4));
		
		request.setAttribute("customerMap", customerMap); 
	%>
	
	<%-- 
	<atguigu:forEach items="${customerMap }" var="cust">
		--${pageScope.cust.key } -- ${cust.value.id } -- ${cust.value.name } <br>
	</atguigu:forEach>
	
	<br><br>
	
	<atguigu:forEach items="${requestScope.customers }" var="cust">
		--${pageScope.cust.id } -- ${cust.name } <br>
	</atguigu:forEach>	
	--%>
		
	<br><br>
	
	<!-- 父标签打印name到控制台.  -->
	<atguigu:parentTag>
		<!-- 子标签以父标签的标签体存在,  子标签把父标签的name属性打印到 JSP 页面上.  -->
		<atguigu:sonTag/>
	</atguigu:parentTag>
	
	<br><br>
	
	<atguigu:choose>
		<atguigu:when test="${param.age > 24}">^大学毕业</atguigu:when>
		<atguigu:when test="${param.age > 20}">^高中毕业</atguigu:when>
		<atguigu:otherwise>^高中以下...</atguigu:otherwise>
	</atguigu:choose>
	
	<!-- 使用一个 EL 的自定义函数 -->
	${fn:length(param.name) } 
	<br><br>
	
	${fn:toUpperCase(param.name1) }
		
	<br><br>
	<!-- 测试自定义的 EL 函数 -->
	${atguigu:concat(param.name1, param.name2)}
	
</body>
</html>