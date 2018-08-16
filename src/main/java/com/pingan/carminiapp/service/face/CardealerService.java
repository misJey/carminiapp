package com.pingan.carminiapp.service.face;

import java.util.List;

import com.pingan.carminiapp.domain.Cardealer;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月3日 下午11:33:41
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public interface CardealerService {
	List<Cardealer> getAllCardealer(int pageNow,int pageSize,String fuzzy);
	
	int getTotal();
	
	Cardealer getCadealerByName(String name);
	
	List<String> getCardealerNameList();
	
	void deleteCardealer(int id);

	Cardealer getCardealerById(int id);
	
	void insertOrUpadteCardealer(Cardealer cardealer);
}
