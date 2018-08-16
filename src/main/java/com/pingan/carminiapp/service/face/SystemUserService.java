package com.pingan.carminiapp.service.face;

import org.springframework.data.domain.Page;

import com.pingan.carminiapp.domain.SystemUser;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月26日 下午2:13:54
 * @version 1.0
 * @since JDK1.8
 * @Description 车商管理后台账号相关操作接口
 */
public interface SystemUserService {
	void insertOrUpdateSystemUser(SystemUser user);
	
	SystemUser selectSystemUser(String username,String password);
	
	Page<SystemUser> getALLUser(int pageNow,int pageSize);
	
	int getTotal();
	
	void deleteSystemUser(int id);
	
	SystemUser getSystemUserById(int id);
	
	SystemUser getSystemUserByUsername(String username);
}
