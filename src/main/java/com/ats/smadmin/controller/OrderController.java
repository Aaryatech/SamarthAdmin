package com.ats.smadmin.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.ats.smadmin.common.Constants;
import com.ats.smadmin.model.Item;
import com.ats.smadmin.model.LoginProcess;
import com.ats.smadmin.model.Order;
import com.ats.smadmin.model.OrderDetails;
import com.ats.smadmin.model.OrderDetailsList;

@Controller
@Scope("session")
public class OrderController {

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
			int found = 0;
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

			if (found == 0) {
				order = new OrderDetailsList();
			}

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
			int placeOrderTableId = Integer.parseInt(request.getParameter("placeOrderTableId"));
			

			if (hashMap.containsKey(placeOrderTableId)) {

				ordDetailList = hashMap.get(placeOrderTableId);
				ordDetailList.add(order);

			} else {

				ordDetailList = new ArrayList<OrderDetailsList>();
				ordDetailList.add(order);
			}
			// ordDetailList.add(order);

			hashMap.put(placeOrderTableId, ordDetailList);
			System.err.println("placeOrderTableId " +placeOrderTableId +"Item " + hashMap.get(placeOrderTableId).get(0).getItemName());
			
			if (ordDetailList.size() > 0)
				return hashMap.get(placeOrderTableId);

		} catch (Exception e) {
			item = new Item();
			e.printStackTrace();
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

			orderRes.setTableNo(Integer.parseInt(request.getParameter("placeOrderTableId")));
			orderRes.setUserId(adm.getAdmin().getAdminId());

			List<OrderDetails> orderDetailList = new ArrayList<>();
			int placeOrderTableId = Integer.parseInt(request.getParameter("placeOrderTableId"));

			ArrayList<OrderDetailsList> ordDetailList = hashMap.get(placeOrderTableId);

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

			}

			orderRes.setOrderDetailList(orderDetailList);

			orderRes = rest.postForObject(Constants.url + "/saveOrder", orderRes, Order.class);
			if (orderRes != null) {
				hashMap.remove(placeOrderTableId);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return item;
	}

}
