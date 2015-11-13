<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>${customPageType}定制单</title>

<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<!--必要样式-->
<link rel='stylesheet' href='${ctx}/resources/css/style.css' media='all' />
<link rel='stylesheet' href='${ctx}/resources/css/bootstrap.css' media='all' />
<link rel="stylesheet" href="${ctx}/resources/css/photoswipe.css" />
<link rel="stylesheet" href="${ctx}/resources/css/default-skin.css" />

<script src="${ctx}/resources/js/jquery-1.8.3.min.js"></script>
<script src="${ctx}/resources/js/top.js"></script>
<script	src="${ctx}/resources/js/add-input.js"></script>
<script src="${ctx}/resources/js/photoswipe.min.js"></script>
<script src="${ctx}/resources/js/photoswipe-ui-default.min.js"></script>
<script src="${ctx}/resources/js/photoswipefromdom.js"></script>

<!-- 定义JS -->
<script src="${ctx}/resources/js/bavlo-initdata.js"></script>
<script src="${ctx}/resources/js/bavlo-event.js"></script>

<!-- 弹框 -->
<!-- jQuery & jQuery UI files (needed)--> 
<link rel="stylesheet" href="/counter/resources/jquery.multiDialog/css/jquery-ui-1.10.3.custom.css">
<script src="/counter/resources/jquery.multiDialog/js/jquery/jquery-ui-1.10.3.custom.js"></script> 
<!-- MultiDialog files (needed) --> 
<link rel="stylesheet" href="/counter/resources/jquery.multiDialog/css/jquery.multiDialog.css"> 
<script src="/counter/resources/jquery.multiDialog/js/jquery.ui.dialog.extended-1.0.2.js"></script> 
<script src="/counter/resources/jquery.multiDialog/js/jquery.multiDialog.js"></script> 
<script src="/counter/resources/js/bavlo-dialog.js"></script>

