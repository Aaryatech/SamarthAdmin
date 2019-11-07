package com.ats.smadmin.model;

import java.util.List;


public class AllTableList {
	
	List<TableList> busyTables;
	
	List<TableList> freeTables;

	public List<TableList> getBusyTables() {
		return busyTables;
	}

	public void setBusyTables(List<TableList> busyTables) {
		this.busyTables = busyTables;
	}

	public List<TableList> getFreeTables() {
		return freeTables;
	}

	public void setFreeTables(List<TableList> freeTables) {
		this.freeTables = freeTables;
	}

	@Override
	public String toString() {
		return "AllTableList [busyTables=" + busyTables + ", freeTables=" + freeTables + "]";
	}
	
	

}
