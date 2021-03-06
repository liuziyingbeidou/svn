<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>${pageGemType}宝石签收单
			<c:choose>
				 <c:when test="${empty gemvo['vnumber']}">   
				 ${number }
				 </c:when>
				 <c:otherwise>
				 ${gemvo['vnumber']}
				 </c:otherwise>	
			</c:choose>
		</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
		<script src="${ctx}/resources/js/jquery-1.8.3.min.js"></script>
		<link type='text/css' rel='stylesheet' href='${ctx}/resources/css/style.css' media='all' />
		<link type='text/css' rel='stylesheet' href='${ctx}/resources/css/bootstrap.css' media='all' />
		<script src="${ctx}/resources/js/top.js"></script>
		
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
			//宝石类型下拉框值
			var typeUrl = "http://www.bavlo.com/getAllGemType";
			loadSelDataStr(nativeUrl, typeUrl, "gem-typec-id", "data[i].id",
					"data[i].type_cn", function() {
						$("#gem-typec-id").val("${gemvo['vtypec']}");
						//形状下拉框
						initShapeByType();
						$("#gem-shape-id").append("<option value='-2'>异形</option>");
					},"推测类型");
			
			//规格下拉框
			//initSpecByTypeShape();
	
			//类型和形状改变
			$("#gem-typec-id").change(function() {
				initShapeByType();
				$(".vtypecId").val($("#gem-typec-id").find("option:selected").attr("sid"));
				$(".vtypec").val($("#gem-typec-id").val());
			});
			
			$("#gem-shape-id").change(function() {
				$(".vshapeId").val($("#gem-shape-id").find("option:selected").attr("sid"));
				$(".vshape").val($("#gem-shape-id").val());
			});
			/*$("#gem-shape-id").change(function() {
				initSpecByTypeShape();
			});*/
			/**
			 *$(document).ajaxStop(function () {setNowSelData(); });
			 **/
			 //选择客户
			 $("#file").bind("click",function(){
			 		openURL("${ctx}/customer/list.do","客户列表",470,550);
			 });
			 setValueByFrame("customer","${gemvo['id']}");
			 //上传图片
			 $(".gem-upload").bind("click",function(){
			 		openURL("${ctx}/upload/uppage.do","上传图片",null,430);
			 });
			 //图片显示
			 $(".gem-pic-show").bind("click",function(){
			 	var mid = $(".mid").val();
			 	if(mid == ""){
			 		if($("#FILE_0").val() == "" || $("#FILE_0").val() == null){
			 			alert("暂未上传图片");
			 		}else{
			 			openURL("${ctx}/upload/shownpic.do?frmId=gemfrmBId","图片展示",null,null,true);
			 		}
			 	}else{
			 		openURL("${ctx}/upload/showpic.do?cpath=com.bavlo.counter.model.sign.GemSignBVO&fkey=gemsignId&id="+mid,"图片展示",null,null,true);
			 	}
			 });
			 //宝石签收单列表
			 /*$(".gem-page-list").bind("click",function(){
			 	openURL("${ctx}/gem-sign/list.do","宝石签收单列表");
			 });*/
			 //有值加后缀
		  	initFieldSuffix();
			 //加载子表数据
		  	loadSubData("${gemvo['id']}");
		  	//控制头像显示
			if($("#customerId").val()){
				$(".header-loc").show();
			}else{
				$(".header-loc").hide();
			}
			
		});
		
		//加载子表数据
		function loadSubData(mid){
			var url = "${ctx}/upload/showpicJson.do";
			$.get(url,{cpath:"com.bavlo.counter.model.sign.GemSignBVO",fkey:"gemsignId",id:mid},function(row){
				var data = row;
				if(data != "" && data != null){
					$(".qsd_pic_list ul").html("");
					var fileModel = $("#filemodel").val();
					for(var i = 0; i < data.length; i++){
						if(data[i].biscover == "Y"){
							$("#FILE_0").val(data[i].vname);
						}else{
							$("#FILE_"+i).val(data[i].vname);
						}
						var minPicName = getMinPicByOrg(data[i].vname);
						//$(".qsd_pic_list ul").append("<li><img class='list_pic' style='width:60px;height:60px;' src='${ctx}/staticRes/gemsign/min/"+minPicName+"'><div class='dask' style='z-index:-1;cursor:pointer;width:60px;height:60px;padding:20px 0 0 20px;background:#000;opacity:0.8;position:relative;top:-60px;' picn='"+data[i].vname+"'><img src='${ctx}/resources/images/delete_shield_24px.ico'></div></li>");
						var value = data[i].vname;
						var ix = value.indexOf(".");
						var val = value.substring(0,ix);
						var fm = "FILE_"+i;
						$(".qsd_pic_list ul").append("<li id='"+val+"' fem='"+fm+"' onmouseout='setMaskT(\""+val+"\")' onmouseover='setMaskO(\""+val+"\")'><img class='list_pic' style='width:60px;height:60px;' src='${ctx}/staticRes/"+fileModel+"/min/"+minPicName+"'><div onclick='rmMaskC(\""+value+"\")' class='dask' style='z-index:-1;cursor:pointer;width:60px;height:60px;padding:20px 0 0 20px;background:#000;opacity:0.8;position:relative;top:-60px;' picn='"+value+"'><img src='${ctx}/resources/images/delete_shield_24px.ico'></div></li>");
						
					}
				}
			});
		}
		
		//初始化形状下拉框值
		function initShapeByType() {
			var gemTypeId = $("#gem-typec-id").find("option:selected").attr("sid");
			if (gemTypeId == "-1") {
				gemTypeId = "${gemvo['vtypec']}";
			}
			if(gemTypeId == undefined){
				$("#gem-shape-id").empty();
				$("#gem-shape-id").append("<option value='-1'>形状</option>");
				return;
			}
			var shapeUrl = "http://www.bavlo.com/getGemShape?typeId="+ gemTypeId;
			loadSelDataStr(nativeUrl, shapeUrl, "gem-shape-id", "data[i].id",
					"data[i].shape_cn", function() {
						$("#gem-shape-id").val("${gemvo['vshape']}");
						$("#gem-shape-id").append("<option value='-2'>异形</option>");
					},"形状");
			
		}
		
		//初始化规格下拉框值
		/*function initSpecByTypeShape() {
			var gemTypeId = $("#gem-type-id").find("option:selected").attr("sid");
			var gemShapeId = $("#gem-shape-id").find("option:selected").attr("sid");
			var specUrl = "http://www.bavlo.com/getGemCalibrated?typeId="
					+ gemTypeId + "&shapeId=" + gemShapeId;
			loadSelDataStr(nativeUrl, specUrl, "gem-spec-id", "data[i].id",
					"data[i].size", function() {
						$("#gem-spec-id").val("${gemvo['vspec']}");
					},"选规格");
		}*/
		
		
		//宝石签收单保存
		function save(){
		
			if(!ckLose("edit_btn","lose-gem")){
				return;
			}
		
			if($("#gem_sign_memo").val() == "签收说明"){
				$("#gem_sign_memo").val("");
			}
			//价值
	    	clearSuffix("gem-worth","元");
	    	//重量
	    	clearSuffix("gem-weight","ct");
	    	//数量
	    	clearSuffix("gem-count","颗");
	    	
			var bvo = JSON.stringify($('#gemfrmBId').serializeJson());
			$.ajax({
			     type : "POST",
			     url : "save.do",
			     data:$('#gemfrmId').serialize()+"&bvo="+bvo,// formid
			     async:false,
			     cache:false,
			     success : function(data) {
			     	 $("#gemid").val(data.id);
			     	 alert("保存成功!");
			     	 if($("#FILE_0").val() != "" && $("#FILE_0").val() != null && $("#FILE_0").val() != undefined){
			     	 	$(".gem-pic-show img").prop("src","/counter/staticRes/"+$("#filemodel").val()+"/"+$("#FILE_0").val());
			     	 }
			     },
			     error : function(e) {
			     	alert("保存失败!");
			     }
		    });
		   initFieldSuffix();
		}
		
		function initFieldSuffix(){
			if($(".gem-worth").val() != ""){
	    		 //价值
				initSuffix("gem-worth","元");
    		}
		  	if($(".gem-weight").val() != ""){
	    		//重量
				initSuffix("gem-weight","ct");
    		}
	    	if($(".gem-count").val() != ""){
	    		//数量
				initSuffix("gem-count","颗");
    		}
	    	if("${gemvo['vmemo']}" != ""){
				$("#gem_sign_memo").val("${gemvo['vmemo']}");
			}
		}
		
		//子窗体调用
		function setValueByFrame(type,id,callback,json){
			var url;
			if(type == "customer"){
				url = "${ctx}/customer/infoJson.do";
				$.get(url,{id:id},function(data){
					if(data != null){
						if(data.vhendimgurl != ""){
							$(".cusheader").prop("src",data.vhendimgurl);
						}else{
							$(".cusheader").prop("src","${ctx}/resources/images/customer_01.png");
						}
						$("#customerId").val(data.id);
					}
					if($("#customerId").val()){
						$(".header-loc").show();
					}else{
						$(".header-loc").hide();
					}
					closeMultiDlg();
				});
			}else if(type == "chain"){
				var data = JSON.parse(json);
				$("#order-list").append("<dd type='ch' sid='"+data.sid+"' class='"+data.sid+" bill'><span class='list_name bill-name'>"+data.sname+"</span><input class='list_num bill-num' style='width:40px;margin-left:10px;' type='text' value='1' placeholder='条'><b class='list_price bill-price'>"+data.sprice+"</b><a href='javascript:rlist("+data.sid+")' class='close_c'><img src='${ctx}/resources/images/close.png'></a></dd>");
				closeMultiDlg();
			}else if(type == "order"){
				url = "${ctx}/order/edit.do?id="+id;//根据id查询客户信息
				window.location = url;
			}else if(type == "order-view"){
				url = "${ctx}/order/view.do?id="+id;//根据id查询客户信息
				window.location = url;
			}else if(type == "signGem"){
				url = "${ctx}/gem-sign/view.do?id="+id;//根据id查询客户信息
				window.location = url;
			}else if(type == "entity"){
				url = "${ctx}/entity-sign/view.do?id="+id;//根据id查询客户信息
				window.location = url;
			}else if(type == "customer-menu"){
				url = "${ctx}/customer/info.do?id="+id;//根据id查询客户信息
				window.location = url;
			}else if(type == "custom"){
				url = "${ctx}/custom/edit.do?id="+id;//根据id定制单信息
				window.location = url;
			}else if(type == "custom-view"){
				url = "${ctx}/custom/detail.do?id="+id;//根据id显示定制单信息
				window.location = url;
			}else if(type == "useGem"){
				url = "${ctx}/useGem/info.do?id="+id;//根据id显示配石单信息
				window.location = url;
			}
		}
		//上传后显示封面
		function showDefaultPic(){
			if($("#FILE_0").val() != null && $("#FILE_0").val() != ""){
				$("#gem-pic-show-id img").attr("src","${ctx}/staticRes/"+$("#filemodel").val()+"/"+$("#FILE_0").val());
			}
		}
		
		</script>
		<style type="text/css">
		.gem-pic-show img{width:330px;height:330px;}
		.camera a{
			background:none;
		}
		.qsd_left ul li { width: auto; padding-right: 20px; float: left;}
		
		.hidden_enent { width:110px; position:relative; top:10px; right:-690px;}
		.edit_hidden { width:110px; position:relative; top:10px; left:-15;}
		/*.qsdn,.qssm{width:328px}*/
		#file{cursor:pointer;}
		
		/*.dask{z-index:-1;cursor:pointer;width:60px;height:60px;padding:20px 0 0 20px;background:#000;opacity:0;position:absolute;top:-200px;}*/
		.dask{
			z-index:-1;cursor:pointer;width:60px;height:60px;padding:20px 0 0 20px;background:#000;opacity:0.8;position:relative;top:-60px;
		}
		.qsd_pic_list ul li{height:60px;}
		@media screen and (max-width: 1280px) and (min-width: 320px){
		.qsd_left ul li {
			height:auto;
		}
		.hidden_enent { width:110px; position:relative; top:10px; right:-400px;}
		.edit_hidden { width:120px; position:relative; top:10px; left:0;}
		}
		</style>
	</head>
	<body>
	<form id="gemfrmId">
	<input type="hidden" id="pageAttr" value="GEM"/>
	<input id="gemid" class="mid tableId" type="hidden" name="id" value="${gemvo['id']}">
	<input id="customerId" class="tocustomerId" type="hidden" name="customerId" value="${gemvo['customerId']}">
