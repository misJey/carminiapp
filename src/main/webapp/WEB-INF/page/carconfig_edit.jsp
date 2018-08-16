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
    <link href="./appointment-edit.css" rel="stylesheet" />
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
                        <el-breadcrumb-item><a href="/appcarconfig?currentPage=0&fuzzy=">首页</a></el-breadcrumb-item>
                        <el-breadcrumb-item><a href="/appcarconfig?currentPage=0&fuzzy=">试驾车型配置</a></el-breadcrumb-item>
                        <el-breadcrumb-item><a href="#">编辑</a></el-breadcrumb-item>
                    </el-breadcrumb>
                </div>
                <div class="content-operation-right flex-start-center">
                    <el-button type="primary" icon="el-icon-edit" @click="submit">保存</el-button>
                    <el-button icon="el-icon-back"><a href="/appcarconfig?currentPage=0&fuzzy=">返回</a></el-button>
                </div>
            </div>

            <div class="main-content-form content-form-1">
                <div class="content-form-title">基本信息</div>
                
                
                <div class="content-form-row flex-start-center form-row-1">
                    <div class="form-row-item">
                    <label class="row-item-title"><span>*</span>归属车商</label>
                    <el-select v-model="cid" placeholder="选择车商">
                        <el-option
                            v-for="item in carServers"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                        </el-option>
                    </el-select>
                    <div class="form-input-error" v-if="error.cid">{{error.cid}}</div>
                    </div>
                    <div class="form-row-item">
                        <label class="row-item-title"><span>*</span>品牌</label>
                        <el-input class="row-item-el-input" v-model="brand" placeholder="请输入品牌"></el-input>
                        <div class="form-input-error" v-if="error.brand">{{error.brand}}</div>
                    </div>
                </div>

                <div class="content-form-row flex-start-center form-row-2">
                    <div class="form-row-item">
                        <label class="row-item-title"><span>*</span>车系名称</label>
                        <el-input class="row-item-el-input" v-model="carseries  " placeholder="请输入车系名称"></el-input>
                    <div class="form-input-error" v-if="error.carseries">{{error.carseries}}</div>
                    </div>
                    <div class="form-row-item">
                        <label class="row-item-title"><span>*</span>参考报价</label>
                        <div class="row-2-price flex-start-center">
                            <el-input 
                                class="row-price-input" 
                                v-model="pricelow" 
                                placeholder="请输入金额"
                            ></el-input>
                            <span>至</span>
                            <el-input 
                                class="row-price-input" 
                                v-model="pricehigh" 
                                placeholder="请输入金额"
                            ></el-input>
                            <label>万元</label>
                        </div>
                        <div class="form-input-error" v-if="error.pricelow || error.pricehigh">必须输入参考报价</div>
                    </div>
                </div>

                <div class="content-form-row flex-start-center form-row-3">
                    <div class="form-row-item">
                        <label class="row-item-title"><span>*</span>车型款数</label>
                        <el-input class="row-item-el-input" v-model="uploadList.length" placeholder="请输入车型款数" :disabled="true"></el-input>
                    </div>
                    <div class="form-row-item">
                        <label class="row-item-title"><span>*</span>排序</label>
                        <el-input class="row-item-el-input" v-model="serialnumber" placeholder="请输入排序"></el-input>
                        <div class="form-input-error" v-if="error.serialnumber">{{error.serialnumber}}</div>
                    </div>
                </div>
            </div>

            <div class="main-content-form content-form-2">
                <div class="content-form-title">车辆图片 <span v-if="error.uploadList">*{{error.uploadList}}</span></div>
                <div class="content-form-upload">
                    <div 
                        class="form-upload-item"
                        v-bind:class="{ 'upload-item-error': upload.isError }"
                        v-for="(upload, key) in uploadList"
                        :key="key"
                    >
                        <div class="upload-item-del" @click="delUpload(key)">
                            <i class="el-icon-close"></i>
                        </div>
                        <el-upload
                            :ref="'upload' + key"
                            class="avatar-uploader"
                            action="${basePath}appupload"
                            :multiple="false"
                            :show-file-list="false"
                            list-type="picture"
                            :limit="1"
                            :disabled="upload.imageProgress"
                            :before-upload="uploadeImageBefore"
                            :on-progress="function () { uploadeImageProgress(key) }"
                            :on-success="function (response) { uploadeImageSuccess(response, key) }"
                        >
                            <img v-if="upload.image" :src="'${basePath}' + upload.imageUrl" class="avatar">
                            <i v-else-if="upload.imageProgress" class="el-icon-loading avatar-uploader-icon"></i>
                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                        </el-upload>
                        <div class="form-upload-describe form-upload-color flex-start-center">
                            <label class="row-item-title"><span>*</span>颜色</label>
                            <el-color-picker v-model="upload.color"></el-color-picker>
                        </div>
                        <div class="form-upload-describe form-upload-sort flex-start-center">
                            <label class="row-item-title"><span>*</span>排序</label>
                            <el-input class="row-item-el-input" v-model="upload.serialnumber" placeholder="请输入排序"></el-input>
                        </div>
                        
                    </div>
                    <div class="form-upload-add flex-center" @click="addUpload">
                        <i class="el-icon-plus avatar-uploader-icon"></i>
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
        cid: '', // 选中的车商
        brand: '', // 品牌
        carServers: [ // 车商列表
            {
                value: '1',
                label: '车商一',
            }
        ],

        carseries: '', // 车系名称

        pricelow: '', // 参考报价
        pricehigh: '', // 参考报价

        cartype: '', // 车型款数
        serialnumber: '', // 排序

        uploadList: [
            {
                image: '', // 图片的名称
                imageUrl: '', // 图片地址
                imageProgress: false, // 图片是否正在上传
                color: '', // 颜色
                serialnumber: '', // 排序
                isError: false // 是否有误 (页面上用于判断必填)
            }
        ],
        
        error: { // 错误提示
            cid: '',
            brand: '', // 品牌
            carseries: '',
            pricelow: '',
            pricehigh: '',
            cartype: '',
            serialnumber: '',
            uploadList: '',
        }
    },

    mounted: function showError() {
        var _this = this;
        // 检测页面是否处于单点登录状态
        this.getIsActive();

    	// 车系
    	var	modifyCarseries = ${modifyCarseries == null ? false : modifyCarseries };
        // 车型
    	var	modifyCarTypeInfo = ${modifyCarTypeInfo == null ? false : modifyCarTypeInfo };
    	// 编辑的情况下
    	if (modifyCarseries) {
            // 车系初始化
    		this.cid = modifyCarseries.cardealername; // 归属车商
    		this.carServers = [{ // 归属车商可选列表
                value: modifyCarseries.cardealername,
                label: modifyCarseries.cardealername,
            }];
    		this.brand = modifyCarseries.brand; // 品牌
    		this.carseries = modifyCarseries.carseries; // 车系名称
    		this.pricelow = modifyCarseries.pricelow; // 参考报价
    		this.pricehigh = modifyCarseries.pricehigh; // 参考报价
    		this.serialnumber = modifyCarseries.serialnumber; // 排序
            // 车型初始化
            if (modifyCarTypeInfo.length > 0) {
                this.uploadList = modifyCarTypeInfo.map(function (val) {
                    return {
                    	id: val.id, // 唯一标识 id (仅在试驾车型配置编辑的情况下才有)
                    	carseriesid: val.carseriesid, // 车型 id (仅在试驾车型配置编辑的情况下才有)
                        image: val.image, // 图片的名称
                        imageUrl: 'img/' + val.image, // 图片地址
                        imageProgress: false, // 图片是否正在上传
                        color: val.color, // 颜色
                        serialnumber: val.serialnumber, // 排序
                        isError: false // 是否有误 (页面上用于判断必填)
                    }
                });
            } else {
                this.uploadList = [];
            }
    	} else { // 新增的情况下
            $.ajax({ // 初始化车商列表
    			type : "get",
    			url : "/appgetcardealernamelist",
    			success : function(response) {
    				if (response.list  && response.list.length > 0) {
                        var myCarServers = [];
        				response.list.map(function (val) {
                            myCarServers.push({
        						value: val,
        						label: val

                            });
        				});
                        _this.carServers = myCarServers;
        				_this.cid = _this.carServers[0].value; // 选中的车商
    				} else {
        				alert("车商用户数据为空");
    				}
    			},
    			error : function(error){
    				alert("获取车商数据发生错误, 原因:" + error);
    			}
    		});
        	
        }
    },
    
    /**
     * 表单输入校验监听
     */
    watch: {
        cid: function cid() { this.verify() },
        brand: function brand() { this.verify() },
        carseries: function carseries() { this.verify() },
        pricelow: function pricelow() { this.verify() },
        pricehigh: function pricehigh() { this.verify() },
        cartype: function cartype() { this.verify() },
        serialnumber: function serialnumber() { this.verify() },
        uploadList: {
    　　　　handler: function handler() { this.verify() },
    　　　　deep: true
    　　}
    },

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
                            window.location.href ='/';
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

        addUpload: function addUpload() {
            this.uploadList.push({
                image: '', // 图片的名称
                imageUrl: '', // 图片地址
                imageProgress: false, // 图片是否正在上传
                color: '', // 颜色
                serialnumber: '', // 排序
                isError: false // 是否有误 (页面上用于判断必填)
            });
        },

        delUpload: function delUpload(key) {
            let myuploadList = this.uploadList.concat([]);
            if (myuploadList.length <= 1) {
                return alert('不能删除此项');
            }
            if (confirm('你确定要删除此项目吗?')) {
                myuploadList.splice(key ,1);
                this.uploadList = myuploadList;
            }
        },

        /**
         * 上传图片之前
         */
        uploadeImageBefore: function uploadeImageBefore(file, key) {
            if (file.size > 1000000) {
                alert('图片大小不能大于1Mb');
                return false 
            }
        },

        /**
         * 正在上传图片
         */
        uploadeImageProgress: function uploadeImageProgress(key) {
            let myuploadList = this.uploadList.concat([]);
            myuploadList[key].imageProgress = true;
            myuploadList[key].image = '';
            myuploadList[key].imageUrl = '';
            this.uploadList = myuploadList;
        },

        /**
         * 上传图片成功
         */
        uploadeImageSuccess: function uploadeImageSuccess(response, key) {
            this.$refs['upload' + key][0].clearFiles();
            let myuploadList = this.uploadList.concat([]);
            myuploadList[key].imageProgress = false;
            myuploadList[key].image = response.imageName;
            myuploadList[key].imageUrl = 'tempfile/' + response.imageName;
            this.uploadList = myuploadList;
        },

        /**
         * 校验
         */
        verify: function verify() {
            var myConsequencer = []; // 不等于 1 表示有错误

            if (this.cid === '') {
                this.error.cid = '必须选择归属车商';
                myConsequencer.push('必须选择归属车商');
            } else {
                this.error.cid = '';
            }
            
            if (this.brand === '') {
                this.error.brand = '品牌不能为空';
                myConsequencer.push('品牌不能为空');
            } else {
                this.error.brand = '';
            }

            if (this.carseries === '') {
                this.error.carseries = '车系名称不能为空';
                myConsequencer.push('车系名称不能为空');
            } else {
                this.error.carseries = '';
            }

            if (this.pricelow === '') {
                this.error.pricelow = '最低参考报价不能为空';
                myConsequencer.push('最低参考报价不能为空');
            } else {
                this.error.pricelow = '';
            }

            if (this.pricehigh === '') {
                this.error.pricehigh = '最高参考报价不能为空';
                myConsequencer.push('最高参考报价不能为空');
            } else {
                this.error.pricehigh = '';
            }

            if (this.serialnumber === '') {
                this.error.serialnumber = '必须输入排序';
                myConsequencer.push('必须输入排序');
            } else if (/^[0-9]*$/.test(this.serialnumber) === false) {
                this.error.serialnumber = '输入排序必须为纯数字';
                myConsequencer.push('输入排序必须为纯数字');
            } else {
                this.error.serialnumber = '';
            }

            // 计算图片上传量
            var uploadCount = 0;
            for (var i = 0; i < this.uploadList.length; i++) {
                if (
                    this.uploadList[i].image !== '' &&
                    this.uploadList[i].color !== '' &&
                    this.uploadList[i].serialnumber !== '' 
                ) { // 
                    uploadCount++
                    this.uploadList[i].isError = false; 
                } else {
                    this.uploadList[i].isError = true; 
                    myConsequencer.push('请完善图片信息');
                }
            }

            if (uploadCount > 0) {
                this.error.uploadList = '';
            } else {
                this.error.uploadList = '至少完善一张车辆图片';
                myConsequencer.push('至少完善一张车辆图片');
            }

            if (myConsequencer.length === 0) { // 表示没有任何错误
                return Consequencer.success();
            } else { // 信息有误
                return Consequencer.error('error', 110, myConsequencer);
            }
        },

        /**
         * 提交保存数据
         */
        submit: function submit() {
            var myVerify = this.verify();
            if (myVerify.result !== 1) { // 如果验证失败
                // 循环提示报错
                for (var i = 0; i < myVerify.data.length; i++) { // 最多提示5条
                    return this.$message({
                        message: myVerify.data[i],
                        type: 'warning'
                    });
                }
            }

            var data = { 
                carSeries: {
                    // amount: this.uploadList.length,
                    brand: this.brand,
                    cardealername: this.cid,
                    carseries: this.carseries,
                    pricelow: this.pricelow,
                    pricehigh: this.pricehigh,
                    serialnumber: this.serialnumber,
                },
                carTypeInfo: this.uploadList.map(function (val) {
                    var myUploadItem = {
                        color: val.color,
                        image: val.image,
                        serialnumber: val.serialnumber
                    }

                    // 如果存在 id 的情况下才赋值进去
                    if (val.carseriesid && val.id) {
                        myUploadItem.id = val.id;
                        myUploadItem.carseriesid = val.carseriesid;
                    }

                    return myUploadItem
                })
            }

            // 如果 url 存在 id 表示 修改
            var pageVar = loadPageVar('id');
            if (pageVar) {
            	data.carSeries.id = pageVar;
            }

            $.ajax({
    			type : "POST",
    			url : "/appaddcarseries",
    			data : JSON.stringify(data),
    			contentType : "application/json",
    			dataType : "json",
    			success : function(response) {
    				if (response.result === 'success') {
    					window.location.href = '/appcarconfig?currentPage=0';
    				} else {
    					// alert(response.message ? response.message : '删除失败!');
    				}
    			},
    			error : function(){
    				alert("错误");
    			}
    		});
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
