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
<%pageContext.setAttribute("title","消息模板"); %>
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
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th>消息描述</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>密码找回</td>
										<td>
											<button type="button" class="btn btn-primary btn-xs">
												<i class="glyphicon glyphicon-pencil"></i>
											</button>
										</td>
									</tr>
									<tr>
										<td>2</td>
										<td>用户激活</td>
										<td>
											<button type="button" class="btn btn-primary btn-xs">
												<i class="glyphicon glyphicon-pencil"></i>
											</button>
										</td>
									</tr>
									<tr>
										<td>3</td>
										<td>风险提示</td>
										<td>
											<button type="button" class="btn btn-primary btn-xs">
												<i class="glyphicon glyphicon-pencil"></i>
											</button>
										</td>
									</tr>
									<tr>
										<td>4</td>
										<td>关于我们</td>
										<td>
											<button type="button" class="btn btn-primary btn-xs">
												<i class="glyphicon glyphicon-pencil"></i>
											</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<%@include file="/include/common-js.jsp"%>
</body>
</html>