<script type="text/javascript">
//本地webservice
var nativeUrl = "${pageScope.basePath}/counter/webservice/http.do";
$(function() {

	// 款式类型下拉框值
	var typeUrl = "http://www.bavlo.com/getAllStyleType";
	loadSelData(nativeUrl, typeUrl, "styleTypeId", "data[i].id",
			"data[i].type_name_cn", function() {
				$("#styleTypeId").val("${customEdit['srcstyleType']}");
			},"款式");
	// 金属材质下拉框值
	var typeUrl = "http://www.bavlo.com/getAllMetalMaterialType";
	loadSelData(nativeUrl, typeUrl, "srcmetail", "data[i].id",
			"data[i].metal_type_cn", function() {
				$("#srcmetail").val("${customEdit['srcmetail']}");
			},"金属");
	// 款式类型下拉框值
	var typeUrl = "http://www.bavlo.com/getAllRingSize";
	loadRingSizeData(nativeUrl, typeUrl, "ringSizeId", "data[i].id",
			"data[i].china", "data[i].diameter", "data[i].circumference",
			function() {
				$("#ringSizeId").val("${customEdit['srcringSize']}");
			},"手寸");
	// 当款式类型不是戒指时，隐藏戒指手寸选项
	$("#styleTypeId").change(function() {
		if ($("#styleTypeId").val() == "1") {
			$("#ringSizeId").css({
				display : "block"
			});
		} else {
			$("#ringSizeId").css({
				display : "none"
			});
		}
	});

	
	//宝石弹框
	$(".kxsGem_btn").click(function(){
		openURL("${ctx}/common/getGemInfo.do","库选石");
	});
	//链子弹框
	$(".lzGem_btn").click(function(){
		openURL("${ctx}/common/getChainInfo.do","链子");
	});
	
	//初始化刻字
	var WS = function(opt) {

		var regexp = opt.regexp || /\S/, el = $(opt.el), list = el.val().split(','), holder = $('<span class="words-split"></span>'), add = $('<div class="kezi"><a href="javascript:void(0)" class="words-split-add">+刻字</a></div>');

		for (var i = 0; i < list.length; i++) {
			holder.append($('<a href="javascript:void(0)" class="fm-button">'
					+ list[i] + '<em> </em></a>'));
		}

		el.hide().after(holder);
		holder.after(add);

		holder.on('click', 'a>em', function() { // 刪除
			$(this).parent().remove();
			el.val(holder.text().match(/\S+/g).join(','))
		});

		add.on('click', function() { // 添加预处理
			$(this).hide();
			$(".zhanwei").append(
					$('<span class="lbl-input" contenteditable="true"/>'))
		});

		$(".zhanwei")
				.on(
						'blur',
						'.lbl-input',
						function() { // 验证添加字段
							var t = $(this), v = t.text();
							if (v) {
								t.remove();
								add.show();
								holder
										.append($('<a href="javascript:void(0)" class="fm-button">'
												+ v + '<em> </em></a>'));
								el.val(holder.text().match(/\S+/g).join(','));
							} else {
								t.remove();
								add.show();
							}
						});

		holder.on('keydown', '.lbl-input', function(e) {
			switch (e.keyCode) {
			case 13:
			case 27:
				$(this).trigger('blur');
			}
		});
	}

	WS({
		el : '#vengrave',
		regexp : /\w+\.\w+/
	});
	
	 //上传图片
	 $(".cankaotu").bind("click",function(){
	 		openURL("${ctx}/upload/uppage.do","上传参考图"); 
	 });
	 $(".qibantu").bind("click",function(){
	 		openURL("${ctx}/upload/uppage.do","上传起版图"); 
	 });
	 //图片显示
	 $(".costomPicShow").bind("click",function(){
	 	var mid = $("#customid").val();
	 	if(mid == ""){
	 		alert("请保存后查看!");
	 	}else{
	 		openURL("${ctx}/upload/showpic.do?cpath=com.bavlo.counter.model.custom.CustomBVO&fkey=customId&id="+mid,"图片展示");
	 	}
	 });
	 //宝石签收单列表
	 $(".kzs_guanlian").bind("click",function(){
	 	openURL("${ctx}/gem-sign/list.do","宝石签收单列表");
	 });
	 //宝石签收单列表
	 $(".kps_guanlian").bind("click",function(){
	 	openURL("${ctx}/gem-sign/list.do","宝石签收单列表");
	 });
	 //有值加后缀
 	//initFieldSuffix();
	 
	//加载子表数据
	function loadSubData(mid){
		var url = "${ctx}/upload/showpicJson.do";
		$.get(url,{cpath:"com.bavlo.counter.model.custom.CustomBVO",fkey:"customId",id:mid},function(row){
			var data = row;
			if(data != "" && data != null){
				for(var i = 0; i < data.length; i++){
					if(data[i].biscover == "Y"){
						$("#FILE_0").val(data[i].vname);
					}else{
						$("#FILE_"+i).val(data[i].vname);
					}
				}
			}
		});
	}
});

// 定制单保存
function saveOrUpdate() {
	cleanFieldSuffix();
	var bvo = JSON.stringify($('#customBId').serializeJson());
	$.ajax({
		type : "POST",
		url : "save.do",
		data : $('#custom').serialize()+"&bvo="+bvo,// formid
		async : false,
		cache : false,
		success : function(data) {
			$("#customid").val(data.id);
			alert("保存成功!");
			initFieldSuffix();
		},
		error : function(e) {
			alert("保存失败!");
			initFieldSuffix();
		}
	});
}

//增加后缀 
function initFieldSuffix(){
	if($(".custom_weight").val() != ""){
		 //重量 
		initSuffix("custom_weight","克");
	}
  	if($(".kzs_price").val() != ""){
		//金额 
		initSuffix("kzs_price","元"); 
	}
  	if($(".kps_count").val() != ""){
		//数量
		initSuffix("kps_count","颗"); 
	}
  	if($(".costom_otherPrice").val() != ""){
		//金额 
		initSuffix("costom_otherPrice","元"); 
	}
}

//清除后缀
function cleanFieldSuffix(){
	//重量 
	clearSuffix("custom_weight","克");
	//金额 
	clearSuffix("kzs_price","元");
	//数量
	clearSuffix("kps_count","颗");
	//金额 
	clearSuffix("costom_otherPrice","元");
	//数量
	//clearSuffix("custom_item","条");
	//刻字 
	//clearSuffix("custom_engrave","刻字标签：,");
}

