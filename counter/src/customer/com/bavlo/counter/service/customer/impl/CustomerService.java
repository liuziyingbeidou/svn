package com.bavlo.counter.service.customer.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bavlo.counter.constant.IConstant;
import com.bavlo.counter.model.customer.CustomerVO;
import com.bavlo.counter.model.manage.tools.QrcodeVO;
import com.bavlo.counter.service.customer.itf.ICustomerService;
import com.bavlo.counter.service.impl.CommonService;
import com.bavlo.counter.service.manage.tools.itf.IToolsService;
import com.bavlo.counter.utils.CommonUtils;
import com.bavlo.counter.utils.DateUtil;
import com.bavlo.counter.utils.StringUtil;
import com.bavlo.weixin.fuwu.pojo.WeixinUserInfo;
import com.bavlo.weixin.fuwu.util.AdvancedUtil;
import com.bavlo.weixin.fuwu.util.CommonUtil;
import com.bavlo.weixin.fuwu.util.IContant;


/** 
 * @Title: ����Counter
 * @ClassName: CustomerService 
 * @Description: �ͻ�service
 * @author shijf
 * @date 2015-10-20 ����04:12:30  
 */
@Service("customerService")
public class CustomerService extends CommonService implements ICustomerService {
	
	@Autowired
	IToolsService toolsService;

	@Override
	public Integer saveCustomer(CustomerVO customerVO) {
		try {
			return saveReID(customerVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void deleteCustomer(CustomerVO customerVO) {
		
	}

	@Override
	public void updateCustomer(CustomerVO customerVO) {
		try {
			update(customerVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void saveOrUpdateCustomer(CustomerVO customerVO) {
		try {
			saveOrUpdate(customerVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public CustomerVO findCustomerById(Integer id) {
		String wh = " id ="+id;
		return findFirst(CustomerVO.class, wh);
	}

	@Override
	public List<CustomerVO> findCustomerByWh() {
		return null;
	}

	@Override
	//@Cacheable(value="myCache", key="'findCustomerList'+#wh") 
	public List<CustomerVO> findCustomerList(String wh) {
	
		return findAll(CustomerVO.class, wh,null,"id","desc");
	}

	@Override
	public boolean isExistByCondition(String condition) {
		String conditions = null;
		if(StringUtil.isNotEmpty(condition)){
			conditions = condition;
		}
		Integer count = getCountByHQL(CustomerVO.class, conditions);
		
		return count > 0 ? true : false;
	}

	@Override
	@Transactional
	public String addCustomerByScan(String openId,HttpSession session,String scene_str) {
		String vcode = null;
		if(!isExistByCondition(" vopenid = '"+openId+"'")){
			String agentId = "bavlo";
			if(StringUtil.isNotEmpty(scene_str)){
				//String serviceCode = scene_str.substring(scene_str.length()-4);
				agentId = scene_str.substring(0,scene_str.length()-4);
			}
			
			String accessToken = session.getAttribute("fw-accessToken")+"";
			if(CommonUtils.isNull(accessToken)){
				accessToken = CommonUtil.getToken(IContant.appId, IContant.appSecret).getAccessToken();
			}
			WeixinUserInfo userInfo = AdvancedUtil.getUserInfo(accessToken,openId);
			CustomerVO cvo = new CustomerVO();
			cvo.setVopenid(userInfo.getOpenId());
			cvo.setVsubscribeState(userInfo.getSubscribe());
			cvo.setVsubscribeTime(DateUtil.formatTime(userInfo.getSubscribeTime()));
			cvo.setVname(userInfo.getNickname());
			cvo.setVnickname(userInfo.getNickname());
			
			String vsex = "";
			if(userInfo.getSex() == 1){
				vsex = "��";
			}else if(userInfo.getSex() == 0){
				vsex = "Ů";
			}
			cvo.setVsex(vsex);
			cvo.setVcontry(userInfo.getCountry());
			cvo.setVprovince(userInfo.getProvince());
			cvo.setVcity(userInfo.getCity());
			cvo.setVlanguage(userInfo.getLanguage());
			String imgUrl = userInfo.getHeadImgUrl();
			if(StringUtil.isNotEmpty(imgUrl)){
				imgUrl = imgUrl.substring(0, imgUrl.lastIndexOf("/")) + "/64" ;
			}
			cvo.setVhendimgurl(imgUrl);
			cvo.setVgroup(userInfo.getGroupid());
			vcode = CommonUtils.getBillCode(IConstant.CODE_CUSTER);
			cvo.setVcustomerCode(vcode);
			cvo.setAgentId(agentId);
			cvo.setVserviceCode(scene_str);
			
			saveOrUpdateCustomer(cvo);
		}else{
			vcode = findCustomerByWhere(" vopenid = '"+openId+"'").getVcustomerCode();
		}
		return vcode;
	}

	@Override
	public CustomerVO findCustomerByWhere(String condition) {
		String conditions = null;
		if(StringUtil.isNotEmpty(condition)){
			conditions = condition;
		}
		return findFirst(CustomerVO.class, conditions);
	}

	@Override
	public void updateCustomerByCondition(String conditions, String[] attrFiled,
			String[] attrValue) {
		updateAttrs(CustomerVO.class, attrFiled, attrValue, conditions);
	}

	@Override
	public String getQYUserIdByKfCode(String kfCode) {
		String userId = null;
		if(!CommonUtils.isNull(kfCode)){
			String contions = " CONCAT(vshop,vkfcode)='" + kfCode + "'";
			QrcodeVO qrcodeVO = toolsService.getQrcodeVOByWh(contions);
			if(qrcodeVO != null){
				userId = qrcodeVO.getUserid();
			}
		}
		return userId;
	}

}
