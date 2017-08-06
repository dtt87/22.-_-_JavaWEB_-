package com.atguigu.javaweb;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthorityServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
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
	
	             //getAuthorities
	public void getAuthorities(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		User user = userDao.get(username);
		
		request.setAttribute("user", user);
		request.setAttribute("authorities", userDao.getAuthorities());
		
		request.getRequestDispatcher("/authority-manager.jsp").forward(request, response);
	}
	
	public void updateAuthority(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String [] authorities = request.getParameterValues("authority");
		List<Authority> authorityList = userDao.getAuthorities(authorities);
		
		userDao.update(username, authorityList);
		response.sendRedirect(request.getContextPath() + "/authority-manager.jsp");
	}
	

}
