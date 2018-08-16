package com.pingan.carminiapp.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.pingan.carminiapp.dao.SystemUserRepository;
import com.pingan.carminiapp.domain.SystemUser;
import com.pingan.carminiapp.service.face.SystemUserService;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月26日 下午2:13:54
 * @version 1.0
 * @since JDK1.8
 * @Description 车商管理后台账号相关操作业务类
 */
@Service
public class SystemUserServiceImpl implements SystemUserService{
	private static final Logger log = LoggerFactory.getLogger(SystemUserServiceImpl.class);
	
	@Autowired
	SystemUserRepository userRepository;
	
	/**
	 * 
	 * @author 作者 : 舒
	 * @date 创建时间：2018年7月26日 下午2:16:12
	 * @version 1.0
	 * @since JDK1.8
	 * @param user
	 * @throws
	 * @Description 添加或修改用户信息（只有管理员才可以）
	 */
	@Override
	public void insertOrUpdateSystemUser(SystemUser user){
		log.info("start adduser service!");
		this.userRepository.saveAndFlush(user);
	}
	
	/**
	 * 
	 * @author 作者 : 舒
	 * @date 创建时间：2018年7月27日 下午2:44:54
	 * @version 1.0
	 * @since JDK1.8
	 * @param user
	 * @throws
	 * @Description 查询登陆用户
	 */
	@Override
	public SystemUser selectSystemUser(String username,String password) {
		log.info("selectSystemUser service start,usrename:"+username);
		SystemUser user = new SystemUser();
		user = this.userRepository.findByUsernameAndPassword(username,password);//userMapper.select(username, password);
		return user;
	}
	
	/**
	 * 
	 * @author 作者 : 舒
	 * @date 创建时间：2018年8月2日 上午10:12:59
	 * @version 1.0
	 * @since JDK1.8
	 * @param pageNow
	 * @param pageSize
	 * @return
	 * @throws
	 * @Description 获取所有用户信息
	 */
	@Override
	public Page<SystemUser> getALLUser(int pageNow, int pageSize) {
		Pageable pageable = PageRequest.of(pageNow, pageSize);
        Page<SystemUser> allUser = userRepository.findAll(pageable);
        return allUser;
	}

	//查询总数
	@Override
	public int getTotal() {
		int total = (int) userRepository.count();
		return total;
	}

	//按id删除用户
	@Override
	public void deleteSystemUser(int id) {
		this.userRepository.deleteById(id);
	}

	//根据id查找
	@Override
	public SystemUser getSystemUserById(int id) {
		SystemUser user = this.userRepository.findById(id).get();
		return user;
	}

	@Override
	public SystemUser getSystemUserByUsername(String username) {
		SystemUser user = this.userRepository.findByUsername(username);
		return user;
	}
	
}
