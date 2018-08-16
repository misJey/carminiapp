package com.pingan.carminiapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pingan.carminiapp.domain.Cardealer;
import com.pingan.carminiapp.domain.SystemUser;
import com.pingan.carminiapp.service.face.CardealerService;
import com.pingan.carminiapp.utils.FileUploadUtil;
import com.pingan.carminiapp.utils.UserStatusUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class CardealerController {
	private static final Logger log = LoggerFactory.getLogger(CardealerController.class);
	
	@Autowired
	@Qualifier("cardealerServiceImpl")
	CardealerService cardealerService;
	//车商管理页
	@RequestMapping("/appcarserver")
	public ModelAndView carServerView(HttpServletRequest request,@RequestParam("currentPage") String currentPage,String fuzzy){
		log.info("carServerView controller start!");
		ModelAndView mav = new ModelAndView("carserver");
		int pageSize = 15;
		int pageNow = Integer.valueOf(currentPage);//页码，从0开始为第一页
		SystemUser user = UserStatusUtil.getUser(request);
		int category = user.getCategory();
		mav.addObject("category", category);//用户类型
		mav.addObject("username", user.getUsername());
		int total = 1;//车商用户登陆默认只展示自己，即总数为1
		
		List<Cardealer> cardealerInfo = null;
		JSONArray jsonArray = null;
		if(category < 2){//管理员可以查看所有
			cardealerInfo = this.cardealerService.getAllCardealer(pageNow, pageSize,fuzzy);
			if(null == cardealerInfo){
				mav.addObject("total", 0);
				return mav;
			}
			jsonArray = JSONArray.fromObject(cardealerInfo.toArray());
			total = this.cardealerService.getTotal();//车商总数
		}else{
			Cardealer cardealer = this.cardealerService.getCadealerByName(user.getCardealername());
			jsonArray = JSONArray.fromObject(cardealer);
		}
		
		mav.addObject("total", total);
		mav.addObject("cardealerInfo", jsonArray);
		return mav;
	}
	
	//按id删除车商（注：删除前加个限制，必须先删除掉对应的系统用户方可删除车商）
	@GetMapping("/appdeletecardealer")
	@ResponseBody
	public Object deleteCardealer(@RequestParam("id")String id){
		log.info("start deleteCardealer--delete!");
		this.cardealerService.deleteCardealer(Integer.parseInt(id));
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
	
	//按id修改车商信息
	@GetMapping("/appmodifycardealer")
	@ResponseBody
	public ModelAndView modifyCardealer(@RequestParam("id")String id,HttpServletRequest request){
		log.info("start modifyCardealer--delete!");
		Cardealer cardealer = this.cardealerService.getCardealerById(Integer.parseInt(id));
		ModelAndView mav = new ModelAndView("carserver_edit");
		SystemUser loginUser = UserStatusUtil.getUser(request);
		mav.addObject("username", loginUser.getUsername());
		mav.addObject("modifyCardealer", JSONObject.fromObject(cardealer));
		return mav;
	}
		
	//车商管理新建页
	@RequestMapping("/appcarserveredit")
	public ModelAndView appCarServerEdit(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("carserver_edit");
		SystemUser loginUser = UserStatusUtil.getUser(request);
		mav.addObject("username", loginUser.getUsername());
		return mav;
	}
	
	//添加车商
	@PostMapping("/appaddcardealer")
	@ResponseBody
	public Object addCardealer(@RequestBody JSONObject jsonObject,HttpServletRequest request){
		log.info("start appaddcardealer--add!");
		Cardealer cardealer = (Cardealer) JSONObject.toBean(jsonObject, Cardealer.class);
		int id = cardealer.getId();
		String imageNew = null;
		String imageOld = null;
		String logoNew = null;
		String logoOld = null;
		if(id != 0){//不为0表示是修改请求
			Cardealer cardealer2 = this.cardealerService.getCardealerById(id);
			//不相等表达图片有更新,这时处理图片更新并重命名为之前的图片名称以覆盖原先图片
			imageNew = cardealer.getImage();
			imageOld =cardealer2.getImage();
			if(!imageNew.equals(imageOld)){
				cardealer.setImage(imageOld);
				FileUploadUtil.saveFile(imageNew,imageOld,request);
			}
			logoNew = cardealer.getLogo();
			logoOld = cardealer2.getLogo();
			if(!logoNew.equals(logoOld)){
				cardealer.setLogo(imageOld);
				FileUploadUtil.saveFile(imageNew,imageOld,request);
			}
		}else{//新增
			imageNew = cardealer.getImage();
			logoNew = cardealer.getLogo();
			FileUploadUtil.saveFile(imageNew,null,request);
			FileUploadUtil.saveFile(logoNew,null,request);
		}
		this.cardealerService.insertOrUpadteCardealer(cardealer);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
	
	//在管理员用户添加车商用户时显示所有车商名称的下拉框
	@GetMapping("/appgetcardealernamelist")
	@ResponseBody
	public Object getCardealerNameList(HttpServletRequest request){
		Map<String,Object> map = new HashMap<String,Object>();
		List<String> list = this.cardealerService.getCardealerNameList();
		SystemUser user = UserStatusUtil.getUser(request);
		int category = user.getCategory();
		map.put("category", category);//用户类型
		map.put("username", user.getUsername());
		map.put("list", JSONArray.fromObject(list));
		return map;
	}
	
	//添加用户时检测用户名是否已存在
	@GetMapping("/appcheckname")
	@ResponseBody
	public Object checkCardealername(@RequestParam("name")String name){
		String flag = "false";
		Cardealer cardealer = this.cardealerService.getCadealerByName(name);
		if(null != cardealer){
			flag = "true";
		}
		return flag;
	}
}
