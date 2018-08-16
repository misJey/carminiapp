package com.pingan.carminiapp.dao;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.pingan.carminiapp.domain.Cardealer;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:26:19
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Repository
public interface CardealerRepository extends JpaRepository<Cardealer,Integer> {
	Cardealer findByName(String name);
	
	@Query(value="select name from tb_cardealer",nativeQuery=true)
	List<String> getCardealerNameList();
	
	@Query(value="select * from tb_cardealer s where  s.name like : keyword ",nativeQuery=true)
	List<Cardealer> searchLike(@Param("keyword")String keyword,Pageable pageable);
}
