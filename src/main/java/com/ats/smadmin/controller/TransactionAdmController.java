package com.ats.smadmin.controller;

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

}
