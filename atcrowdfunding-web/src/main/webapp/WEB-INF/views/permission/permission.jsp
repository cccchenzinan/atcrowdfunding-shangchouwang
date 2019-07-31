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
<link rel="stylesheet" href="${ctx}/static/css/doc.min.css">
<link rel="stylesheet" href="${ctx}/static/ztree/zTreeStyle.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}
</style>
</head>

<body>
<%pageContext.setAttribute("title","权限维护"); %>
	<!-- 顶部导航 -->
	<%@include file="/include/top-nav.jsp"%>


	<div class="container-fluid">
		<div class="row">


			<!-- 侧边栏 -->
			<%@include file="/include/side-bar.jsp"%>




			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-th-list"></i> 权限权限列表
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	  <!-- 权限添加模态框 -->
	<div class="modal fade" id="permissionAddModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">权限添加</h4>
	      </div>
	      <div class="modal-body">
	      	<form id="permissionAddForm">
		      	<input name="pid" type="hidden">
		       	<!--  pid  name   icon   url      -->
		       	<div class="form-group">
				    <label>权限名称</label>
				    <input type="text" class="form-control" name="title">
				 </div>
				 <div class="form-group">
				    <label>权限图标</label>
				    <input type="text" class="form-control" name="icon">
				 </div>
				 <div class="form-group">
				    <label>权限标识</label>
				    <input type="text" class="form-control" name="name">
				 </div>
	      	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="savePermissionBtn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
		<!-- 权限分配菜单模态框 -->
	<div class="modal fade" id="permissionRoleAssignModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">权限可操作的菜单</h4>
	      </div>
	      <div class="modal-body">
	      		<!-- 准备一个菜单树 -->
	      		<ul class="ztree" id="menuTree"></ul>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="updatePermissionMenuBtn">修改</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 权限修改模态框 -->
	<div class="modal fade" id="permissionUpdateModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">权限修改</h4>
	      </div>
	      <div class="modal-body">
	       	<form id="permissionUpdateForm">
	       		<input name="id" type="hidden">
		      	<input name="pid" type="hidden">
		       	<!--  pid  name   icon   url      -->
		       	<div class="form-group">
				    <label>权限名称</label>
				    <input type="text" class="form-control" name="title">
				 </div>
				 <div class="form-group">
				    <label>权限图标</label>
				    <input type="text" class="form-control" name="icon">
				 </div>
				 <div class="form-group">
				    <label>权限标识</label>
				    <input type="text" class="form-control" name="name">
				 </div>
	      	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="updatePermissionBtn">修改</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<%@include file="/include/common-js.jsp"%>
	
	<!-- 获取和展示菜单的整个树 -->
	<script type="text/javascript">
		var menuZtreeObj = null;
		$(function(){
			initMenuTree();
		});
	    //初始化菜单树
	    function initMenuTree(){
	    	//1、导入js和css
	        //2、准备好树形节点；
	        //3、显示在ul里面
	    	var setting = {
	    			data: {
	    				simpleData: {
	    					enable: true,
	    					pIdKey: "pid",
	    				},
	    				key:{
	    					url: "haha"
	        			}
	    			},
	    			view:{
	    				addDiyDom: showMyIcon//显示自定义图标
	        		},
	        		check: {
	    				enable: true
	    			}
	    	};
	    	var zNodes = null;
	    	$.get("${ctx}/menu/list",function(data){
	    		zNodes = data;
	    		zNodes.push({id:0,name:"系统权限菜单"});//给数组添加一个数据
	    		menuZtreeObj = $.fn.zTree.init($("#menuTree"), setting, zNodes);
	    		menuZtreeObj.expandAll(true);
	        });
	    	
	    }
	</script>
	<SCRIPT type="text/javascript">
	var ztreeObj=null;
		$(function() {
			initPermissionTree();
		});
		//自定义显示图标的回调函数，要显示每个节点的时候都会被调用
		function showMyIcon(treeId,treeNode){
			//treeId:需要显示自定义控件的节点JSON数据对象，整个树ul的id
			//treeNode:当前节点；
			//treeSemo_1_ico：时图标的元素的id
			//treeDemo_1_span:是显示文本的元素的id
		var tId=treeNode.tId;
		var iconSpan=$("<span class='"+treeNode.icon+"'></span>")
		//父标签在展开收缩的时候class的值会改变，导致图标消失
		//$("#"+tId+"_ico").removeClass().addCladd(treeNode.icon);
		//清空原来默认样式
			$("#"+tId+"_ico").removeClass();
		//追加自定义图标
			$("#"+tId+"_ico").after(iconSpan);
		}	
		//showCrudBtnGroup显示自定义的按钮组
		function showCrudBtnGroup(treeId, treeNode) {
			console.log(treeNode);
			var addBtn = $("<button permissionid='"+treeNode.id+"' title='添加' class='btn btn-success btn-xs glyphicon glyphicon-plus'></button> ");
			var deleteBtn = $("<button permissionid='"+treeNode.id+"' title='删除' class='btn btn-danger btn-xs glyphicon glyphicon-minus'></button> ");
			var updateBtn = $("<button permissionid='"+treeNode.id+"' title='修改' class='btn btn-primary btn-xs glyphicon glyphicon-pencil'></button> ")
			var assignMenuBtn = $("<button permissionid='"+treeNode.id+"' title='分配菜单' class='btn btn-info btn-xs glyphicon glyphicon-th-list'></button> ")
			var tid = treeNode.tId;
			var btnGroup = $("<span id='"+tid+"_btngroup' class='curdBtnGroup'></span>");

			var length = 0;
			try {
				length = treeNode.children.length;
			} catch (e) {
				length = 0;
			}
			if (treeNode.pid == 0 && length > 0) {
				//1、当前元素是父权限，并且有子元素；只显示 + *
				btnGroup.append(addBtn).append(" ").append(updateBtn);
			} else if (treeNode.pid == 0 && length == 0) {
				//2、当前元素是父权限，并且没有有子元素；只显示 + - *
				btnGroup.append(addBtn).append(" ").append(updateBtn).append(" ").append(deleteBtn);
			} else if (treeNode.pid > 0) {
				//3、当前元素是子权限，显示 - *
				btnGroup.append(deleteBtn).append(" ").append(updateBtn).append(" ").append(assignMenuBtn);
			} else if (treeNode.id == 0) {
				btnGroup.append(addBtn);
			}
			if ($("#" + tid + "_a").nextAll("#" + tid + "_btngroup").length == 0) {
				$("#" + tid + "_a").after(btnGroup);
			};
		}
		//删除按钮
		function removeCrudBtnGroup(treeId, treeNode) {
			//鼠标移出删除按钮
			var tid = treeNode.tId;
			$("#" + tid + "_a").nextAll("#" + tid + "_btngroup").remove();
		}
		//初始化权限项
		function initPermissionTree() {
			var setting = {
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
					//自定义按钮
					addHoverDom : showCrudBtnGroup,
					//移除自定义的按钮
					removeHoverDom : removeCrudBtnGroup
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
	</SCRIPT>
	
	
	<!-- 权限的crud -->
  	<script type="text/javascript">
		$("#treeDemo").on("click",".curdBtnGroup",function(e){
			//layer.msg("6666")
			//console.log();
			var target = e.target;//传入的是当前被点击的元素
			if($(target).hasClass("btn-success")){
				addPermission($(target).attr("permissionid"));
			}
			if($(target).hasClass("btn-primary")){
				updatePermission($(target).attr("permissionid"));
			}
			if($(target).hasClass("btn-danger")){
				detelePermission($(target).attr("permissionid"));
			}
			if($(target).hasClass("btn-info")){
				assignPermissionsMenu($(target).attr("permissionid"));
			}
		});

		//打开给权限分配菜单的模态框
		function assignPermissionsMenu(permissionid){
			globalPermissionId = permissionid;
			//0、回显当前权限能操作的菜单
			$.get("${ctx}/menu/permisson/get?pid="+permissionid,function(data){
				//console.log(data);
				$.each(data,function(){
					//找到ztree中id为我们指定值得节点
					var treeNode = menuZtreeObj.getNodeByParam("id", this.id, null);
					menuZtreeObj.checkNode(treeNode, true, false);
				});
			});
			
			//1、打开菜单树的模态框；
			$("#permissionRoleAssignModal").modal({
				show:true,backdrop:'static'
			})
		}
		//给权限分配菜单
		$("#updatePermissionMenuBtn").click(function(){
			var checkedNode = menuZtreeObj.getCheckedNodes(true);
			var menuIds = "";
			$.each(checkedNode,function(){
				if(this.id!=0){
					menuIds += this.id+",";
				}
			});
			//layer.msg("所有选中的菜单："+menuIds+"==》权限id："+globalPermissionId)
			//发送请求进行保存
			$.post("${ctx}/menu/permisson/save",{"permissionId":globalPermissionId,"menuIds":menuIds},function(data){
				if(data =="ok"){
					layer.msg("权限的菜单分配完成...");
					//关闭模态框
					$("#permissionRoleAssignModal").modal("hide");
				}
			});
		});
		
		
		
		function addPermission(permissionid){
			//0、刚才点击的那个节点的id，是作为父权限pid的值
			$("#permissionAddModal input[name='pid']").val(permissionid);
			//1、打开权限添加的模态框
			$("#permissionAddModal").modal({
				show:true,
				backdrop:'static'
			})
		}

		function updatePermission(permissionid){
			//0、去数据库查出这个权限的信息，并进行回显
			$.get("${ctx}/permission/get?id="+permissionid,function(data){
				//回显模态框内容
				$("#permissionUpdateForm input[name='id']").val(data.id);
				$("#permissionUpdateForm input[name='pid']").val(data.pid);
				$("#permissionUpdateForm input[name='title']").val(data.title);
				$("#permissionUpdateForm input[name='icon']").val(data.icon);
				$("#permissionUpdateForm input[name='name']").val(data.name);
			})
			
			//1、打开权限修改的模态框
			$("#permissionUpdateModal").modal({
				show:true,
				backdrop:'static'
			})
		}

		function detelePermission(permissionid){
			layer.confirm("确认删除【id为："+permissionid+"】吗？",{icon: 3, title:'删除提示'},function(){
				//确定的回调函数
				$.get("${ctx}/permission/delete?id="+permissionid,function(){
					layer.msg("删除成功");
					initPermissionTree();
				});
			},
			function(){
				//取消的毁掉函数
				layer.msg("权限删除已经取消....");
			}
		);
		}


		//保存权限
		$("#savePermissionBtn").click(function(){
			$.post("${ctx}/permission/add",$("#permissionAddForm").serialize(),function(data){
				layer.msg("保存成功");
				$("#permissionAddModal").modal("hide");
				//刷新列表
				initPermissionTree();
			});
		});

		//修改权限
		$("#updatePermissionBtn").click(function(){
			$.post("${ctx}/permission/update",$("#permissionUpdateForm").serialize(),function(data){
				layer.msg("权限修改成功。。。")
				$("#permissionUpdateModal").modal("hide");
				//刷新列表
				initPermissionTree();
			})

		});
		
		
  	</script>
</body>
</html>
