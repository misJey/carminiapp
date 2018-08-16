package com.pingan.carminiapp.service.face;

import java.util.List;

import com.pingan.carminiapp.domain.CarSeries;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:45:25
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public interface CarSeriesService {
	List<CarSeries> getAllCarSeries(int pageNow,int pageSize,String fuzzy);
	
	int getTotal();
	
	int getTotalByName(String cardealername);
	
	void deleteCarseries(int id);
	
	CarSeries getCarSeriesById(int id);
	
	CarSeries insertCarSeries(CarSeries carSeries);
}
