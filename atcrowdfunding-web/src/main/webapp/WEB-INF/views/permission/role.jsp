<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet"
	href="${ctx}/static/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctx}/static/css/font-awesome.min.css">
<link rel="stylesheet" href="${ctx}/static/css/main.css">
<link rel="stylesheet" href="${ctx}/static/ztree/zTreeStyle.css">

<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
}
</style>
</head>

<body>
	<%
		pageContext.setAttribute("title", "角色维护");
	%>
	<!-- 顶部导航 -->
	<%@include file="/include/top-nav.jsp"%>



	<div class="container-fluid">
		<div class="row">



			<!-- 侧边栏 -->
			<%@include file="/include/side-bar.jsp"%>


			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input id="searchConditionInput"
										class="form-control has-success" type="text"
										placeholder="请输入查询条件">
								</div>
							</div>
							<button type="button" class="btn btn-warning" id="searchBtn">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button  id="deleteAllRoleBtn" type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;" id="openRoleAddModelBtn">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox" id="allCheckBtn"></th>
										<th>名称</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody id="content">
								
								</tbody>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination" id="pageInfoBar">
											
											</ul>
										</td>
									</tr>

								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 添加模态框 -->
	<div class="modal fade" id="roleAddModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="roleAddModalTitle">添加角色</h4>
				</div>
				<div class="modal-body">
					<form action="${ctx }/role/add" method="post" id="roleAddForm">
						<div class="form-group">
							<label>角色名</label> 
							<input type="email" class="form-control" id="rolename_input" name="name">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveRoleAddBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 修改模态框 -->
	<div class="modal fade" id="roleUpdateModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" ">修改角色</h4>
				</div>
				<div class="modal-body">
					<form action="${ctx }/role/update" method="post" id="roleUpdateForm">
						<div class="form-group">
							<label>角色名</label> 
							<input type="hidden" name="id">
							<input type="email" class="form-control" id="rolename_input" name="name">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateRoleAddBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 权限模态框-->
	<div class="modal fade" id="rolePermissionModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" ">权限维护</h4>
				</div>
				<div class="modal-body">
					<ul id="treeDemo" class="ztree"></ul>	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateRolePermissionBtn">保存</button>
				</div>
			</div>
		</div>
	</div>


	<%@include file="/include/common-js.jsp"%>

	<!-- 分页带条件查询 -->
	<script type="text/javascript">
		//页码
		var globalPn = 1;
		//每页显示项数
		var globalPs = 3;
		//总页码
		var globalCondition = "";
		var lastPage=0;
		//分页总页码
		var globalTotal=0;
		$(function() {
			//页面加载完成，
			//1、获取所有数据
			getAllRoles(globalPn, globalPs, globalCondition);
		});
		//发送请求获取数据

		//1、$get(url,function(data){data});发送get请求
		//2、$post(url,{name:"zs",age:"18"},function(data){data});发送post请求
		//3、$Ajax({}); {}可以定制请求的所有，参考jQuary文档	

		//去第pn页
		function getAllRoles(pn, ps, condition) {

			$.get("${ctx}/role/list?pn=" + pn + "&ps=" + ps + "&condition="
					+ condition, function(data) {
				lastPage=data.lastPage;
				//1、构造表格的内容
				buildTableContent(data.list);
				//2、构造分页面的内容
				buildTablePageInfo(data);
			});
		}
		//1、构造表格内容数据
		function buildTableContent(data) {
			//ajax不会刷新页面，每次请求得到的数据会直接拼接，要清空上次的表格数据
			$("#content").empty();
				$.each(data,function() {
					var id = this.id;
					var name = this.name;
					//每遍历一个数据就是一行tr，tr里面拼接过长，进行分割
					//$("<tr></tr>"): $(html字符串) 创建出这个对象
					//按钮单元对象 
					var btnTd = $("<td></td>");
					btnTd.append('<button rid="'+id+'" type="button" class="btn btn-success btn-xs rolePermissionAssignBtn"><i class=" glyphicon glyphicon-check"></i></button>');
					btnTd.append('<button rid="'+id+'" type="button" class="btn btn-primary btn-xs roleItemUpdateBtn"><i class=" glyphicon glyphicon-pencil"></i></button>');
					btnTd.append('<button rid="'+id+'" type="button" class="btn btn-danger btn-xs roleItemDeleteBtn"><i class=" glyphicon glyphicon-remove"></i></button>');
					var tr = $("<tr></tr>");
						tr.append("<td>" + id + "</td>")
						  .append("<td><input type='checkbox' id='"+id+"' class='checkItem'></td>")
						  .append("<td>" + name + "</td>")
						  .append(btnTd)
					//a.appendTo(b) 把a放到b里面
						  .appendTo($("#content"));
					//a.append(b) 给a里面放个b
					//$("#content").append(tr); 
						});
		}
		//2、构造页面的分页条 
		function buildTablePageInfo(data) {
			//清空上次的分页内容 
			$("#pageInfoBar").empty();
			//总页码数
			globalTotal = data.pages;
		//显示首页和上一页 
		var first = '<li tonum="1"><a>首页</a></li>';
		var prev = '<li tonum="'+ data.prePage +'"><a>上一页</a></li>';
		//把first追加到id为pafeInfoBar的标签中 
		$("#pageInfoBar").append(first);
		$("#pageInfoBar").append(prev);
		
		
		//1、显示连续分页
		$.each(data.navigatepageNums, function() {
			//2、判断是否是当前页 var
			var li = "";
			if (data.pageNum == this) {
				li = '<li tonum="'+this+'" class="active"><a>' + this
						+ '<span class="sr-only">(current)</span></a></li>';
			} else {
				li = '<li tonum="'+this+'"><a>' + this + '</a></li>';
			}
			$("#pageInfoBar").append(li);
		});
		//下一页和末页 
		var next = '<li tonum="'+data.nextPage+'"><a>下一页</a></li>';
		var last = '<li tonum="'+data.lastPage+'"><a>末页</a></li>';	
		$("#pageInfoBar").append(next);
		$("#pageInfoBar").append(last);
		}
		//3、给分页条的每个按钮绑上单击事件,click只能给已有的元素绑定事件，
		//ajax中拼接的按钮属于未来元素，不能用click绑定
		//$(已经存在的父及以上元素).on("click","目标元素选择器"，function(){回调函数});
		$("#pageInfoBar").on("click", "li", function() {
			//console.log(this);在浏览器控制台打印
			//$(this).prop() 获取和设置原生属性的值
			//自定义属性用attr tonum是自定义属性 var pn =$(this).attr("tonum");
			var pn = $(this).attr("tonum");
			//翻页时把页码数保存到全局参数中
			globalPn = pn;
			getAllRoles(pn, globalPs, globalCondition);
		});
		$("#searchBtn").click(function() {
			globalCondition = $("#searchConditionInput").val();
			getAllRoles(1, globalPs, globalCondition);
		})
	</script>

	<!-- 增删改角色 -->
	<script type="text/javascript">
		//增
		//点击新增打开模态框
		$("#openRoleAddModelBtn").click(function() {
			$("#roleAddModal").modal({
				//点模态框背景时模态框不会关闭
				backdrop : 'static',
				//模态框的显示与关闭
				show : true
			});
		});
		//点击保存，提交表单给服务器保存数据
		$("#saveRoleAddBtn").click(function() {
			//属性选择器
			var val = $("#roleAddForm input[name='name']").val();
			//除了ajax请求不跳转页面， 提交表单submit，点击超链接href等等都属于页面跳转方式
			//$("#roleAddForm").submit();
			
			//请求，参数，回调方法
			//在参数的位置写k=v和或者写对象都行
			$.post("${ctx}/role/add", {"name" : val}, function(data) {
				//layer.msg(data);
				if(data="ok"){
				layer.msg("角色保存成功 ");
			
				//关闭模态框
				$("#roleAddModal").modal('hide');
				//保存完置空搜索条件globalCondition 并跳到最后一页,分页总页码globalTotal+1
				globalCondition="";
				getAllRoles(globalTotal+1000,globalPs,globalCondition);
				}

			});
		});
		
		
		
		//单个删
		$("#content").on("click",".roleItemDeleteBtn",function(){
			var name=$(this).parents("tr").find("td:eq(2)").text();
			var that=this;
			deleteRole($(that).attr("rid"));
			
		});
		
		
		
		
		
		
		//1、将表头的勾选框状态设置给表格中勾选框
		$("#allCheckBtn").click(function(){
			//获取到当前这个按钮的勾选状态
			//cehcked为true为勾中
			//this是dom对象没法调用jquery方法，需要转为jquery对象
			//console.log在浏览器控制台打印详细信息
			//attr()获取标签上已写出的属性
			//prop获取标签所有的属性，只要标签的属性改变了，就可以正确的用prop获取到
			//prop只能获取html中给标签规定的属性，自定义的属性不能获取
			//var checked=$(this).prop("checked");
			//$(".checkItem").prop("checked",checked);
			
			//将表头的勾选框状态设置给表格中勾选框
			$(".checkItem").prop("checked",$(this).prop("checked"));
		});
		//2、表格单个勾选框全部勾选，则自动勾选表头的全选勾选框，否则表头勾选框不勾选
		$("#content").on("click","checkItem",function(){
			$("#allCheckBtn").prop("checked",$(".checkItem:checked").length==$(".checkItem").length)	
		});
		
		//多个删
		function deleteRole(ids){
			layer.confirm("确认删除 "+ids+" 这些人吗？",{icon:3,title:"删除提示"},function(){
				$.get("${ctx}/role/delete?ids="+ids,function(data){
					if(data=="ok"){
						layer.msg("角色删除成功")
						//回到当前页
						getAllRoles(globalPn,globalPs,globalCondition);
				  	}
				})
				},
				function(){
					layer.msg("已取消删除")
				});
		}
		
		//提交需要删除的id拼接的字符串
		$("#deleteAllRoleBtn").click(function(){
			var ids = "";
			$.each($(".checkItem:checked"),function(){
				ids += $(this).attr("rid")+",";
			});
 			deleteRole(ids);
		});
		
		//改
		$("#content").on("click",".roleItemUpdateBtn",function(){
			var rid=$(this).attr("rid");
			$.get("${ctx}/role/get?id="+rid,function(data){
				$("#roleUpdateForm input[name='id']").val(data.id);
				$("#roleUpdateForm input[name='name']").val(data.name);
				$("#roleUpdateModal").modal({
					backdrop: 'static',
					show:true
				});				
			});
		});
		

		//改完提交
		$("#updateRoleAddBtn").click(function() {
			var name = $("#roleUpdateForm input[name='name']").val();
			var id = $("#roleUpdateForm input[name='id']").val();
			$.post("${ctx}/role/update", {"id":id,"name":name}, function(data) {
				if (data == "ok") {
					layer.msg("修改成功");
					$("#roleUpdateModal").modal("hide");
					getAllRoles(globalPn,globalPs,globalCondition);
				}
			});
		});
	</script>
	<!-- 角色权限树 -->
	<script type="text/javascript">
		var ztreeObj = null;
		$(function() {
			initPermissionTree();
		});
		//初始化权限项
		function initPermissionTree() {
			var setting = {
				check:{
					enable:true
				},
				data : {
					simpleData : {
						enable : true,
						pIdKey : "pid",
					},
					key : {
						url : "..",
						name : "title"
					}
				},
				view : {
					//自定义图标
					addDiyDom : showMyIcon,
				}
			};
			var zNodes = null;
			$.get("${ctx}/permission/list", function(data) {
				zNodes = data;
				//给数组添加一个数据
				zNodes.push({
					id : 0,
					title : "系统所有权限"
				});
				//将zNode展示在id为treeDome的ul里面
				ztreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
				//将整个ztree展开
				ztreeObj.expandAll(true);
			});
		}
		//自定义显示图标的回调函数，要显示每个节点的时候都会被调用
		function showMyIcon(treeId, treeNode) {
			//treeId:需要显示自定义控件的节点JSON数据对象，整个树ul的id
			//treeNode:当前节点；
			//treeSemo_1_ico：时图标的元素的id
			//treeDemo_1_span:是显示文本的元素的id
			var tId = treeNode.tId;
			var iconSpan = $("<span class='"+treeNode.icon+"'></span>")
			//父标签在展开收缩的时候class的值会改变，导致图标消失
			//$("#"+tId+"_ico").removeClass().addCladd(treeNode.icon);
			//清空原来默认样式
			$("#" + tId + "_ico").removeClass();
			//追加自定义图标
			$("#" + tId + "_ico").after(iconSpan);
		}
		
	</script>
	<!-- 角色权限维护 -->
	<script type="text/javascript">
		var globalRid="";
		$("#content").on("click", ".rolePermissionAssignBtn", function() {
			globalRid = $(this).attr("rid");
			//查出角色权限回显
			$.get("${ctx}/permission/role/get?rid="+globalRid,function(data){
				//清空上次勾选状态
				ztreeObj.checkAllNodes(false);
				$.each(data,function(){
					//根据权限id去ztreeObj中找到这个id对应的treeNide；
					var treeNode=ztreeObj.getNodeByParam("id",this.id,null);
					//勾选要回显的数据
					ztreeObj.checkNode(treeNode,true,false);
				})
			});
			//打开模态框
			$("#rolePermissionModal").modal({
				show : true,
				backdrop : 'static'
			})
		});
	$("#updateRolePermissionBtn").click(function(){
		//1准备上次点击的角色id
		//2准备选中的权限id
		var permissionIds="";
		$.each(ztreeObj.getCheckedNodes(true),function(){
			if(this.id!=0){
				permissionIds+=this.id+",";
			}
		});
		
		$.post("${ctx}/permission/role/assign",{"rid":globalRid,"permissionIds":permissionIds},function(data){
			if(data=="ok"){
				layer.msg("分配完成");
				$("#rolePermissionModal").modal("hide");
						
			}
		});
	});
	</script>


</body>
</html>
