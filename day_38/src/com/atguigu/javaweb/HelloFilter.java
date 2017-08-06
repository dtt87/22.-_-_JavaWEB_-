package com.atguigu.javaweb;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class HelloFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("init..");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		System.out.println("1. Before HelloFilter's chain.doFilter ..."); //1
		
		//·ÅÐÐ
		chain.doFilter(request, response);
		
		System.out.println("2. After HelloFilter's chain.doFilter ..."); //2
	}

	@Override
	public void destroy() {
		System.out.println("destroy...");
	}

}
