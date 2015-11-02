/**
 * @author liuzy
 * @param 2015-10-21
 * 事件
 */
(function( $ ){
    $(function() {
    	/***************宝石签收单-开始******************/
    	//价值
    	setSuffix("gem-worth","元");
    	//重量
    	setSuffix("gem-weight","克");
    	//数量
    	setSuffix("gem-count","颗");

    	/***************宝石签收单-结束******************/
    });
    
    /**
     * 设置后缀
     */
    function setSuffix(myClass,suffix){
    	//获得焦点
    	$("."+myClass).bind("focusin",function(){
    		var worth = $("."+myClass).val();
    		var index = isContain(worth,suffix);
    		if(index >= 0){
    			$("."+myClass).val(worth.substring(0,index));
    		}
    	});
    	//失去焦点
    	$("."+myClass).bind("focusout",function(){
    		var worth = $("."+myClass).val();
    		var index = isContain(worth,suffix);
    		if(index == -1){
    			$("."+myClass).val(worth + suffix);
    		}
    	});
    }
    
    /*
     * 判断是否包含该字符
     * str 目标字符串
     * em 包含的字符串
     */
    function isContain(str,em){
        var s = str.indexOf(em); 
        return (s);
    } 
})( jQuery );
