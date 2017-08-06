<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<!--  
		
		利用 Cookie 实现 "您浏览过的图书有: x, y, z", 只显示最近浏览的 3 本图书的信息
		且支持 Cookie 的持久化. 其余的 Cookie 被删除: 调用其 setMaxAge() 方法, 传入
		0 即可。 
		
	-->
	
	<h4>Books Page</h4>
	
	<a href="book.jsp?book=JavaWeb">Java Web</a><br><br>
	<a href="book.jsp?book=Java">Java</a><br><br>
	<a href="book.jsp?book=Oracle">Oracle</a><br><br>
	<a href="book.jsp?book=Ajax">Ajax</a><br><br>
	<a href="book.jsp?book=JavaScript">JavaScript</a><br><br>
	<a href="book.jsp?book=Android">Android</a><br><br>
	<a href="book.jsp?book=Jbpm">Jbpm</a><br><br>
	<a href="book.jsp?book=Struts">Struts</a><br><br>
	<a href="book.jsp?book=Hibernate">Hibernate</a><br><br>
	<a href="book.jsp?book=Spring">Spring</a><br><br>
	
	<br><br>
	
	
	
	<% 
		StringBuilder books = new StringBuilder("");
	
		Cookie [] cookies = request.getCookies();
	
		if(cookies != null && cookies.length > 0){
			
			
			for(Cookie cookie: cookies){
				String cookieName = cookie.getName();
				String cookieVal = cookie.getValue();
				
				if(cookieName.startsWith("book_")){ 
					books.append(cookieVal + "&nbsp;&nbsp;");
				}
			}
			
		}
		
		if(!books.toString().equals("")){
			out.print("您浏览过的商品有: " + books.toString()); 
		}
	
	%>
	
</body>
</html>