package com.pingan.carminiapp.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.pingan.carminiapp.dao.CarSeriesRepository;
import com.pingan.carminiapp.domain.CarSeries;
import com.pingan.carminiapp.service.face.CarSeriesService;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:46:41
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Service
public class CarSeriesServiceImpl implements CarSeriesService {
	
	@Autowired
	CarSeriesRepository carSeriesRepository;
	
	@Override
	public List<CarSeries> getAllCarSeries(int pageNow, int pageSize, String fuzzy) {
		List<CarSeries> allCarSeries = null;
		Pageable pageable = PageRequest.of(pageNow, pageSize);
		if(StringUtils.isEmpty(fuzzy)){
	        allCarSeries = carSeriesRepository.findAll(pageable).getContent();
		}else {
			//分页模糊查询
			allCarSeries = carSeriesRepository.searchLike("%"+fuzzy+"%",pageable);
		}
        return allCarSeries;
	}
	
	@Override
	public int getTotal() {
		int total = (int) carSeriesRepository.count();
		return total;
	}

	@Override
	public void deleteCarseries(int id) {
		this.carSeriesRepository.deleteById(id);
	}

	@Override
	public CarSeries getCarSeriesById(int id) {
		CarSeries carSeries = this.carSeriesRepository.findById(id).get();
		return carSeries;
	}

	@Override
	public CarSeries insertCarSeries(CarSeries carSeries) {
		return this.carSeriesRepository.save(carSeries);
	}

	@Override
	public int getTotalByName(String cardealername) {
		int total = (int) carSeriesRepository.getTotalByName(cardealername);
		return total;
	}
}
