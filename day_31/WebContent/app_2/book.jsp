<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h4>Book Detail Page</h4>
	
	Book: <%= request.getParameter("book") %>
	
	<br><br>
	
	<a href="books.jsp">Return</a>
	
	<% 
		String book = request.getParameter("book");
		Cookie tempCookie = null;
		
		//只显示最近浏览过的 3 件商品. 
		
		//1. 获取所有满足条件的 Cookie
		List<Cookie> books = new ArrayList<Cookie>();
		
		Cookie [] cookies = request.getCookies();
	
		if(cookies != null && cookies.length > 0){
			
			
			for(Cookie cookie: cookies){
				String cookieName = cookie.getName();
				
				if(cookieName.startsWith("book_")){ 
					books.add(cookie);
					
					String cookieVal = cookie.getValue();
					if(cookieVal.equals(book)){ 
						tempCookie = cookie;
					}
				}
			}
			
		}
		
		if(books.size() == 5){
			if(tempCookie == null){
				tempCookie = books.get(0);
			}
			
			tempCookie.setMaxAge(0);
			response.addCookie(tempCookie);
		}
		
		//2. 在数组 length == 3 的情况下, 把最早的那个(即数组的第 1 个元素-下标是 0 的那个元素)删除 
		Cookie cookie = new Cookie("book_" + book, book);
		response.addCookie(cookie);
	%>
	
</body>
</html>