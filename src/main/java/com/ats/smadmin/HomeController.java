package com.ats.smadmin;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.smadmin.common.Constants;
import com.ats.smadmin.model.Admin;
import com.ats.smadmin.model.ErrorMessage;
import com.ats.smadmin.model.Item;
import com.ats.smadmin.model.LoginProcess;
import com.ats.smadmin.model.Order;
import com.ats.smadmin.model.OrderDetails;
import com.ats.smadmin.model.OrderDetailsList;
import com.ats.smadmin.model.OrderHeaderList;
import com.ats.smadmin.model.TableBean;
import com.ats.smadmin.model.TableCat;
import com.ats.smadmin.model.TableList;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	RestTemplate restTemplate = new RestTemplate();
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}*/
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("login");

		return mav;
	}
	
	@RequestMapping(value = "/sessionTimeOut", method = RequestMethod.GET)
	public String sessionTimeOut(HttpSession session) {
		System.out.println("User Logout in sessionTimeOut");

		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Locale locale, Model model, HttpSession session) {

		session.invalidate();

		return "redirect:/";
	}
	
	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	public String loginProcess(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String mav = null;
		
		try {

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();			
			map.add("userName", request.getParameter("username"));
			map.add("pass", request.getParameter("password"));

			LoginProcess admlogin = restTemplate.postForObject(Constants.url + "/adminLogin", map,
					LoginProcess.class);		
			System.err.println("Admin Login----------" + admlogin.getAdmin());	
			if (admlogin.isError()==true) {
				
				mav = "redirect:/";
				
				System.err.println("Login failed");
				model.addAttribute("errorPassMsg", "Invalid Login Credentials");
				
			} else {
					mav = "redirect:/welcomePage";
					session = request.getSession();	
					session.setAttribute("admLogin", admlogin);
					session.setMaxInactiveInterval(18000); // mean inactive immediately
					
					System.err.println("Successful Login----------" + admlogin);						
				
				}
		} catch (Exception e) {
			mav = "redirect:/";
			System.err.println("Exception in Login Process  " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/welcomePage", method = RequestMethod.GET)
	public ModelAndView welcomePage(Locale locale, Model model,HttpSession session) {
		ModelAndView mav = new ModelAndView("welcome");
		try {
				
				String currDate = Constants.getSimpleCurDate();
				mav.addObject("currdate", currDate);					
				
				TableCat[] tableCatArr = restTemplate.getForObject(Constants.url + "/getAllTablesCatByIsUsed",TableCat[].class);
				List<TableCat> tableCatList = new ArrayList<TableCat>(Arrays.asList(tableCatArr));
				mav.addObject("tableCatList", tableCatList);
				
				TableList[]	tableArr = restTemplate.getForObject(Constants.url+"/getFreeTableList", TableList[].class);
				List<TableList> tableList = new ArrayList<TableList>(Arrays.asList(tableArr));
				mav.addObject("tableList", tableList);
				
				TableList[] busyTableArr = restTemplate.getForObject(Constants.url+"/getBsyTableList", TableList[].class);
				List<TableList> busyTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
				mav.addObject("busyTableList", busyTableLists);
				/*Admin adm = (Admin) session.getAttribute("admLogin");
				String  userName = adm.getUsername();
				model.addAttribute("userName", userName);*/
				
				mav.addObject("disc", 0);
				hashMap.clear();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	/*Sachin */
	
	RestTemplate rest = new RestTemplate();

	LinkedHashMap<Integer, ArrayList<OrderDetailsList>> hashMap = new LinkedHashMap<Integer, ArrayList<OrderDetailsList>>();
	ArrayList<OrderDetailsList> ordDetailList = new ArrayList<OrderDetailsList>();

	@RequestMapping(value = "/getItemByCode", method = RequestMethod.GET)
	public @ResponseBody Object getItemByCode(HttpServletRequest request, HttpServletResponse response) {
		Item item = null;

		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("itemCode", request.getParameter("itemCode"));
			map.add("delStatus", 1);

			item = rest.postForObject(Constants.url + "/getItemByCode", map, Item.class);

			//System.err.println("Qty " + request.getParameter("itemQty") + "Rem " + request.getParameter("itemRemark"));
			OrderDetailsList order = null;
			
			/*
			 * try {
			 * 
			 * for (int i = 0; i < ordDetailList.size(); i++) { found = 0; if
			 * (item.getItemId() == ordDetailList.get(i).getItemId()) { order =
			 * ordDetailList.get(i); found = 1; break; }
			 * 
			 * } } catch (Exception e) {
			 * 
			 * }
			 */
			int placeOrderTableId = Integer.parseInt(request.getParameter("placeOrderTableId"));

			if (item!=null) {
				order = new OrderDetailsList();
		

			order.setItemId(item.getItemId());
			order.setIsMixer(0);
			order.setItemName(item.getItemName());

			order.setOrderDetailsId(0);
			order.setOrderId(0);

			order.setQuantity(Integer.parseInt(request.getParameter("itemQty")));
			order.setRate(item.getMrpRegular());

			order.setRemark(request.getParameter("itemRemark"));

			order.setStatus(1);

			order.setTotal(order.getRate() * order.getQuantity());
			

			if (hashMap.containsKey(placeOrderTableId)) {
				System.err.println("contains " +placeOrderTableId );

				ordDetailList = hashMap.get(placeOrderTableId);
				int found = 0;
					/*
					 * for(int i=0;i<ordDetailList.size();i++) {
					 * 
					 * if(ordDetailList.get(i).getItemId()==order.getItemId()) {
					 * System.err.println("Item Matched "); ordDetailList.set(i, order); found =1;
					 * break; } }
					 */
				if(found==0) {
					ordDetailList.add(order);
				}
				
			} else {
				System.err.println("not contains " +placeOrderTableId );
				ordDetailList = new ArrayList<OrderDetailsList>();
				ordDetailList.add(order);
			}
			// ordDetailList.add(order);

			hashMap.put(placeOrderTableId, ordDetailList);
			System.err.println("placeOrderTableId " +placeOrderTableId +"Item " + hashMap.get(placeOrderTableId).get(0).getItemName());
			}
			if (ordDetailList.size() > 0)
				return hashMap.get(placeOrderTableId);

		} catch (Exception e) {
			item = new Item();
			e.printStackTrace();
		}
		return item;
	}
	
	
	
	@RequestMapping(value = "/getOrderDataByTableId", method = RequestMethod.GET)
	public @ResponseBody Object getOrderDataByTableId(HttpServletRequest request, HttpServletResponse response) {
		Item item = null;
		try {
			
		int placeOrderTableId = Integer.parseInt(request.getParameter("placeOrderTableId"));
		int key=Integer.parseInt(request.getParameter("key"));
		

		System.err.println("placeOrderTableId " +placeOrderTableId);
		if(key<0) {
		return hashMap.get(placeOrderTableId);
		}
		else {
			System.err.println("In Else remove at key " +key );
			ordDetailList=hashMap.get(placeOrderTableId);
			ordDetailList.remove(key);
			return ordDetailList;
		}
		}catch (Exception e) {
			item = new Item();
		}
		
		return item;
		
	}
	

	@RequestMapping(value = "/placeOrder", method = RequestMethod.POST)
	public @ResponseBody Object placeOrder(HttpServletRequest request, HttpServletResponse response) {
		Item item = null;
		System.err.println("In placeOrder ");
		Order orderRes = new Order();
		try {

			HttpSession session = request.getSession();
			LoginProcess adm = (LoginProcess) session.getAttribute("admLogin");

			orderRes.setBillStatus(1);
			String curDate;

			SimpleDateFormat hmsDf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Calendar cal = Calendar.getInstance();

			String curDtTime = hmsDf.format(cal.getTime());

			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			curDate = df.format(new Date());
			orderRes.setDelStatus(1);
			orderRes.setOrderDate(curDate);
			orderRes.setOrderDateTime(curDtTime);

			orderRes.setOrderId(0);

			orderRes.setTableNo(Integer.parseInt(request.getParameter("placeOrderTableNo")));
			orderRes.setUserId(adm.getAdmin().getAdminId());

			List<OrderDetails> orderDetailList = new ArrayList<>();
			int placeOrderTableId = Integer.parseInt(request.getParameter("placeOrderTableId"));

			ArrayList<OrderDetailsList> ordDetailList = hashMap.get(placeOrderTableId);

			String placeOrderTableName=request.getParameter("placeOrderTableName");
			
			
			
			
			StringBuilder sb=new StringBuilder();
			
			
			for (int i = 0; i < ordDetailList.size(); i++) {

				OrderDetails od = new OrderDetails();

				od.setIsMixer(0);
				od.setItemId(ordDetailList.get(i).getItemId());
				od.setOrderDetailsId(0);
				od.setOrderId(orderRes.getOrderId());
				od.setQuantity(ordDetailList.get(i).getQuantity());
				od.setRate(ordDetailList.get(i).getRate());
				od.setRemark(ordDetailList.get(i).getRemark());
				od.setStatus(1);

				orderDetailList.add(od);
				
				sb.append(ordDetailList.get(i).getItemName()+"("+od.getRemark()+")");
				
				sb.append(ordDetailList.get(i).getQuantity()+"");
				
				

			}
			sb.append("--------------------------------------------");
			orderRes.setOrderDetailList(orderDetailList);

			orderRes = rest.postForObject(Constants.url + "/saveOrder", orderRes, Order.class);
			

			String text="\t\tKOT\n"+"Date :- "+orderRes.getOrderDateTime()+"\n"+"Order No :-"+orderRes.getOrderId()+"\t"+"Table No :- "+orderRes.getTableNo()+"\n\n"
					+"Item                        "+"    Qty\n"+"---------------------------------------------\n"+"--------------------------------------------";
			
			text=text+sb.toString();
			
			
			String kotPrint=Constants.createKOTReceipt(orderRes,ordDetailList,placeOrderTableName);
			System.err.println("text " +text);
			
			if (orderRes != null) {
				hashMap.remove(placeOrderTableId);

			}
			orderRes.setOrderDate(kotPrint);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderRes;
	}

	
	@RequestMapping(value = "/printBill/{tableName}", method = RequestMethod.GET)
	public ModelAndView printBill(Locale locale, Model model,HttpSession session,
			HttpServletRequest request, HttpServletResponse response,@PathVariable String tableName) {
		ModelAndView mav = new ModelAndView("cust_bill_print");
		
		ErrorMessage saveBill =(ErrorMessage) session.getAttribute("saveBill");
		
		List<OrderHeaderList> ordersList=(List<OrderHeaderList>) session.getAttribute("orderBillArray");
		
		session.removeAttribute("saveBill");
		session.removeAttribute("orderBillArray");
		
		List<OrderDetailsList> ordDetail=new ArrayList<OrderDetailsList>();
		try {
				for(int i=0;i<ordersList.size();i++) {
					
					ordDetail.addAll(ordersList.get(i).getOrderDetailsList());

				}
				
				mav.addObject("billDetail" ,ordDetail);
				mav.addObject("billNo" ,saveBill);
				mav.addObject("tableName", tableName);
				String curDtTime=Constants.getCurDateTime();
				mav.addObject("curDtTime", curDtTime);
				
		}catch (Exception e) {
			mav = new ModelAndView("cust_bill_print");
		}
		return mav;
	
	}
}
