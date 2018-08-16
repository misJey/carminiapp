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
 * @Description 车商，对应数据库tb_cardealer
 */
@Entity
@Component
@Table(name="tb_cardealer")
public class Cardealer implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
	private int cid;
	private int pid;
	private String contacts;
	private String tel;
	private String code;
	private String name;
	private int category;
	private String brand;
	private String license;
	private String logo;
	private String image;
	private String working;
	private String workend;
	private String longitude;
	private String latitude;
	private String address;
	private String info;
	private String visit;
	
	public Cardealer() {
	}

	public Cardealer(int id, int cid, int pid, String contacts, String tel, String code, String name, int category,
			String brand, String license, String logo, String image, String working, String workend, String longitude,
			String latitude, String address, String info, String visit) {
		super();
		this.id = id;
		this.cid = cid;
		this.pid = pid;
		this.contacts = contacts;
		this.tel = tel;
		this.code = code;
		this.name = name;
		this.category = category;
		this.brand = brand;
		this.license = license;
		this.logo = logo;
		this.image = image;
		this.working = working;
		this.workend = workend;
		this.longitude = longitude;
		this.latitude = latitude;
		this.address = address;
		this.info = info;
		this.visit = visit;
	}

	public Cardealer(int cid, int pid, String contacts, String tel, String code, String name, int category,
			String brand, String license, String logo, String image, String working, String workend, String longitude,
			String latitude, String address, String info, String visit) {
		super();
		this.cid = cid;
		this.pid = pid;
		this.contacts = contacts;
		this.tel = tel;
		this.code = code;
		this.name = name;
		this.category = category;
		this.brand = brand;
		this.license = license;
		this.logo = logo;
		this.image = image;
		this.working = working;
		this.workend = workend;
		this.longitude = longitude;
		this.latitude = latitude;
		this.address = address;
		this.info = info;
		this.visit = visit;
	}
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getWorking() {
		return working;
	}

	public void setWorking(String working) {
		this.working = working;
	}

	public String getWorkend() {
		return workend;
	}

	public void setWorkend(String workend) {
		this.workend = workend;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getVisit() {
		return visit;
	}

	public void setVisit(String visit) {
		this.visit = visit;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "id:"+this.id+",cid:"+this.cid+",pid:"+this.pid+",contacts:"+this.contacts+",tel"+this.tel
				+",code:"+this.code+",name:"+this.name+",category:"+this.category+",brand:"+this.brand
				+",license:"+this.license+",logo:"+this.logo+",image:"+this.image+",working:"+this.working
				+",workend:"+this.workend+",longtitude"+this.longitude+",latitude:"+this.latitude+",address:"
				+this.address+",info:"+this.info+",visit:"+this.visit;
	}
}
