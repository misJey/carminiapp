package com.pingan.carminiapp.dao;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.pingan.carminiapp.domain.CarSeries;
/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:42:19
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public interface CarSeriesRepository extends JpaRepository<CarSeries,Integer> {
	
	@Query(value="select * from tb_carseries s where  s.cardealername like : keyword ",nativeQuery=true)
	List<CarSeries> searchLike(@Param("keyword")String keyword,Pageable pageable);
	
	@Query(value="select count(*) from tb_carseries s where  s.cardealername=?1",nativeQuery=true)
	int getTotalByName(String cardealername);
}
