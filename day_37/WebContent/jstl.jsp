<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.atguigu.javaweb.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h4>
		c:url 产生一个 url 地址. 可以 Cookie 是否可用来智能进行 URL 重写, 对 GET 请求的参数进行编码
		可以把产生的 URL 存储在域对象的属性中.
		还可以使用 c:param 为 URL 添加参数. c:url 会对参数进行自动的转码. 
		value 中的 / 代表的是当前 WEB 应用的根目录. 
	</h4>
	<c:url value="/test.jsp" var="testurl" scope="page">
		<c:param name="name" value="尚硅谷"></c:param>
	</c:url>
	
	url: ${testurl }

	<h4>
		c:redirect 使当前 JSP 页面重定向到指定的页面. 使当前 JSP 转发到指定页面可以使用
		<%--  
		<jsp:forward page="/test.jsp"></jsp:forward>	
		--%>
		/ 代表的是当前 WEB 应用的根目录. 
		
		response.sendRedirect("/test.jsp") / 代表 WEB 站点的根目录
	</h4>
	<%-- 
	<c:redirect url="http://www.atguigu.com"></c:redirect>
	<c:redirect url="/test.jsp"></c:redirect>
	--%>
	
	<h4>c:import 可以包含任何页面到当前页面</h4>
	<c:import url="http://www.baidu.com"></c:import>

	<h4>c:forTokens: 处理字符串的, 类似于 String 的 split() 方法</h4>
	<c:set value="a,b,c.d.e.f;g;h;j" var="test" scope="request"></c:set>
	<c:forTokens items="${requestScope.test }" delims="." var="s">
		${s }<br>
	</c:forTokens>
	
	<h4>c:forEach: 可以对数组, Collection, Map 进行遍历, begin(对于集合 begin 从 0 开始算), end, step</h4>
	<c:forEach begin="1" end="10" step="3" var="i">
		${ i} --
	</c:forEach>
	<br><br>
	
	<% 
		List<Customer> custs = new ArrayList<Customer>();
		custs.add(new Customer(1, "AAA")); //index: 0 
		custs.add(new Customer(2, "BBB")); //1
		custs.add(new Customer(3, "CCC")); 
		custs.add(new Customer(4, "DDD")); //3
		custs.add(new Customer(5, "EEE"));
		custs.add(new Customer(6, "FFF")); //5
		
		request.setAttribute("custs", custs);
	%>
	
	<br><br>
	<!-- 遍历 Collection, 遍历数组同 Collection -->
	<c:forEach items="${requestScope.custs }" var="cust"
		varStatus="status">
		${status.index}, ${status.count}, ${status.first}, ${status.last}: ${cust.id }: ${cust.name }<br>
	</c:forEach>
	
	<!-- 遍历 Map -->
	<% 
		Map<String, Customer> custMap = new HashMap<String, Customer>();
		custMap.put("a", new Customer(1, "AAA")); //index: 0 
		custMap.put("b", new Customer(2, "BBB")); //index: 0 
		custMap.put("c", new Customer(3, "CCC")); //index: 0 
		custMap.put("d", new Customer(4, "DDD")); //index: 0 
		custMap.put("e", new Customer(5, "EEE")); //index: 0 
		custMap.put("f", new Customer(6, "FFF")); //index: 0 
		
		request.setAttribute("custMap", custMap);
	%>
	
	<br><br>
	<c:forEach items="${requestScope.custMap }" var="cust">
		${cust.key } - ${cust.value.id } - ${cust.value.name }<br>
	</c:forEach>
	
	<% 
		String [] names = new String[]{"A", "B", "C"};
		request.setAttribute("names", names);
	%>
	<br><br>
	<c:forEach var="name" items="${names }">${name }-</c:forEach>
	
	<br><br>
	<c:forEach items="${pageContext.session.attributeNames }" var="attrName">
		${attrName }-
	</c:forEach>
	
	<h4>
		c:choose, c:when, c:otherwise: 可以实现 if...else if...else if...else 的效果. 但较为麻烦
		其中: c:choose 以 c:when, c:otherwise 的父标签出现.
		c:when, c:otherwise 不能脱离 c:choose 单独使用.
		c:otherwise 必须在 c:when 之后使用。 
	</h4>
	<c:choose>		
		<c:when test="${param.age > 60 }">
			老年
		</c:when>
		<c:when test="${param.age > 35 }">
			中年
		</c:when>
		<c:when test="${param.age > 18 }">
			青年
		</c:when>
		<c:otherwise>
			未成年. 
		</c:otherwise>
	</c:choose>

	<c:set value="20" var="age" scope="request"></c:set>

	<h4>c:if: 不能实现 else 操作, 但可以把结果储存起来。 </h4>
	<c:if test="${requestScope.age > 18 }">成年了!</c:if>
	<br><br>
	
	<c:if test="${param.age > 18 }" var="isAdult" scope="request"></c:if>
	isAdult: <c:out value="${requestScope.isAdult }"></c:out>


	<h4>c:remove: 移除指定域对象的指定属性值</h4>
	<c:set value="1997-09-1" var="date" scope="session"></c:set>
	date: ${sessionScope.date }
	<br><br>

	<c:remove var="date" scope="session"/>
	date: --${sessionScope.date }--
	<br><br>
	
	<h4>c:set: 可以为域赋属性值, 其中 value 属性支持 EL 表达式; 还可以为域对象中的 JavaBean 的属性赋值, target, value都支持 EL 表达式</h4>
	
	<c:set var="name" value="ATGUIGU" scope="page"></c:set>
	<%-- 
		pageContext.setAttribute("name", "atguigu");
	--%>
	name: ${pageScope.name }	
	
	<br><br>
	<c:set var="subject" value="${param.subject }" scope="session"></c:set>
	subject: ${sessionScope.subject }
	
	<br><br>
	<% 
		Customer cust = new Customer();
		cust.setId(1001);
		request.setAttribute("cust", cust);
	%>
	ID: ${requestScope.cust.id }
	<c:set target="${requestScope.cust }" property="id" value="${param.id }"></c:set>
	<br>
	ID: ${requestScope.cust.id }
	
	<br><br>
	
	<h4>c:out: 可以对特殊字符进行转换. </h4>
	
	<% 
		request.setAttribute("book", "<<Java>>");
	%>
	book: ${requestScope.book }
	<br><br>
	book: <c:out value="${requestScope.book }" default="booktitle"></c:out>
	
</body>
</html>