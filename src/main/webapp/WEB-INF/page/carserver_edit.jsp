<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>车商小程序管理后台</title>
    <jsp:include page="/WEB-INF/page/head.jsp"></jsp:include>
    <script src="https://ycpd-assets.oss-cn-shenzhen.aliyuncs.com/ycpd/component/vue-baidu-map/vue-baidu-map.js"></script>
    <link href="./car-server-edit.css" rel="stylesheet" />
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
                        <el-breadcrumb-item><a href="/appcarserver?currentPage=0&fuzzy=">首页</a></el-breadcrumb-item>
                        <el-breadcrumb-item><a href="/appcarserver?currentPage=0&fuzzy=">车商管理</a></el-breadcrumb-item>
                        <el-breadcrumb-item><a href="#">编辑</a></el-breadcrumb-item>
                    </el-breadcrumb>
                </div>
                <div class="content-operation-right flex-start-center">
                    <el-button type="primary" icon="el-icon-edit" @click="submit">保存</el-button>
                    <a href="/appcarserver?currentPage=0&fuzzy=" style="display: block; padding-left: 10px;">
                    	<el-button icon="el-icon-back">返回</el-button>
                    </a>
                </div>
            </div>

            <div class="main-content-form">

                <div class="content-form-row flex-start form-row-1">
                    <div class="form-row-item">
                        <label><span>*</span>车商名称</label>
                        <el-input @blur="nameInputBlur" class="row-item-el-input" v-model="name" placeholder="请输入车商名称"></el-input>
                        <div class="form-input-error" v-if="error.name">{{error.name}}</div>
                    </div>
                    <div class="form-row-item">
                        <label><span>*</span>车商编码</label>
                        <el-input class="row-item-el-input" v-model="cid" placeholder="请输入车商编码"></el-input>
                        <div class="form-input-error" v-if="error.cid">{{error.cid}}</div>
                    </div>
                </div>

                <div class="content-form-row flex-start form-row-2">
                    <div class="form-row-item">
                        <label><span>*</span>统一社会信用代码</label>
                        <el-input class="row-item-el-input" v-model="code" placeholder="请输入统一社会信用代码"></el-input>
                        <div class="form-input-error" v-if="error.code">{{error.code}}</div>
                    </div>
                    <div class="form-row-item">
                        <label>平安网点ID</label>
                        <el-input class="row-item-el-input" v-model="pid" placeholder="请输入平安网点ID"></el-input>
                        <div class="form-input-error" v-if="error.pid">{{error.pid}}</div>
                    </div>
                </div>

                <div class="content-form-row flex-start form-row-3">
                    <div class="form-row-item">
                        <label>车商品牌</label>
                        <el-input class="row-item-el-input" v-model="brand" placeholder="请输入车商品牌"></el-input>
                        <div class="form-input-error" v-if="error.brand">{{error.brand}}</div>
                    </div>
                    <div class="form-row-item form-row-time">
                        <label>营业时间</label>
                        <div class="item-time-select flex-start-center">
                            <el-time-select
                                class="select-opening-hours"
                                v-model="working"
                                :picker-options="{
                                    start: '00:00',
                                    step: '00:30',
                                    end: '24:00'
                                }"
                                placeholder="营业开始时间"
                            ></el-time-select>
                            <el-time-select
                                v-model="workend"
                                :picker-options="{
                                    start: '00:00',
                                    step: '00:30',
                                    end: '24:00'
                                }"
                                placeholder="营业结束时间"
                            ></el-time-select>
                        </div>
                        <div class="form-input-error" v-if="error.working || error.workend">{{error.brand}} {{error.workend}}</div>
                    </div>
                </div>

                <div class="content-form-row flex-start form-row-4">
                    <div class="form-row-item">
                        <label>联系人</label>
                        <el-input class="row-item-el-input" v-model="contacts" placeholder="请输入联系人"></el-input>
                        <div class="form-input-error" v-if="error.contacts">{{error.contacts}}</div>
                    </div>
                    <div class="form-row-item">
                        <label>联系电话</label>
                        <el-input class="row-item-el-input" v-model="tel" placeholder="请输入联系电话"></el-input>
                        <div class="form-input-error" v-if="error.tel">{{error.tel}}</div>
                    </div>
                </div>

                <div class="form-row-5">
                    <div class="form-row-item">
                        <label>车商地址</label>
                        <el-input class="row-item-el-input" v-model="address" placeholder="请输入车商地址"></el-input>
                        <div class="form-input-error" v-if="error.address">{{error.address}}</div>
                    </div>
                </div>

                <div class="content-form-row flex-start form-row-6">
                    <div class="form-row-item">
                        <el-input class="row-item-el-input" v-model="longitude" placeholder="经度"></el-input>
                        <div class="form-input-error" v-if="error.longitude">{{error.longitude}}</div>
                    </div>
                    <div class="form-row-item">
                        <el-input class="row-item-el-input" v-model="latitude" placeholder="纬度"></el-input>
                        <div class="form-input-error" v-if="error.latitude">{{error.latitude}}</div>
                    </div>
                </div>

                <div class="form-row-7">
                    <baidu-map 
                        :center="location" 
                        :zoom="zoom"
                        :BmInfoWindow="false"
                        :double-click-zoom="false"
                        :map-click="false"
                        @ready="BMapReadyHandler"
                        @click="BMapClickHandler"
                        @dblclick="BMapDblClickHandler"
                    >
                        <bm-info-window 
                            :position="BMapInfoWindow.location" 
                            title="你选中的位置信息" 
                            :show="BMapInfoWindow.isShow" 
                            @close="infoWindowClose"
                        >
                            <p v-text="BMapInfoWindow.contents"></p>
                        </bm-info-window>
                        <bm-navigation anchor="BMAP_ANCHOR_TOP_RIGHT"></bm-navigation>
                    </baidu-map>
                </div>

                <div class="content-form-row flex-start form-row-8">
                    <div class="form-row-item">
                        <label>上传logo (推荐尺寸：240*240)</label>
                        <el-upload
                            ref="uploadLogo"
                            class="avatar-uploader"
                            action="${basePath}appupload"
                            :multiple="false"
                            :show-file-list="false"
                            list-type="picture"
                            :limit="1"
                            :disabled="logoProgress"
                            :before-upload="uploadeLogoBefore"
                            :on-progress="uploadeLogoProgress"
                            :on-success="uploadeLogoSuccess"
                        >
                            <img v-if="logo" :src="'${basePath}' + logoUrl" class="avatar">
                            <i v-else-if="logoProgress" class="el-icon-loading avatar-uploader-icon"></i>
                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                        </el-upload>
                        <div class="form-input-error" v-if="error.logo">{{error.logo}}</div>

                    </div>
                    <div class="form-row-item">
                        <label>门店照片（门头照） (推荐尺寸：375*300)</label>
                        <el-upload
                            ref="uploadImage"
                            class="avatar-uploader"
                            action="${basePath}appupload"
                            :multiple="false"
                            :show-file-list="false"
                            list-type="picture"
                            :limit="1"
                            :disabled="imageProgress"
                            :before-upload="uploadeImageBefore"
                            :on-progress="uploadeImageProgress"
                            :on-success="uploadeImageSuccess"
                        >
                            <img v-if="image" :src="'${basePath}' + imageUrl" class="avatar">
                            <i v-else-if="imageProgress" class="el-icon-loading avatar-uploader-icon"></i>
                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                        </el-upload>
                        <div class="form-input-error" v-if="error.image">{{error.image}}</div>
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
    isActive: true,

    init: function init() {
        // 注册百度地图
        Vue.use(VueBaiduMap.default, {
            // ak 是在百度地图开发者平台申请的密钥 详见 http://lbsyun.baidu.com/apiconsole/key */
            ak: 'vuKvf6G4ivYvVdeK44F8dR8ZqZIcwG4s'
        });
        this.vueMount = new Vue(VmMain);
    }
}

