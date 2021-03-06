package com.ats.smadmin.model;

public class Admin {
	
	private int adminId;
	private String username;
	private String password;
	private String type;
	private int delStatus;
	private String token;
	private int venueId;

	public int getAdminId() {
		return adminId;
	}

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	public String getType() {
		return type;
	}

	public int getDelStatus() {
		return delStatus;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public int getVenueId() {
		return venueId;
	}

	public void setVenueId(int venueId) {
		this.venueId = venueId;
	}

	@Override
	public String toString() {
		return "Admin [adminId=" + adminId + ", username=" + username + ", password=" + password + ", type=" + type
				+ ", delStatus=" + delStatus + ", token=" + token + ", venueId=" + venueId + "]";
	}

}
