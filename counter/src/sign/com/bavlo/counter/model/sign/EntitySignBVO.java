package com.bavlo.counter.model.sign;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.bavlo.counter.model.IdEntity;

/**
 * @Title: 宝珑Counter
 * @ClassName: SignBVO 
 * @Description: 实物签收单子表（图片）
 * @author liuzy
 * @date 2015-10-19 下午07:21:21
 */
@Entity
@Table(name="blct_entitysign_b")
public class EntitySignBVO extends IdEntity implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/**
	 * 主表主键		longint	
	 */
	private Integer entitysignId;
	/**
	 * 实物名称		varchar(100)	
	 */
	private String vname;
	/**
	 * 实物路径		varchar(100)	
	 */
	private String vpath;
	/**
	 * 是否封面		char(1)	Y、N
	 */
	private String biscover;
	
	public Integer getEntitysignId() {
		return entitysignId;
	}
	public void setEntitysignId(Integer entitysignId) {
		this.entitysignId = entitysignId;
	}
	public String getVname() {
		return vname;
	}
	public void setVname(String vname) {
		this.vname = vname;
	}
	public String getVpath() {
		return vpath;
	}
	public void setVpath(String vpath) {
		this.vpath = vpath;
	}
	public String getBiscover() {
		return biscover;
	}
	public void setBiscover(String biscover) {
		this.biscover = biscover;
	}
	
}