//子窗体调用
function setValueByFrame(type,id,callback,json,gem){
	var url;
	if(type == "chain"){
		var data = JSON.parse(json);
		$(".chain").append("<dd class='"+data.sid+"'><div class='lianzi'><h3>链子</h3><a href='javascript:rlist("+data.sid+")' class='close_c'><font>X</font></a><div class='clear'></div><input class='custom_item' id='iitem' name='iitem' type='text' value='' placeholder='条'><strong>"+data.sname+"</strong></div></dd>");
		closeMultiDlg();
	}else if(type == "signGem"){
		var data = JSON.parse(id);
			var signGem = $("#gemSignId").val();
			if(data != null){
				if(signGem == ""){
					$("#gemSignId").val(data);
					$(".kong").append("<img class='kzs_img' src='${ctx}/resources/images/kzs_"+data+".png' >");
					alert("id="+data);
				}else{
					var kzs_img=$(".kzs_img").attr("src");
					$("#gemSignId").val(data);
					$(".kzs_img").attr("src","${ctx}/resources/images/kzs_"+data+".png");
					alert("id="+data);
				}
			}
			closeMultiDlg();
	}else if(type == "gem"){
		 var html="";
		 var data = JSON.parse(json);
		 
		 var type=gem.attr("type");
		 var shape=gem.attr("shape");
		 var calibrated=gem.attr("calibrated");
		 var weight=gem.attr("weight");
		 var costPrice=gem.attr("costPrice");
		 var pic=gem.find("img").attr("src");
			
	     html+= "<dd class='"+data.sid+"'>"+
	    	 	"<div div class='lianzi'>"+	
			    "<h3>库选宝石</h3>"+
			    "<a href='javascript:rlist("+data.sid+")' class='close_c'><font>X</font></a><div class='clear'></div>"+
			    "<input class='custom_item' id='iitem' name='iitem' type='text' value='' placeholder='颗'>"+
				"<img src='"+pic+"'/><strong>"+type+" "+weight+"ct</strong>"+
				"<input type='hidden' class='sgPrice' value='"+costPrice+"'/>"+
				"</div></dd>";
				 
				
				
		 $(".chain").append(html);
		$("input[name='stockGemQ']").blur(function(){
			 checkNum(this);
			 var qutity=$(this).val();
			 var price=$(this).attr("price");
			 $(this).parent().nextAll(".sgPrice").val((price*qutity+qutity*2).toFixed(2));
		 })
		 closeMultiDlg();
	}
	
}
//删除清单
function rlist(className){
	$("."+className).remove();
}

</script>

</head>

