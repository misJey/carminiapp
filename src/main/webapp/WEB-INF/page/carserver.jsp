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
    <link href="./car-server.css" rel="stylesheet" />
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
                    <el-breadcrumb-item><a href="/appcarserver?currentPage=0&fuzzy=">首页</a></el-breadcrumb-item>
                    <el-breadcrumb-item><a href="/appcarserver?currentPage=0&fuzzy=">车商管理</a></el-breadcrumb-item>
                </el-breadcrumb>
            </div>

            <div class="main-content-operation flex-start-center">
                <div class="content-operation-left flex-rest">
                    <a href="/appcarserveredit" v-if="${category } !== 2">
                        <el-button type="primary" icon="el-icon-plus">新建</el-button>
                    </a>
                    <el-button>导出</el-button>
                </div>
                <div class="content-operation-right flex-start-center">
                    <div style="display: none;">
                        <el-button>开始时间</el-button>
                        <el-button>结束时间</el-button>
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
                        type="index"
                    	label="序号"    
                    >
                    </el-table-column>
                    <el-table-column
                        prop="name"
                        label="车商名称"
                    ></el-table-column>
                    <el-table-column
                        prop="brand"
                        label="品牌"
                    ></el-table-column>
                    <el-table-column
                        prop="pid"
                        label="平安网点 ID"
                    ></el-table-column>
                    <el-table-column
                        prop="contacts"
                        label="客户姓名"
                    ></el-table-column>
                    <el-table-column
                        prop="tel"
                        label="联系电话"
                    ></el-table-column>
                    <el-table-column
                        prop="address"
                        label="地址"
                    ></el-table-column>
                    <el-table-column
                        prop="time"
                        label="营业时间"
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
        search: '', // 关键字搜索

        tableData: [
            //{
            //    name: '',
            //    brand: '',
            //    pid: '',
            //    contacts: '',
            //    tel: '',
            //    address: '',
            //    time: '',
            //}
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
		if (${cardealerInfo}[0]) {
	    	this.tableData = ${cardealerInfo}.map(function (val, key) {
	            // 判断 working 和 workend 存在 才进行渲染
	            if (val && val.working && val.workend) {
	                val.time = val.working + '-' + val.workend;
	            }
	        	return val
	        });
		}
    },

    methods: {
        /**
         * 修改车商
         */
        handleModifier: function handleModifier(row) {
			window.location.href = '/appmodifycardealer?id=' + row.id;
        },
        /**
         * 删除车商
         */
        handleDeleter: function handleDeleter(row) {
        	var _this = this;
        	if(!confirm("确认要删除么？")){
    			return false;
    		};
            $.ajax({
    			type : "get",
    			url : "/appdeletecardealer?id=" + row.id,
    			success : function(response) {
    				if (response.result === 'success') {
    					window.location.href ='/appcarserver?currentPage=' + (_this.currentPage - 1);
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
			window.location.href ='/appcarserver?currentPage=' + (currentPage - 1);
        },
    }
}

function loadPageVar(sVar) { 
    return decodeURI(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURI(sVar).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1")); 
} 
</script>

</body>
</html>
