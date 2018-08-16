package com.pingan.carminiapp.domain;

import java.io.Serializable;

import javax.persistence.Column;
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
 * @Description 后台管理员，对应数据库tb_systemuser
 */
@Entity
@Component
@Table(name="tb_systemuser")
public class SystemUser implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
	@Column(name="username")
	private String username;
	@Column(name="password")
	private String password;
	private int category;
	private String cardealername;
	private String image;
	
	public SystemUser() {
	}

	public SystemUser(int id, String username, String password, int category, String cardealername, String image) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.category = category;
		this.cardealername = cardealername;
		this.image = image;
	}

	public SystemUser(String username, String password, int category, String cardealername, String image) {
		super();
		this.username = username;
		this.password = password;
		this.category = category;
		this.cardealername = cardealername;
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

	@Column(name = "username")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getCardealername() {
		return cardealername;
	}

	public void setCardealername(String cardealername) {
		this.cardealername = cardealername;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "SystemUser [id=" + id + ", username=" + username + ", password=" + password + ", category=" + category
				+ ", cardealername=" + cardealername + ", image=" + image + "]";
	}
}