var VmMain = {
    el: '#root',

    data: {
        name: '', // 车商名称
        cid: '', // 车商编码

        code: '', // 统一社会信用代码
        pid: '', // 平安网点ID
        
        brand: '', // 车商品牌

        working: '', // 营业开始时间
        workend: '', // 营业结束时间

        contacts: '', // 联系人
        tel: '', // 联系电话

        address: '', // 车商地址

        longitude: '', // longitude 经度 (最终提交的数据)
        latitude: '', // latitude 纬度 (最终提交的数据) 

        BMapInfoWindow: { // BMap 信息窗体
            isShow: false,
            contents: '', // 显示的内容
            location: { // BMap 信息窗体的经纬度
                lng: 0,  // longitude 经度
                lat: 0, // latitude 纬度
            },
        },
        Geocoder: null, // BMap类用于获取用户的地址解析

        location: { // vue-baidu-map 插件数据 
            lng: 0,  // longitude 经度
            lat: 0, // latitude 纬度
        },

        zoom: 3, // vue-baidu-map 插件 层级 3表示全国 13 表示市

        logo: '', // 上传logo
        image: '', // 上传门店图

        logoProgress: false, // logo图片 是否正在上传
        imageProgress: false, // 门店图片 是否正在上传

        logoUrl: '', // 上传logo 的完整地址
        imageUrl: '', // 上传门店图 的完整地址

        error: { // 错误提示
            name: '',
            cid: '',
            code: '',
            pid: '',
            brand: '',
            working: '',
            workend: '',
            contacts: '',
            tel: '',
            address: '',
            longitude: '',
            latitude: '',
            logo: '',
            image: '',
        }
    },

    mounted: function showError() {
        var _this = this;
        // 检测页面是否处于单点登录状态
        this.getIsActive();
        
    	var	modifyCardealer = ${modifyCardealer == null ? false : modifyCardealer };
    	// 编辑的情况下
    	if (modifyCardealer) {
            this.name = modifyCardealer.name;
            this.cid = modifyCardealer.cid;
            this.code = modifyCardealer.code;
            this.pid = modifyCardealer.pid;
            this.brand = modifyCardealer.brand;
            this.working = modifyCardealer.working;
            this.workend = modifyCardealer.workend;
            this.contacts = modifyCardealer.contacts;
            this.tel = modifyCardealer.tel;
            this.address = modifyCardealer.address;
            this.longitude = modifyCardealer.longitude;
            this.latitude = modifyCardealer.latitude;
            this.logo = modifyCardealer.logo;
            this.image = modifyCardealer.image;

            this.logoUrl = 'img/' + modifyCardealer.logo;
            this.imageUrl = 'img/' +  modifyCardealer.image;
    	} else { // 新增的情况
    		
    	}
        
    },
    
    /**
     * 表单输入校验监听
     */
    // watch: {
    //     name: function name() { this.verify() },
    //     cid: function cid() { this.verify() },
    //     code: function code() { this.verify() },
    //     pid: function pid() { this.verify() },
    //     brand: function brand() { this.verify() },
    //     working: function working() { this.verify() },
    //     workend: function workend() { this.verify() },
    //     contacts: function contacts() { this.verify() },
    //     tel: function tel() { this.verify() },
    //     address: function address() { this.verify() },
    //     longitude: function longitude() { this.verify() },
    //     latitude: function latitude() { this.verify() },
    //     logo: function logo() { this.verify() },
    //     image: function image() { this.verify() },
    // },

    methods: {
        /**
         * 检测登录信息 轮询
         */
        getIsActive: function getIsActive() {
            var _this = this;
            // 弹出提示框
            var showError = function showError(message) {
                _this.$confirm(
                    message, 
                    '检测到登录已失效', // 标题
                    {
                        confirmButtonText: '重新登录',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }
                ).then(function () {
                    $.ajax({
                        asyn: false,
                        type : "get",
                        url : "/apploginout",
                        contentType: "application/json;charset=utf-8",
                        success : function(response) {
                            document.cookie = '';
                            window.location.href = '/';
                        }
                    });
                });
            }

            if (Main.isActive === false) { // 如果已经处于登出状态就不用进行查询了
                return false;
            }

            $.ajax({
                type: "GET",
                url: "/isactive",
                success: function success(response){
                	
                    if (response.data === '1') { // 表示处于激活状态下
                        // 30S 轮询一次状态
                        setTimeout(function () {
                            _this.getIsActive();
                        }, 30000);
                    } else {
                        Main.isActive = false;
                        showError('可能登录状态已经过期');
                    }
                }, 
                error: function error(error) {
                    Main.isActive = false;
                    showError('请求服务器检测登录状态失败');
                }
         });
        },

        /**
         * 初始化 vue-baidu-map 信息
         */
        BMapReadyHandler: function BMapReadyHandler(BaiduMap) {
            this.zoom = 13; // 初始化地图层级

            // 判断是否有位置信息
            if ( 
                this.longitude &&
                this.latitude
            ) {
                this.location.lng = this.longitude;
                this.location.lat = this.latitude;

                if (this.address) { // 如果有位置信息
                    this.location.lng = this.longitude;
                    this.location.lat = this.latitude;
                    // this.BMapInfoWindow = {
                    //     isShow: true,
                    //     contents: this.address,
                    //     location: {
                    //         lng: this.longitude,  // longitude 经度
                    //         lat: this.latitude, // latitude 纬度
                    //     },
                    // }
                }
            } else { // 初始化位置信息为深圳
                this.location.lng = 114.0595600000;
                this.location.lat = 22.5428600000;
            }

            // 初始实例化类
            this.Geocoder = new BaiduMap.BMap.Geocoder();
        },

        /**
         * 单击 vue-baidu-map 如果点击中, 则设置信息
         */
        BMapClickHandler: function BMapClickHandler(BMap) {
        	var _this = this;
            this.BMapInfoWindow.location = {
                lng: BMap.point.lng,  // longitude 经度
                lat: BMap.point.lat, // latitude 纬度
            }
            this.Geocoder.getLocation(
                BMap.point,
                function (rs) {
                	_this.BMapInfoWindow.contents = rs.address;
                }
            );
        },

        /**
         * 双击 vue-baidu-map 设置经纬度
         */
        BMapDblClickHandler: function BMapDblClickHandler(BMap) {
            this.longitude = parseInt(BMap.point.lng).toFixed(4); // longitude 经度
            this.latitude = parseInt(BMap.point.lat).toFixed(4); // latitude 纬度
            this.address = this.BMapInfoWindow.contents; // address 地址
            this.BMapInfoWindow.isShow = true;
        },

        /**
         * 关闭 vue-baidu-map 弹窗的提示
         */
        infoWindowClose: function infoWindowClose() {
            this.BMapInfoWindow.isShow = false;
        },

        /**
         * 上传logo之前判断一下大小的限制
         */
        uploadeLogoBefore: function uploadeLogoBefore(file) {
            if (file.size > 1000000) {
                alert('图片大小不能大于1Mb');
                return false 
            }
        },

        /**
         * 正在 上传logo 的情况下
         */
        uploadeLogoProgress: function uploadeLogoProgress() {
            this.logoProgress = true;
            this.logo = '';
            this.logoUrl = '';
        },

        /**
         * 上传logo 成功的情况下
         */
        uploadeLogoSuccess: function uploadeLogoSuccess(response, file, fileList) {
            this.$refs.uploadLogo.clearFiles();
            this.logoProgress = false;
            this.logo = response.imageName;
            this.logoUrl = 'tempfile/' + response.imageName;
        },

        /**
         * 上传门店照片（门头照） 之前判断一下大小的限制
         */
        uploadeImageBefore: function uploadeImageBefore(file) {
            if (file.size > 1000000) {
                alert('图片大小不能大于1Mb');
                return false 
            }
        },

        /**
         * 正在 门店照片（门头照） 的情况下
         */
        uploadeImageProgress: function uploadeImageProgress() {
            this.imageProgress = true;
            this.image = '';
            this.imageUrl = '';
        },

        /**
         * 上传 门店照片（门头照） 成功的情况下
         */
        uploadeImageSuccess: function uploadeImageSuccess(response, file, fileList) {
            this.$refs.uploadImage.clearFiles();
            this.imageProgress = false;
            this.image = response.imageName;
            this.imageUrl = 'tempfile/' + response.imageName;
        },

        /**
         * 校验
         */
        verify: function verify() {
            var myConsequencer = []; // 不等于 1 表示有错误

            if (this.name === '') {
                this.error.name = '车商名称不能为空';
                myConsequencer.push('车商名称不能为空');
            } else {
                this.error.name = '';
            }

            if (this.cid === '') {
                this.error.cid = '车商编码不能为空';
                myConsequencer.push('车商编码不能为空');
            } else {
                this.error.cid = '';
            }

            if (this.code === '') {
                this.error.code = '统一社会信用代码不能为空';
                myConsequencer.push('统一社会信用代码不能为空');
            } else {
                this.error.code = '';
            }

            if (this.pid === '') {
                this.error.pid = '平安网点ID不能为空';
                myConsequencer.push('平安网点ID不能为空');
            } else {
                this.error.pid = '';
            }

            if (this.brand === '') {
                this.error.brand = '车商品牌不能为空';
                myConsequencer.push('车商品牌不能为空');
            } else {
                this.error.brand = '';
            }

            if (this.working === '') {
                this.error.working = '营业开始时间不能为空';
                myConsequencer.push('营业开始时间不能为空');
            } else {
                this.error.working = '';
            }

            if (this.workend === '') {
                this.error.workend = '营业结束时间不能为空';
                myConsequencer.push('营业结束时间不能为空');
            } else {
                this.error.workend = '';
            }

            if (this.contacts === '') {
                this.error.contacts = '联系人不能为空';
                myConsequencer.push('联系人不能为空');
            } else {
                this.error.contacts = '';
            }

            if (this.tel === '') {
                this.error.tel = '联系电话不能为空';
                myConsequencer.push('联系电话不能为空');
            } else {
                this.error.tel = '';
            }

            if (this.address === '') {
                this.error.address = '车商地址不能为空';
                myConsequencer.push('车商地址不能为空');
            } else {
                this.error.address = '';
            }

            if (this.longitude === '') {
                this.error.longitude = '经度不能为空';
                myConsequencer.push('经度不能为空');
            } else if (/^-?((0|1?[0-7]?[0-9]?)(([.][0-9]{1,4})?)|180(([.][0]{1,4})?))$/.test(this.longitude) === false) {
                this.error.longitude = '请输入正确格式的经度';
                myConsequencer.push('请输入正确格式的经度');
            }  else {
                this.error.longitude = '';
            }

            if (this.latitude === '') {
                this.error.latitude = '纬度不能为空';
                myConsequencer.push('纬度不能为空');
            } else if (/^-?((0|[1-8]?[0-9]?)(([.][0-9]{1,4})?)|90(([.][0]{1,4})?))$/.test(this.latitude) === false) {
                this.error.latitude = '请输入正确格式的纬度';
                myConsequencer.push('请输入正确格式的纬度');
            } else {
                this.error.latitude = '';
            }

            if (this.logo === '') {
                this.error.logo = '必须上传logo';
                myConsequencer.push('必须上传logo');
            } else {
                this.error.logo = '';
            }

            if (this.image === '') {
                this.error.image = '必须上传门店图';
                myConsequencer.push('必须上传门店图');
            } else {
                this.error.image = '';
            }

            if (myConsequencer.length === 0) { // 表示没有任何错误
                return Consequencer.success();
            } else { // 信息有误
                return Consequencer.error('error', myConsequencer);
            }
        },

        /**
         * 校验车商名称
         */
        nameInputBlur: function nameInputBlur() {
            var _this = this;
            this.verifyName(this.name)
            .then(
                function (resolve) {
                    if (resolve.result !== 1) { // 表示没有重复字段
                        _this.error.name = '车商名称已存在';
                    }
                }, 
                function (error) {
                    alert('请求校验用户名称发生错误');
                }
            );
        },

        /**
         * 校验车商名称
         */
        verifyName: function verifyName(name) {
            return new Promise(function(resolve, reject) {
                $.ajax({
                    type : "GET",
                    url : "/appcheckname?name=" + name,
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
                    return this.$message({
                        message: myVerify.data[i],
                        type: 'warning'
                    });
                }
            }

            var data = { 
           		name: this.name,
                cid: this.cid,
                code: this.code,
                pid: this.pid,
                brand: this.brand,
                working: this.working,
                workend: this.workend,
                contacts: this.contacts,
                tel: this.tel,
                address: this.address,
                longitude: this.longitude,
                latitude: this.latitude,
                logo: this.logo,
                image: this.image,
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
                    url : "/appaddcardealer",
                    data : JSON.stringify(data),
                    contentType : "application/json",
                    dataType : "json",
                    success : function(response) {
                        if (response.result === 'success') {
                            window.location.href = '/appcarserver?currentPage=0';
                        } else {
                            // alert(response.message ? response.message : '删除失败!');
                        }
                    },
                    error : function(){
                        alert("错误");
                    }
                });
            }

            this.verifyName(this.name)
            .then(
                function (resolve) {
                    if (resolve.result === 1) { // 表示没有重复字段
                        postSubmit();
                    } else {
                        _this.error.name = '车商名称已存在';
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
    error: function success(message, result, data) {
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
