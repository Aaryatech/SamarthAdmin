package com.ats.smadmin.common;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.http.client.support.BasicAuthorizationInterceptor;
import org.springframework.web.client.RestTemplate;

import com.ats.smadmin.model.Order;
import com.ats.smadmin.model.OrderDetailsList;

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
	
	
	public static String createKOTReceipt(Order orderDisplays, ArrayList<OrderDetailsList> orderItems, String tableName) {
        String method = "";
        StringBuilder textData = new StringBuilder();

        try {

            String tableNo = String.valueOf(orderDisplays.getTableNo());
        
            String date = orderDisplays.getOrderDate();
            textData.append("\t\tKOT\n");

            SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a");
            Calendar calendar = Calendar.getInstance();

            // textData.append("Captain Name :- "+captainName + "\n");
            textData.append("Date :- " + date + "  " + sdf.format(calendar.getTimeInMillis()) + "\n");

           // textData.append("Order No :- " + orderDisplays.getOrderId());
            textData.append("Table No :- " + tableName + "\n\n");



            textData.append("Item");
            for (int s = 0; s < 24; s++) {
                textData.append(" ");
            }
            textData.append("    Qty\n");
            textData.append("-------------------------------------\n");

            for (int i = 0; i < orderItems.size(); i++) {
                try {

                    String strName = orderItems.get(i).getItemName();
                    if (strName.length() >= 28) {
                        String itemName = orderItems.get(i).getItemName().substring(0, 28);
                        textData.append("" + itemName);
                    } else if (strName.length() < 28) {
                        textData.append("" + strName);
                        int difference = 28 - strName.length();

                        for (int d = 0; d < difference; d++) {
                            textData.append(" ");
                        }
                    }

                    String qty = String.valueOf(orderItems.get(i).getQuantity());

                    textData.append("    " + qty + "\n");

                    String remark = orderItems.get(i).getRemark();
                    String strRemark = "("+orderItems.get(i).getRemark()+")";
                    if (!remark.isEmpty()) {
                        if (strRemark.length() >= 28) {
                            String rm = orderItems.get(i).getRemark().substring(0, 28);
                            textData.append("" + rm);
                        } else if (strRemark.length() < 28) {
                            textData.append("" + strRemark);
                            int difference = 28 - strRemark.length();

                            for (int d = 0; d < difference; d++) {
                                textData.append(" ");
                            }
                        }

                        textData.append("\n");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            textData.append("-------------------------------------\n");
          
            textData.append("\n");
            System.err.println("Text Data\n " +textData.toString());

        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
        return textData.toString();
    }
	
}
