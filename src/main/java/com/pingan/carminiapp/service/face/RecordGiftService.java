package com.pingan.carminiapp.service.face;

import java.util.List;

import com.pingan.carminiapp.domain.RecordGift;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月8日 上午11:57:16
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public interface RecordGiftService {
	List<RecordGift> getAllRecordGift(int pageNow,int pageSize,String fuzzy);
	
	int getTotal();

	int getTotalByName(String cardealername);
	
	void insertOrUpdateRecordGift(RecordGift recordGift);
}
