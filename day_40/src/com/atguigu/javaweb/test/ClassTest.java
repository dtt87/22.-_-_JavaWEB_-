package com.atguigu.javaweb.test;

import static org.junit.Assert.*;

import org.junit.Test;

public class ClassTest {

	@Test
	public void test() {

		Customer customer1 = new Customer();
		Customer customer2 = new Customer();
		
		System.out.println(customer1.getClass() == customer2.getClass());
	}

}
