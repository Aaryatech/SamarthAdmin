package com.ats.smadmin.model;

public class TableCat {

	private int tableCatId;
	private String tableCatName;
	private String tableCatDesc;
	private int isActive;

	public int getTableCatId() {
		return tableCatId;
	}

	public void setTableCatId(int tableCatId) {
		this.tableCatId = tableCatId;
	}

	public String getTableCatName() {
		return tableCatName;
	}

	public void setTableCatName(String tableCatName) {
		this.tableCatName = tableCatName;
	}

	public String getTableCatDesc() {
		return tableCatDesc;
	}

	public void setTableCatDesc(String tableCatDesc) {
		this.tableCatDesc = tableCatDesc;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	@Override
	public String toString() {
		return "TableCat [tableCatId=" + tableCatId + ", tableCatName=" + tableCatName + ", tableCatDesc="
				+ tableCatDesc + ", isActive=" + isActive + "]";
	}

}
