package com.pingan.carminiapp.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pingan.carminiapp.domain.SystemUser;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月2日 下午1:37:09
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Repository
public interface SystemUserRepository  extends JpaRepository<SystemUser,Integer> {
	
//	@Modifying//update delete insert需要加这两注解
//	@Transactional
	//@Query("delete from tb_systemuser user where user.username=?1")
	//符合命名格式后不需要@Query,加上后报错，并且返回int
//	int deleteByUsername(String username);
	
//	@Modifying//update delete insert需要加这两注解
//	@Transactional
//	@Query(value="insert into tb_systemuser(username,password,category,cardealername) values(?1,?2,?3,?4)",nativeQuery = true)
//	void insertSystemUser(String username,String password,int category,String cardealername);
	
	SystemUser findByUsernameAndPassword(String username,String password);
	
	SystemUser findByUsername(String username);
}
