<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>订单列表</title>
<script language="javascript" type="text/javascript" src="${ctx}/resources/js/jquery-1.8.3.min.js"></script>
<script src="${ctx}/resources/js/top.js"></script>
<link href="${ctx}/resources/css/style.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resources/css/orderlist.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/resources/js/showList.js" type="text/javascript"></script>
</head>

<body>
<div id="orderlist">
  <div class="orderlist">
    <div class="order-main">
		<div class="order-list">订单列表 X</div>
		<div class="search-1">
			<form action='' method='post'>
				<input type='text' name='search' class="search" value='搜索'>
			</form>
		</div>
		<div class="">
			<div class="main1 content">
				<div class="left-sider">
				  <div class="operate">
					<ul id="juheweb">
					<c:forEach items="${orderList}" var="bean">
					  <li >
						<h4 ><img src="${ctx}/resources/images/customer_01.png"><b>${bean.customerId}</b><a href="">${bean.vorderCode}</a><span><a href="${ctx}/order/view.do?id=${bean.id}">选择</a></span></h4>
						<div class="list-item none">
						  <dl>
							<dd><img src="${ctx}/resources/images/good_01.png"></dd>
							<dd><img src="${ctx}/resources/images/good_02.png"></dd>
							<dd><img src="${ctx}/resources/images/good_03.png"></dd>
						  </dl>
						  <div class="clear"></div>
						  <dt>报价：<b>${bean.nquotedPrice }元</b> 已付：<b>${bean.npayment }元</b> 未付：<b>${bean.nnonPayment }元</b> 实收：${bean.ntailPaid } </dt>
						</div>
						<div class="clear"></div>
					  </li>
					  </c:forEach>
					</ul>
					<script type="text/javascript" language="javascript">
						navList(12);
					</script>
				  </div>
				</div>
			  </div>
		</div>
    </div>
  </div>
</div>
</body>
</html>

