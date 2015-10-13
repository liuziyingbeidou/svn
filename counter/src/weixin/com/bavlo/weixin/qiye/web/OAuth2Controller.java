package com.bavlo.weixin.qiye.web;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bavlo.weixin.qiye.pojo.AccessToken;
import com.bavlo.weixin.qiye.util.Constants;
import com.bavlo.weixin.qiye.util.QiYeUtil;
import com.bavlo.weixin.qiye.util.Result;

/**
 * OAuth2 处理控制器
 * @author shijf
 *
 */
@Controller
public class OAuth2Controller {
	/**
	 * 构造参数并将请求重定向到微信API获取登录信息
	 * 
	 * @param index
	 * @return
	 */
	@RequestMapping(value = { "/oauth2.do", "/oauth2" })
	public String Oauth2API(HttpServletRequest request, @RequestParam String resultUrl) {
		// 此处可以添加获取持久化的数据，如企业号id等相关信息
		String CropId = Constants.CORPID;
		String redirectUrl = "";
		if (resultUrl != null) {
			String reqUrl = "bavlo.tunnel.mobi/counter";
			//TODO 此处测试上面的方法，把参数：“reqUrl” 拼接你自己的 URL
			String backUrl ="http://" + reqUrl + "/oauth2url.do?oauth2url=" + resultUrl;
			redirectUrl = oAuth2Url(CropId, backUrl);
		}
		return "redirect:" + redirectUrl;
	}

	/**
	 * 根据code获取Userid后跳转到需要带用户信息的最终页面
	 * 
	 * @param request
	 * @param code
	 *            获取微信重定向到自己设置的URL中code参数
	 * @param oauth2url
	 *            跳转到最终页面的地址
	 * @return
	 */
	@RequestMapping(value = { "/oauth2url.do" })
	public String Oauth2MeUrl(HttpServletRequest request, @RequestParam String code, @RequestParam String oauth2url) {
		AccessToken accessToken = QiYeUtil.getAccessToken(Constants.CORPID, Constants.SECRET);
		HttpSession session = request.getSession();
		if (accessToken != null && accessToken.getToken() != null) {
			String Userid = getMemberGuidByCode(accessToken.getToken(), code, Constants.AGENTID);
			if (Userid != null) {
				session.setAttribute("UserId", Userid);
				session.setAttribute("Tagname", QiYeUtil.getUserTag(Userid));
			}
		}
		// 这里简单处理,存储到session中
		return "redirect:" + oauth2url;
	}

	/**
	 * 构造带员工身份信息的URL
	 * 
	 * @param corpid
	 *            企业id
	 * @param redirect_uri
	 *            授权后重定向的回调链接地址，请使用urlencode对链接进行处理
	 * @param state
	 *            重定向后会带上state参数，企业可以填写a-zA-Z0-9的参数值
	 * @return
	 */
	private String oAuth2Url(String corpid, String redirect_uri) {
		try {
			redirect_uri = java.net.URLEncoder.encode(redirect_uri, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String oauth2Url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + corpid + "&redirect_uri=" + redirect_uri
				+ "&response_type=code&scope=snsapi_base&state=shijf#wechat_redirect";
		return oauth2Url;
	}

	/**
	 * 调用接口获取用户信息
	 * 
	 * @param token
	 * @param code
	 * @param agentId
	 * @return
	 * @throws SQLException
	 * @throws RemoteException
	 */
	public String getMemberGuidByCode(String token, String code, int agentId) {
		Result<String> result = QiYeUtil.oAuth2GetUserByCode(token, code, agentId);
		if (result.getErrcode() == "0") {
			if (result.getObj() != null) {
				// 此处可以通过微信授权用code的Userid查询自己本地服务器中的数据
				return result.getObj();
			}
		}
		return "";
	}

}