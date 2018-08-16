<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>车商小程序管理后台</title>
    <jsp:include page="/WEB-INF/page/head.jsp"></jsp:include>
    <link href="./login.css" rel="stylesheet" />
</head>
<body>

<div id="root" class="main flex-center">
    <img class="main-background" alt="background-img" :src="'https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/pingan-wechatapplets/icon/management-login.jpg?x-oss-process=image/resize,m_fill,w_' + clientWidth + ',h_' + clientHeight + ',limit_0/auto-orient,0/quality,q_100'" />
    <div class="main-login flex-column-center">
        <div class="main-login-logo">
            <div class="login-logo-content">
                <img class="login-logo-img" alt="login-logo-img" src="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/pingan-wechatapplets/pingan-logo.png?x-oss-process=image/resize,m_fill,w_475,h_82,limit_0/auto-orient,0/quality,q_100" />
            </div>
        </div>
        <div class="main-login-lable flex-center">
            <span>—— 欢迎使用车商小程序管理系统</span>
        </div>
        <el-form ref="form" :model="form" action="/backstageLogin" method="post">

            <el-form-item class="main-login-input" prop="username">
                <el-input placeholder="请输入账号" v-model="form.username">
                    <template slot="prepend">
                        <svg t="1533007168988" class="icon"viewBox="0 0 1028 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2232" xmlns:xlink="http://www.w3.org/1999/xlink" 
                            width="22" height="22">
                            <path d="M815.814506 299.350645c0 165.306834-134.011812 299.350645-299.350645 299.350645s-299.350645-134.011812-299.350645-299.350645c0-165.306834 134.011812-299.350645 299.350645-299.350645s299.350645 134.011812 299.350645 299.350645z" p-id="2233" fill="#606266"></path>
                            <path d="M763.52814 612.780851c-69.75782 55.070279-156.219118 85.661323-247.064279 85.661323-91.901128 0-179.1944-31.295022-249.27221-87.421268-184.698228 67.805881-267.19165 304.758476-267.19165 412.979094l1027.711884 0c0-107.260648-83.133402-342.549295-264.183744-411.18715z" p-id="2234" fill="#606266"></path>
                        </svg>
                    </template>
                </el-input>
            </el-form-item>

            <el-form-item class="main-login-input" prop="password">
                <el-input placeholder="请输入密码" type="password" v-model="form.password">
                    <template slot="prepend">
                        <svg t="1533007203224" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3198" xmlns:xlink="http://www.w3.org/1999/xlink" 
                            width="22" height="22">
                            <path d="M908.702808 1023.749181h-746.483778c-38.390594 4.265622-72.515567-46.921837-72.515567-72.515567v-482.015239c0-51.187459 55.453081-85.312432 85.312431-85.312432h42.656216v-127.968648c0-145.031134 153.562377-255.937295 298.593512-255.937295s298.593511 110.906161 298.593511 255.937295v127.968648h42.656216c34.124973 0 85.312432 29.859351 85.312432 85.312432v482.015239c-4.265622 25.59373 4.265622 72.515567-34.124973 72.515567z m-183.421729-767.811886c0-98.109297-115.171783-170.624864-213.281079-170.624863s-213.281079 72.515567-213.281079 170.624863v127.968648h426.562158v-127.968648z m127.968648 213.28108h-682.499454v469.218375h682.499454l12.796865 12.796864-12.796865-482.015239z m-298.593511 243.14043v98.109297c0 25.59373-17.062486 42.656216-42.656216 42.656216s-42.656216-21.328108-42.656216-42.656216v-98.109297c-25.59373-12.796865-42.656216-42.656216-42.656216-72.515567 0-46.921837 38.390594-85.312432 85.312432-85.312431s85.312432 38.390594 85.312432 85.312431c0 29.859351-17.062486 59.718702-42.656216 72.515567z" p-id="3199" fill="#606266"></path>
                        </svg>
                    </template>
                </el-input>
            </el-form-item>
            
            <div  class="main-login-error" >${ error }</div>
            

            <el-form-item class="main-login-token" prop="token" style="display: none;">
                <el-input v-model="form.token"></el-input>
            </el-form-item>
            
            <el-form-item>
                <div class="login-form-submit">
                    <input @click="submitForm" value="立即登录">
                </div>
            </el-form-item>
        </el-form>
    </div>
</div>

<script>

window.onload = function () {
    Main.init();
};

var Main = {
    vueMount: null, // vue的实例挂载 (提供给外部访问与测试)

    init: function init() {
        this.vueMount = new Vue(VmMain);
    }
}

var VmMain = {
    el: '#root',

    data: {
        clientWidth: document.body.offsetWidth || document.documentElement.clientWidth || window.innerWidth,
        clientHeight: document.body.offsetHeight || document.documentElement.clientHeight || window.innerHeight,


        form: { // 表单
        	username: '',
            password: '',
            token: '${token}'
        }
    },

    mounted: function mounted() {
        var _this = this;
        $(document).keypress(function (event) {
            if (event.keyCode === 13) {
                _this.submitForm();
            }
        });
    },

    methods: {
        submitForm: function submitForm() {
        	if (this.form.username === "") {
        		return alert('用户名不能为空');
        	}
        	if (this.form.password === "") {
        		return alert('密码不能为空');
        	}
        	var myForm = $([
        		'<form action="/backstageLogin" method="post">',
	        		'<input type="text" name="username" value="' + this.form.username + '">',
	        		'<input type="text" name="password" value="' + this.form.password + '">',
	        		'<input type="text" name="token" value="' + this.form.token + '">',
        		'</form>'
       		].join(''));
       		$(document.body).append(myForm);
       		myForm.submit();
       		
        }
    }
}

</script>

</body>
</html>