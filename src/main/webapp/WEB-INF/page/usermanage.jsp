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
    <link href="./user.css" rel="stylesheet" />
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
                    </el-breadcrumb>
                </div>
                <div class="content-operation-right flex-start-center">
	                <a href="/appusermanageedit" v-if="${category } !== 2" >
	                    <el-button type="primary" icon="el-icon-plus">新建用户</el-button>
	                </a>
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
                        prop="username"
                        label="用户名"
                    ></el-table-column>
                    <el-table-column
                        prop="category"
                        label="用户角色"
                    ></el-table-column>
                    <el-table-column
                        prop="cardealername"
                        label="关联车商"
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
            // {
            // 	username: 'admin',
            //     password: '******',
            //     category: '2006-01-01',
            //     cardealername: '关联车商',
            // }
        ],

        currentPage: loadPageVar('currentPage') ? (parseInt(loadPageVar('currentPage')) + 1) : 1, // 当前的页面
        pagesize: 15, // 当前页面显示多少条数据
        pagetotal: ${total }, // 一共多少条数据
    },

    mounted: function mounted() {
        
    	this.tableData = ${userInfo}.map(function (val, key) {
        	if (val.category === 0){
        		val.category = "超级管理员";
        	} else if (val.category === 1){
        		val.category = "管理员";
        	} else if (val.category === 2){
        		val.category = "车商";
        	}
        	val.index = key;
        	return val
        });
    },
    watch: {
    	currentPage: function (newCurrentPage, oldCurrentPage) {
			this.handleCurrentChange(newCurrentPage);
    	}
   	},
    methods: {
        /**
        * 修改用户
        */
        handleModifier: function handleModifier(row) {
        	var myCategory = row.category;
        	var myUsername = row.username;
        	
        	// 登录用户 是 管理员
        	if (${category } === 1) {
        		// 如果目标用户是超级管理员
        		if (myCategory === '超级管理员') {
               		return alert('你不能修改超级管理员的信息');
        		}

        		// 如果目标也是管理员 则 自己只能修改自己,不能修改其他管理员
        		if (myCategory === '管理员' && myUsername !== '${username }') {
                	return alert('你不能修改其他管理员的信息');
        		}
        	}
        	
			window.location.href = '/appmodifyuser?id=' + row.id;
        },
        /**
        * 删除用户
        */
        handleDeleter: function handleDeleter(row) {
        	var myCategory = row.category;
        	var myUsername = row.username;
        	
        	// 登录用户 是 超级管理员
        	if (${category } === 0 && myCategory === '超级管理员') {
        		return alert('不能删除超级管理员');
        	}
        	
        	// 登录用户 是 管理员
        	if (${category } === 1) {
        		// 如果目标用户是超级管理员
        		if (myCategory === '超级管理员') {
               		return alert('你不能删除超级管理员的信息');
        		}
        		
        		// 如果目标用户是管理员
        		if (myCategory === '超级管理员') {
               		return alert('你不能删除管理员的信息');
        		}
        	}
        	
        	var _this = this;
        	if(!confirm("确认要删除么？")){
    			return false;
    		};
            $.ajax({
    			type : "get",
    			url : "/appdeleteuser?id=" + row.id,
    			success : function(response) {
    				if (response.result === 'success') {
    					window.location.href ='/appusermanage?currentPage=' + (_this.currentPage - 1);
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
			window.location.href ='/appusermanage?currentPage=' + (currentPage - 1);
        }
    }

}

function loadPageVar(sVar) { 
	 return decodeURI(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURI(sVar).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1")); 
} 

</script>

</body>
</html>
