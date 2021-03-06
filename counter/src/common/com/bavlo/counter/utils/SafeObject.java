package com.bavlo.counter.utils;



public class SafeObject {
	/**
	 * @param o
	 * @return
	 * @version NC5.6, BPS
	 * @author liuhao
	 * @time 2010-3-30 下午08:57:33
	 * @description 是否为空
	 */
	public static boolean ifnull(Object o) {
		return o == null || o.toString() == null
				|| o.toString().trim().length() == 0;
	}

	/**
	 * @param o!
	 * @return
	 * @version NC5.6, BPS
	 * @author liuhao
	 * @time 2010-3-30 下午08:57:33
	 * @description 是否不为空
	 */
	public static boolean isNotNull(Object o) {
		return !ifnull(o);
	}


	public static String toString(Object o) {
		if (o instanceof String) {
			return (String) o;
		} else if (isNotNull(o)) {
			return o.toString();
		} else {
			return null;
		}
	}




	public static Double toDouble(Object o) {
		if (ifnull(o)) {
			return Double.valueOf(0);
		} else {
			return Double.valueOf(o.toString());
		}
	}


	public static Integer toIntegerWithNull(Object o) {
		if (o instanceof Integer) {
			return (Integer) o;
		} else if (ifnull(o)) {
			return null;
		} else {
			return Integer.valueOf(o.toString());
		}
	}
	
	public static Integer toInteger(Object o) {
		if (o instanceof Integer) {
			return (Integer) o;
		}  else if (o instanceof Double) {  //modify by wangjxf 20140611 for 为888.000时的处理
			return Integer.valueOf(((Double) o).intValue());
		} else if (ifnull(o)) {
			return Integer.valueOf(0);
		} else {
			return Integer.valueOf(o.toString());
		}
	}

}
