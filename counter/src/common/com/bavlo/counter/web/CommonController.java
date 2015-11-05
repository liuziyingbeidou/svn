package com.bavlo.counter.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bavlo.counter.constant.IConstant;

/**
 * @Title: ����Counter
 * @ClassName: CommonController 
 * @Description: 
 * @author liuzy
 * @date 2015-11-5 ����10:57:03
 */
@Controller(value="CommonController")
@RequestMapping(value="/common")
public class CommonController extends BaseController {

	@RequestMapping(value="getChainInfo")
	public ModelAndView getChainInfo(){
		
		ModelAndView model = new ModelAndView(IConstant.PATH_COMMON + IConstant.COMMON_CHAIN);
		
		return model;
	}
}
