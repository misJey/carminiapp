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
    <link href="./user-edit.css" rel="stylesheet" />
</head>

<body>

<div id="root">
    <!-- 顶部栏 -->
    <jsp:include page="/WEB-INF/page/top.jsp"></jsp:include>
    
    <div class="main flex-start flex-rest">
        <!-- 侧边栏 -->
		<jsp:include page="/WEB-INF/page/left.jsp"></jsp:include>
    
        <!-- 主要内容 -->
        <div class="main-content flex-rest">

            <div class="main-content-operation flex-start-center">
                <div class="content-operation-left flex-rest">
                    <el-breadcrumb separator="/">
                        <el-breadcrumb-item><a href="/appusermanage?currentPage=0">首页</a></el-breadcrumb-item>
                        <el-breadcrumb-item><a href="/appusermanage?currentPage=0">用户列表</a></el-breadcrumb-item>
                        <el-breadcrumb-item><a href="#">${modifyUser == null ? '新增' : '编辑' }</a></el-breadcrumb-item>
                    </el-breadcrumb>
                </div>
                <div class="content-operation-right flex-start-center">
                    <el-button type="primary" icon="el-icon-edit" @click="submit">保存</el-button>
                    <a href="/appusermanage?currentPage=0" style="padding-left: 10px;">
                    	<el-button icon="el-icon-back">返回</el-button>
                    </a>
                </div>
            </div>

            <div class="main-content-form">

                <div class="content-form-row flex-start-center form-row-1">
                    <div class="form-row-item">
                        <label><span>*</span>人员姓名</label>
                        <el-input class="row-item-el-input" v-model="username" placeholder="请输入人员姓名"></el-input>
                        <div class="form-input-error" v-if="error.username">{{error.username}}</div>
                    </div>
                    <div class="form-row-item">
                        <label><span>*</span>登陆密码</label>
                        <el-input class="row-item-el-input" v-model="password" placeholder="请输入登陆密码"></el-input>
                        <div class="form-input-error" v-if="error.password">{{error.password}}</div>
                    </div>
                </div>

                <div class="content-form-row flex-start-center form-row-1">
                    <div class="form-row-item">
                        <label><span>*</span>用户角色</label>
                        <el-select v-model="category" placeholder="选择用户角色">
                            <el-option
                                v-for="item in categoryList"
                                :key="item.value"
                                :label="item.label"
                                :value="item.value">
                            </el-option>
                        </el-select>
                        <div class="form-input-error" v-if="error.category">{{error.category}}</div>
                    </div>
                    <div class="form-row-item">
                        <label><span>*</span>关联车商</label>
                        <el-select v-model="cardealername" placeholder="请选择关联车商">
                            <el-option
                                v-for="item in cardealernameList"
                                :key="item.value"
                                :label="item.label"
                                :value="item.value">
                            </el-option>
                        </el-select>
                        <div class="form-input-error" v-if="error.cardealername">{{error.cardealername}}</div>
                    </div>
                </div>
            </div>
        </div>
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
        username: '', // 人员姓名
        password: '', // 登陆密码
        category: 2, // 用户角色  默认车商
        cardealername: '车商名称', // 关联车商

        categoryList: [
            {
                value: 1,
                label: '管理员',
            }, {
                value: 2,
                label: '车商',
            }
        ],

        allcardealername: [ // 从数据库获取的所有关联车商
        ],
    
        cardealernameList: [ // 显示的关联车商
            {
                value: '车商名称',
                label: '车商名称',
            }
        ],

        error: { // 错误提示
            username: '',
            password: '',
            category: '',
            cardealername: '',
        }
    },

    mounted: function mounted() {
        var _this = this;
    	// {"cardealername":"","category":0,"id":1,"image":"test.png","password":"admin","username":"admin"}
    	var	SystemUser = ${modifyUser == null ? false : modifyUser };
    	// 编辑的情况下
    	if (SystemUser) {
    		this.username = SystemUser.username;
    		this.password = SystemUser.password;
    		this.category = SystemUser.category;
    		this.cardealername = SystemUser.cardealername;
    		
    		// 用户是 超级管理员的情况下
    		if (SystemUser.category === 0) {
    			this.categoryList = [{ value: SystemUser.category, label: '超级管理员' }];
    			this.cardealernameList = [{ value: SystemUser.cardealername, label: '中国平安' }];
    		}
    		// 用户是 管理员的情况下
    		if (SystemUser.category === 1) {
    			this.categoryList = [{ value: SystemUser.category, label: '管理员' }];
    			this.cardealernameList = [{ value: SystemUser.cardealername, label: '中国平安' }];
    		}
    		// 用户是 车商的情况下
    		if (SystemUser.category === 2) {
    			this.categoryList = [{ value: SystemUser.category, label: '车商' }];
    			this.cardealernameList = [{ value: SystemUser.cardealername, label: SystemUser.cardealername }];
    		}

    	} else { // 新增的情况
            $.ajax({
    			type : "get",
    			url : "/appgetcardealernamelist",
    			success : function(response) {
    				if (response.list  && response.list.length > 0) {
        				var myCardealernameList = response.list.map(function (val) {
        					return {
        						value: val,
        						label: val
        					}
        				});
        				_this.cardealername = response.list[0];
        				_this.allcardealername = myCardealernameList;
        				_this.cardealernameList = myCardealernameList;
        		    	
        	        	// 登录用户 是 管理员
        	        	if (response.category === 1) {
        	        		_this.category = 2; // 只能新增车商
        	    			_this.categoryList = [{ value: 2, label: '车商' }];
        	        	}
    				} else {
                        _this.category = 1; // 车商数据为空, 只能新增管理员
        				alert("车商用户数据为空");
    				}
    			},
    			error : function(error){
    				alert("获取车商数据发生错误, 原因:" + error);
    			}
    		});
    	}
    },

    // 监听字段改变进行校验
    watch: {
        // username: function username() { this.verify() },
        // password: function password() { this.verify() },
        // 用户角色
    	category: function (newCategory, oldCategory) {
            // 如果选择车商
            if (newCategory === 2 || newCategory === '2') {
                // 车商数据为空的情况下
                if (this.allcardealername.length === 0) {
                    alert('车商数据为空, 请先添加车商信息');
                    return this.category = 1;
                }
            }
            // 表示管理员
            if (newCategory === 1 || newCategory === '1') {
                this.cardealername = '中国平安'; // 关联车商
                this.cardealernameList = [{
                    value: '中国平安',
                    label: '中国平安',
                }];
            } else if (newCategory === 2 || newCategory === '2') {
                this.cardealername = this.allcardealername[0].value; // 关联车商
                this.cardealernameList = this.allcardealername;
            }
    	},
        // cardealername: function cardealername() {  },
   	},

    methods: {
        /**
         * 校验
         */
        verify: function verify() {
            var myConsequencer = []; // 不等于 1 表示有错误

            if (this.username === '') {
                this.error.username = '人员姓名不能为空';
                myConsequencer.push('人员姓名不能为空');
            } else {
                this.error.username = '';
            }

            if (this.password === '') {
                this.error.password = '登陆密码不能为空';
                myConsequencer.push('登陆密码不能为空');
            } else {
                this.error.password = '';
            }

            if (this.category === '') {
                this.error.category = '用户角色不能为空';
                myConsequencer.push('用户角色不能为空');
            } else {
                this.error.category = '';
            }

            if (this.cardealername === '') {
                this.error.cardealername = '关联车商不能为空';
                myConsequencer.push('关联车商不能为空');
            } else {
                this.error.cardealername = '';
            }

            if (myConsequencer.length === 0) { // 表示没有任何错误
                return Consequencer.success();
            } else { // 信息有误
                return Consequencer.error('error', 2, myConsequencer);
            }
        },
        /**
         * 校验用户名称
         */
        verifyUsername: function verifyUsername(username) {
            return new Promise(function(resolve, reject) {
                $.ajax({
                    type : "GET",
                    url : "/appcheckusername?username=" + username,
                    success : function(response) {
                        if (response === 'true') {
                            resolve(Consequencer.error('字段重复'));
                        } else {
                            resolve(Consequencer.success());
                        }
                    },
                    error : function(){
                        reject("请求错误");
                    }
                });
            });
        },

        /**
         * 提交保存数据
         */
        submit: function submit() {
            var _this = this;
            var myVerify = this.verify();

            if (myVerify.result !== 1) { // 如果验证失败
                // 循环提示报错
                var errorcount = myVerify.data.length >= 5 ? 5 : myVerify.data.length;
                for (var i = 0; i < errorcount; i++) { // 最多提示5条
                    this.$message({
                        message: myVerify.data[i],
                        type: 'warning'
                    });
                }
                return false
            }
            var data = {
   	    		username: this.username,
   	    		password: this.password,
   	    		category: this.category,
   	    		cardealername: this.cardealername
            }
            // 如果 url 存在 id 表示 修改
            var pageVar = loadPageVar('id');
            if (pageVar) {
            	data.id = pageVar;
            }

            /**
             * 提交保存数据 的请求
             */
            var postSubmit = function postSubmit() {
                $.ajax({
                    type : "POST",
                    url : "/appadduser",
                    data : JSON.stringify(data),
                    contentType : "application/json",
                    dataType : "json",
                    success : function(response) {
                        if (response.result === 'success') {
                            window.location.href = '/appusermanage?currentPage=0';
                        } else {
                            // alert(response.message ? response.message : '删除失败!');
                        }
                    },
                    error : function(){
                        alert("错误");
                    }
                });
            }

            this.verifyUsername(this.username)
            .then(
                function (resolve) {
                    if (resolve.result === 1) { // 表示没有重复字段
                        postSubmit();
                    } else {
                        _this.error.username = '用户名已存在';
                    }
                }, 
                function (error) {
                    alert('请求校验用户名称发生错误');
                }
            );
        }
    }
}

var Consequencer = {
    /**
     * 请求成功
     * @param {any} data 返回成功的数据封装
     * @param {string} message 返回成功的信息封装
     * @return {any} 成功封装的结果
     */
    success: function success(data, message) {
        return {
            'result': 1,
            'data': data || null,
            'message': message || 'success'
        }
    },

    /**
     * 请求失败
     * @param {string} message 返回失败的信息封装
     * @param {number} result 返回失败的数据封装
     * @param {any} data 返回失败的数据封装
     * @return {any} 失败封装的结果
     */
    error: function error(message, result, data) {
        return {
            'result': result || 0,
            'data': data || null,
            'message': message
        }
    }
}

function loadPageVar(sVar) { 
    return decodeURI(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURI(sVar).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1")); 
} 

</script>

</body>
</html>
