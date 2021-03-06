package com.bavlo.counter.web.test;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bavlo.counter.constant.IConstant;
import com.bavlo.counter.model.test.User;
import com.bavlo.counter.service.test.impl.UserService;
import com.bavlo.counter.web.BaseController;

@Controller("demoController")
@RequestMapping(value = "/demo")
// 表示要访问这个action的时候都要加上这个//user路径
public class DemoController extends BaseController {

	@Resource
	private UserService userService;
	
    Logger log = Logger.getLogger(DemoController.class);
    
    @RequestMapping("/upload")
    public void uploadHeadPic(@RequestParam("file")MultipartFile file,HttpServletRequest request,HttpServletResponse response){
        try {
            super.upload(file,IConstant.RES_TYPE_PIC, "/order/",request);
            //System.out.println(request.getParameter("test"));
            renderText(super.getfName());
        } catch (Exception e) {
            e.printStackTrace();
        }
   }
	
	/*
	 * 接收参数getParameter()的时候:
	 * 如果地址栏/springmvc/hello.htm上面没有传递参数,那么当id为int型的时候会报错,当id为Integer的时候值为null
	 * 当地址栏为/springmvc/hello.htm?id=10的时候,action中有三种接收方式 1、String
	 * hello(@RequestParam(value = "userid") int
	 * id),这样会把地址栏参数名为userid的值赋给参数id,如果用地址栏上的参数名为id,则接收不到 2、String
	 * hello(@RequestParam int id),这种情况下默认会把id作为参数名来进行接收赋值 3、String hello(int
	 * id),这种情况下也会默认把id作为参数名来进行接收赋值
	 * 注:如果参数前面加上@RequestParam注解,如果地址栏上面没有加上该注解的参数,例如:id,那么会报404错误,找不到该路径
	 * 3.从运用地方来说
	 *	forward:一般用于用户登陆的时候,根据角色转发到相应的模块.
	 *	redirect:一般用于用户注销登陆时返回主页面和跳转到其它的网站等.
	 */
	@RequestMapping(value = "/hello.htm")
	public String hello(int id) {// getParameter()的方式
		System.out.println("hello action:" + id);
		// return "hello";
		return "redirect:/index.jsp";// 不能重定向web-info里面的文件,而且需要写上绝对路径
	}

	// 返回页面参数的第一种方式,在形参中放入一个map
	@RequestMapping(value = "/hello1.htm")
	public String hello(int id, Map<String, Object> map) {
		System.out.println("hello1 action:" + id);
		map.put("name", "huangjie");
		return "test";
	}

	// 返回页面参数的第二种方式,在形参中放入一个Model
	@RequestMapping(value = "/hello2.htm")
	public String hello2(int id, Model model) {
		System.out.println("hello2 action:" + id);
		model.addAttribute("name", "huangjie");
		// 这个只有值没有键的情况下,使用Object的类型作为key,String-->string
		model.addAttribute("ok");
		return "test";
	}

	// 得到request,response,session等,只要在方法形参中声明参数即可
	@RequestMapping(value = "/hello3.htm")
	public String hello3(HttpServletRequest request) {
		String id = request.getParameter("id");
		System.out.println("hello3 action:" + id);
		return "test";
	}

	@RequestMapping(value = "/test")
	public String test(Model model){
		model.addAttribute("name", "小黄");
		model.addAttribute("string", "说了一句话...");
		return "test";
	}
	
	@RequestMapping(params = "method=log")
	public ModelAndView log(User user) {
		System.out.println("用户登录");
		userService.test();
		
		//return "log_fail";
		
		return new ModelAndView("redirect:page/test.jsp");//forward:
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login2(HttpServletRequest request) {
		String username = request.getParameter("username").trim();
		System.out.println(username);
		return "login2";
	}
}