<body>
	<form id="custom">
	<jsp:include page="../header.jsp"></jsp:include>
	<input type="hidden" id='customid' name='id'
		value="${customEdit.id }" />
	<input type="hidden" id='orderId' name='orderId'
		value="${customEdit.orderId }" />
	<input type="hidden" id='customerId' name='customerId'
		value="${customEdit.customerId }" />
	<input type="hidden" id='gemSignId' name='gemSignId'
		value="${customEdit.iprimaryGemID }" />
	<input type="hidden" id='gemSignIdB' name='gemSignIdB'
		value="${customEdit.iforeignGemID }" />
	<div class="all">
		<div class="main">
			<div class="mainleft">
				<div class="cankao">
					<h2><a href="javascript:;" style="color:#fff" class="cankaotu">+ 参考图</a></h2>
					<div class="pro">
						<b><a href="javascript:;" onclick="PicShow_Hidden(pic)">显示</a></b>
						<div class="demo" id='pic' style='display: none;'>
							<b><a href="javascript:;" onclick="PicShow_Hidden(pic)">隐藏</a></b>
							<!--<b class="hide">隐藏</b>-->
							<div class="my-gallery">
								<volist name="list" id="list"> <figure> 
								<a class="costomPicShow" href="javascript:void();">
									<c:choose>
										<c:when test="${empty customEdit['FILE_0']}">   
											<img src="${ctx}/resources/images/zb_03.png">
										</c:when>
										<c:otherwise>
											<img src="${ctx}/staticRes/${customEdit['FILE_0']}">
										</c:otherwise>
									</c:choose> 
								</a>
								</figcaption> </figure> </volist>

							</div>
						</div>
					</div>
				</div>
				<div class="sheji">
					<h2><a href="javascript:;" style="color:#fff" class="qibantu">+ 起版设计图</a></h2>
					<div class="pro">
						<!--<img src="images/zb_06.png" />-->
						<b><a href="javascript:;" onclick="Pic1Show_Hidden(pic1)">显示</a></b>
						<div class="demo" id='pic1' style='display: none;'>
							<b><a href="javascript:;" onclick="Pic1Show_Hidden(pic1)">隐藏</a></b>
							<!--<b class="hide">隐藏</b>-->
							<div class="my-gallery">
								<volist name="list" id="list"> <figure>
								<a class="costomPicShow" href="javascript:void();">
									<c:choose>
										<c:when test="${empty customEdit['FILE_0']}">   
											<img src="${ctx}/resources/images/zb_03.png">
										</c:when>
										<c:otherwise>
											<img src="${ctx}/staticRes/${customEdit['FILE_0']}">
										</c:otherwise>
									</c:choose> 
								</a>
								</figcaption> </figure> </volist>

							</div>

							<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
								<div class="pswp__bg"></div>
								<div class="pswp__scroll-wrap">
									<div class="pswp__container">
										<div class="pswp__item"></div>
										<div class="pswp__item"></div>
										<div class="pswp__item"></div>
									</div>
									<div class="pswp__ui pswp__ui--hidden">
										<div class="pswp__top-bar">
											<div class="pswp__counter"></div>
											<button class="pswp__button pswp__button--close"
												title="Close (Esc)"></button>
											<div class="pswp__preloader">
												<div class="pswp__preloader__icn">
													<div class="pswp__preloader__cut">
														<div class="pswp__preloader__donut"></div>
													</div>
												</div>
											</div>
										</div>
										<div
											class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
											<div class="pswp__share-tooltip"></div>
										</div>
										<button class="pswp__button pswp__button--arrow--left"
											title="Previous (arrow left)"></button>
										<button class="pswp__button pswp__button--arrow--right"
											title="Next (arrow right)"></button>
										<div class="pswp__caption">
											<div class="pswp__caption__center"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
				<div class="name">
					<input type="text" id="vstyleName" name="vstyleName"
						placeholder="给本款取个名字把"
						class="quming" />
				</div>
				<div class="xuqiu">
					<textarea id="vrequirement" name="vrequirement" cols="" rows=""
						placeholder="需求描述"
						class="miaoshu1"></textarea>
				</div>
			</div>
			<div class="mainmid">
				<h2>BOM</h2>
				<div class="bom">
					<select id="styleTypeId" name="srcstyleType" class="jiezhi">
						<option>选择款式</option>
					</select> <select class="nvkuan">
						<option  id="vsex" name="vsex">女款</option>
						<option  id="vsex" name="vsex">男款</option>
					</select>
				</div>
				<div class="changdu">
					<select id="ringSizeId" name="srcringSize" class="neijin">
						<option>选择手寸</option>
					</select>
				</div>
				<div class="weight">
					<select id="srcmetail" name="srcmetail" class="wk">
						<option>选择金属</option>
					</select>
					<input type="text" id="nweight" name="nweight"
						placeholder="克"
						class="custom_weight" value="" />
				</div>
				<!-- <div class="price">
					<input id="iprice" name="iprice" 
					value="元"
					onfocus="if(value=='元'){value=''}" 
					onblur="if(value==''){value='元'}"
					class="jiege" /> <b>+选择</b>
				</div> -->
				<dl class="chain">

					<dd class="kzsGem" style="display: none">
						<div class="kzs">
							<h3>
								<a href="">客主石</a>
							</h3>
							<ul>
								<li><input type="text" 
								id="nprimaryGem" name="nprimaryGem" class="kzs_price"
								placeholder="元"/>
								</li>
								<li class="kzs_gl"><input type='button' name="guanlian" class="kzs_guanlian"
									value="+ 关联" /></li>
								<li class="kong"></li>
								<li class="cha"><a href="javascript:h('kzsGem')"><font>X</font></a></li>
							</ul>
							<div class="clear"></div>
						</div>
					</dd>
					<dd class="kpsGem" style="display: none">
						<div class="kzs">
							<h3>
								<a href="">客配石</a>
							</h3>
							<ul>
								<li><input type="text" id="iforeignGem" name="iforeignGem" class="kps_count"
										placeholder="颗"/>
								</li>
								<li class="kzs_gl"><a href="javascript:h('kpsGem')"><input type='button' name="guanlian" class="kps_guanlian"
									value="+ 关联" /></a></li>
								<li class="kong"></li>
								<%-- <li class="kps"><img src="${ctx}/resources/images/zb_09.png" width="42"
									height="42" /></li> --%>
								<li class="cha"><a href="javascript:h('kpsGem')"><font>X</font></a></li>
							</ul>
							<div class="clear"></div>
						</div>
					</dd>
				</dl>
