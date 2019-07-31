<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
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

input[type=checkbox] {
	width: 18px;
	height: 18px;
}
</style>
</head>

<body>
<%pageContext.setAttribute("title","分类管理"); %>
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
							<i class="glyphicon glyphicon-th"></i> 数据矩阵
						</h3>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th>名称</th>
										<th>商业公司</th>
										<th>个体工商户</th>
										<th>个人经营</th>
										<th>政府及非营利组织</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>营业执照副本</td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
									</tr>
									<tr>
										<td>税务登记证</td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
									</tr>
									<tr>
										<td>组织机构代码证</td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
									</tr>
									<tr>
										<td>单位登记证件</td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
									</tr>
									<tr>
										<td>法定代表人证件</td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
									</tr>
									<tr>
										<td>经营者证件</td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
									</tr>
									<tr>
										<td>手执身份证照片</td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
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
