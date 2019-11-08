package com.ats.smadmin.model;

import java.util.List;

public class OrderHeaderList {
	

	private int orderId;
	private int userId;
	private int tableNo;
	private int billStatus;
	private String orderDate;
	private String orderDateTime;
	private int delStatus;
	float orderTotal;
	List<OrderDetailsList> orderDetailsList;

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getTableNo() {
		return tableNo;
	}

	public void setTableNo(int tableNo) {
		this.tableNo = tableNo;
	}

	public int getBillStatus() {
		return billStatus;
	}

	public void setBillStatus(int billStatus) {
		this.billStatus = billStatus;
	}
	
	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderDateTime() {
		return orderDateTime;
	}

	public void setOrderDateTime(String orderDateTime) {
		this.orderDateTime = orderDateTime;
	}

	public int getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	public float getOrderTotal() {
		return orderTotal;
	}

	public void setOrderTotal(float orderTotal) {
		this.orderTotal = orderTotal;
	}

	public List<OrderDetailsList> getOrderDetailsList() {
		return orderDetailsList;
	}

	public void setOrderDetailsList(List<OrderDetailsList> orderDetailsList) {
		this.orderDetailsList = orderDetailsList;
	}

	@Override
	public String toString() {
		return "OrderHeaderList [orderId=" + orderId + ", userId=" + userId + ", tableNo=" + tableNo + ", billStatus="
				+ billStatus + ", orderDate=" + orderDate + ", orderDateTime=" + orderDateTime + ", delStatus="
				+ delStatus + ", orderTotal=" + orderTotal + ", orderDetailsList=" + orderDetailsList + "]";
	}
	
	

}
