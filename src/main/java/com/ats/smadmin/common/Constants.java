package com.ats.smadmin.common;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.http.client.support.BasicAuthorizationInterceptor;
import org.springframework.web.client.RestTemplate;

public class Constants {

	// Web Api Path url
	public static final String url = "http://localhost:8097/";
	//public static final String url = "http://132.148.143.124:8080/CATaskMngtApi/";
		
	public static RestTemplate rest = new RestTemplate();
	public static final String imageSaveUrl = "/home/lenovo/Downloads/";
	public static String imageViewUrl="http://132.148.143.124:8080/uploads/ujwal/UjjwalImg/";

	public static final String REPORT_SAVE = "/home/maddy/ats-11/rusa_report2019.pdf"; 
	public static String[] values = { "jpg", "jpeg", "gif", "png" };
	
	public static RestTemplate getRestTemplate() {
			rest=new RestTemplate();
			rest.getInterceptors().add(new BasicAuthorizationInterceptor("aaryatech", "Aaryatech@1cr"));
			return rest;

			}
	
	public static String getCurDateTime() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		String curDateTime = dateFormat.format(cal.getTime());
		return curDateTime;

	}
	
	public static String getSimpleCurDate() {
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyy");
		Calendar cal = Calendar.getInstance();
		String curDateTime = dateFormat.format(cal.getTime());
		return curDateTime;

	}
	
}
