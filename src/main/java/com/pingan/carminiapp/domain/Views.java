package com.pingan.carminiapp.domain;

import java.io.Serializable;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月26日 下午2:13:54
 * @version 1.0
 * @since JDK1.8
 * @Description 浏览量，对应数据库tb_views
 */
public class Views implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
	private int cid;
	private String name;
	private int view1;
	private int view2;
	
	public Views() {
	}

	public Views(int id, int cid, String name, int view1, int view2) {
		super();
		this.id = id;
		this.cid = cid;
		this.name = name;
		this.view1 = view1;
		this.view2 = view2;
	}

	public Views(int cid, String name, int view1, int view2) {
		super();
		this.cid = cid;
		this.name = name;
		this.view1 = view1;
		this.view2 = view2;
	}

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getView1() {
		return view1;
	}

	public void setView1(int view1) {
		this.view1 = view1;
	}

	public int getView2() {
		return view2;
	}

	public void setView2(int view2) {
		this.view2 = view2;
	}

	@Override
	public String toString() {
		return "Views [id=" + id + ", cid=" + cid + ", name=" + name + ", view1=" + view1 + ", view2=" + view2 + "]";
	}
	
}
