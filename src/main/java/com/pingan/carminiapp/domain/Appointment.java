package com.pingan.carminiapp.domain;

import java.io.Serializable;
import java.sql.Timestamp;

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
 * @Description 预约pojo，对应数据库tb_appointment
 */
@Entity
@Component
@Table(name="tb_appointment")
public class Appointment implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
	private String tel;
	private String cardealername;
	private String brand;
	private String carseries;
	private String appointment;
	private Timestamp committime;//对应数据库表tb_appointment中默认default current_timestamp
	
	public Appointment() {
	}

	public Appointment(int id, String tel, String cardealername, String brand, String carseries, String appointment,
			Timestamp committime) {
		super();
		this.id = id;
		this.tel = tel;
		this.cardealername = cardealername;
		this.brand = brand;
		this.carseries = carseries;
		this.appointment = appointment;
		this.committime = committime;
	}

	public Appointment(String tel, String cardealername, String brand, String carseries, String appointment,
			Timestamp committime) {
		super();
		this.tel = tel;
		this.cardealername = cardealername;
		this.brand = brand;
		this.carseries = carseries;
		this.appointment = appointment;
		this.committime = committime;
	}

	public Appointment(String tel, String cardealername, String brand, String carseries, String appointment) {
		super();
		this.tel = tel;
		this.cardealername = cardealername;
		this.brand = brand;
		this.carseries = carseries;
		this.appointment = appointment;
	}

	public Appointment(int id, String tel, String cardealername, String brand, String carseries, String appointment) {
		super();
		this.id = id;
		this.tel = tel;
		this.cardealername = cardealername;
		this.brand = brand;
		this.carseries = carseries;
		this.appointment = appointment;
	}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
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

	public String getAppointment() {
		return appointment;
	}

	public void setAppointment(String appointment) {
		this.appointment = appointment;
	}

	public Timestamp getCommittime() {
		return committime;
	}

	public void setCommittime(Timestamp committime) {
		this.committime = committime;
	}

	@Override
	public String toString() {
		return "Appointment [id=" + id + ", tel=" + tel + ", cardealername=" + cardealername + ", brand=" + brand
				+ ", carseries=" + carseries + ", appointment=" + appointment + ", committime=" + committime + "]";
	}

	
}
