package com.bavlo.counter.service.custom.itf;

import java.util.List;

import com.bavlo.counter.model.custom.CustomVO;

/**
 * @Title: 宝珑Counter
 * @ClassName: ICustomService
 * @Description: 定制单接口
 * @author shijf
 * @date 2015-10-20 下午04:12:56
 */
public interface ICustomService {

	/**
	 * @Description: 保存定制单
	 * @param
	 * @return void
	 */
	public void saveCustom(CustomVO customVO);

	/**
	 * @Description: 删除定制单
	 * @param
	 * @return void
	 */
	public void deleteCustom(CustomVO customVO);

	/**
	 * @Description: 更新定制单
	 * @param
	 * @return void
	 */
	public void updateCustom(CustomVO customVO);
	
	/**
	 * @Description: 更新定制单
	 * @param
	 * @return void
	 */
	public void saveOrUpdateCustom(CustomVO customVO);

	/**
	 * @Description: 通过ID查找定制单
	 * @param @return
	 * @return CustomVO
	 */
	public CustomVO findCustomById(Integer id);

	/**
	 * @Description: 通过条件查找定制单
	 * @param @return
	 * @return List<CustomVO>
	 */
	public List<CustomVO> findCustomByWh();

	/**
	 * @Description: 查找定制单列表
	 * @param @return
	 * @return List<CustomVO>
	 */
	public List<CustomVO> findCustomList();

}
