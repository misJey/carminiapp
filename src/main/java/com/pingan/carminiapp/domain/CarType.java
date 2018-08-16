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
 * @Description 车辆，对应数据库tb_car
 */
@Entity
@Component
@Table(name="tb_cartype")
public class CarType implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
	private int carseriesid;
	private String color;
	private int serialnumber;
	private String image;
	
	public CarType() {
	}

	public CarType(int id, int carseriesid, String color, int serialnumber, String image) {
		super();
		this.id = id;
		this.carseriesid = carseriesid;
		this.color = color;
		this.serialnumber = serialnumber;
		this.image = image;
	}

	public CarType(int carseriesid, String color, int serialnumber, String image) {
		super();
		this.carseriesid = carseriesid;
		this.color = color;
		this.serialnumber = serialnumber;
		this.image = image;
	}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCarseriesid() {
		return carseriesid;
	}

	public void setCarseriesid(int carseriesid) {
		this.carseriesid = carseriesid;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public int getSerialnumber() {
		return serialnumber;
	}

	public void setSerialnumber(int serialnumber) {
		this.serialnumber = serialnumber;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "Car [id=" + id + ", carseriesid=" + carseriesid + ", color=" + color + ", serialnumber=" + serialnumber + ", image="
				+ image + "]";
	}

	@Override
	public int hashCode() {
		return 0;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CarType other = (CarType) obj;
		if (carseriesid != other.carseriesid)
			return false;
		if (color == null) {
			if (other.color != null)
				return false;
		} else if (!color.equals(other.color))
			return false;
		if (id != other.id)
			return false;
		if (image == null) {
			if (other.image != null)
				return false;
		} else if (!image.equals(other.image))
			return false;
		if (serialnumber != other.serialnumber)
			return false;
		return true;
	}
	
	
}
