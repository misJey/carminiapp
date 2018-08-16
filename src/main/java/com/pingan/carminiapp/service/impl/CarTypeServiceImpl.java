package com.pingan.carminiapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pingan.carminiapp.dao.CarTypeRepository;
import com.pingan.carminiapp.domain.CarType;
import com.pingan.carminiapp.service.face.CarTypeService;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:46:18
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Service
public class CarTypeServiceImpl implements CarTypeService {
	@Autowired
	CarTypeRepository carTypeRepository;
	
	//根据车系id删除关联车型
	@Override
	public void deleteCarType(int carSeriesId) {
		this.carTypeRepository.deleteByCarseriesid(carSeriesId);
	}

	@Override
	public List<CarType> getAllCarType(int carSeriesId) {
		List<CarType> carTypeInfo = this.carTypeRepository.findAllByCarseriesid(carSeriesId);
		return carTypeInfo;
	}

	@Override
	public void insertCarType(CarType carType) {
		this.carTypeRepository.save(carType);
	}

	@Override
	public void deleteCarTypeById(int id) {
		this.carTypeRepository.deleteById(id);
	}

	@Override
	public CarType getCarTypeById(int id) {
		CarType carType = this.carTypeRepository.findById(id).get();
		return carType;
	}
}
