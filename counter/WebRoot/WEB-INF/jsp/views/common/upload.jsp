<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>上传文件</title>
<script src="${ctx}/resources/js/jquery-1.8.3.min.js"></script>
<script src="${ctx}/resources/js/jquery-2.1.4.min.js"></script>
<link type='text/css' rel='stylesheet' href='${ctx }/resources/css/style.css' media='all' />
<link type='text/css' rel='stylesheet' href='${ctx }/resources/css/bootstrap.css' media='all' />
<script src="${ctx }/resources/js/top.js"></script>
<!-- 上传图片 -->
<link rel="stylesheet" type="text/css" href="${ctx }/resources/webuploader/css/webuploader.css" />
<link rel="stylesheet" type="text/css" href="${ctx }/resources/webuploader/css/upload.css" />    
<script type="text/javascript" src="${ctx }/resources/js/jquery.js"></script>
<script type="text/javascript" src="${ctx }/resources/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${ctx }/resources/webuploader/js/upload.js"></script>
    
    <script type="text/javascript">
    $(function(){
    	$("#filevalue").val($("#filevalue",window.parent.document).val());
	    $("#filemodel").val($("#filemodel",window.parent.document).val());
	    $("#filetype").val($("#filetype",window.parent.document).val());
	    if($("#filetype").val() == "file"){
	    	$(".file-upload").show();
	    	$(".pic-upload").hide();
	    }else{
	    	$(".pic-upload").show();
	    	$(".file-upload").hide();
	    }
    	$(".signlefile").bind("click",function(){
    		/*var filemodel = $("#filemodel",window.parent.document).val();
	    	var filetype = $("#filetype",window.parent.document).val();
	    	var filevalue = $("#filevalue",window.parent.document).val();*/
    		/*var url = "${ctx }/upload/uploadSGFile.do";//?filemodel="+filemodel+"&filetype="+filetype+"&filevalue="+filevalue*/
	    	 upfile();
	    });
	    
	    //完成事件
	    $(".completeBtn").click(function(){
	    	$(".ui-dialog-titlebar-close",window.parent.document).trigger("click");
	    	window.parent.fnCompleteBtn();
	    });
    });
    
    function upfile(){
    	var formData = new FormData($("#sgform")[0]);
		  $.ajax({
		    url: '${ctx }/upload/uploadSGFile.do' ,
		    type: 'POST',
		    data: formData,
		    async: false,
		    cache: false,
		    contentType: false,
		    processData: false,
		    success: function (returndata) {
		    	alert("上传成功!");
		    	$(".completeBtn").show();
		    	var obj = $("#filevalue").val();
		    	$(".sfile-name").text(returndata);
		        $("#"+obj,window.parent.document).val(returndata);
		        //删除原文件名
		        window.parent.delFileByName();
		        
		    }
		  });
    }
    
    function setFileName(){
   		var index = $("#sfile").val().lastIndexOf('\\');
    	var len = $("#sfile").val().length;
    	var name = $("#sfile").val().substring(index+1,len);
	    $(".sfile-name").text(name);
    }
    
    </script>
    
    <style type="text/css">
    .completeBtn{
    	display: none;
    }
    </style>
</head>

<body>

<div id="upload">
  <div class="upload pic-upload">
    <p>限9张图片</p>
    <form>
	<div id="wrapper">
        <div id="container">
            <!--头部，相册选择和格式选择-->
            <div id="uploader">
                <div class="queueList">
                    <div id="dndArea" class="placeholder">
                        <div id="filePicker"></div>
                        <p>或将照片拖到这里</p>
                    </div>
                </div>
                <div class="statusBar" style="display:none;">
                    <div class="progress">
                        <span class="text">0%</span>
                        <span class="percentage"></span>
                    </div><div class="info"></div>
                    <div class="btns">
                        <div id="filePicker2"></div><div class="uploadBtn">开始上传</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </form>
  </div>
  	
	<div class="upload-cad file-upload">
	<p>&nbsp;</p>
	<form id="sgform" action="" method="post" enctype="multipart/form-data">	
      <a href="javascript: void(0);" class="file2"><input type="file" onchange="setFileName()" name="sfile" id="sfile"></a>
      <font id="d9" style="display:block; margin-bottom:10px;">&nbsp;<span class="sfile-name"></span><a href="javascript: void(0);"  onclick="shwoOrHidden8()">X</a></font>
	  <input type="hidden" name="filevalue" id="filevalue"></input>
	  <input type="hidden" name="filemodel" id="filemodel" value="temp">
	  <input type="hidden" name="filetype" id="filetype" value="file">
	  <div class="clear"></div>
	  </form>
    </div>
    <div class="upload_btn file-upload"><input type='button' class="signlefile" name='button' value='Upload'></div>
    <div class="upload_btn completeBtn"><input type='button' name='buttonc' value='完成'></div>
</div>
</body>
</html>
