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
 * @Description 礼品卷发放记录，对应数据库tb_recordgift
 */
@Entity
@Component
@Table(name="tb_recordgift")
public class RecordGift implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
	private String cardealername;
	private String giftname;
	private String username;
	private String tel;
	private Timestamp gettime;//对应数据库表tb_recordgift中默认default current_timestamp
	
	public RecordGift() {
	}

	public RecordGift(int id, String cardealername, String giftname, String username, String tel, Timestamp gettime) {
		super();
		this.id = id;
		this.cardealername = cardealername;
		this.giftname = giftname;
		this.username = username;
		this.tel = tel;
		this.gettime = gettime;
	}

	public RecordGift(String cardealername, String giftname, String username, String tel, Timestamp gettime) {
		super();
		this.cardealername = cardealername;
		this.giftname = giftname;
		this.username = username;
		this.tel = tel;
		this.gettime = gettime;
	}

	public RecordGift(String cardealername, String giftname, String username, String tel) {
		super();
		this.cardealername = cardealername;
		this.giftname = giftname;
		this.username = username;
		this.tel = tel;
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

	public String getGiftname() {
		return giftname;
	}

	public void setGiftname(String giftname) {
		this.giftname = giftname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public Timestamp getGettime() {
		return gettime;
	}

	public void setGettime(Timestamp gettime) {
		this.gettime = gettime;
	}

	@Override
	public String toString() {
		return "RecordGift [id=" + id + ", cardealername=" + cardealername + ", giftname=" + giftname + ", username=" + username
				+ ", tel=" + tel + ", gettime=" + gettime + "]";
	}
}
