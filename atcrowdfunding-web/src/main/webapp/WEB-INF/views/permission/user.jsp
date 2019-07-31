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
		pageContext.setAttribute("title", "用户维护");
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
						<form class="form-inline" role="form" style="float: left;"
							action="${ctx }/admin/index.html">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text"
										name="condition" placeholder="请输入查询条件"
										value="${sessionScope.condition }">
								</div>
							</div>
							<button type="submit" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger" id="deleteAllBtn"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;"
							onclick="location.href='${ctx}/user/add.html'">
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
										<th>账号</th>
										<th>名称</th>
										<th>邮箱地址</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${page.list }" var="admin">
										<tr>
											<td>${admin.id }</td>
											<td><input type="checkbox" class="checkItem"></td>
											<td>${admin.loginacct }</td>
											<td>${admin.username }</td>
											<td>${admin.email }</td>
											<td>
												<button type="button" class="btn btn-success btn-xs"
													onclick="location.href='${ctx}/user/assignRole.html?id=${admin.id }'">
													<i class=" glyphicon glyphicon-check"></i>
												</button>
												<button type="button" class="btn btn-primary btn-xs"
													onclick="location.href='${ctx}/user/edit.html?id=${admin.id }'">
													<i class=" glyphicon glyphicon-pencil"></i>
												</button> <!-- 传字符串 ${admin.username }加引号-->
												<button type="button" class="btn btn-danger btn-xs"
													onclick="deleteAdmin(${admin.id},'${admin.username }')">
													<i class=" glyphicon glyphicon-remove"></i>
												</button>
											</td>
										</tr>

									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">
												<li><a
													href="${ctx}/admin/index.html?pn=1&condition=${sessionScope.condition}">首页</a></li>
												<!-- 有上一页再显示 -->
												<c:if test="${page.hasPreviousPage }">
													<li><a
														href="${ctx}/admin/index.html?pn=${page.prePage}&condition=${sessionScope.condition}">上一页</a></li>
												</c:if>

												<%--  --%>
												<!-- 连续分页 -->
												<c:forEach items="${page.navigatepageNums }" var="num">
													<c:if test="${num == page.pageNum }">
														<!-- 正在遍历当前页 -->
														<li class="active"><a
															href="${ctx}/admin/index.html?pn=${num }&condition=${sessionScope.condition}">${num }<span
																class="sr-only">(current)</span></a></li>
													</c:if>
													<c:if test="${num != page.pageNum }">
														<!-- 遍历不是当前页 -->
														<li><a
															href="${ctx}/admin/index.html?pn=${num }&condition=${sessionScope.condition}">${num }</a></li>
													</c:if>

												</c:forEach>


												<c:if test="${page.hasNextPage }">
													<li><a
														href="${ctx}/admin/index.html?pn=${page.nextPage}&condition=${sessionScope.condition}">下一页</a></li>
												</c:if>
												<li><a
													href="${ctx}/admin/index.html?pn=${page.pages}&condition=${sessionScope.condition}">末页</a></li>
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
	<%@include file="/include/common-js.jsp"%>
	
	<script type="text/javascript">
		//单个删除
		function deleteAdmin(id,name) {

			layer.confirm("确认要删除 "+name+" 吗？", {
				icon : 3,
				title : '删除提示'
			}, function() {
				location.href='${ctx}/user/delete?id='+id;
			}, function() {
				layer.msg("已取消删除");
			});
		}
		
		//批量删除
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
			$(".checkItem").click(function(){
				//checkItem的总数量
				//var total=$(".checkItem").length;
				//当前有多少被勾选
				//var checked=$(".checkItem:checked").length;
				//当表格勾中数==checked的总数时，checked被设置为true
			//$("#allCheckBtn").prop("cheched",checked==total)
			//合并
			$("#allCheckBtn").prop("checked",$(".checkItem:checked").length==$(".checkItem").length)
			});
		//3、批量删除
	
		$("#deleteAllBtn").click(function(){
			//1、获取到当前被选中的所有的id
			var checked = $(".checkItem:checked");
			if(checked.length==0){
				layer.alert("你还没有选择任何用户");
			}else{
				var ids = "";
				//jquery如何遍历元素
				$.each(checked,function(){
					//checked的parent（上级标签）的parent（上级标签）到达包含单个用户信息这一级
					//find(查找)  td标签中下标为0的（下标为0是第一个）的text（${admin.id}被解析的文本信息）
					//后面拼接 , 号分割开id
					ids+=$(this).parent().parent().find("td:eq(0)").text()+",";
				});
				//浏览器控制台打印 js截取的字符串
				console.log(ids);
				layer.confirm("确认删除 "+ids+" 这些人吗？",{icon:3,title:"删除提示"},
					function(){
						location.href="${ctx}/user/batch/delete?ids="+ids;
					},
					function(){
						layer.msg("已取消删除")
					})
			}
		});
	</script>
	
</body>
</html>
