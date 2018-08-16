package com.pingan.carminiapp.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.pingan.carminiapp.dao.RecordGiftRepository;
import com.pingan.carminiapp.domain.RecordGift;
import com.pingan.carminiapp.service.face.RecordGiftService;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月8日 上午11:57:31
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Service
public class RecordGiftServiceImpl implements RecordGiftService {
	private static final Logger log = LoggerFactory.getLogger(RecordGiftServiceImpl.class);
	
	@Autowired
	RecordGiftRepository recordGiftRepository;
	
	@Override
	public List<RecordGift> getAllRecordGift(int pageNow, int pageSize, String fuzzy) {
		List<RecordGift> allRecordGift = null;
		Pageable pageable = PageRequest.of(pageNow, pageSize);
		if(StringUtils.isEmpty(fuzzy)){
	        allRecordGift = recordGiftRepository.findAll(pageable).getContent();
		}else {
			//分页模糊查询
			allRecordGift = recordGiftRepository.searchLike("%"+fuzzy+"%",pageable);
		}
        return allRecordGift;
	}

	@Override
	public int getTotal() {
		int total = (int) recordGiftRepository.count();
		return total;
	}

	@Override
	public int getTotalByName(String cardealername) {
		int total = (int) recordGiftRepository.getTotalByName(cardealername);
		return total;
	}

	@Override
	public void insertOrUpdateRecordGift(RecordGift recordGift) {
		log.info("start insertOrUpdateRecordGift service!");
		this.recordGiftRepository.saveAndFlush(recordGift);
	}

}
