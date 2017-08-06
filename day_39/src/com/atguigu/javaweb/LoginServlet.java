package com.atguigu.javaweb;

import java.io.IOException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String methodName = request.getParameter("method");
		
		try {
			Method method = getClass().getMethod(methodName, 
					HttpServletRequest.class, HttpServletResponse.class);
			method.invoke(this, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private UserDao userDao = new UserDao();
	
	public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 获取 name
		String name = request.getParameter("name");
		
		//2. 调用 UserDao 获取用户信息, 把用户信息放入到 HttpSession 中
		User user = userDao.get(name);
		request.getSession().setAttribute("user", user);
		
		//3. 重定向到 articles.jsp
		response.sendRedirect(request.getContextPath() + "/articles.jsp");
	}
	
	public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 获取 HttpSession
		
		//2. 使 HttpSession 失效
		request.getSession().invalidate();
		
		//3. 重定向到 /loign.jsp
		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}
	

}
