package com.pingan.carminiapp.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.pingan.carminiapp.dao.CardealerRepository;
import com.pingan.carminiapp.domain.Cardealer;
import com.pingan.carminiapp.service.face.CardealerService;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:34:29
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Service
public class CardealerServiceImpl implements CardealerService {

	@Autowired
	CardealerRepository cardealerRepository;
	
	@Override
	public List<Cardealer> getAllCardealer(int pageNow, int pageSize,String fuzzy) {
		List<Cardealer> allCardealer = null;
		Pageable pageable = PageRequest.of(pageNow, pageSize);
		if(StringUtils.isEmpty(fuzzy)){
	        allCardealer = cardealerRepository.findAll(pageable).getContent();
		}else {
			//分页模糊查询
			allCardealer = cardealerRepository.searchLike("%"+fuzzy+"%",pageable);
		}
        return allCardealer;
	}

	@Override
	public int getTotal() {
		int total = (int) cardealerRepository.count();
		return total;
	}

	@Override
	public Cardealer getCadealerByName(String name) {
		Cardealer cardealer = this.cardealerRepository.findByName(name);
		return cardealer;
	}

	@Override
	public List<String> getCardealerNameList() {
		List<String> list = this.cardealerRepository.getCardealerNameList();
		return list;
	}

	@Override
	public void deleteCardealer(int id) {
		this.cardealerRepository.deleteById(id);
	}

	@Override
	public Cardealer getCardealerById(int id) {
		Cardealer cardealer = this.cardealerRepository.findById(id).get();
		return cardealer;
	}

	@Override
	public void insertOrUpadteCardealer(Cardealer cardealer) {
		this.cardealerRepository.save(cardealer);
	}
	
}
