package com.ats.smadmin.model;

import java.sql.Date;

public class Item {
	
	private int itemId;
	private String itemName;
	private String itemDesc;
	private String itemImage;
	private float mrpGame;
	private float mrpRegular;
	private float mrpSpecial;
	private float openingRate;
	private float maxRate;
	private float minRate;
	private int currentStock;
	private int catId;
	private float sgst;
	private float cgst;
	private int isMixerApplicable;
	private int userId;
	private String updatedDate;
	private int delStatus;
	private int minStock;

	private String hsnCode;

	public int getItemId() {
		return itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public String getItemDesc() {
		return itemDesc;
	}

	public String getItemImage() {
		return itemImage;
	}

	public float getMrpGame() {
		return mrpGame;
	}

	public float getMrpRegular() {
		return mrpRegular;
	}

	public float getMrpSpecial() {
		return mrpSpecial;
	}

	public float getOpeningRate() {
		return openingRate;
	}

	public float getMaxRate() {
		return maxRate;
	}

	public float getMinRate() {
		return minRate;
	}

	public int getCurrentStock() {
		return currentStock;
	}

	public int getCatId() {
		return catId;
	}

	public float getSgst() {
		return sgst;
	}

	public float getCgst() {
		return cgst;
	}

	public int getIsMixerApplicable() {
		return isMixerApplicable;
	}

	public int getUserId() {
		return userId;
	}

	public String getUpdatedDate() {
		return updatedDate;
	}

	public int getDelStatus() {
		return delStatus;
	}

	public int getMinStock() {
		return minStock;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public void setItemImage(String itemImage) {
		this.itemImage = itemImage;
	}

	public void setMrpGame(float mrpGame) {
		this.mrpGame = mrpGame;
	}

	public void setMrpRegular(float mrpRegular) {
		this.mrpRegular = mrpRegular;
	}

	public void setMrpSpecial(float mrpSpecial) {
		this.mrpSpecial = mrpSpecial;
	}

	public void setOpeningRate(float openingRate) {
		this.openingRate = openingRate;
	}

	public void setMaxRate(float maxRate) {
		this.maxRate = maxRate;
	}

	public void setMinRate(float minRate) {
		this.minRate = minRate;
	}

	public void setCurrentStock(int currentStock) {
		this.currentStock = currentStock;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public void setSgst(float sgst) {
		this.sgst = sgst;
	}

	public void setCgst(float cgst) {
		this.cgst = cgst;
	}

	public void setIsMixerApplicable(int isMixerApplicable) {
		this.isMixerApplicable = isMixerApplicable;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	public void setMinStock(int minStock) {
		this.minStock = minStock;
	}

	public String getHsnCode() {
		return hsnCode;
	}

	public void setHsonCode(String hsnCode) {
		this.hsnCode = hsnCode;
	}

	@Override
	public String toString() {
		return "Item [itemId=" + itemId + ", itemName=" + itemName + ", itemDesc=" + itemDesc + ", itemImage="
				+ itemImage + ", mrpGame=" + mrpGame + ", mrpRegular=" + mrpRegular + ", mrpSpecial=" + mrpSpecial
				+ ", openingRate=" + openingRate + ", maxRate=" + maxRate + ", minRate=" + minRate + ", currentStock="
				+ currentStock + ", catId=" + catId + ", sgst=" + sgst + ", cgst=" + cgst + ", isMixerApplicable="
				+ isMixerApplicable + ", userId=" + userId + ", updatedDate=" + updatedDate + ", delStatus=" + delStatus
				+ ", minStock=" + minStock + ", hsnCode=" + hsnCode + "]";
	}

}
