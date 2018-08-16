package com.pingan.carminiapp.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.transaction.annotation.Transactional;

import com.pingan.carminiapp.domain.CarType;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:41:34
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public interface CarTypeRepository extends JpaRepository<CarType,Integer> {
	@Modifying//update delete insert需要加这两注解
	@Transactional
	void deleteByCarseriesid(int carSeriesId);
	
	List<CarType> findAllByCarseriesid(int carSeriesId);
}
