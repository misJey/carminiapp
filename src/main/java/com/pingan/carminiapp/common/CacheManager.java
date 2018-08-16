package com.pingan.carminiapp.common;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月27日 下午5:09:03
 * @version 1.0
 * @since JDK1.8
 * @Description 缓存用
 */
public class CacheManager {
	private static final Logger log = LoggerFactory.getLogger(CacheManager.class);
	public static Map<String, Object> dataCache = new HashMap<String,Object>();
	private static CacheManager cm = null;
	
	private CacheManager(){
	}
	
	public static CacheManager getInstance(){
		  if(cm==null){
		   cm = new CacheManager();
		  }
		  return cm;
	}
	
	 /**
	  * 增加缓存
	  * @param key
	  * @param value
	  * @param ccm 缓存对象
	  * @return 
	  */
	 public  boolean addCache(String key,Object value){
		 log.info("开始增加缓存－－－－－－－－－－－－－,key:"+key);
		  boolean flag = false;
		  try {
			  dataCache.put(key, value);
			  log.info("增加缓存结束－－－－－－－－－－－－－,SZIE:"+dataCache.size());
			  flag=true;
		  } catch (Exception e) {
			e.printStackTrace();
		  }
		  return flag;
	}
	 
	 
	   /**
	    * 获取缓存实体
	    */
	 public Object getValue(String key){
		 Object obj = dataCache.get(key);
		 log.info("获取缓存,key:"+key+",value:"+obj);
		 if(null != obj){
			 return obj;
		 }else{
			 return null;
		 }
	 }
	 
	 /**
	  * 删除缓存
	  * @param key
	  * @return 
	  */
	 public boolean removeCache(Object key){
		 log.info("删除缓存－－－－－－－－－－－－－,key:"+key);
		 boolean flag=false;
		 try {
			 	dataCache.remove(key);
			 	flag=true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		  return flag;
	 }

}
