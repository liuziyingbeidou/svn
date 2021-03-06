package com.bavlo.counter.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bavlo.counter.httpclient.HttpTools;

/**
 * @Title: 宝珑Counter
 * @ClassName: HttpContrller 
 * @Description: ajax对远程接口的访问(json)
 * @author liuzy
 * @date 2015-10-21 下午04:50:48
 */
@Controller
@RequestMapping(value="/webservice")
public class HttpContrller extends BaseController {

	@RequestMapping(value="/http",produces = "application/json; charset=utf-8")
	//@ResponseBody
	public void request(String url){
		//url.replace("@", "&");
		System.out.println("开始调用远程接口..."+url);
		String info = HttpTools.getDataByURL(url);
		System.out.println("返回数据:"+info);
		renderJson(info);
		//return info;
	}
	
	@RequestMapping(value="/httprequest",produces = "application/json; charset=utf-8")
	//@ResponseBody
	public void httprequest(String requestUrl, String requestMethod, String outputStr){
		
		System.out.println("开始调用远程接口..."+requestUrl);
		String info = null;
		if("GET".equals(requestMethod)){
			info = HttpTools.submitGet(requestUrl);
		}else if("POST".equals(requestMethod)){
			info = HttpTools.submitPost(requestUrl, outputStr)+"";
		}
		System.out.println("返回数据:"+info);
		renderJson(info);
		//return info;
	}
	
	
	@RequestMapping(value="/httpcalculator",produces = "application/json; charset=utf-8")
	//@ResponseBody
	public void httpcalculator(String requestUrl, String outputStr){
		
		System.out.println("开始调用远程接口..."+requestUrl);
		String info = null;

		info = HttpTools.submitPost(requestUrl, outputStr)+"";
		System.out.println("返回数据:"+info);
		renderJson(info);
		//return info;
	}
}
