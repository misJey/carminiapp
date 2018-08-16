<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>车商小程序管理后台</title>
    <jsp:include page="/WEB-INF/page/head.jsp"></jsp:include>
    <link href="./index.css" rel="stylesheet" />
</head>

<body>

<div id="root">
    <!-- 顶部栏 -->
    <jsp:include page="/WEB-INF/page/top.jsp"></jsp:include>
    
    <div class="main flex-start flex-rest">
	    <!-- 侧边栏 -->
	    <jsp:include page="/WEB-INF/page/left.jsp"></jsp:include>
	    
	    <!-- 主要内容 -->
        <div class="main-content flex-rest" id="welcome">
        	<img src="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/pingan-wechatapplets/backstage-home-banner.png" />
        </div>
    </div>
</div>
<style>
.main .main-side-nav {
	box-shadow: none;
}

.main .main-side-nav .side-nav-line {
     background: #fff;
}

#welcome {
    padding: 0px;
    background: #fff;
    overflow: hidden;
}

#welcome img {
	display: block;
	width: 100%;
	height: 100%;
}
</style>

<script>

window.onload = function () {
	Main.init();
};
var Main = {
    vueMount: null, // vue的实例挂载 (提供给外部访问与测试)

    init: function init() {
    	
        this.vueMount = new Vue(VmMain);
        this.initwelcome();
    },

    initwelcome: function initwelcome() {
		$('#welcome').attr('style', 'height: ' + (document.body.offsetHeight - 50) + 'px;' )
    }
}

var VmMain = {
    el: '#root',

    data: {
        clientWidth: document.body.offsetWidth || document.documentElement.clientWidth || window.innerWidth,
        clientHeight: document.body.offsetHeight || document.documentElement.clientHeight || window.innerHeight,
    }

}
</script>
</body>
</html>
