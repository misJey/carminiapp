package com.pingan.carminiapp.domain;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月26日 下午2:13:54
 * @version 1.0
 * @since JDK1.8
 * @Description 车型，对应数据库tb_cardtype
 */
@Entity
@Component
@Table(name="tb_carseries")
public class CarSeries implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
	private String cardealername;
	private String brand;
	private String carseries;
	private int amount;
	private float pricelow;
	private float pricehigh;
	private int serialnumber;
	
	public CarSeries() {
	}

	public CarSeries(String cardealername, String brand, String carseries, int amount, float pricelow, float pricehigh,
			int serialnumber) {
		super();
		this.cardealername = cardealername;
		this.brand = brand;
		this.carseries = carseries;
		this.amount = amount;
		this.pricelow = pricelow;
		this.pricehigh = pricehigh;
		this.serialnumber = serialnumber;
	}

	public CarSeries(int id, String cardealername, String brand, String carseries, int amount, float pricelow,
			float pricehigh, int serialnumber) {
		super();
		this.id = id;
		this.cardealername = cardealername;
		this.brand = brand;
		this.carseries = carseries;
		this.amount = amount;
		this.pricelow = pricelow;
		this.pricehigh = pricehigh;
		this.serialnumber = serialnumber;
	}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCardealername() {
		return cardealername;
	}

	public void setCardealername(String cardealername) {
		this.cardealername = cardealername;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getCarseries() {
		return carseries;
	}

	public void setCarseries(String carseries) {
		this.carseries = carseries;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public float getPricelow() {
		return pricelow;
	}

	public void setPricelow(float pricelow) {
		this.pricelow = pricelow;
	}

	public float getPricehigh() {
		return pricehigh;
	}

	public void setPricehigh(float pricehigh) {
		this.pricehigh = pricehigh;
	}

	public int getSerialnumber() {
		return serialnumber;
	}

	public void setSerialnumber(int serialnumber) {
		this.serialnumber = serialnumber;
	}

	@Override
	public String toString() {
		return "CarSeries [id=" + id + ", cardealername=" + cardealername + ", brand=" + brand + ", carseries="
				+ carseries + ", amount=" + amount + ", pricelow=" + pricelow + ", pricehigh=" + pricehigh
				+ ", serialnumber=" + serialnumber + "]";
	}
}
