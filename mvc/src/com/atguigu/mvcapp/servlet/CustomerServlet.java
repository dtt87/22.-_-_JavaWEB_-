package com.atguigu.mvcapp.servlet;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.atguigu.mvcapp.dao.CriteriaCustomer;
import com.atguigu.mvcapp.dao.CustomerDAO;
import com.atguigu.mvcapp.dao.factory.CustomerDAOFactory;
import com.atguigu.mvcapp.dao.impl.CustomerDAOXMLImpl;
import com.atguigu.mvcapp.domain.Customer;


public class CustomerServlet extends HttpServlet {


	private CustomerDAO customerDAO = 
			CustomerDAOFactory.getInstance().getCustomerDAO();
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
//		String method = request.getParameter("method");
//		
//		switch(method){
//			case "add":    add(request, response); break;
//			case "query":  query(request, response); break;
//			case "delete": delete(request, response); break;
//			case "update": update(request, response); break;
//		}
//	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		//1. 锟斤拷取 ServletPath: /edit.do 锟斤拷 /addCustomer.do
		String servletPath = req.getServletPath();

		//2. 去锟斤拷 / 锟斤拷 .do, 锟矫碉拷锟斤拷锟斤拷锟斤拷 edit 锟斤拷 addCustomer 锟斤拷锟斤拷锟斤拷锟街凤拷锟斤拷
		String methodName = servletPath.substring(1);
		methodName = methodName.substring(0, methodName.length() - 3);
		
