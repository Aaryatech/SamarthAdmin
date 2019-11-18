package com.ats.smadmin.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.ats.smadmin.common.Constants;
import com.ats.smadmin.model.AllTableList;
import com.ats.smadmin.model.ErrorMessage;
import com.ats.smadmin.model.Item;
import com.ats.smadmin.model.LoginProcess;
import com.ats.smadmin.model.OrderHeaderList;
import com.ats.smadmin.model.TableList;


@Controller
public class TransactionAdmController {
	
	RestTemplate rest = new RestTemplate();
	
	@RequestMapping(value="/getTablesByCatId", method = RequestMethod.GET)
	public @ResponseBody AllTableList getAllFreeTables(HttpServletRequest request, HttpServletResponse response) {
		
		
		AllTableList allTable = new AllTableList();
				
		System.out.println("CatId----------");
		List<TableList> freeTableLists = new ArrayList<TableList>();
		List<TableList> busyTableLists = new ArrayList<TableList>();
		
		try {
			int catId = Integer.parseInt(request.getParameter("tableCat"));
			TableList[]	tableArr = null;
			//TableList[]	busyTableArr = null;
			
			if(catId!=0) {
			System.out.println("CatId----------"+catId);
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();			
			map.add("catId", catId);
			
			tableArr = rest.postForObject(Constants.url+"/getFreeTableListByCatId", map, TableList[].class);
			freeTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
			allTable.setFreeTables(freeTableLists);
			
			
			tableArr = rest.postForObject(Constants.url+"/getBsyTableListByCatId", map, TableList[].class);
			busyTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
			allTable.setBusyTables(busyTableLists);
			
			
			System.out.println("Table Cat-------------"+allTable);
			}else {
				
				System.out.println("No Cat Id");
				
				tableArr = rest.getForObject(Constants.url+"/getFreeTableList", TableList[].class);
				freeTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
				allTable.setFreeTables(freeTableLists);
				
				tableArr = rest.getForObject(Constants.url+"/getBsyTableList", TableList[].class);
				busyTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
				allTable.setBusyTables(busyTableLists);
				
			}
		} catch (Exception e) {

			e.printStackTrace();

		}
		return allTable;

	}
	
	@RequestMapping(value="/getAllMenuItems", method = RequestMethod.GET)
	public @ResponseBody List<Item> getAllMenuItems(HttpServletRequest request, HttpServletResponse response) {
			
		List<Item> itemLists = new ArrayList<Item>();
		
		try {
			Item[]	itemArr = rest.getForObject(Constants.url+"/getAllItem", Item[].class);
			itemLists = new ArrayList<Item>(Arrays.asList(itemArr));
			System.out.println("ItemsList-------------"+itemLists);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return itemLists;

	}
	@RequestMapping(value="/getOrderItemList", method = RequestMethod.GET)
	public @ResponseBody List<OrderHeaderList> getOrderItemList(HttpServletRequest request, HttpServletResponse response) {
		List<OrderHeaderList> ordersList = new ArrayList<OrderHeaderList>();
		try {
			int tableNo = Integer.parseInt(request.getParameter("tableNo"));
			System.out.println("Table----------------"+tableNo);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();			
			map.add("tableNo", tableNo);
			
			OrderHeaderList[] orderArr = rest.postForObject(Constants.url+"/orderListByTableNo", map, OrderHeaderList[].class);
			ordersList = new ArrayList<OrderHeaderList>(Arrays.asList(orderArr));
			
			HttpSession session=request.getSession();
			session.setAttribute("orderBillArray", ordersList);
			System.out.println("Order-----"+ordersList);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ordersList;
	}
	
	@RequestMapping(value="/saveBill", method = RequestMethod.GET)
	public @ResponseBody int saveBill(HttpServletRequest request, HttpServletResponse response) {
		int res=0;
		try {
			
			HttpSession session=request.getSession();
			LoginProcess adm = (LoginProcess) session.getAttribute("admLogin");
			
			System.out.println(adm.getAdmin().getAdminId()+" "+adm.getAdmin().getVenueId());
			
			int tableNo = Integer.parseInt(request.getParameter("tabNo"));
			float discount = Float.parseFloat(request.getParameter("discount"));
			System.out.println("Valus"+tableNo+"----"+discount);
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();			
			map.add("tableNo", tableNo);
			map.add("discount", discount);
			map.add("venueId", adm.getAdmin().getVenueId());			
			map.add("userId", adm.getAdmin().getAdminId());
			
			ErrorMessage saveBill = rest.postForObject(Constants.url+"/generateBill", map, ErrorMessage.class);
			System.out.println("sabveBill---------------"+saveBill);
			
			session.setAttribute("saveBill", saveBill);

			if(saveBill.isError()==false) {
				res=1;
			}else {
				res=0;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	

}







/*package com.ats.smadmin.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.ats.smadmin.common.Constants;
import com.ats.smadmin.model.AllTableList;
import com.ats.smadmin.model.Item;
import com.ats.smadmin.model.TableList;


@Controller
public class TransactionAdmController {
	
	RestTemplate rest = new RestTemplate();
	
	@RequestMapping(value="/getTablesByCatId", method = RequestMethod.GET)
	public @ResponseBody AllTableList getAllFreeTables(HttpServletRequest request, HttpServletResponse response) {
		
		
		AllTableList allTable = new AllTableList();
				
		System.out.println("CatId----------");
		List<TableList> freeTableLists = new ArrayList<TableList>();
		List<TableList> busyTableLists = new ArrayList<TableList>();
		
		try {
			int catId = Integer.parseInt(request.getParameter("tableCat"));
			TableList[]	tableArr = null;
			//TableList[]	busyTableArr = null;
			
			if(catId!=0) {
			System.out.println("CatId----------"+catId);
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();			
			map.add("catId", catId);
			
			tableArr = rest.postForObject(Constants.url+"/getFreeTableListByCatId", map, TableList[].class);
			freeTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
			allTable.setFreeTables(freeTableLists);
			
			
			tableArr = rest.postForObject(Constants.url+"/getBsyTableListByCatId", map, TableList[].class);
			busyTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
			allTable.setBusyTables(busyTableLists);
			
			
			System.out.println("Table Cat-------------"+allTable);
			}else {
				
				System.out.println("No Cat Id");
				
				tableArr = rest.getForObject(Constants.url+"/getFreeTableList", TableList[].class);
				freeTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
				allTable.setFreeTables(freeTableLists);
				
				tableArr = rest.getForObject(Constants.url+"/getBsyTableList", TableList[].class);
				busyTableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
				allTable.setBusyTables(busyTableLists);
				
			}
		} catch (Exception e) {

			e.printStackTrace();

		}
		return allTable;

	}
	
	@RequestMapping(value="/getAllMenuItems", method = RequestMethod.GET)
	public @ResponseBody List<Item> getAllMenuItems(HttpServletRequest request, HttpServletResponse response) {
			
		List<Item> itemLists = new ArrayList<Item>();
		
		try {
			Item[]	itemArr = rest.getForObject(Constants.url+"/getAllItem", Item[].class);
			itemLists = new ArrayList<Item>(Arrays.asList(itemArr));
			System.out.println("ItemsList-------------"+itemLists);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return itemLists;

	}

}*/