<header class="demo-bar">
	<h1>
		<c:choose>
			 <c:when test="${empty gemvo['vnumber']}">   
			 <input type="hidden" name="vnumber" value="${number }">
			 </c:when>
			 <c:otherwise>
			 <input type="hidden" name="vnumber" value="${gemvo['vnumber']}">
			 </c:otherwise>	
		</c:choose>
	</h1> 
</header>
<jsp:include page="../header.jsp"></jsp:include>

<div class="qsd">
  <div class="qsd_main">
    <div class="qsd_left">
      <ul>
        <li class="header-loc"><a href="javascript: void(0);"><img class="cusheader" style="width:60px;height:60px;" src="${ctx}/resources/images/customer_01.png"></a></li>
        <li><div class="file3"><a href="javascript: void(0);"><input type="text" name="file" id="file"></a></div></li>
        <li class="camera"><a class="gem-upload" href="javascript: void(0);"><img src="${ctx}/resources/images/camera.png"></a></li>
        <div class="clear"></div>
      </ul>
	  <div class="clear"></div>
      <dt><a id="gem-pic-show-id" class="gem-pic-show" href="javascript: void(0);">
			<c:choose>
				<c:when test="${empty gemvo['FILE_0']}">
					<img src="${ctx}/resources/images/pic_02.png">
				</c:when>
				<c:otherwise>
					<img src="${ctx}/staticRes/${gemvo['FILE_0']}">
				</c:otherwise>
			</c:choose> 
		</a>
	</dt>
	<div class="qsd_pic_list">
	<ul>
		<!--<li><img class="list_pic" style="width:60px;height:60px;" src="${ctx}/resources/images/customer_01.png">
			<div class="dask">
			<img src="${ctx}/resources/images/delete_shield_24px.ico">
			</div>
		</li>-->
		
	</ul>
	</div>
    </div>
    <div class="qsd_right edit_btn">
      <div class="qsd_right_1">
      <!--
        <select name="vtype" class="qsdr r1" id="gem-type-id">
          <option value="-1">宝石</option>
        </select>
        -->
        <input type='text' name='vtype' placeholder="声明类型" class="qsdr r1 gem-type bl-ck-null lose-gem" value="${gemvo['vtype']}">
        <dt><input type='text' name='nworth' placeholder="声明价值" class="qsdr r2 gem-worth bl-ck-null lose-gem" value="${gemvo['nworth']}"></dt>
        <div class="clear"></div>
      </div>
      <div class="qsdtt qsd_right_1">
      	<select name="vtypec0" class="qsdt r1" id="gem-typec-id">
          <option value="-1">推测类型</option>
        </select>
        <input type="hidden" name="vtypecId" class="vtypecId" value="${gemvo['vtypecId']}">
        <input type="hidden" name="vtypec" class="vtypec" value="${gemvo['vtypec']}">
        <div class="clear"></div>
      </div>
      
      <div class="qsd_right_1">
        <select name="vshape0" class="qsdr r1 lose-gem"  id="gem-shape-id">
          <option value="-1">形状</option>
        </select>
        <input type="hidden" name="vshapeId" class="vshapeId" value="${gemvo['vshapeId']}">
        <input type="hidden" name="vshape" class="vshape" value="${gemvo['vshape']}">
        <!--<input type='text' name='vshape' placeholder="宝石形状" class="qsdr r1 gem-shape bl-ck-null lose-gem" value="${gemvo['vshape']}">-->
        <dt><input type='text' name='nweight' placeholder="重量" class="qsdr r2 gem-weight bl-ck-null lose-gem" value="${gemvo['nweight']}"></dt>
        <div class="clear"></div>
      </div>
      <div class="qsdtt">
		<!--<select name="vspec"  class="qsdt" id="gem-spec-id">
          <option value="-1">规格</option>
        </select>
        -->
        <input type='text' name='vspec' placeholder="宝石规格" class="qsdt gem-spec bl-ck-null lose-gem" value="${gemvo['vspec']}">
      </div>
      <div class="clear"></div>
      <div class="qsdtt"><input type='text' name='icount' placeholder="数量" value="${gemvo['icount']}" class="qsdn t3 gem-count bl-ck-null lose-gem"></div>
      <div class="qssm-l"><%-- <textarea name="vmemo" cols="" rows="" class="qssm" placeholder="签收说明">${gemvo['vmemo']}</textarea> --%>
      	<textarea id="gem_sign_memo" name="vmemo" cols="" rows="" class="qssm" 
		onfocus="if(value =='签收说明'){value =''}" onblur="if(value ==''){value='签收说明'}" >签收说明</textarea>
      </div>
      <div class="qs_save">
        <input type="button" name="button" onclick="javascript:save()" value="保存">
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
	</form>
	<form id="gemfrmBId">
	<input type="hidden" name="filemodel" id="filemodel" value="gemsign">
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
	<input type="hidden" name="filevalue" id="filevalue"></input>
	</form>
	</body>
	<script type="text/javascript">
	$(function(){
		//小图列表遮罩
		setMask();
		//删除图片
		delPic();
	});
	//遮罩
	function setMask(){
		$(".qsd_pic_list ul li").hover(
			function () {
				$(this).find(".dask").stop().delay(20).animate({"z-index":"1",opacity:0.8},200);
			 },
			function () {
				$(this).find(".dask").stop().animate({"z-index":"-1",opacity:0},200);
			}
			
		);
	}
	
	//删除图片
	function delPic(){
		$(".qsd_pic_list ul li").bind("click",function(){
			var em = this;
			if(confirm("是否删除?")){
				var fileModel = $("#filemodel").val();
				var fileName = $(this).attr("picn");
			 	var url = "${ctx}/upload/delPic.do";
				$.get(url,{fileModel:fileModel,fileName:fileName},function(){
					var fem = $(em).attr("fem");
					if(fem == "FILE_0"){
						$("#gem-pic-show-id img").prop("src","${ctx}/resources/images/pic_02.png");
						$("#FILE_0").val("");
					}
					
					$(em).remove();
				});
			}
		});
	}
	//上传后显示小图{JS实现}
	function showMinPic(em,value,c){
		if($("#"+em).val() != null && $("#"+em).val() != ""){
			var minPicName = getMinPicByOrg(value);
			var ix = value.indexOf(".");
			var val = value.substring(0,ix);
			var fileModel = $("#filemodel").val();
			$(".qsd_pic_list ul").append("<li id='"+val+"' fem='"+em+"' onmouseout='setMaskT(\""+val+"\")' onmouseover='setMaskO(\""+val+"\")'><img class='list_pic' style='width:60px;height:60px;' src='${ctx}/staticRes/"+fileModel+"/min/"+minPicName+"'><div onclick='rmMaskC(\""+value+"\")' class='dask' style='z-index:-1;cursor:pointer;width:60px;height:60px;padding:20px 0 0 20px;background:#000;opacity:0.8;position:relative;top:-60px;' picn='"+value+"'><img src='${ctx}/resources/images/delete_shield_24px.ico'></div></li>");
		}
	}
	
	//移入
	function setMaskO(value){
		$("#"+value).find(".dask").stop().delay(20).animate({"z-index":"1",opacity:0.8},200);
	}
	
	//移出
	function setMaskT(value){
		$("#"+value).find(".dask").stop().animate({"z-index":"-1",opacity:0},200);
	}
	
	//删除小图
	function rmMaskC(value){
		var ix = value.indexOf(".");
		var val = value.substring(0,ix);
		if(confirm("是否删除?")){
			var fileModel = $("#filemodel").val();
			var fileName = value;
		 	var url = "${ctx}/upload/delPic.do";
			$.get(url,{fileModel:fileModel,fileName:fileName},function(){
				var fem = $("#"+val).attr("fem");
				if(fem == "FILE_0"){
					$("#gem-pic-show-id img").prop("src","${ctx}/resources/images/pic_02.png");
					$("#FILE_0").val("");
				}
				$("#"+val).remove();
			});
		}
	}
	//根据原图名称获取小图名称
	function getMinPicByOrg(picName){//20160226_min.jsp
		var newPicName = "";
		if(picName != "" && picName != null){
			var ix = picName.indexOf(".");
			newPicName = picName.substring(0,ix)+"_min"+picName.substring(ix,picName.length);
		}
		
		return newPicName;
	}
	
	//根据原图名称获取小图名称
	function getOrgPicByMin(picName){//20160226_min.jsp
		var newPicName = "";
		if(picName != "" && picName != null){
			var ix = picName.indexOf("_min.");
			newPicName = picName.substring(0,ix)+"."+picName.substring(ix+5,picName.length);
		}
		
		return newPicName;
	}
	</script>
</html>
