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
		//判断用户是否登录, 只有登录的用户才会得到响应. 
		//登录方式有两种: 
			//1. 从 login.jsp 页面提交表单
			//2. 从含有登录名的 Cookie 中登录
			
		String name = request.getParameter("name");
	
		if(name == null){
			Cookie [] cookies = request.getCookies();
			
			if(cookies != null){
				for(Cookie cookie: cookies){
					if("loginName".equals(cookie.getName())){  
						name = cookie.getValue();
					}
				}
			}
		}
		//把 loginName 保存在 Cookie 中, 并回传给浏览器
		else{
			Cookie cookie = new Cookie("loginName", name);
			cookie.setMaxAge(45);
			
			response.addCookie(cookie);
		}
		
		if(name == null){
			response.sendRedirect("login.jsp");
		}else{
			out.print("Hello: " + name);
		}
	%>

</body>
</html>