<!-- 				<div style="width: 100%; position: relative;">
				
				</div> -->
				<div class="xuanze">
					<ul>
						<li><a href="javascript:;" class="kzsGem_btn">+客主石</a></li>
						<li><a href="javascript:;" class="kpsGem_btn">+客配石</a></li>
						<li><a href="javascript:;" class="kxsGem_btn">+库选石</a></li>
						<li><a href="javascript:void(0);" class="lzGem_btn">+链子</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="mainrig">
				<h2>其他信息</h2>
				
				<!-- 标签 -->
				<input type="text" class="custom_engrave" name="vengrave" value="刻字标签：" id="vengrave" />
				<div class="zhanwei">
				<select id="vfont" name="vfont" class="ziti">
					<option value="华文细黑" >华文细黑</option>
					<option value="华文仿宋" >华文仿宋</option>
					<option value="华文楷体" >华文楷体</option>
					<option value="华文宋体" >华文宋体</option>
					<option value="华文中宋" >华文中宋</option>
					<option value="仿宋" >仿宋</option>
					<option value="黑体" >黑体</option>
					<option value="楷体" >楷体</option>
					<option value="Bradley Hand ITC" >Bradley Hand ITC</option>
					<option value="Segoe Script" >Segoe Script</option>
					<option value="Verdana" >Verdana</option>
				</select>
				</div>
				<br />
	
				<textarea id="vrequirementB" name="vrequirementB" cols="" rows="" 
				placeholder="表面工艺描述"			
				class="miaoshu1"></textarea>
				<br />
				
				<select name="icertificate" name="icertificate" class="jianding1">
					<option value="0">鉴定证书 -无</option>
					<option value="1">鉴定证书 -有</option>
				</select>
				<!-- 
				<div class="tu">
					<div class="tu1">
						<input type="file" id="kezitu" style="display: none;">
						<a href="javascript:;" class="kzsGem_btn">+ 刻字矢量图</a><strong>Love.cdr</strong><br />
					</div>
					<u>+ CAD文件</u><strong>无</strong>
				</div> -->
				<div class="qita">
					<div class="clear"></div>
					<input type="text" 
					id="notherPrice" name="notherPrice" class="costom_otherPrice"
					placeholder="其他 元" />
					<!-- <strong>13325+13150=<u>26800 </u>元</strong> -->
				</div>
				<div class="jisuan">
					<dl>
						<dd class="plus">
							<a href="">+</a>
						</dd>
						<dd class="sum">
							<a href="">计算</a>
						</dd>
					</dl>
					<div class="clear"></div>
				</div>
				<div class="baocun1">
					<input type="button" name="button"
						onclick="javascript:saveOrUpdate()" value="保存" />
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	</form>
	<form id="customBId">
	<input type="hidden" name="filemodel" id="filemodel" value="costom">
	<input type="hidden" name="filetype" id="filetype" value="pic">
	<input type="hidden" name="FILE_0" id="FILE_0"></input>
	<input type="hidden" name="FILE_1" id="FILE_1"></input>
	<input type="hidden" name="FILE_2" id="FILE_2"></input>
	<input type="hidden" name="FILE_3" id="FILE_3"></input>
	<input type="hidden" name="FILE_4" id="FILE_4"></input>
	<input type="hidden" name="FILE_5" id="FILE_5"></input>
	<input type="hidden" name="FILE_6" id="FILE_6"></input>
	<input type="hidden" name="FILE_7" id="FILE_7"></input>
	<input type="hidden" name="FILE_8" id="FILE_8"></input>
	</form>
</body>
</html>
