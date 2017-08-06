package com.atguigu.javaweb;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LoginServlet implements Servlet{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void init(ServletConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	
	@Override
	public void service(ServletRequest request, ServletResponse response)
			throws ServletException, IOException {
		System.out.println("ÇëÇóÀ´ÁË...");
		System.out.println(request); 
		
		String user = request.getParameter("user");
		String password = request.getParameter("password");
		
		System.out.println(user + ", " + password); 
		
		String interesting = request.getParameter("interesting");
		System.out.println(interesting); 

		String [] interestings = request.getParameterValues("interesting");
		for(String interest: interestings){
			System.out.println("-->" + interest);
		}
		
		Enumeration<String> names = request.getParameterNames();
		while(names.hasMoreElements()){
			String name = names.nextElement();
			String val = request.getParameter(name);
			
			System.out.println("^^" + name + ": " + val);
		}
		
		Map<String, String[]> map = request.getParameterMap();
		for(Map.Entry<String, String[]> entry: map.entrySet()){
			System.out.println("**" + entry.getKey() + ":" + Arrays.asList(entry.getValue()));  
		}
		
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		
		String requestURI = httpServletRequest.getRequestURI();
		System.out.println(requestURI);
		
		String method = httpServletRequest.getMethod();
		System.out.println(method); 
		
		String queryString = httpServletRequest.getQueryString();
		System.out.println(queryString); 
		
		String servletPath = httpServletRequest.getServletPath();
		System.out.println(servletPath); 
		
		
		response.setContentType("application/msword");

		PrintWriter out = response.getWriter();
		out.println("helloworld...");
		
	}

	

}
