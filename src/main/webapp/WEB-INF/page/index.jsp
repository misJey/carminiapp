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
        <div class="main-content flex-rest">
            <div class="main-content-title">
                <el-breadcrumb separator="/">
                    <el-breadcrumb-item><a href="/">首页</a></el-breadcrumb-item>
                    <el-breadcrumb-item><a href="/">预约记录</a></el-breadcrumb-item>
                </el-breadcrumb>
            </div>

            <div class="main-content-operation flex-start-center">
                <div class="content-operation-left flex-rest">
                    <el-button>导出</el-button>
                </div>
                <div class="content-operation-right flex-start-center">
                    <div style="display: none;">
                        <el-button>开始时间</el-button>
                        <el-button>结束时间</el-button>
                        <div class="operation-right-select">
                            <el-select v-model="carServerSelected" placeholder="选择车商">
                                <el-option
                                    v-for="item in carServers"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                                </el-option>
                            </el-select>
                        </div>
                    </div>
                    <div class="operation-right-search">
                        <el-input
                            placeholder="关键字搜索"
                            prefix-icon="el-icon-search"
                            v-model="search">
                        </el-input>
                    </div>
                </div>
            </div>

            <div class="main-content-table">
                <el-table
                    :data="tableData"
                    border
                    style="width: 100%"
                >
                    <el-table-column
                        prop="server"
                        label="车商名称"
                    ></el-table-column>
                    <el-table-column
                        prop="brand"
                        label="车商品牌"
                    ></el-table-column>
                    <el-table-column
                        prop="carType"
                        label="预约车系"
                    ></el-table-column>
                    <el-table-column
                        prop="name"
                        label="客户姓名"
                    ></el-table-column>
                    <el-table-column
                        prop="phone"
                        label="联系电话"
                    ></el-table-column>
                    <el-table-column
                        prop="time"
                        label="预约到店时间"
                    ></el-table-column>
                    <el-table-column
                        prop="submit"
                        label="预约提交时间"
                    ></el-table-column>
                </el-table>
            </div>
            
            <div class="main-content-pagination flex-center">
                <el-pagination
                    @current-change="handleCurrentChange"
                    :current-page.sync="currentPage"
                    :page-size="pagesize"
                    layout="prev, pager, next, jumper"
                    :total="pagetotal"
                ></el-pagination>
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
        carServerSelected: '', // 选中的车商
        carServers: [ // 车商列表
            {
                value: '车商一',
                label: '车商一',
            }
        ],

        search: '', // 关键帧搜索

        tableData: [
        	{
                server: 'xxx服务门店',
                brand: '宝马',
                carType: '宝马一系',
                name: '卢佩',
                phone: '18927403415',
                time: '2018-07-17 09:00-09:30',
                submit: '2018-07-17 09:00-09:30',
            },

        ],

        currentPage: 1, // 当前的页面
        pagesize: 100, // 当前页面显示多少条数据
        pagetotal: 1000, // 一共多少条数据
    },
    
    mounted: function() {
    	var _this = this;
    	//$.get('./houtai', function(data) {
			// _this.tableData = data.tableData;
    	// })
    },

    methods: {

        /**
        * 列表页改变时候调用的函数
        */
        handleCurrentChange: function handleSizeChange() {
        
        }
    }


}
</script>
</body>
</html>
