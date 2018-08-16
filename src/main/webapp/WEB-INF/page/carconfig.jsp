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
    <link href="./appointment.css" rel="stylesheet" />
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
                    <el-breadcrumb-item><a href="/appcarconfig?currentPage=0&fuzzy=">首页</a></el-breadcrumb-item>
                    <el-breadcrumb-item><a href="/appcarconfig?currentPage=0&fuzzy=">试驾车型配置</a></el-breadcrumb-item>
                </el-breadcrumb>
            </div>

            <div class="main-content-operation flex-start-center">
                <div class="content-operation-left flex-rest">
                    <a href="/appcarconfigedit">
                        <el-button type="primary" icon="el-icon-plus">新建</el-button>
                    </a>
                    <el-button>导出</el-button>
                </div>
                <div class="content-operation-right flex-start-center">
                    <div class="operation-right-select">
                        <div style="display: none;">
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
                        prop="cardealername"
                        label="车商名称"
                    ></el-table-column>
                    <el-table-column
                        prop="brand"
                        label="品牌"
                    ></el-table-column>
                    <el-table-column
                        prop="carseries"
                        label="车系"
                    ></el-table-column>
                    <el-table-column
                        prop="price"
                        label="参考报价"
                    ></el-table-column>
                    <el-table-column
                        prop="serialnumber"
                        label="车型数量"
                    ></el-table-column>
                    <el-table-column
                      fixed="right"
                      label="执行操作"
                    >
                      <template slot-scope="scope">
                        <el-button 
                            @click="handleModifier(scope.row)"
                            type="text" 
                            size="small"
                        >修改</el-button>
                      	<div style="display: inline-block; padding-left: 15px;" v-if="${category } !== 2">
                            <el-button 
                                @click="handleDeleter(scope.row)"
                                type="text" 
                                size="small"
                            >删除</el-button>
                      	</div>
                      </template>
                    </el-table-column>
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

        search: '', // 关键字搜索

        tableData: [
            // {
            //     cardealername: 'xxx服务门店',
            //     brand: '宝马',
            //     carseries: '宝马X3',
            //     price: '23.45-40.8 万元',
            //     serialnumber: '6',
            // }
        ],

        currentPage: loadPageVar('currentPage') ? (parseInt(loadPageVar('currentPage')) + 1) : 1, // 当前的页面
        pagesize: 15, // 当前页面显示多少条数据
        pagetotal: ${total }, // 一共多少条数据
    },
    
    watch: {
    	currentPage: function (newCurrentPage, oldCurrentPage) {
			this.handleCurrentChange(newCurrentPage);
    	}
   	},

    mounted: function mounted() {
		if (${carSeriesInfo}[0]) {
	    	this.tableData = ${carSeriesInfo}.map(function (val, key) {
                val.price = '' + val.pricelow + ' - ' + val.pricehigh + '万元';
	        	return val
	        });
		}
    },

    methods: {
        /**
         * 修改试驾车型
         */
        handleModifier: function handleModifier(row) {
			window.location.href = '/appmodifycarseries?id=' + row.id;
        },
        /**
         * 删除试驾车型
         */
        handleDeleter: function handleDeleter(row) {
        	var _this = this;
        	if(!confirm("确认要删除么？")){
    			return false;
    		};
            $.ajax({
    			type : "get",
    			url : "/appdeletecarseries?id=" + row.id,
    			success : function(response) {
    				if (response.result === 'success') {
    					window.location.href ='/appcarconfig?currentPage=' + (_this.currentPage - 1);
    				} else {
    					// alert(response.message ? response.message : '删除失败!');
    				}
    			},
    			error : function(){
    				alert("错误");
    			}
    		});
        },

        /**
        * 列表页改变时候调用的函数
        */
        handleCurrentChange: function handleSizeChange(currentPage) {
			window.location.href ='/appcarconfig?currentPage=' + (currentPage - 1);
        },
    }
}

function loadPageVar(sVar) { 
    return decodeURI(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURI(sVar).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1")); 
} 
</script>

</body>
</html>
