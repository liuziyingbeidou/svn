package com.bavlo.counter.model;

import java.util.List;

/**
 * @Title: ����Counter
 * @ClassName: LoginVO 
 * @Description: �洢��¼��Ϣ
 * @author liuzy
 * @date 2015-11-19 ����10:30:44
 */
public class LoginVO {

	//��¼�û�userid
	private String userId;
	//���û�userid
	private String muserId;
	//��ɫ
	private List<String> role;
	//����
	private String shop;
	//��΢�ź�
	private String mwxcode;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getShop() {
		return shop;
	}
	public void setShop(String shop) {
		this.shop = shop;
	}
	public String getMwxcode() {
		return mwxcode;
	}
	public void setMwxcode(String mwxcode) {
		this.mwxcode = mwxcode;
	}
	public List<String> getRole() {
		return role;
	}
	public void setRole(List<String> role) {
		this.role = role;
	}
	public String getMuserId() {
		return muserId;
	}
	public void setMuserId(String muserId) {
		this.muserId = muserId;
	}
	
}