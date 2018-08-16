package com.pingan.carminiapp.dao;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.pingan.carminiapp.domain.RecordGift;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:43:36
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public interface RecordGiftRepository extends JpaRepository<RecordGift,Integer>{
	@Query(value="select * from tb_recordgift s where  s.cardealername like : keyword ",nativeQuery=true)
	List<RecordGift> searchLike(@Param("keyword")String keyword,Pageable pageable);
	
	@Query(value="select count(*) from tb_recordgift s where  s.cardealername=?1",nativeQuery=true)
	int getTotalByName(String cardealername);
}
