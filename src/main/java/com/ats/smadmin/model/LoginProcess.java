package com.ats.smadmin.model;

public class LoginProcess {
	
	private String message;
	private boolean isError;
	private Admin admin;
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isError() {
		return isError;
	}
	public void setError(boolean isError) {
		this.isError = isError;
	}
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	@Override
	public String toString() {
		return "LoginProcess [message=" + message + ", isError=" + isError + ", admin=" + admin + "]";
	}
	
	

}
