package com.pingan.carminiapp.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年7月30日 上午9:31:07
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
@Controller
@RequestMapping(value = "error")
public class BaseErrorController implements ErrorController{
	private static final Logger logger = LoggerFactory.getLogger(BaseErrorController.class);

    @Override

    public String getErrorPath() {
        logger.info("出错啦！进入自定义错误控制器");
        return "404";
    }

    @RequestMapping
    public String error() {
        return getErrorPath();
    }
}
