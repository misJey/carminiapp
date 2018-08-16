<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String basePath= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
%>
<body class="topbody">
	<header class="flex-start-center">
        <div class="header-title flex-rest">车商小程序管理后台</div>
        <div class="header-user flex-start-center">
            <div class="header-user-portrait">
                <div class="user-portrait-content">
                	<svg t="1533302326885" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3546" xmlns:xlink="http://www.w3.org/1999/xlink" width="32" height="32">
						<path d="M410.9312 574.634667A264.669867 264.669867 0 0 0 258.048 744.448a25.6 25.6 0 0 0 49.083733 14.4384 213.435733 213.435733 0 0 1 409.6 0.7168 25.6 25.6 0 1 0 49.152-14.267733 264.669867 264.669867 0 0 0-152.917333-170.5984 187.733333 187.733333 0 1 0-202.069333-0.068267zM512 1024C229.239467 1024 0 794.760533 0 512 0 229.239467 229.239467 0 512 0c282.760533 0 512 229.239467 512 512 0 282.760533-229.239467 512-512 512z m0-471.04a136.533333 136.533333 0 1 1 0-273.066667 136.533333 136.533333 0 0 1 0 273.066667z" fill="#FFF" p-id="3547"></path>
					</svg>
                </div>
            </div>
            <el-dropdown>
				<span class="el-dropdown-link" style="color: #fff;">
		   			${username }<i class="el-icon-arrow-down el-icon--right"></i>
			  	</span>
				<el-dropdown-menu slot="dropdown">
					<el-dropdown-item><div  onclick="SideNav.loginout()">安全退出</div></el-dropdown-item>
				</el-dropdown-menu>
			</el-dropdown>
        </div>
    </header>
</body>
</html>