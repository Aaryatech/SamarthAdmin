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
import com.ats.smadmin.model.TableList;


@Controller
public class TransactionAdmController {
	
	RestTemplate rest = new RestTemplate();
	
	@RequestMapping(value="/getTablesByCatId", method = RequestMethod.GET)
	public @ResponseBody List<TableList> getAllFreeTables(HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("CatId----------");
		List<TableList> tableLists = new ArrayList<TableList>();
		
		try {
			int catId = Integer.parseInt(request.getParameter("tableCat"));
			System.out.println("CatId----------"+catId);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();			
			map.add("catId", catId);
			
			TableList[]	tableArr = rest.postForObject(Constants.url+"/getFreeTableListByCatId", map, TableList[].class);
			tableLists = new ArrayList<TableList>(Arrays.asList(tableArr));
			System.out.println("Table Cat-------------"+tableLists);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return tableLists;

	}

}
