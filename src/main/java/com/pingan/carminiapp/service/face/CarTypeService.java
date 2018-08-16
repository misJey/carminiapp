package com.pingan.carminiapp.service.face;

import java.util.List;

import com.pingan.carminiapp.domain.CarType;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:45:09
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public interface CarTypeService {
	void deleteCarType(int carSeriesId);
	
	void deleteCarTypeById(int id);
	
	List<CarType> getAllCarType(int carSeriesId);
	
	void insertCarType(CarType carType);
	
	CarType getCarTypeById(int id);
}
