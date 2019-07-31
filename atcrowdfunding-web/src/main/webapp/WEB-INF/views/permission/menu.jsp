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
<%pageContext.setAttribute("title","菜单维护"); %>
	<!-- 顶部导航 -->
	<%@include file="/include/top-nav.jsp"%>


	<div class="container-fluid">
		<div class="row">


			<!-- 侧边栏 -->
			<%@include file="/include/side-bar.jsp"%>




			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
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
	  <!-- 菜单添加模态框 -->
	<div class="modal fade" id="menuAddModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">菜单添加</h4>
	      </div>
	      <div class="modal-body">
	      	<form id="menuAddForm">
		      	<input name="pid" type="hidden">
		       	<!--  pid  name   icon   url      -->
		       	<div class="form-group">
				    <label>菜单名称</label>
				    <input type="text" class="form-control" name="name">
				 </div>
				 <div class="form-group">
				    <label>菜单图标</label>
				    <input type="text" class="form-control" name="icon">
				 </div>
				 <div class="form-group">
				    <label>菜单路径</label>
				    <input type="text" class="form-control" name="url">
				 </div>
	      	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="saveMenuBtn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 菜单修改模态框 -->
	<div class="modal fade" id="menuUpdateModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">菜单修改</h4>
	      </div>
	      <div class="modal-body">
	       	<form id="menuUpdateForm">
	       		<input name="id" type="hidden">
		      	<input name="pid" type="hidden">
		       	<!--  pid  name   icon   url      -->
		       	<div class="form-group">
				    <label>菜单名称</label>
				    <input type="text" class="form-control" name="name">
				 </div>
				 <div class="form-group">
				    <label>菜单图标</label>
				    <input type="text" class="form-control" name="icon">
				 </div>
				 <div class="form-group">
				    <label>菜单路径</label>
				    <input type="text" class="form-control" name="url">
				 </div>
	      	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="updateMenuBtn">修改</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<%@include file="/include/common-js.jsp"%>
	<SCRIPT type="text/javascript">
	var ztreeObj=null;
		$(function() {
			initMenuTree();
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
		function showCrudBtnGroup(treeId, treeNode){
			console.log(treeNode);
			var addBtn = $("<button menuid='"+treeNode.id+"' title='添加' class='btn btn-success btn-xs glyphicon glyphicon-plus'></button> ");
			var deleteBtn = $("<button menuid='"+treeNode.id+"' title='删除' class='btn btn-danger btn-xs glyphicon glyphicon-minus'></button> ");
			var updateBtn = $("<button menuid='"+treeNode.id+"' title='修改' class='btn btn-primary btn-xs glyphicon glyphicon-pencil'></button> ")
			var tid = treeNode.tId;
			var btnGroup = $("<span id='"+tid+"_btngroup' class='curdBtnGroup'></span>");

			var length = 0;
			try{
				length = treeNode.children.length;
			}catch(e){
				length = 0;
			}
			

			
			if(treeNode.pid == 0&& length>0){
				//1、当前元素是父菜单，并且有子元素；只显示 + *
				btnGroup.append(addBtn).append(updateBtn);
			}else if(treeNode.pid == 0&& length == 0){
				//2、当前元素是父菜单，并且没有有子元素；只显示 + - *
				btnGroup.append(addBtn).append(updateBtn).append(deleteBtn);
			}else if(treeNode.pid > 0){
				//3、当前元素是子菜单，显示 - *
				btnGroup.append(deleteBtn).append(updateBtn);
			}else if(treeNode.id==0){
				btnGroup.append(addBtn);
			}
			
			if($("#"+tid+"_a").nextAll("#"+tid+"_btngroup").length==0){
				$("#"+tid+"_a").after(btnGroup);
			};
		}
		
	function removeCrudBtnGroup(treeId,treeNode){
		var tid= treeNode.tId;
		$("#"+tid+"_a").nextAll("#"+tid+"_btngroup").remove();
	}
		
		
		//初始化菜单项
		function initMenuTree() {
			var setting = {
				data : {
					simpleData : {
						enable : true,
						pIdKey:"pid",
					},
					key:{
						url:".."
					}
				},
				view:{
					//自定义图标
					addDiyDom:showMyIcon,
					//自定义按钮
					addHoverDom:showCrudBtnGroup,
					//移除自定义的按钮
					removeHoverDom:removeCrudBtnGroup
				}
			};
			var zNodes = null;
			$.get("${ctx}/menu/list", function(data) {
				zNodes = data;
				//给数组添加一个数据
				zNodes.push({id:0,name:"系统权限菜单"});
				//将zNode展示在id为treeDome的ul里面
				ztreeObj=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				//将整个ztree展开
				ztreeObj.expandAll(true);
			});

		}
	</SCRIPT>
	
	
	<!-- 菜单的crud -->
  	<script type="text/javascript">
		$("#treeDemo").on("click",".curdBtnGroup",function(e){
			//layer.msg("6666")
			//console.log();
			var target = e.target;//传入的是当前被点击的元素
			if($(target).hasClass("btn-success")){
				addMenu($(target).attr("menuid"));
			}
			if($(target).hasClass("btn-primary")){
				updateMenu($(target).attr("menuid"));
			}
			if($(target).hasClass("btn-danger")){
				deteleMenu($(target).attr("menuid"));
			}
			
		});

		function addMenu(menuid){
			//0、刚才点击的那个节点的id，是作为父菜单pid的值
			$("#menuAddModal input[name='pid']").val(menuid);
			//1、打开菜单添加的模态框
			$("#menuAddModal").modal({
				show:true,
				backdrop:'static'
			})
		}

		function updateMenu(menuid){
			//0、去数据库查出这个菜单的信息，并进行回显
			$.get("${ctx}/menu/get?id="+menuid,function(data){
				//回显模态框内容
				$("#menuUpdateForm input[name='id']").val(data.id);
				$("#menuUpdateForm input[name='pid']").val(data.pid);
				$("#menuUpdateForm input[name='name']").val(data.name);
				$("#menuUpdateForm input[name='icon']").val(data.icon);
				$("#menuUpdateForm input[name='url']").val(data.url);
			})
			
			//1、打开菜单修改的模态框
			$("#menuUpdateModal").modal({
				show:true,
				backdrop:'static'
			})
		}

		function deteleMenu(menuid){
			layer.confirm("确认删除【id为："+menuid+"】吗？",{icon: 3, title:'删除提示'},function(){
				//确定的回调函数
				$.get("${ctx}/menu/delete?id="+menuid,function(){
					layer.msg("删除成功");
					initMenuTree();
				});
			},
			function(){
				//取消的毁掉函数
				layer.msg("菜单删除已经取消....");
			}
		);
		}


		//保存菜单
		$("#saveMenuBtn").click(function(){
			$.post("${ctx}/menu/add",$("#menuAddForm").serialize(),function(data){
				layer.msg("保存成功");
				$("#menuAddModal").modal("hide");
				//刷新列表
				initMenuTree();
			});
		});

		//修改菜单
		$("#updateMenuBtn").click(function(){
			$.post("${ctx}/menu/update",$("#menuUpdateForm").serialize(),function(data){
				layer.msg("菜单修改成功。。。")
				$("#menuUpdateModal").modal("hide");
				//刷新列表
				initMenuTree();
			})

		});
		
		
  	</script>
</body>
</html>
