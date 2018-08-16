<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
    <script>
      if(!window.Promise) {
        document.writeln('<script src="https://cdn.bootcss.com/es6-promise/4.1.1/es6-promise.min.js"'+'>'+'<'+'/'+'script>');
      }
    </script>
    
    <script type="text/javascript" src="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/ycpd/javascript/vue.js"></script>

    <script type="text/javascript" src="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/ycpd/javascript/element-ui.js"></script>
    <link href="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/ycpd/css/element-ui.css" rel="stylesheet" />

    <link href="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/ycpd/css/base.css" rel="stylesheet" />
    <link href="./index.css" rel="stylesheet" />
</head>
<body>
<div id="root">
    <!-- 顶部栏 -->
    <div>
    <jsp:include page="/WEB-INF/page/top.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/page/left.jsp"></jsp:include>
    </div>
</div>
</body>
</html>