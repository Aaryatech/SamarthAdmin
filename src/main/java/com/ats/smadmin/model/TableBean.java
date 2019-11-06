package com.ats.smadmin.model;

import java.util.Date;

public class TableBean {

	private int tableId;
	private int tableNo;
	private String tableName;
	private int isDelete;
	private int isActive;
	private int userId;
	private int venueId;
	private String updatedDate;
	
	public int getTableId() {
		return tableId;
	}
	public int getTableNo() {
		return tableNo;
	}
	public String getTableName() {
		return tableName;
	}
	public int getIsDelete() {
		return isDelete;
	}
	public int getIsActive() {
		return isActive;
	}
	public int getUserId() {
		return userId;
	}
	public String getUpdatedDate() {
		return updatedDate;
	}
	public void setTableId(int tableId) {
		this.tableId = tableId;
	}
	public void setTableNo(int tableNo) {
		this.tableNo = tableNo;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}
	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}
	
	public int getVenueId() {
		return venueId;
	}
	public void setVenueId(int venueId) {
		this.venueId = venueId;
	}
	@Override
	public String toString() {
		return "TableBean [tableId=" + tableId + ", tableNo=" + tableNo + ", tableName=" + tableName + ", isDelete="
				+ isDelete + ", isActive=" + isActive + ", userId=" + userId + ", updatedDate=" + updatedDate + "]";
	}

}