		try {
			//3. 锟斤拷锟矫凤拷锟斤拷锟饺� methodName 锟斤拷应锟侥凤拷锟斤拷
			Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, 
					HttpServletResponse.class);
			//4. 锟斤拷锟矫凤拷锟斤拷锟斤拷枚锟接︼拷姆锟斤拷锟�
			method.invoke(this, req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			//锟斤拷锟斤拷锟斤拷一些锟斤拷应.
			resp.sendRedirect("error.jsp");
		}
		
	}

	private void edit(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException{
		
		String forwardPath = "/error.jsp";
		
		//1. 锟斤拷取锟斤拷锟斤拷锟斤拷锟� id
		String idStr = request.getParameter("id");
		
		//2. 锟斤拷锟斤拷 CustomerDAO 锟斤拷 customerDAO.get(id) 锟斤拷取锟斤拷 id 锟斤拷应锟斤拷 Customer 锟斤拷锟斤拷 customer
		try {
			Customer customer = customerDAO.get(Integer.parseInt(idStr));
			if(customer != null){
				forwardPath = "/updatecustomer.jsp";
				//3. 锟斤拷 customer 锟斤拷锟斤拷 request 锟斤拷
				request.setAttribute("customer", customer);
			}
		} catch (NumberFormatException e) {} 
		
		
		//4. 锟斤拷应 updatecustomer.jsp 页锟斤拷: 转锟斤拷.
		request.getRequestDispatcher(forwardPath).forward(request, response);
		
	}

	private void update(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		//1. 锟斤拷取锟斤拷锟斤拷锟斤拷: id, name, address, phone, oldName
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String oldName = request.getParameter("oldName");
		
		//2. 锟斤拷锟斤拷 name 锟角凤拷锟窖撅拷锟斤拷占锟斤拷:
		
		//2.1 锟饺斤拷 name 锟斤拷 oldName 锟角凤拷锟斤拷同, 锟斤拷锟斤拷同说锟斤拷 name 锟斤拷锟斤拷. 
		//2.1 锟斤拷锟斤拷锟斤拷同, 锟斤拷锟斤拷锟� CustomerDAO 锟斤拷 getCountWithName(String name) 锟斤拷取 name 锟斤拷锟斤拷锟捷匡拷锟斤拷锟角凤拷锟斤拷锟�
		if(!oldName.equalsIgnoreCase(name)){
			long count = customerDAO.getCountWithName(name);
			//2.2 锟斤拷锟斤拷锟斤拷值锟斤拷锟斤拷 0, 锟斤拷锟斤拷应 updatecustomer.jsp 页锟斤拷: 通锟斤拷转锟斤拷锟侥凤拷式锟斤拷锟斤拷应 newcustomer.jsp
			if(count > 0){
				//2.2.1 锟斤拷 updatecustomer.jsp 页锟斤拷锟斤拷示一锟斤拷锟斤拷锟斤拷锟斤拷息: 锟矫伙拷锟斤拷 name 锟窖撅拷锟斤拷占锟斤拷, 锟斤拷锟斤拷锟斤拷选锟斤拷!
				//锟斤拷 request 锟叫凤拷锟斤拷一锟斤拷锟斤拷锟斤拷 message: 锟矫伙拷锟斤拷 name 锟窖撅拷锟斤拷占锟斤拷, 锟斤拷锟斤拷锟斤拷选锟斤拷!, 
				//锟斤拷页锟斤拷锟斤拷通锟斤拷 request.getAttribute("message") 锟侥凤拷式锟斤拷锟斤拷示
				request.setAttribute("message", "锟矫伙拷锟斤拷" + name + "锟窖撅拷锟斤拷占锟斤拷, 锟斤拷锟斤拷锟斤拷选锟斤拷!");
				
				//2.2.2 newcustomer.jsp 锟侥憋拷值锟斤拷锟皆伙拷锟斤拷. 
				//address, phone 锟斤拷示锟结交锟斤拷锟斤拷锟铰碉拷值, 锟斤拷 name 锟斤拷示 oldName, 锟斤拷锟斤拷锟斤拷锟斤拷锟结交锟斤拷 name
				
				//2.2.3 锟斤拷锟斤拷锟斤拷锟斤拷: return 
				request.getRequestDispatcher("/updatecustomer.jsp").forward(request, response);
				return;
			}
		}
		
		//3. 锟斤拷锟斤拷证通锟斤拷, 锟斤拷驯锟斤拷锟斤拷锟斤拷锟阶拔伙拷锟� Customer 锟斤拷锟斤拷 customer
		Customer customer = new Customer(name, address, phone);
		customer.setId(Integer.parseInt(id)); 
		
		//4. 锟斤拷锟斤拷 CustomerDAO 锟斤拷  update(Customer customer) 执锟叫革拷锟铰诧拷锟斤拷
		customerDAO.update(customer);
		
		//5. 锟截讹拷锟斤拷 query.do
		response.sendRedirect("query.do");
	}

	private void query(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//锟斤拷取模锟斤拷锟斤拷询锟斤拷锟斤拷锟斤拷锟斤拷锟�
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
		//锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟阶拔伙拷锟� CriteriaCustomer 锟斤拷锟斤拷
		CriteriaCustomer cc = new CriteriaCustomer(name, address, phone);
		
		//1. 锟斤拷锟斤拷 CustomerDAO 锟斤拷 getForListWithCriteriaCustomer() 锟矫碉拷 Customer 锟侥硷拷锟斤拷
		List<Customer> customers = customerDAO.getForListWithCriteriaCustomer(cc);
		
		//2. 锟斤拷 Customer 锟侥硷拷锟较凤拷锟斤拷 request 锟斤拷
		request.setAttribute("customers", customers);
		
		//3. 转锟斤拷页锟芥到 index.jsp(锟斤拷锟斤拷使锟斤拷锟截讹拷锟斤拷)
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String idStr = request.getParameter("id");
		int id = 0;
		
		//try ... catch 锟斤拷锟斤拷锟斤拷: 锟斤拷止 idStr 锟斤拷锟斤拷转为 int 锟斤拷锟斤拷
		//锟斤拷锟斤拷锟斤拷转锟斤拷 id = 0, 锟睫凤拷锟斤拷锟斤拷锟轿何碉拷删锟斤拷锟斤拷锟斤拷. 
		try {
			id = Integer.parseInt(idStr);
			System.out.println(id); 
			customerDAO.delete(id);
		} catch (Exception e) {}
		
		response.sendRedirect("query.do");
	}

	private void addCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//1. 锟斤拷取锟斤拷锟斤拷锟斤拷: name, address, phone
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");
		
		//2. 锟斤拷锟斤拷 name 锟角凤拷锟窖撅拷锟斤拷占锟斤拷:
		
		//2.1 锟斤拷锟斤拷 CustomerDAO 锟斤拷 getCountWithName(String name) 锟斤拷取 name 锟斤拷锟斤拷锟捷匡拷锟斤拷锟角凤拷锟斤拷锟�
		long count = customerDAO.getCountWithName(name);
		
		//2.2 锟斤拷锟斤拷锟斤拷值锟斤拷锟斤拷 0, 锟斤拷锟斤拷应 newcustomer.jsp 页锟斤拷: 
		//通锟斤拷转锟斤拷锟侥凤拷式锟斤拷锟斤拷应 newcustomer.jsp
		if(count > 0){
			//2.2.1 要锟斤拷锟斤拷 newcustomer.jsp 页锟斤拷锟斤拷示一锟斤拷锟斤拷锟斤拷锟斤拷息: 锟矫伙拷锟斤拷 name 锟窖撅拷锟斤拷占锟斤拷, 锟斤拷锟斤拷锟斤拷选锟斤拷!
			//锟斤拷 request 锟叫凤拷锟斤拷一锟斤拷锟斤拷锟斤拷 message: 锟矫伙拷锟斤拷 name 锟窖撅拷锟斤拷占锟斤拷, 锟斤拷锟斤拷锟斤拷选锟斤拷!, 
			//锟斤拷页锟斤拷锟斤拷通锟斤拷 request.getAttribute("message") 锟侥凤拷式锟斤拷锟斤拷示
			request.setAttribute("message", "锟矫伙拷锟斤拷" + name + "锟窖撅拷锟斤拷占锟斤拷, 锟斤拷锟斤拷锟斤拷选锟斤拷!");
			
			//2.2.2 newcustomer.jsp 锟侥憋拷值锟斤拷锟皆伙拷锟斤拷. 
			//通锟斤拷 value="<%= request.getParameter("name") == null ? "" : request.getParameter("name") %>"
			//锟斤拷锟斤拷锟叫伙拷锟斤拷
			//2.2.3 锟斤拷锟斤拷锟斤拷锟斤拷: return 
			request.getRequestDispatcher("/newcustomer.jsp").forward(request, response);
			return;
		}
		
		//3. 锟斤拷锟斤拷证通锟斤拷, 锟斤拷驯锟斤拷锟斤拷锟斤拷锟阶拔伙拷锟� Customer 锟斤拷锟斤拷 customer
		Customer customer = new Customer(name, address, phone);
		
		//4. 锟斤拷锟斤拷 CustomerDAO 锟斤拷  save(Customer customer) 执锟叫憋拷锟斤拷锟斤拷锟�
		customerDAO.save(customer);
		
		//5. 锟截讹拷锟斤拷 success.jsp 页锟斤拷: 使锟斤拷锟截讹拷锟斤拷锟斤拷员锟斤拷锟斤拷锟街憋拷锟斤拷锟截革拷锟结交锟斤拷锟斤拷.  
		response.sendRedirect("success.jsp");
		//request.getRequestDispatcher("/success.jsp").forward(request, response);
	}

}
