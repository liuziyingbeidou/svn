package com.bavlo.counter.model.sign;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.bavlo.counter.model.IdEntity;

/**
 * @Title: 宝珑Counter
 * @ClassName: SignVO 
 * @Description: 实物(0)签收单
 * @author liuzy
 * @date 2015-10-19 下午02:54:18
 * vdef1,vdef2,vdef3查询使用
 */
@Entity
@Table(name="blct_gemsign")
public class GemSignVO extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	/**
	 * 客户主键		longint	
	 */
	private Long customerId;
	/**
	 * 编号		varchar(50)	
	 */
	@Column(length=50)
	private String vnumber;
	/**
	 * 声明类型		varchar(100)	
	 */
	@Column(length=100)
	private String vtype;
	/**
	 *  推测声明类型		varchar(100)	
	 */
	@Column(length=100)
	private String vtypec;
	/**
	 *  推测声明类型Id		varchar(100)	
	 */
	@Column(length=100)
	private String vtypecId;
	/**
	 * 声明价值		decimal(20,8)
	 */
	@Column(precision=20,scale=8)
	private Double nworth;
	/**
	 * 数量		int	
	 */
	private Integer icount;
	/**
	 * 重量		decimal(20,8)	
	 */
	@Column(precision=20,scale=8)
	private Double nweight;
	/**
	 * 形状		varchar(50)	
	 */
	private String vshape;
	/**
	 * 形状Id		varchar(50)	
	 */
	private String vshapeId;
	/**
	 * 规格		varchar(50)	
	 */
	private String vspec;
	/**
	 * 回收价格		decimal(20,8)	
	 */
	@Column(precision=20,scale=8)
	private Double nrecoveryPrice;	
	/**
	 * 创建时间		varchar(30)	
	 */
	private String vcreateTime;	

	public Long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	public String getVnumber() {
		return vnumber;
	}
	public void setVnumber(String vnumber) {
		this.vnumber = vnumber;
	}
	public String getVtype() {
		return vtype;
	}
	public void setVtype(String vtype) {
		this.vtype = vtype;
	}
	public Double getNworth() {
		return nworth;
	}
	public void setNworth(Double nworth) {
		this.nworth = nworth;
	}
	public Integer getIcount() {
		return icount;
	}
	public void setIcount(Integer icount) {
		this.icount = icount;
	}
	public Double getNweight() {
		return nweight;
	}
	public void setNweight(Double nweight) {
		this.nweight = nweight;
	}
	public String getVshape() {
		return vshape;
	}
	public void setVshape(String vshape) {
		this.vshape = vshape;
	}
	public String getVspec() {
		return vspec;
	}
	public void setVspec(String vspec) {
		this.vspec = vspec;
	}
	public Double getNrecoveryPrice() {
		return nrecoveryPrice;
	}
	public void setNrecoveryPrice(Double nrecoveryPrice) {
		this.nrecoveryPrice = nrecoveryPrice;
	}
	public String getVcreateTime() {
		return vcreateTime;
	}
	public void setVcreateTime(String vcreateTime) {
		this.vcreateTime = vcreateTime;
	}
	public String getVtypec() {
		return vtypec;
	}
	public void setVtypec(String vtypec) {
		this.vtypec = vtypec;
	}
	public String getVtypecId() {
		return vtypecId;
	}
	public void setVtypecId(String vtypecId) {
		this.vtypecId = vtypecId;
	}
	public String getVshapeId() {
		return vshapeId;
	}
	public void setVshapeId(String vshapeId) {
		this.vshapeId = vshapeId;
	}

}
