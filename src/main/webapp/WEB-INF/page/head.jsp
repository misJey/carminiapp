<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	if(!window.Promise) {
		document.writeln('<script src="https://cdn.bootcss.com/es6-promise/4.1.1/es6-promise.min.js"'+'>'+'<'+'/'+'script>');
	}
</script>
<script src="https://cdn.bootcss.com/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/ycpd/javascript/vue.js"></script>

<script type="text/javascript" src="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/ycpd/javascript/element-ui.js"></script>
<link href="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/ycpd/css/element-ui.css" rel="stylesheet" />

<link href="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/ycpd/css/base.css" rel="stylesheet" />
<script>
 
$(document).ready(function () {
	SideNav.init();
});

var SideNav = {
	 loginout: function loginout() {
		if(!confirm("确认要退出么？")){
			return false;
		};
		$.ajax({
			asyn: false,
			type : "get",
			url : "/apploginout",
			contentType: "application/json;charset=utf-8",
			success : function(response) {
				alert(response.message);
				document.cookie = '';
				window.location.href ='/';
			},
			error : function(){
				alert("错误");
			}
		});
	 },
	 click: function click(id) {
         window.location.href = '/' + id + '?currentPage=0&fuzzy=';
	 },
     init: function init () {
         $('#main-side-nav .side-nav-item').each(function (key) {
             var id = $(this).attr('data-id');
             
             if (window.location.pathname.indexOf(id) !== -1) {
            	 $($(this)[0]).addClass('nav-item-selected');
             } else {
            	 $($(this)[0]).removeClass('nav-item-selected');
             }
             
             //  if (key === 0) {  
             //  	 if (window.location.pathname === '/' || window.location.pathname === '/backstageLogin' ) {
             //          $($(this)[0]).addClass('nav-item-selected');
             //	 }
             // } 
         });
     }
}
</script>