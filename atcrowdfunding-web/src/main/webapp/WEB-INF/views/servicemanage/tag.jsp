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
<%pageContext.setAttribute("title","项目标签"); %>
	<!-- 顶部导航 -->
	<%@include file="/include/top-nav.jsp"%>



	<div class="container-fluid">
		<div class="row">


			<!-- 侧边栏 -->
			<%@include file="/include/side-bar.jsp"%>


			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-th-list"></i> 项目标签列表
					</div>
					<div class="panel-body">
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<%@include file="/include/common-js.jsp"%>
	
	
	<script type="text/javascript">
		$(function() {
		

			var setting = {
				view : {
					selectedMulti : false,
					addDiyDom : function(treeId, treeNode) {
						var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
						if (treeNode.icon) {
							icoObj.removeClass("button ico_docu ico_open")
									.addClass(treeNode.icon).css("background",
											"");
						}
					},
					addHoverDom : function(treeId, treeNode) {
						var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
						aObj.attr("href", "javascript:;");
						if (treeNode.editNameFlag
								|| $("#btnGroup" + treeNode.tId).length > 0)
							return;
						var s = '<span id="btnGroup'+treeNode.tId+'">';
						if (treeNode.level == 0) {
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${ctx}/static/#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
						} else if (treeNode.level == 1) {
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="${ctx}/static/#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
							if (treeNode.children.length == 0) {
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${ctx}/static/#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
							}
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${ctx}/static/#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
						} else if (treeNode.level == 2) {
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="${ctx}/static/#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${ctx}/static/#">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
						}

						s += '</span>';
						aObj.after(s);
					},
					removeHoverDom : function(treeId, treeNode) {
						$("#btnGroup" + treeNode.tId).remove();
					}
				},
				async : {
					enable : true,
					url : "tree.txt",
					autoParam : [ "id", "name=n", "level=lv" ]
				},
				callback : {
					onClick : function(event, treeId, json) {

					}
				}
			};
			//$.fn.zTree.init($("#treeDemo"), setting); //异步访问数据

			var d = [ {
				"id" : 1,
				"pid" : 0,
				"seqno" : 0,
				"name" : "众筹平台项目标签",
				"url" : null,
				"icon" : "glyphicon glyphicon-tags",
				"open" : true,
				"checked" : false,
				"children" : [ {
					"id" : 2,
					"pid" : 1,
					"seqno" : 0,
					"name" : "手机",
					"url" : "dashboard.htm",
					"icon" : "glyphicon glyphicon-th-large",
					"open" : true,
					"checked" : false,
					"children" : [ {
						"id" : 8,
						"pid" : 7,
						"seqno" : 1,
						"name" : "手机",
						"url" : "user/index.htm",
						"icon" : "glyphicon glyphicon-tag",
						"open" : true,
						"checked" : false,
						"children" : []
					}, {
						"id" : 9,
						"pid" : 7,
						"seqno" : 1,
						"name" : "快充",
						"url" : "role/index.htm",
						"icon" : "glyphicon glyphicon-tag",
						"open" : true,
						"checked" : false,
						"children" : []
					}, {
						"id" : 10,
						"pid" : 7,
						"seqno" : 1,
						"name" : "超级本",
						"url" : "permission/index.htm",
						"icon" : "glyphicon glyphicon-tag",
						"open" : true,
						"checked" : false,
						"children" : []
					} ]
				}, {
					"id" : 6,
					"pid" : 1,
					"seqno" : 1,
					"name" : "数码",
					"url" : "message/index.htm",
					"icon" : "glyphicon glyphicon-th-large",
					"open" : true,
					"checked" : false,
					"children" : [ {
						"id" : 8,
						"pid" : 7,
						"seqno" : 1,
						"name" : "电脑",
						"url" : "user/index.htm",
						"icon" : "glyphicon glyphicon-tag",
						"open" : true,
						"checked" : false,
						"children" : []
					}, {
						"id" : 9,
						"pid" : 7,
						"seqno" : 1,
						"name" : "旋转屏幕",
						"url" : "role/index.htm",
						"icon" : "glyphicon glyphicon-tag",
						"open" : true,
						"checked" : false,
						"children" : []
					}, {
						"id" : 10,
						"pid" : 7,
						"seqno" : 1,
						"name" : "超级本",
						"url" : "permission/index.htm",
						"icon" : "glyphicon glyphicon-tag",
						"open" : true,
						"checked" : false,
						"children" : []
					} ]
				}, {
					"id" : 7,
					"pid" : 1,
					"seqno" : 1,
					"name" : "电脑",
					"url" : "",
					"icon" : "glyphicon glyphicon-th-large",
					"open" : true,
					"checked" : false,
					"children" : [ {
						"id" : 8,
						"pid" : 7,
						"seqno" : 1,
						"name" : "电脑",
						"url" : "user/index.htm",
						"icon" : "glyphicon glyphicon-tag",
						"open" : true,
						"checked" : false,
						"children" : []
					}, {
						"id" : 9,
						"pid" : 7,
						"seqno" : 1,
						"name" : "旋转屏幕",
						"url" : "role/index.htm",
						"icon" : "glyphicon glyphicon-tag",
						"open" : true,
						"checked" : false,
						"children" : []
					}, {
						"id" : 10,
						"pid" : 7,
						"seqno" : 1,
						"name" : "超级本",
						"url" : "permission/index.htm",
						"icon" : "glyphicon glyphicon-tag",
						"open" : true,
						"checked" : false,
						"children" : []
					} ]
				} ]
			} ];
			$.fn.zTree.init($("#treeDemo"), setting, d);
		});
	</script>
</body>
</html>
